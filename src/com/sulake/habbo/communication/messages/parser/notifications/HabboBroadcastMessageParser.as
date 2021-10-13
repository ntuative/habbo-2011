package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboBroadcastMessageParser implements IMessageParser 
    {

        private var var_3159:String = "";

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3159 = param1.readString();
            return (true);
        }

        public function get messageText():String
        {
            return (this.var_3159);
        }

    }
}