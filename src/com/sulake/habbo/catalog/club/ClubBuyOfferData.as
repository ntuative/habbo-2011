package com.sulake.habbo.catalog.club
{

    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.purse.Purse;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public class ClubBuyOfferData implements IPurchasableOffer
    {

        private var _offerId: int;
        private var _productCode: String;
        private var _price: int;
        private var _upgrade: Boolean;
        private var _vip: Boolean;
        private var _periods: int;
        private var _daysLeftAfterPurchase: int;
        private var _page: ICatalogPage;
        private var _year: int;
        private var _month: int;
        private var _day: int;
        private var _extraParameter: String;
        private var _upgradeHcPeriodToVip: Boolean = false;

        public function ClubBuyOfferData(offerId: int, productCode: String, price: int, upgrade: Boolean, vip: Boolean, periods: int, daysLeftAfterPurchase: int, year: int, month: int, day: int)
        {
            this._offerId = offerId;
            this._productCode = productCode;
            this._price = price;
            this._upgrade = upgrade;
            this._vip = vip;
            this._periods = periods;
            this._daysLeftAfterPurchase = daysLeftAfterPurchase;
            this._year = year;
            this._month = month;
            this._day = day;
        }

        public function dispose(): void
        {
        }

        public function get extraParameter(): String
        {
            return this._extraParameter;
        }

        public function set extraParameter(value: String): void
        {
            this._extraParameter = value;
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function get productCode(): String
        {
            return this._productCode;
        }

        public function get price(): int
        {
            return this._price;
        }

        public function get upgrade(): Boolean
        {
            return this._upgrade;
        }

        public function get vip(): Boolean
        {
            return this._vip;
        }

        public function get periods(): int
        {
            return this._periods;
        }

        public function get daysLeftAfterPurchase(): int
        {
            return this._daysLeftAfterPurchase;
        }

        public function get year(): int
        {
            return this._year;
        }

        public function get month(): int
        {
            return this._month;
        }

        public function get day(): int
        {
            return this._day;
        }

        public function get priceInActivityPoints(): int
        {
            return 0;
        }

        public function get activityPointType(): int
        {
            return Purse.ACTIVITY_POINTS_TYPE_PIXELS;
        }

        public function get priceInCredits(): int
        {
            return this._price;
        }

        public function get page(): ICatalogPage
        {
            return this._page;
        }

        public function get priceType(): String
        {
            return Offer.PRICE_TYPE_CREDITS;
        }

        public function get productContainer(): IProductContainer
        {
            return null;
        }

        public function get localizationId(): String
        {
            return this._productCode;
        }

        public function set page(param1: ICatalogPage): void
        {
            this._page = param1;
        }

        public function get upgradeHcPeriodToVip(): Boolean
        {
            return this._upgradeHcPeriodToVip;
        }

        public function set upgradeHcPeriodToVip(param1: Boolean): void
        {
            this._upgradeHcPeriodToVip = param1;
        }

    }
}
