package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoucherRedeemErrorMessageParser implements IMessageParser
    {

        private var _errorCode: String = "";

        public function flush(): Boolean
        {
            this._errorCode = "";
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._errorCode = data.readString();

            return true;
        }

        public function get errorCode(): String
        {
            return this._errorCode;
        }

    }
}
