package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CanCreateRoomMessageParser implements IMessageParser 
    {

        public static const var_1685:int = 0;
        public static const var_1686:int = 1;

        private var var_3129:int;
        private var var_3250:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3129 = param1.readInteger();
            this.var_3250 = param1.readInteger();
            return (true);
        }

        public function get resultCode():int
        {
            return (this.var_3129);
        }

        public function get roomLimit():int
        {
            return (this.var_3250);
        }

    }
}