package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftInfoParser implements IMessageParser
    {

        private var _daysUntilNextGift: int;
        private var _giftsAvailable: int;
        private var _offers: Array;
        private var _giftData: Map;

        public function flush(): Boolean
        {
            this._offers = [];
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._daysUntilNextGift = data.readInteger();
            this._giftsAvailable = data.readInteger();
            this._offers = [];
            
            var itemCount: int = data.readInteger();
            var i: int = 0;
            
            while (i < itemCount)
            {
                this._offers.push(new CatalogPageMessageOfferData(data));
                i++;
            }

            this._giftData = new Map();
            var clubGiftData: ClubGiftData;
            
            itemCount = data.readInteger();
            i = 0;
            
            while (i < itemCount)
            {
                clubGiftData = new ClubGiftData(data);
                this._giftData.add(clubGiftData.offerId, clubGiftData);
                i++;
            }

            return true;
        }

        public function get daysUntilNextGift(): int
        {
            return this._daysUntilNextGift;
        }

        public function get giftsAvailable(): int
        {
            return this._giftsAvailable;
        }

        public function get offers(): Array
        {
            return this._offers;
        }

        public function get giftData(): Map
        {
            return this._giftData;
        }

    }
}
