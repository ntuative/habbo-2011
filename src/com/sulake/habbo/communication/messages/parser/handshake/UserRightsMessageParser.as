package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserRightsMessageParser implements IMessageParser
    {

        private var _clubLevel: int;
        private var _securityLevel: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._clubLevel = data.readInteger();
            this._securityLevel = data.readInteger();
            
            return true;
        }

        public function get clubLevel(): int
        {
            return this._clubLevel;
        }

        public function get securityLevel(): int
        {
            return this._securityLevel;
        }

    }
}
