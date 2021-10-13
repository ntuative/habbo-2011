package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerRemovedMessageParser implements IMessageParser 
    {

        private var var_2972:int;
        private var _userId:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2972 = param1.readInteger();
            this._userId = param1.readInteger();
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_2972);
        }

        public function get userId():int
        {
            return (this._userId);
        }

    }
}