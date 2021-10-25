package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FindFriendsProcessResultMessageParser implements IMessageParser
    {

        private var _suggest: Boolean;

        public function get success(): Boolean
        {
            return this._suggest;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._suggest = data.readBoolean();

            return true;
        }

    }
}
