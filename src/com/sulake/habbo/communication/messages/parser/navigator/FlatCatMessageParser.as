package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCatMessageParser implements IMessageParser 
    {

        private var var_2972:int;
        private var var_2979:int;

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2972 = param1.readInteger();
            this.var_2979 = param1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            this.var_2972 = 0;
            this.var_2979 = 0;
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_2972);
        }

        public function get nodeId():int
        {
            return (this.var_2979);
        }

    }
}