package com.sulake.habbo.communication.messages.incoming.handshake
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.InitCryptoMessageParser;

    public class InitCryptoMessageEvent extends MessageEvent implements IMessageEvent
    {

        public function InitCryptoMessageEvent(param1: Function)
        {
            super(param1, InitCryptoMessageParser);
        }

        public function get token(): String
        {
            return (this._parser as InitCryptoMessageParser).token;
        }

        public function get isServerEncrypted(): Boolean
        {
            return (this._parser as InitCryptoMessageParser).isServerEncrypted;
        }

        public function get isClientEncrypted(): Boolean
        {
            return (this._parser as InitCryptoMessageParser).isClientEncrypted;
        }

    }
}
