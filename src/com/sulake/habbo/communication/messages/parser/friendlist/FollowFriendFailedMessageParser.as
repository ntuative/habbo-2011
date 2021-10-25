package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FollowFriendFailedMessageParser implements IMessageParser
    {

        private var _errorCode: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._errorCode = param1.readInteger();
            
            return true;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

    }
}
