package com.sulake.habbo.communication.messages.incoming.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubOfferData
    {

        private var _offerId: int;
        private var _productCode: String;
        private var _price: int;
        private var _upgrade: Boolean;
        private var _vip: Boolean;
        private var _periods: int;
        private var _daysLeftAfterPurchase: int;
        private var _year: int;
        private var _month: int;
        private var _day: int;

        public function ClubOfferData(data: IMessageDataWrapper)
        {
            this._offerId = data.readInteger();
            this._productCode = data.readString();
            this._price = data.readInteger();
            this._upgrade = data.readBoolean();
            this._vip = data.readBoolean();
            this._periods = data.readInteger();
            this._daysLeftAfterPurchase = data.readInteger();
            this._year = data.readInteger();
            this._month = data.readInteger();
            this._day = data.readInteger();
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

    }
}
