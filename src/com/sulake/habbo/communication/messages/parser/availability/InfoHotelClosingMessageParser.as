package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoHotelClosingMessageParser implements IMessageParser 
    {

        private var var_3128:int;

        public function get minutesUntilClosing():int
        {
            return (this.var_3128);
        }

        public function flush():Boolean
        {
            this.var_3128 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3128 = param1.readInteger();
            return (true);
        }

    }
}