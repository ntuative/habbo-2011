package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogLocalizationData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageParser implements IMessageParser
    {

        private var _pageId: int;
        private var _layoutCode: String;
        private var _localization: CatalogLocalizationData;
        private var _offers: Array;
        private var _offerId: int;

        public function get pageId(): int
        {
            return this._pageId;
        }

        public function get layoutCode(): String
        {
            return this._layoutCode;
        }

        public function get localization(): CatalogLocalizationData
        {
            return this._localization;
        }

        public function get offers(): Array
        {
            return this._offers;
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function flush(): Boolean
        {
            this._pageId = -1;
            this._layoutCode = "";
            this._localization = null;
            this._offers = [];
            this._offerId = -1;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._pageId = data.readInteger();
            this._layoutCode = data.readString();
            this._localization = new CatalogLocalizationData(data);
            this._offers = [];
            
            var offerCount: int = data.readInteger();
            var i: int;
           
            while (i < offerCount)
            {
                this._offers.push(new CatalogPageMessageOfferData(data));
                i++;
            }

            this._offerId = data.readInteger();

            return true;
        }

    }
}
