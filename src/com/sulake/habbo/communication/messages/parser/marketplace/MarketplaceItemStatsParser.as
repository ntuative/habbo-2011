package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceItemStatsParser implements IMessageParser 
    {

        private var var_2630:int;
        private var var_2631:int;
        private var var_2632:int;
        private var _dayOffsets:Array;
        private var var_2633:Array;
        private var var_2634:Array;
        private var var_2635:int;
        private var var_2636:int;

        public function get averagePrice():int
        {
            return (this.var_2630);
        }

        public function get offerCount():int
        {
            return (this.var_2631);
        }

        public function get historyLength():int
        {
            return (this.var_2632);
        }

        public function get dayOffsets():Array
        {
            return (this._dayOffsets);
        }

        public function get averagePrices():Array
        {
            return (this.var_2633);
        }

        public function get soldAmounts():Array
        {
            return (this.var_2634);
        }

        public function get furniTypeId():int
        {
            return (this.var_2635);
        }

        public function get furniCategoryId():int
        {
            return (this.var_2636);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2630 = param1.readInteger();
            this.var_2631 = param1.readInteger();
            this.var_2632 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            this._dayOffsets = [];
            this.var_2633 = [];
            this.var_2634 = [];
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this._dayOffsets.push(param1.readInteger());
                this.var_2633.push(param1.readInteger());
                this.var_2634.push(param1.readInteger());
                _loc3_++;
            };
            this.var_2636 = param1.readInteger();
            this.var_2635 = param1.readInteger();
            return (true);
        }

    }
}