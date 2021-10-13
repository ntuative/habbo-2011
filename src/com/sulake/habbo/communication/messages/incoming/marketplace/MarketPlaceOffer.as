package com.sulake.habbo.communication.messages.incoming.marketplace
{
    public class MarketPlaceOffer 
    {

        private var _offerId:int;
        private var _furniId:int;
        private var var_2649:int;
        private var var_2650:String;
        private var var_2612:int;
        private var var_2101:int;
        private var var_2652:int = -1;
        private var var_2630:int;
        private var var_2653:int;

        public function MarketPlaceOffer(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int, param9:int=-1)
        {
            this._offerId = param1;
            this._furniId = param2;
            this.var_2649 = param3;
            this.var_2650 = param4;
            this.var_2612 = param5;
            this.var_2101 = param6;
            this.var_2652 = param7;
            this.var_2630 = param8;
            this.var_2653 = param9;
        }

        public function get offerId():int
        {
            return (this._offerId);
        }

        public function get furniId():int
        {
            return (this._furniId);
        }

        public function get furniType():int
        {
            return (this.var_2649);
        }

        public function get stuffData():String
        {
            return (this.var_2650);
        }

        public function get price():int
        {
            return (this.var_2612);
        }

        public function get status():int
        {
            return (this.var_2101);
        }

        public function get timeLeftMinutes():int
        {
            return (this.var_2652);
        }

        public function get averagePrice():int
        {
            return (this.var_2630);
        }

        public function get offerCount():int
        {
            return (this.var_2653);
        }

    }
}