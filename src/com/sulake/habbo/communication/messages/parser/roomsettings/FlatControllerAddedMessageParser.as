package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerAddedMessageParser implements IMessageParser 
    {

        private var var_2972:int;
        private var _data:FlatControllerData;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2972 = param1.readInteger();
            this._data = new FlatControllerData(param1);
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_2972);
        }

        public function get data():FlatControllerData
        {
            return (this._data);
        }

    }
}