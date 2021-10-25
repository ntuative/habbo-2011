package com.sulake.habbo.communication.messages.parser.marketplace
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketPlaceOwnOffersParser implements IMessageParser
    {

        private const _maximumOffers: int = 500;

        private var _offers: Array;
        private var _creditsWaiting: int;

        public function flush(): Boolean
        {
            this._offers = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            var offerId: int;
            var status: int;
            var furniType: int;
            var furniId: int;
            var stuffData: String;
            var price: int;
            var timeLeftMinutes: int;
            var averagePrice: int;
            var marketPlaceOffer: MarketPlaceOffer;

            this._offers = [];
            this._creditsWaiting = param1.readInteger();
            
            var offerCount: int = param1.readInteger();
            var i: int;

            while (i < offerCount)
            {
                offerId = param1.readInteger();
                status = param1.readInteger();
                furniType = param1.readInteger();
                furniId = param1.readInteger();
                stuffData = param1.readString();
                price = param1.readInteger();
                timeLeftMinutes = param1.readInteger();
                averagePrice = param1.readInteger();
                
                marketPlaceOffer = new MarketPlaceOffer(offerId, furniId, furniType, stuffData, price, status, timeLeftMinutes, averagePrice);
                
                if (i < this._maximumOffers)
                {
                    this._offers.push(marketPlaceOffer);
                }

                i++;
            }

            return true;
        }

        public function get offers(): Array
        {
            return this._offers;
        }

        public function get creditsWaiting(): int
        {
            return this._creditsWaiting;
        }

    }
}
