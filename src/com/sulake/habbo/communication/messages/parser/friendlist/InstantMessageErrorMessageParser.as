package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InstantMessageErrorMessageParser implements IMessageParser
    {

        private var _errorCode: int;
        private var _userId: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._errorCode = data.readInteger();
            this._userId = data.readInteger();
            
            return true;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

        public function get userId(): int
        {
            return this._userId;
        }

    }
}
