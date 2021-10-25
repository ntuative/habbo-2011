package com.sulake.habbo.friendlist.domain
{

    import flash.utils.Dictionary;

    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;

    public class AvatarSearchResults
    {

        private var _deps: IAvatarSearchDeps;
        private var _friends: Array;
        private var _others: Array;
        private var _friendRequests: Dictionary = new Dictionary();

        public function AvatarSearchResults(deps: IAvatarSearchDeps)
        {
            this._deps = deps;
        }

        public function getResult(id: int): HabboSearchResultData
        {
            var friend: HabboSearchResultData;
            var other: HabboSearchResultData;

            for each (friend in this._friends)
            {
                if (friend.avatarId == id)
                {
                    return friend;
                }

            }

            for each (other in this._others)
            {
                if (other.avatarId == id)
                {
                    return other;
                }

            }

            return null;
        }

        public function searchReceived(friends: Array, others: Array): void
        {
            this._friends = friends;
            this._others = others;

            this._deps.view.refreshList();
        }

        public function get friends(): Array
        {
            return this._friends;
        }

        public function get others(): Array
        {
            return this._others;
        }

        public function setFriendRequestSent(id: int): void
        {
            this._friendRequests[id] = "yes";
        }

        public function isFriendRequestSent(id: int): Boolean
        {
            return this._friendRequests[id] != null;
        }

    }
}
