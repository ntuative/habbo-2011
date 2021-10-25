package com.sulake.habbo.communication.messages.incoming.marketplace
{

    public class MarketPlaceOffer
    {

        private var _offerId: int;
        private var _furniId: int;
        private var _furniType: int;
        private var _stuffData: String;
        private var _price: int;
        private var _status: int;
        private var _timeLeftMinutes: int = -1;
        private var _averagePrice: int;
        private var _offerCount: int;

        public function MarketPlaceOffer(offerId: int, furniId: int, furniType: int, stuffData: String, price: int, status: int, timeLeftMinutes: int, averagePrice: int, offerCount: int = -1)
        {
            this._offerId = offerId;
            this._furniId = furniId;
            this._furniType = furniType;
            this._stuffData = stuffData;
            this._price = price;
            this._status = status;
            this._timeLeftMinutes = timeLeftMinutes;
            this._averagePrice = averagePrice;
            this._offerCount = offerCount;
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

        public function get status(): int
        {
            return this._status;
        }

        public function get timeLeftMinutes(): int
        {
            return this._timeLeftMinutes;
        }

        public function get averagePrice(): int
        {
            return this._averagePrice;
        }

        public function get offerCount(): int
        {
            return this._offerCount;
        }

    }
}
