package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PurchaseOKMessageParser implements IMessageParser
    {

        private var _offer: CatalogPageMessageOfferData;

        public function get offer(): CatalogPageMessageOfferData
        {
            return this._offer;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._offer = new CatalogPageMessageOfferData(param1);
            
            return true;
        }

    }
}
