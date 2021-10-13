package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MessengerErrorMessageParser implements IMessageParser 
    {

        private var var_3152:int;
        private var var_2102:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3152 = param1.readInteger();
            this.var_2102 = param1.readInteger();
            return (true);
        }

        public function get clientMessageId():int
        {
            return (this.var_3152);
        }

        public function get errorCode():int
        {
            return (this.var_2102);
        }

    }
}