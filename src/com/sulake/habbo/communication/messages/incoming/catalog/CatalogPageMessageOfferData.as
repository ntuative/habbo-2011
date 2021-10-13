package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageOfferData 
    {

        private var _offerId:int;
        private var var_2828:String;
        private var var_2829:int;
        private var var_2830:int;
        private var var_2831:int;
        private var var_2839:Array;

        public function CatalogPageMessageOfferData(param1:IMessageDataWrapper)
        {
            this._offerId = param1.readInteger();
            this.var_2828 = param1.readString();
            this.var_2829 = param1.readInteger();
            this.var_2830 = param1.readInteger();
            this.var_2831 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            this.var_2839 = new Array();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_2839.push(new CatalogPageMessageProductData(param1));
                _loc3_++;
            };
        }

        public function get offerId():int
        {
            return (this._offerId);
        }

        public function get localizationId():String
        {
            return (this.var_2828);
        }

        public function get priceInCredits():int
        {
            return (this.var_2829);
        }

        public function get priceInActivityPoints():int
        {
            return (this.var_2830);
        }

        public function get products():Array
        {
            return (this.var_2839);
        }

        public function get activityPointType():int
        {
            return (this.var_2831);
        }

    }
}