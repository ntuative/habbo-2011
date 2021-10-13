package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PurchaseOKMessageParser implements IMessageParser 
    {

        private var var_2607:CatalogPageMessageOfferData;

        public function get offer():CatalogPageMessageOfferData
        {
            return (this.var_2607);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2607 = new CatalogPageMessageOfferData(param1);
            return (true);
        }

    }
}