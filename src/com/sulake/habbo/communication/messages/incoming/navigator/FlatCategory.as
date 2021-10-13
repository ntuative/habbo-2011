package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCategory 
    {

        private var var_2979:int;
        private var var_2980:String;
        private var var_1023:Boolean;

        public function FlatCategory(param1:IMessageDataWrapper)
        {
            this.var_2979 = param1.readInteger();
            this.var_2980 = param1.readString();
            this.var_1023 = param1.readBoolean();
        }

        public function get nodeId():int
        {
            return (this.var_2979);
        }

        public function get nodeName():String
        {
            return (this.var_2980);
        }

        public function get visible():Boolean
        {
            return (this.var_1023);
        }

    }
}