package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MessengerInitMessageParser implements IMessageParser
    {

        private var _userFriendLimit: int;
        private var _normalFriendLimit: int;
        private var _extendedFriendLimit: int;
        private var _evenMoreExtendedFriendLimit: int;
        private var _categories: Array;
        private var _friends: Array;

        public function flush(): Boolean
        {
            this._categories = [];
            this._friends = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._userFriendLimit = data.readInteger();
            this._normalFriendLimit = data.readInteger();
            this._extendedFriendLimit = data.readInteger();
            this._evenMoreExtendedFriendLimit = data.readInteger();

            var friendCategoryCount: int = data.readInteger();
            var i: int = 0;

            while (i < friendCategoryCount)
            {
                this._categories.push(new FriendCategoryData(data));
                i++;
            }

            var friendCount: int = data.readInteger();
            i = 0;

            while (i < friendCount)
            {
                this._friends.push(new FriendData(data));
                i++;
            }

            return true;
        }

        public function get userFriendLimit(): int
        {
            return this._userFriendLimit;
        }

        public function get normalFriendLimit(): int
        {
            return this._normalFriendLimit;
        }

        public function get extendedFriendLimit(): int
        {
            return this._extendedFriendLimit;
        }

        public function get categories(): Array
        {
            return this._categories;
        }

        public function get friends(): Array
        {
            return this._friends;
        }

        public function get evenMoreExtendedFriendLimit(): int
        {
            return this._evenMoreExtendedFriendLimit;
        }

    }
}
