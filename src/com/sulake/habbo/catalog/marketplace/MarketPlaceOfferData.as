package com.sulake.habbo.catalog.marketplace
{
    import flash.display.BitmapData;

    public class MarketPlaceOfferData implements IMarketPlaceOfferData 
    {

        private var _offerId:int;
        private var _furniId:int;
        private var var_2649:int;
        private var var_2650:String;
        private var var_2612:int;
        private var var_2630:int;
        private var var_2651:int;
        private var var_2101:int;
        private var var_2652:int = -1;
        private var var_2653:int;
        private var var_988:BitmapData;

        public function MarketPlaceOfferData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int=-1)
        {
            this._offerId = param1;
            this._furniId = param2;
            this.var_2649 = param3;
            this.var_2650 = param4;
            this.var_2612 = param5;
            this.var_2101 = param6;
            this.var_2630 = param7;
            this.var_2653 = param8;
        }

        public function dispose():void
        {
            if (this.var_988)
            {
                this.var_988.dispose();
                this.var_988 = null;
            };
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

        public function get averagePrice():int
        {
            return (this.var_2630);
        }

        public function get image():BitmapData
        {
            return (this.var_988);
        }

        public function set image(param1:BitmapData):void
        {
            if (this.var_988 != null)
            {
                this.var_988.dispose();
            };
            this.var_988 = param1;
        }

        public function set imageCallback(param1:int):void
        {
            this.var_2651 = param1;
        }

        public function get imageCallback():int
        {
            return (this.var_2651);
        }

        public function get status():int
        {
            return (this.var_2101);
        }

        public function get timeLeftMinutes():int
        {
            return (this.var_2652);
        }

        public function set timeLeftMinutes(param1:int):void
        {
            this.var_2652 = param1;
        }

        public function set price(param1:int):void
        {
            this.var_2612 = param1;
        }

        public function set offerId(param1:int):void
        {
            this._offerId = param1;
        }

        public function get offerCount():int
        {
            return (this.var_2653);
        }

        public function set offerCount(param1:int):void
        {
            this.var_2653 = param1;
        }

    }
}