package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenMessageParser implements IMessageParser 
    {

        private var var_2900:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2900 = param1.readInteger();
            return (true);
        }

        public function get stuffId():int
        {
            return (this.var_2900);
        }

    }
}