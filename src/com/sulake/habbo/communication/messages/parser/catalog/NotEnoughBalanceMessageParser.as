package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NotEnoughBalanceMessageParser implements IMessageParser 
    {

        private var var_3135:int = 0;
        private var var_3136:int = 0;
        private var var_2831:int = 0;

        public function get notEnoughCredits():int
        {
            return (this.var_3135);
        }

        public function get notEnoughActivityPoints():int
        {
            return (this.var_3136);
        }

        public function get activityPointType():int
        {
            return (this.var_2831);
        }

        public function flush():Boolean
        {
            this.var_3135 = 0;
            this.var_3136 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3135 = param1.readInteger();
            this.var_3136 = param1.readInteger();
            this.var_2831 = param1.readInteger();
            return (true);
        }

    }
}