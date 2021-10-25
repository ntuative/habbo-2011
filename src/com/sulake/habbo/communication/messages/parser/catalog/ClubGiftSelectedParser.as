package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftSelectedParser implements IMessageParser
    {

        private var _productCode: String;
        private var _products: Array;

        public function flush(): Boolean
        {
            this._products = [];

            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._products = [];
            this._productCode = param1.readString();
            
            var productCount: int = param1.readInteger();
            var i: int;
            
            while (i < productCount)
            {
                this._products.push(new CatalogPageMessageProductData(param1));
                i++;
            }

            return true;
        }

        public function get productCode(): String
        {
            return this._productCode;
        }

        public function get products(): Array
        {
            return this._products;
        }

    }
}
