package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;

    public class Offer implements IPurchasableOffer 
    {

        public static const var_783:String = "pricing_model_unknown";
        public static const var_784:String = "pricing_model_single";
        public static const var_785:String = "pricing_model_multi";
        public static const var_786:String = "pricing_model_bundle";
        public static const PRICE_TYPE_NONE:String = "price_type_none";
        public static const var_716:String = "price_type_credits";
        public static const var_787:String = "price_type_activitypoints";
        public static const var_788:String = "price_type_credits_and_activitypoints";

        private var var_2826:String;
        private var var_2827:String;
        private var _offerId:int;
        private var var_2828:String;
        private var var_2829:int;
        private var var_2830:int;
        private var var_2831:int;
        private var var_2610:ICatalogPage;
        private var var_2832:IProductContainer;
        private var var_2620:String = "";
        private var var_2833:int;

        public function Offer(param1:int, param2:String, param3:int, param4:int, param5:int, param6:Array, param7:ICatalogPage)
        {
            this._offerId = param1;
            this.var_2828 = param2;
            this.var_2829 = param3;
            this.var_2830 = param4;
            this.var_2831 = param5;
            this.var_2610 = param7;
            this.analyzePricingModel(param6);
            this.analyzePriceType();
            this.createProductContainer(param6);
        }

        public function get extraParameter():String
        {
            return (this.var_2620);
        }

        public function set extraParameter(param1:String):void
        {
            this.var_2620 = param1;
        }

        public function get page():ICatalogPage
        {
            return (this.var_2610);
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

        public function get activityPointType():int
        {
            return (this.var_2831);
        }

        public function get productContainer():IProductContainer
        {
            return (this.var_2832);
        }

        public function get pricingModel():String
        {
            return (this.var_2826);
        }

        public function get priceType():String
        {
            return (this.var_2827);
        }

        public function get previewCallbackId():int
        {
            return (this.var_2833);
        }

        public function set previewCallbackId(param1:int):void
        {
            this.var_2833 = param1;
        }

        public function dispose():void
        {
            this._offerId = 0;
            this.var_2828 = "";
            this.var_2829 = 0;
            this.var_2830 = 0;
            this.var_2831 = 0;
            this.var_2610 = null;
            if (this.var_2832 != null)
            {
                this.var_2832.dispose();
                this.var_2832 = null;
            };
        }

        private function createProductContainer(param1:Array):void
        {
            switch (this.var_2826)
            {
                case var_784:
                    this.var_2832 = new SingleProductContainer(this, param1);
                    return;
                case var_785:
                    this.var_2832 = new MultiProductContainer(this, param1);
                    return;
                case var_786:
                    this.var_2832 = new BundleProductContainer(this, param1);
                    return;
                default:
                    Logger.log(("[Offer] Unknown pricing model" + this.var_2826));
            };
        }

        private function analyzePricingModel(param1:Array):void
        {
            var _loc2_:Product;
            if (param1.length == 1)
            {
                _loc2_ = param1[0];
                if (_loc2_.productCount == 1)
                {
                    this.var_2826 = var_784;
                }
                else
                {
                    this.var_2826 = var_785;
                };
            }
            else
            {
                if (param1.length > 1)
                {
                    this.var_2826 = var_786;
                }
                else
                {
                    this.var_2826 = var_783;
                };
            };
        }

        private function analyzePriceType():void
        {
            if (((this.var_2829 > 0) && (this.var_2830 > 0)))
            {
                this.var_2827 = var_788;
            }
            else
            {
                if (this.var_2829 > 0)
                {
                    this.var_2827 = var_716;
                }
                else
                {
                    if (this.var_2830 > 0)
                    {
                        this.var_2827 = var_787;
                    }
                    else
                    {
                        this.var_2827 = PRICE_TYPE_NONE;
                    };
                };
            };
        }

        public function clone():Offer
        {
            var _loc3_:Product;
            var _loc4_:IFurnitureData;
            var _loc5_:Product;
            var _loc1_:Array = new Array();
            var _loc2_:IProductData = this.var_2610.viewer.catalog.getProductData(this.localizationId);
            for each (_loc3_ in this.var_2832.products)
            {
                _loc4_ = this.var_2610.viewer.catalog.getFurnitureData(_loc3_.productClassId, _loc3_.productType);
                _loc5_ = new Product(_loc3_.productType, _loc3_.productClassId, _loc3_.extraParam, _loc3_.productCount, _loc3_.expiration, _loc2_, _loc4_);
                _loc1_.push(_loc5_);
            };
            return (new Offer(this.offerId, this.localizationId, this.priceInCredits, this.priceInActivityPoints, this.activityPointType, _loc1_, this.page));
        }

    }
}