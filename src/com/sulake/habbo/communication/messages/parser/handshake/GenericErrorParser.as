package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GenericErrorParser implements IMessageParser
    {

        private var _errorCode: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._errorCode = data.readInteger();
            
            return true;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

    }
}
