package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.purse.Purse;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public class ClubBuyOfferData implements IPurchasableOffer 
    {

        private var _offerId:int;
        private var var_2611:String;
        private var var_2612:int;
        private var var_2613:Boolean;
        private var var_2614:Boolean;
        private var var_2615:int;
        private var var_2616:int;
        private var var_2610:ICatalogPage;
        private var var_2617:int;
        private var var_2618:int;
        private var var_2619:int;
        private var var_2620:String;
        private var var_2621:Boolean = false;

        public function ClubBuyOfferData(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:int, param9:int, param10:int)
        {
            this._offerId = param1;
            this.var_2611 = param2;
            this.var_2612 = param3;
            this.var_2613 = param4;
            this.var_2614 = param5;
            this.var_2615 = param6;
            this.var_2616 = param7;
            this.var_2617 = param8;
            this.var_2618 = param9;
            this.var_2619 = param10;
        }

        public function dispose():void
        {
        }

        public function get extraParameter():String
        {
            return (this.var_2620);
        }

        public function set extraParameter(param1:String):void
        {
            this.var_2620 = param1;
        }

        public function get offerId():int
        {
            return (this._offerId);
        }

        public function get productCode():String
        {
            return (this.var_2611);
        }

        public function get price():int
        {
            return (this.var_2612);
        }

        public function get upgrade():Boolean
        {
            return (this.var_2613);
        }

        public function get vip():Boolean
        {
            return (this.var_2614);
        }

        public function get periods():int
        {
            return (this.var_2615);
        }

        public function get daysLeftAfterPurchase():int
        {
            return (this.var_2616);
        }

        public function get year():int
        {
            return (this.var_2617);
        }

        public function get month():int
        {
            return (this.var_2618);
        }

        public function get day():int
        {
            return (this.var_2619);
        }

        public function get priceInActivityPoints():int
        {
            return (0);
        }

        public function get activityPointType():int
        {
            return (Purse.var_142);
        }

        public function get priceInCredits():int
        {
            return (this.var_2612);
        }

        public function get page():ICatalogPage
        {
            return (this.var_2610);
        }

        public function get priceType():String
        {
            return (Offer.var_716);
        }

        public function get productContainer():IProductContainer
        {
            return (null);
        }

        public function get localizationId():String
        {
            return (this.var_2611);
        }

        public function set page(param1:ICatalogPage):void
        {
            this.var_2610 = param1;
        }

        public function get upgradeHcPeriodToVip():Boolean
        {
            return (this.var_2621);
        }

        public function set upgradeHcPeriodToVip(param1:Boolean):void
        {
            this.var_2621 = param1;
        }

    }
}