package com.sulake.habbo.communication.messages.parser.inventory.purse
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CreditBalanceParser implements IMessageParser
    {

        private var _balance: int;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._balance = int(data.readString());
            
            return true;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function get balance(): int
        {
            return this._balance;
        }

    }
}
