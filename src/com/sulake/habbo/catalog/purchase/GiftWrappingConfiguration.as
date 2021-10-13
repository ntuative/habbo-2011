package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;

    public class GiftWrappingConfiguration 
    {

        private var var_2536:Boolean = false;
        private var var_2612:int;
        private var var_2672:Array;
        private var var_2673:Array;
        private var var_2674:Array;

        public function GiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent)
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:GiftWrappingConfigurationParser = param1.getParser();
            if (_loc2_ == null)
            {
                return;
            };
            this.var_2536 = _loc2_.isWrappingEnabled;
            this.var_2612 = _loc2_.wrappingPrice;
            this.var_2672 = _loc2_.stuffTypes;
            this.var_2673 = _loc2_.boxTypes;
            this.var_2674 = _loc2_.ribbonTypes;
        }

        public function get isEnabled():Boolean
        {
            return (this.var_2536);
        }

        public function get price():int
        {
            return (this.var_2612);
        }

        public function get stuffTypes():Array
        {
            return (this.var_2672);
        }

        public function get boxTypes():Array
        {
            return (this.var_2673);
        }

        public function get ribbonTypes():Array
        {
            return (this.var_2674);
        }

    }
}