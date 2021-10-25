package com.sulake.habbo.friendlist.domain
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.Util;

    public class FriendCategory implements IDisposable
    {

        public static const FRIENDS_PER_PAGE: int = 100;
        public static const FRIENDS_ONLINE: int = 0;
        public static const FRIENDS_OFFLINE: int = -1;

        private var _id: int;
        private var _name: String;
        private var _open: Boolean;
        private var _friends: Array = [];
        private var _recieved: Boolean;
        private var _disposed: Boolean;
        private var _view: IWindowContainer;
        private var _pageIndex: int;

        public function FriendCategory(id: int, name: String)
        {
            this._id = id;
            this._name = name;
            this._open = this._id != FRIENDS_OFFLINE;
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
            this._view = null;
        }

        public function addFriend(friend: Friend): void
        {
            var item: Friend;

            if (this._friends.indexOf(friend) >= 0)
            {
                return;
            }

            var lname: String = friend.name.toLowerCase();

            var i: int;
            
            while (i < this._friends.length)
            {
                item = this._friends[i];

                if (lname < item.name.toLowerCase())
                {
                    this._friends.splice(i, 0, friend);
                    
                    return;
                }

                i++;
            }

            this._friends.push(friend);
        }

        public function getSelectedFriends(friends: Array): void
        {
            var friend: Friend;

            for each (friend in this._friends)
            {
                if (friend.selected)
                {
                    friends.push(friend);
                }

            }

        }

        public function getFriend(id: int): Friend
        {
            var friend: Friend;

            for each (friend in this._friends)
            {
                if (friend.id == id)
                {
                    return friend;
                }

            }

            return null;
        }

        public function getFriendCount(includeOffline: Boolean, includeNoFollow: Boolean = false): int
        {
            var friend: Friend;
            var total: int;

            for each (friend in this._friends)
            {
                if ((!includeOffline || friend.online) && (!includeNoFollow || friend.followingAllowed))
                {
                    total = total + 1;
                }

            }

            return total;
        }

        public function removeFriend(id: int): Friend
        {
            var friend: Friend = this.getFriend(id);
            
            if (friend != null)
            {
                Util.remove(this._friends, friend);
                
                return friend;
            }

            return null;
        }

        private function checkPageIndex(): void
        {
            if (this._pageIndex >= this.getPageCount())
            {
                this._pageIndex = Math.max(0, this.getPageCount() - 1);
            }

        }

        public function getPageCount(): int
        {
            return Math.ceil(this._friends.length / FRIENDS_PER_PAGE);
        }

        public function getStartFriendIndex(): int
        {
            this.checkPageIndex();

            return this._pageIndex * FRIENDS_PER_PAGE;
        }

        public function getEndFriendIndex(): int
        {
            this.checkPageIndex();

            return Math.min((this._pageIndex + 1) * FRIENDS_PER_PAGE, this._friends.length);
        }

        public function setOpen(open: Boolean): void
        {
            var friend: Friend;

            this._open = open;

            if (!open)
            {
                for each (friend in this._friends)
                {
                    friend.selected = false;
                }

            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get received(): Boolean
        {
            return this._recieved;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get friends(): Array
        {
            return this._friends;
        }

        public function get view(): IWindowContainer
        {
            return this._view;
        }

        public function get open(): Boolean
        {
            return this._open;
        }

        public function get pageIndex(): int
        {
            return this._pageIndex;
        }

        public function set id(value: int): void
        {
            this._id = value;
        }

        public function set name(value: String): void
        {
            this._name = value;
        }

        public function set view(value: IWindowContainer): void
        {
            this._view = value;
        }

        public function set received(value: Boolean): void
        {
            this._recieved = value;
        }

        public function set pageIndex(value: int): void
        {
            this._pageIndex = value;
        }

    }
}
