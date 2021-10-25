package com.sulake.habbo.communication.messages.parser.marketplace
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceBuyOfferResultParser implements IMessageParser
    {

        private var _result: int;
        private var _offerId: int = -1;
        private var _newPrice: int = -1;
        private var _requestedOfferId: int = -1;

        public function get result(): int
        {
            return this._result;
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function get newPrice(): int
        {
            return this._newPrice;
        }

        public function get requestedOfferId(): int
        {
            return this._requestedOfferId;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._result = data.readInteger();
            this._offerId = data.readInteger();
            this._newPrice = data.readInteger();
            this._requestedOfferId = data.readInteger();
            
            return true;
        }

    }
}
