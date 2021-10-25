package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendListUpdateMessageParser implements IMessageParser
    {

        private var _cats: Array;
        private var _removedFriendIds: Array;
        private var _addedFriends: Array;
        private var _updatedFriends: Array;

        public function flush(): Boolean
        {
            this._cats = [];
            this._removedFriendIds = [];
            this._addedFriends = [];
            this._updatedFriends = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var updateType: int;
            var id: int;
            var friendCategoryCount: int = data.readInteger();
            var i: int;
            while (i < friendCategoryCount)
            {
                this._cats.push(new FriendCategoryData(data));
                i++;
            }

            var updateCount: int = data.readInteger();
            i = 0;

            while (i < updateCount)
            {
                updateType = data.readInteger();
                if (updateType == -1)
                {
                    id = data.readInteger();
                    this._removedFriendIds.push(id);
                }
                else if (updateType == 0)
                {
                    this._updatedFriends.push(new FriendData(data));
                }
                else if (updateType == 1)
                {
                    this._addedFriends.push(new FriendData(data));
                }

                i++;
            }

            return true;
        }

        public function get cats(): Array
        {
            return this._cats;
        }

        public function get removedFriendIds(): Array
        {
            return this._removedFriendIds;
        }

        public function get addedFriends(): Array
        {
            return this._addedFriends;
        }

        public function get updatedFriends(): Array
        {
            return this._updatedFriends;
        }

    }
}
