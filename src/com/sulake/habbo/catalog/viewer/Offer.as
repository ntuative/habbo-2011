package com.sulake.habbo.catalog.viewer
{

    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;

    public class Offer implements IPurchasableOffer
    {

        public static const PRICING_MODEL_UNKNOWN: String = "pricing_model_unknown";
        public static const PRICING_MODEL_SINGLE: String = "pricing_model_single";
        public static const PRICING_MODEL_MULTI: String = "pricing_model_multi";
        public static const PRICING_MODEL_BUNDLE: String = "pricing_model_bundle";
        public static const PRICE_TYPE_NONE: String = "price_type_none";
        public static const PRICE_TYPE_CREDITS: String = "price_type_credits";
        public static const PRICE_TYPE_ACTIVITYPOINTS: String = "price_type_activitypoints";
        public static const PRICE_TYPE_CREDITS_AND_ACTIVITYPOINTS: String = "price_type_credits_and_activitypoints";

        private var _pricingModel: String;
        private var _priceType: String;
        private var _offerId: int;
        private var _localizationId: String;
        private var _priceInCredits: int;
        private var _priceInActivityPoints: int;
        private var _activityPointType: int;
        private var _page: ICatalogPage;
        private var _productContainer: IProductContainer;
        private var _extraParameter: String = "";
        private var _previewCallbackId: int;

        public function Offer(offerId: int, localizationId: String, priceInCredits: int, priceInActivityPoints: int, activityPointType: int, products: Array, page: ICatalogPage)
        {
            this._offerId = offerId;
            this._localizationId = localizationId;
            this._priceInCredits = priceInCredits;
            this._priceInActivityPoints = priceInActivityPoints;
            this._activityPointType = activityPointType;
            this._page = page;
            this.analyzePricingModel(products);
            this.analyzePriceType();
            this.createProductContainer(products);
        }

        public function get extraParameter(): String
        {
            return this._extraParameter;
        }

        public function set extraParameter(param1: String): void
        {
            this._extraParameter = param1;
        }

        public function get page(): ICatalogPage
        {
            return this._page;
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function get localizationId(): String
        {
            return this._localizationId;
        }

        public function get priceInCredits(): int
        {
            return this._priceInCredits;
        }

        public function get priceInActivityPoints(): int
        {
            return this._priceInActivityPoints;
        }

        public function get activityPointType(): int
        {
            return this._activityPointType;
        }

        public function get productContainer(): IProductContainer
        {
            return this._productContainer;
        }

        public function get pricingModel(): String
        {
            return this._pricingModel;
        }

        public function get priceType(): String
        {
            return this._priceType;
        }

        public function get previewCallbackId(): int
        {
            return this._previewCallbackId;
        }

        public function set previewCallbackId(param1: int): void
        {
            this._previewCallbackId = param1;
        }

        public function dispose(): void
        {
            this._offerId = 0;
            this._localizationId = "";
            this._priceInCredits = 0;
            this._priceInActivityPoints = 0;
            this._activityPointType = 0;
            this._page = null;
            if (this._productContainer != null)
            {
                this._productContainer.dispose();
                this._productContainer = null;
            }

        }

        private function createProductContainer(products: Array): void
        {
            switch (this._pricingModel)
            {
                case PRICING_MODEL_SINGLE:
                    this._productContainer = new SingleProductContainer(this, products);
                    return;
                case PRICING_MODEL_MULTI:
                    this._productContainer = new MultiProductContainer(this, products);
                    return;
                case PRICING_MODEL_BUNDLE:
                    this._productContainer = new BundleProductContainer(this, products);
                    return;
                default:
                    Logger.log("[Offer] Unknown pricing model" + this._pricingModel);
            }

        }

        private function analyzePricingModel(products: Array): void
        {
            var product: Product;

            if (products.length == 1)
            {
                product = products[0];

                if (product.productCount == 1)
                {
                    this._pricingModel = PRICING_MODEL_SINGLE;
                }
                else
                {
                    this._pricingModel = PRICING_MODEL_MULTI;
                }

            }
            else
            {
                if (products.length > 1)
                {
                    this._pricingModel = PRICING_MODEL_BUNDLE;
                }
                else
                {
                    this._pricingModel = PRICING_MODEL_UNKNOWN;
                }

            }

        }

        private function analyzePriceType(): void
        {
            if (this._priceInCredits > 0 && this._priceInActivityPoints > 0)
            {
                this._priceType = PRICE_TYPE_CREDITS_AND_ACTIVITYPOINTS;
            }
            else
            {
                if (this._priceInCredits > 0)
                {
                    this._priceType = PRICE_TYPE_CREDITS;
                }
                else
                {
                    if (this._priceInActivityPoints > 0)
                    {
                        this._priceType = PRICE_TYPE_ACTIVITYPOINTS;
                    }
                    else
                    {
                        this._priceType = PRICE_TYPE_NONE;
                    }

                }

            }

        }

        public function clone(): Offer
        {
            var _loc3_: Product;
            var _loc4_: IFurnitureData;
            var _loc5_: Product;
            var _loc1_: Array = [];
            var _loc2_: IProductData = this._page.viewer.catalog.getProductData(this.localizationId);
            for each (_loc3_ in this._productContainer.products)
            {
                _loc4_ = this._page.viewer.catalog.getFurnitureData(_loc3_.productClassId, _loc3_.productType);
                _loc5_ = new Product(_loc3_.productType, _loc3_.productClassId, _loc3_.extraParam, _loc3_.productCount, _loc3_.expiration, _loc2_, _loc4_);
                _loc1_.push(_loc5_);
            }

            return new Offer(this.offerId, this.localizationId, this.priceInCredits, this.priceInActivityPoints, this.activityPointType, _loc1_, this.page);
        }

    }
}
