package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboSearchResultMessageParser implements IMessageParser
    {

        private var _friends: Array;
        private var _others: Array;

        public function flush(): Boolean
        {
            this._friends = [];
            this._others = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var friendCount: int = data.readInteger();
            var i: int;
            while (i < friendCount)
            {
                this._friends.push(new HabboSearchResultData(data));
                i++;
            }

            var otherCount: int = data.readInteger();
            i = 0;
            
            while (i < otherCount)
            {
                this._others.push(new HabboSearchResultData(data));
                i++;
            }

            return true;
        }

        public function get friends(): Array
        {
            return this._friends;
        }

        public function get others(): Array
        {
            return this._others;
        }

    }
}
