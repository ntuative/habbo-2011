package com.sulake.habbo.catalog.marketplace
{

    public class MarketplaceItemStats
    {

        private var _averagePrice: int;
        private var _offerCount: int;
        private var _historyLength: int;
        private var _dayOffsets: Array;
        private var _averagePrices: Array;
        private var _soldAmounts: Array;
        private var _furniTypeId: int;
        private var _furniCategoryId: int;

        public function get averagePrice(): int
        {
            return this._averagePrice;
        }

        public function get offerCount(): int
        {
            return this._offerCount;
        }

        public function get historyLength(): int
        {
            return this._historyLength;
        }

        public function get dayOffsets(): Array
        {
            return this._dayOffsets;
        }

        public function get averagePrices(): Array
        {
            return this._averagePrices;
        }

        public function get soldAmounts(): Array
        {
            return this._soldAmounts;
        }

        public function get furniTypeId(): int
        {
            return this._furniTypeId;
        }

        public function get furniCategoryId(): int
        {
            return this._furniCategoryId;
        }

        public function set averagePrice(price: int): void
        {
            this._averagePrice = price;
        }

        public function set offerCount(count: int): void
        {
            this._offerCount = count;
        }

        public function set historyLength(length: int): void
        {
            this._historyLength = length;
        }

        public function set dayOffsets(offsets: Array): void
        {
            this._dayOffsets = offsets.slice();
        }

        public function set averagePrices(param1: Array): void
        {
            this._averagePrices = param1.slice();
        }

        public function set soldAmounts(param1: Array): void
        {
            this._soldAmounts = param1.slice();
        }

        public function set furniTypeId(param1: int): void
        {
            this._furniTypeId = param1;
        }

        public function set furniCategoryId(param1: int): void
        {
            this._furniCategoryId = param1;
        }

    }
}
