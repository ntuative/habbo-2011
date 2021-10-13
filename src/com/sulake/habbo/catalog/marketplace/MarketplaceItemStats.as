package com.sulake.habbo.catalog.marketplace
{
    public class MarketplaceItemStats 
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

        public function set averagePrice(param1:int):void
        {
            this.var_2630 = param1;
        }

        public function set offerCount(param1:int):void
        {
            this.var_2631 = param1;
        }

        public function set historyLength(param1:int):void
        {
            this.var_2632 = param1;
        }

        public function set dayOffsets(param1:Array):void
        {
            this._dayOffsets = param1.slice();
        }

        public function set averagePrices(param1:Array):void
        {
            this.var_2633 = param1.slice();
        }

        public function set soldAmounts(param1:Array):void
        {
            this.var_2634 = param1.slice();
        }

        public function set furniTypeId(param1:int):void
        {
            this.var_2635 = param1;
        }

        public function set furniCategoryId(param1:int):void
        {
            this.var_2636 = param1;
        }

    }
}