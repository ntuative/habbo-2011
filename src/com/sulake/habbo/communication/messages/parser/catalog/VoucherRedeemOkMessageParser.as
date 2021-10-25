package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoucherRedeemOkMessageParser implements IMessageParser
    {

        private var _productName: String = "";
        private var _productDescription: String = "";

        public function flush(): Boolean
        {
            this._productDescription = "";
            this._productName = "";
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._productDescription = data.readString();
            this._productName = data.readString();
            
            return true;
        }

        public function get productName(): String
        {
            return this._productName;
        }

        public function get productDescription(): String
        {
            return this._productDescription;
        }

    }
}
