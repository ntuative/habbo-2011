package com.sulake.habbo.catalog.purchase
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public class ChargeOffer implements IPurchasableOffer 
    {

        private var var_2671:ChargeInfo;
        private var var_2620:String;

        public function ChargeOffer(param1:ChargeInfo)
        {
            this.var_2671 = param1;
        }

        public function get offerId():int
        {
            return (0);
        }

        public function get extraParameter():String
        {
            return (this.var_2620);
        }

        public function set extraParameter(param1:String):void
        {
            this.var_2620 = param1;
        }

        public function get priceInActivityPoints():int
        {
            return (this.var_2671.priceInActivityPoints);
        }

        public function get activityPointType():int
        {
            return (this.var_2671.activityPointType);
        }

        public function get priceInCredits():int
        {
            return (this.var_2671.priceInCredits);
        }

        public function get page():ICatalogPage
        {
            return (null);
        }

        public function get priceType():String
        {
            return (null);
        }

        public function get productContainer():IProductContainer
        {
            return (null);
        }

        public function get localizationId():String
        {
            return (null);
        }

    }
}