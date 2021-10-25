package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IdentityAccountsMessageParser implements IMessageParser
    {

        private var _accounts: Map;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._accounts = new Map();

            var accountCount: int = data.readInteger();
            var i: int;
            
            while (i < accountCount)
            {
                this._accounts.add(data.readInteger(), data.readString());
                i++;
            }

            return true;
        }

        public function get accounts(): Map
        {
            return this._accounts;
        }

    }
}
