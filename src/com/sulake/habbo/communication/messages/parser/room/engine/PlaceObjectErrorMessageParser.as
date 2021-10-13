package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PlaceObjectErrorMessageParser implements IMessageParser 
    {

        private var var_2102:int;

        public function get errorCode():int
        {
            return (this.var_2102);
        }

        public function flush():Boolean
        {
            this.var_2102 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2102 = param1.readInteger();
            return (true);
        }

    }
}