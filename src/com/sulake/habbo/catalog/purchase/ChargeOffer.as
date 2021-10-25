package com.sulake.habbo.catalog.purchase
{

    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public class ChargeOffer implements IPurchasableOffer
    {

        private var _chargeInfo: ChargeInfo;
        private var _extraParameter: String;

        public function ChargeOffer(chargeInfo: ChargeInfo)
        {
            this._chargeInfo = chargeInfo;
        }

        public function get offerId(): int
        {
            return 0;
        }

        public function get extraParameter(): String
        {
            return this._extraParameter;
        }

        public function set extraParameter(param1: String): void
        {
            this._extraParameter = param1;
        }

        public function get priceInActivityPoints(): int
        {
            return this._chargeInfo.priceInActivityPoints;
        }

        public function get activityPointType(): int
        {
            return this._chargeInfo.activityPointType;
        }

        public function get priceInCredits(): int
        {
            return this._chargeInfo.priceInCredits;
        }

        public function get page(): ICatalogPage
        {
            return null;
        }

        public function get priceType(): String
        {
            return null;
        }

        public function get productContainer(): IProductContainer
        {
            return null;
        }

        public function get localizationId(): String
        {
            return null;
        }

    }
}
