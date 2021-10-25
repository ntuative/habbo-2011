package com.sulake.habbo.communication.messages.parser.marketplace
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceItemStatsParser implements IMessageParser
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

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._averagePrice = data.readInteger();
            this._offerCount = data.readInteger();
            this._historyLength = data.readInteger();
            this._dayOffsets = [];
            this._averagePrices = [];
            this._soldAmounts = [];
            
            var itemStats: int = data.readInteger();
            var i: int;
            
            while (i < itemStats)
            {
                this._dayOffsets.push(data.readInteger());
                this._averagePrices.push(data.readInteger());
                this._soldAmounts.push(data.readInteger());
                
                i++;
            }

            this._furniCategoryId = data.readInteger();
            this._furniTypeId = data.readInteger();

            return true;
        }

    }
}
