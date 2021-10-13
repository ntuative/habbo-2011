package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityStatusMessageParser implements IMessageParser 
    {

        private var var_2667:Boolean;
        private var var_3124:Boolean;

        public function get isOpen():Boolean
        {
            return (this.var_2667);
        }

        public function get onShutDown():Boolean
        {
            return (this.var_3124);
        }

        public function flush():Boolean
        {
            this.var_2667 = false;
            this.var_3124 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2667 = (param1.readInteger() > 0);
            this.var_3124 = (param1.readInteger() > 0);
            return (true);
        }

    }
}