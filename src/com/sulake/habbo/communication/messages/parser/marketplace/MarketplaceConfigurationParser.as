package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceConfigurationParser implements IMessageParser 
    {

        private var var_2536:Boolean;
        private var var_3216:int;
        private var var_3217:int;
        private var var_3218:int;
        private var var_3219:int;
        private var var_3220:int;
        private var var_3221:int;
        private var var_2641:int;

        public function get isEnabled():Boolean
        {
            return (this.var_2536);
        }

        public function get commission():int
        {
            return (this.var_3216);
        }

        public function get tokenBatchPrice():int
        {
            return (this.var_3217);
        }

        public function get tokenBatchSize():int
        {
            return (this.var_3218);
        }

        public function get offerMinPrice():int
        {
            return (this.var_3220);
        }

        public function get offerMaxPrice():int
        {
            return (this.var_3219);
        }

        public function get expirationHours():int
        {
            return (this.var_3221);
        }

        public function get averagePricePeriod():int
        {
            return (this.var_2641);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2536 = param1.readBoolean();
            this.var_3216 = param1.readInteger();
            this.var_3217 = param1.readInteger();
            this.var_3218 = param1.readInteger();
            this.var_3220 = param1.readInteger();
            this.var_3219 = param1.readInteger();
            this.var_3221 = param1.readInteger();
            this.var_2641 = param1.readInteger();
            return (true);
        }

    }
}