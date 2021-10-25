package com.sulake.habbo.communication.messages.incoming.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageOfferData
    {

        private var _offerId: int;
        private var _localizationId: String;
        private var _priceInCredits: int;
        private var _priceInActivityPoints: int;
        private var _activityPointType: int;
        private var _products: Array;

        public function CatalogPageMessageOfferData(data: IMessageDataWrapper)
        {
            this._offerId = data.readInteger();
            this._localizationId = data.readString();
            this._priceInCredits = data.readInteger();
            this._priceInActivityPoints = data.readInteger();
            this._activityPointType = data.readInteger();
            this._products = [];

            var productCount: int = data.readInteger();
            var i: int;

            while (i < productCount)
            {
                this._products.push(new CatalogPageMessageProductData(data));
                i++;
            }

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

        public function get products(): Array
        {
            return this._products;
        }

        public function get activityPointType(): int
        {
            return this._activityPointType;
        }

    }
}
