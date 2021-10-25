package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MessengerErrorMessageParser implements IMessageParser
    {

        private var _clientMessageId: int;
        private var _errorCode: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._clientMessageId = data.readInteger();
            this._errorCode = data.readInteger();

            return true;
        }

        public function get clientMessageId(): int
        {
            return this._clientMessageId;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

    }
}
