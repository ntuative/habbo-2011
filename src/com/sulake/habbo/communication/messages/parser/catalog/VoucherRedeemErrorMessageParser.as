package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoucherRedeemErrorMessageParser implements IMessageParser 
    {

        private var var_2102:String = "";

        public function flush():Boolean
        {
            this.var_2102 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2102 = param1.readString();
            return (true);
        }

        public function get errorCode():String
        {
            return (this.var_2102);
        }

    }
}