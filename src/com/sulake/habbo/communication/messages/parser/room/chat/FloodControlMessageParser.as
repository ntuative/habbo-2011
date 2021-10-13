package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FloodControlMessageParser implements IMessageParser 
    {

        private var var_3295:int = 0;

        public function get seconds():int
        {
            return (this.var_3295);
        }

        public function flush():Boolean
        {
            this.var_3295 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3295 = param1.readInteger();
            return (true);
        }

    }
}