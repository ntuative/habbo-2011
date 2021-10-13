package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoucherRedeemOkMessageParser implements IMessageParser 
    {

        private var var_2763:String = "";
        private var var_2764:String = "";

        public function flush():Boolean
        {
            this.var_2764 = "";
            this.var_2763 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2764 = param1.readString();
            this.var_2763 = param1.readString();
            return (true);
        }

        public function get productName():String
        {
            return (this.var_2763);
        }

        public function get productDescription():String
        {
            return (this.var_2764);
        }

    }
}