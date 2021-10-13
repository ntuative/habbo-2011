package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityTimeMessageParser implements IMessageParser 
    {

        private var var_2667:Boolean;
        private var var_3125:int;

        public function get isOpen():Boolean
        {
            return (this.var_2667);
        }

        public function get minutesUntilChange():int
        {
            return (this.var_3125);
        }

        public function flush():Boolean
        {
            this.var_2667 = false;
            this.var_3125 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2667 = (param1.readInteger() > 0);
            this.var_3125 = param1.readInteger();
            return (true);
        }

    }
}