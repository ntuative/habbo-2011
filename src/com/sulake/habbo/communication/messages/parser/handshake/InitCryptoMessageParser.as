package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InitCryptoMessageParser implements IMessageParser
    {

        protected var _isClientEncrypted: Boolean;
        protected var _isServerEncrypted: Boolean;
        protected var _token: String;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._token = data.readString();
            this._isServerEncrypted = data.readInteger() > 0;

            return true;
        }

        public function get token(): String
        {
            return this._token;
        }

        public function get isServerEncrypted(): Boolean
        {
            return this._isServerEncrypted;
        }

        public function get isClientEncrypted(): Boolean
        {
            return this._isClientEncrypted;
        }

    }
}
