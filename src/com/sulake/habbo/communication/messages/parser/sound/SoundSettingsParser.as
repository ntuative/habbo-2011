package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SoundSettingsParser implements IMessageParser 
    {

        private var var_3346:int;

        public function get volume():int
        {
            return (this.var_3346);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3346 = param1.readInteger();
            return (true);
        }

    }
}