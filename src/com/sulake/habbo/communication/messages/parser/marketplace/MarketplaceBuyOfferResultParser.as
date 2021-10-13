package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceBuyOfferResultParser implements IMessageParser 
    {

        private var _result:int;
        private var var_3213:int = -1;
        private var var_3214:int = -1;
        private var var_3215:int = -1;

        public function get result():int
        {
            return (this._result);
        }

        public function get offerId():int
        {
            return (this.var_3213);
        }

        public function get newPrice():int
        {
            return (this.var_3214);
        }

        public function get requestedOfferId():int
        {
            return (this.var_3215);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._result = param1.readInteger();
            this.var_3213 = param1.readInteger();
            this.var_3214 = param1.readInteger();
            this.var_3215 = param1.readInteger();
            return (true);
        }

    }
}