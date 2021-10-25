package com.sulake.habbo.communication.messages.parser.marketplace
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceConfigurationParser implements IMessageParser
    {

        private var _isEnabled: Boolean;
        private var _commission: int;
        private var _tokenBatchPrice: int;
        private var _tokenBatchSize: int;
        private var _offerMaxPrice: int;
        private var _offerMinPrice: int;
        private var _expirationHours: int;
        private var _averagePricePriod: int;

        public function get isEnabled(): Boolean
        {
            return this._isEnabled;
        }

        public function get commission(): int
        {
            return this._commission;
        }

        public function get tokenBatchPrice(): int
        {
            return this._tokenBatchPrice;
        }

        public function get tokenBatchSize(): int
        {
            return this._tokenBatchSize;
        }

        public function get offerMinPrice(): int
        {
            return this._offerMinPrice;
        }

        public function get offerMaxPrice(): int
        {
            return this._offerMaxPrice;
        }

        public function get expirationHours(): int
        {
            return this._expirationHours;
        }

        public function get averagePricePeriod(): int
        {
            return this._averagePricePriod;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._isEnabled = data.readBoolean();
            this._commission = data.readInteger();
            this._tokenBatchPrice = data.readInteger();
            this._tokenBatchSize = data.readInteger();
            this._offerMinPrice = data.readInteger();
            this._offerMaxPrice = data.readInteger();
            this._expirationHours = data.readInteger();
            this._averagePricePriod = data.readInteger();
            
            return true;
        }

    }
}
