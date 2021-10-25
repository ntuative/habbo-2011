package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SecretKeyMessageParser implements IMessageParser
    {

        protected var _serverPublicKey: String;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._serverPublicKey = data.readString();
            
            return true;
        }

        public function get serverPublicKey(): String
        {
            return this._serverPublicKey;
        }

    }
}
