package com.sulake.habbo.friendlist.domain
{

    import flash.utils.Dictionary;

    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.friendlist.Util;
    import com.sulake.habbo.communication.messages.incoming.friendlist.*;
    import com.sulake.habbo.communication.messages.parser.friendlist.*;

    public class FriendCategories
    {

        private var _deps: IFriendCategoriesDeps;
        private var _categories: Array = [];
        private var _friendsById: Dictionary = new Dictionary();

        public function FriendCategories(deps: IFriendCategoriesDeps)
        {
            this._deps = deps;
        }

        public function addFriend(friend: Friend): FriendCategory
        {
            var categoryId: int = friend.online ? friend.categoryId : FriendCategory.FRIENDS_OFFLINE;
            var category: FriendCategory = this.findCategory(categoryId);

            if (category != null)
            {
                category.addFriend(friend);
                this._friendsById[friend.id] = friend;

                return category;
            }

            Logger.log("No category " + categoryId + " found for friend " + friend.id + ". Ignoring");

            return null;
        }

        public function getSelectedFriends(): Array
        {
            var category: FriendCategory;
            var friends: Array = [];

            for each (category in this._categories)
            {
                category.getSelectedFriends(friends);
            }

            return friends;
        }

        public function getSelectedFriend(): Friend
        {
            var friends: Array = this.getSelectedFriends();

            return friends.length == 1 ? friends[0] : null;
        }

        public function getAllFriends(): Dictionary
        {
            return this._friendsById;
        }

        public function getFriendCount(includeOffline: Boolean, includeNoFollow: Boolean = false): int
        {
            var category: FriendCategory;
            var total: int;

            for each (category in this._categories)
            {
                total = total + category.getFriendCount(includeOffline, includeNoFollow);
            }

            return total;
        }

        public function getCategories(): Array
        {
            return this._categories;
        }

        public function addCategory(category: FriendCategory): void
        {
            this._categories.push(category);
        }

        public function findFriend(id: int): Friend
        {
            return this._friendsById[id];
        }

        public function findCategory(id: int): FriendCategory
        {
            var category: FriendCategory;

            for each (category in this._categories)
            {
                if (category.id == id)
                {
                    return category;
                }

            }

            return null;
        }

        public function onFriendListUpdate(event: IMessageEvent): void
        {
            var status: int;
            var parser: FriendListUpdateMessageParser;
            var removedFriendId: int;
            var updatedFriend: FriendData;
            var addedFriend: FriendData;
            var currentlyOnline: Boolean;
            var wasSelected: Boolean;
            var friend: Friend;

            Logger.log("Received friend list update");

            status = 0;

            try
            {
                parser = (event as FriendListUpdateEvent).getParser();

                status = 1;

                this.updateCategories(parser.cats);
                status = 2;

                for each (removedFriendId in parser.removedFriendIds)
                {
                    this.removeFriend(removedFriendId, true);
                }

                status = 3;

                for each (updatedFriend in parser.updatedFriends)
                {
                    Logger.log("Got UPDATE: " + updatedFriend.id + ", " + updatedFriend.online + ", " + updatedFriend.name + ", " + updatedFriend.followingAllowed);

                    this._deps.messenger.setFollowingAllowed(updatedFriend.id, updatedFriend.followingAllowed && updatedFriend.online);

                    currentlyOnline = this.isFriendOnline(updatedFriend.id);

                    if (currentlyOnline && !updatedFriend.online)
                    {
                        this._deps.messenger.setOnlineStatus(updatedFriend.id, updatedFriend.online);
                        this._deps.notifications.addOfflineNotification(updatedFriend.name, updatedFriend.realName);
                    }

                    if (!currentlyOnline && updatedFriend.online)
                    {
                        this._deps.messenger.setOnlineStatus(updatedFriend.id, updatedFriend.online);
                        this._deps.view.setNewMessageArrived();
                        this._deps.notifications.addOnlineNotification(updatedFriend.name, updatedFriend.figure, updatedFriend.realName);
                    }

                    wasSelected = this.removeFriend(updatedFriend.id, true);

                    friend = new Friend(updatedFriend);
                    friend.selected = wasSelected;

                    this.addFriend(friend);
                }

                status = 4;

                for each (addedFriend in parser.addedFriends)
                {
                    Logger.log("Got INSERT: " + addedFriend.id + ", " + addedFriend.name);
                    this.removeFriend(addedFriend.id, true);
                    this.addFriend(new Friend(addedFriend));
                }

                status = 5;

                this._deps.view.refreshList();

                status = 6;
            }
            catch (e: Error)
            {
                ErrorReportStorage.addDebugData("FriendCategories", "onFriendListUpdate crashed, status = " + String(status) + "!");
                throw e;
            }

        }

        private function updateCategories(categories: Array): void
        {
            var categoryData: FriendCategoryData;
            var notRecieved: FriendCategory;
            var category: FriendCategory;

            this.flushReceivedStatus();

            this.findCategory(FriendCategory.FRIENDS_OFFLINE).received = true;
            this.findCategory(FriendCategory.FRIENDS_ONLINE).received = true;

            for each (categoryData in categories)
            {
                category = this.findCategory(categoryData.id);

                if (category != null)
                {
                    category.received = true;

                    if (category.name != categoryData.name)
                    {
                        category.name = categoryData.name;
                    }

                }
                else
                {
                    var instance: FriendCategory = new FriendCategory(categoryData.id, categoryData.name);

                    instance.received = true;

                    this.addCategory(instance);
                }

            }

            for each (notRecieved in this.getCategoriesNotReceived())
            {
                if (notRecieved.friends.length <= 0)
                {
                    Util.remove(this._categories, notRecieved);
                    notRecieved.dispose();
                }

            }

        }

        private function removeFriend(id: int, dispose: Boolean): Boolean
        {
            var category: FriendCategory;
            var friend: Friend;

            if (dispose)
            {
                this._friendsById[id] = null;
            }

            var selected: Boolean;

            for each (category in this._categories)
            {
                friend = category.removeFriend(id);

                if (friend != null)
                {
                    selected = friend.selected;

                    if (dispose)
                    {
                        friend.dispose();
                    }

                }

            }

            return selected;
        }

        private function flushReceivedStatus(): void
        {
            var category: FriendCategory;

            for each (category in this._categories)
            {
                category.received = false;
            }

        }

        private function getCategoriesNotReceived(): Array
        {
            var category: FriendCategory;
            var notReceived: Array = [];

            for each (category in this._categories)
            {
                if (!category.received)
                {
                    notReceived.push(category);
                }

            }

            return notReceived;
        }

        private function isFriendOnline(param1: int): Boolean
        {
            var friend: Friend = this.findFriend(param1);

            return friend == null ? false : friend.online;
        }

        public function getFriendNames(): Array
        {
            var friend: Friend;

            if (this._friendsById == null)
            {
                return [];
            }

            var names: Array = [];

            for each (friend in this._friendsById)
            {
                if (friend != null)
                {
                    names.push(friend.name);
                }

            }

            return names;
        }

    }
}
