package com.sulake.habbo.catalog.marketplace
{

    import flash.display.BitmapData;

    public class MarketPlaceOfferData implements IMarketPlaceOfferData
    {

        private var _offerId: int;
        private var _furniId: int;
        private var _furniType: int;
        private var _stuffData: String;
        private var _price: int;
        private var _averagePrice: int;
        private var _imageCallback: int;
        private var _status: int;
        private var _timeLeftMinutes: int = -1;
        private var _offerCount: int;
        private var _image: BitmapData;

        public function MarketPlaceOfferData(offerId: int, furniId: int, furniType: int, stuffData: String, price: int, status: int, averagePrice: int, offerCount: int = -1)
        {
            this._offerId = offerId;
            this._furniId = furniId;
            this._furniType = furniType;
            this._stuffData = stuffData;
            this._price = price;
            this._status = status;
            this._averagePrice = averagePrice;
            this._offerCount = offerCount;
        }

        public function dispose(): void
        {
            if (this._image)
            {
                this._image.dispose();
                this._image = null;
            }

        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function get furniId(): int
        {
            return this._furniId;
        }

        public function get furniType(): int
        {
            return this._furniType;
        }

        public function get stuffData(): String
        {
            return this._stuffData;
        }

        public function get price(): int
        {
            return this._price;
        }

        public function get averagePrice(): int
        {
            return this._averagePrice;
        }

        public function get image(): BitmapData
        {
            return this._image;
        }

        public function set image(value: BitmapData): void
        {
            if (this._image != null)
            {
                this._image.dispose();
            }


            this._image = value;
        }

        public function set imageCallback(callback: int): void
        {
            this._imageCallback = callback;
        }

        public function get imageCallback(): int
        {
            return this._imageCallback;
        }

        public function get status(): int
        {
            return this._status;
        }

        public function get timeLeftMinutes(): int
        {
            return this._timeLeftMinutes;
        }

        public function set timeLeftMinutes(minutes: int): void
        {
            this._timeLeftMinutes = minutes;
        }

        public function set price(value: int): void
        {
            this._price = value;
        }

        public function set offerId(value: int): void
        {
            this._offerId = value;
        }

        public function get offerCount(): int
        {
            return this._offerCount;
        }

        public function set offerCount(count: int): void
        {
            this._offerCount = count;
        }

    }
}
