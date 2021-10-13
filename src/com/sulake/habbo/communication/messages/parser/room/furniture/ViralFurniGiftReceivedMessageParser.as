package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniGiftReceivedMessageParser implements IMessageParser 
    {

        private var var_3312:String;
        private var var_3313:Boolean;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3312 = param1.readString();
            this.var_3313 = param1.readBoolean();
            return (true);
        }

        public function get firstClickUserName():String
        {
            return (this.var_3312);
        }

        public function get giftWasReceived():Boolean
        {
            return (this.var_3313);
        }

    }
}