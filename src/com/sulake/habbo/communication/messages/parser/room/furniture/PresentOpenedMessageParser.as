package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PresentOpenedMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_2934:String;
        private var var_2935:int;
        private var var_2611:String;

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get itemType():String
        {
            return (this.var_2934);
        }

        public function get classId():int
        {
            return (this.var_2935);
        }

        public function get productCode():String
        {
            return (this.var_2611);
        }

        public function flush():Boolean
        {
            this.var_2934 = "";
            this.var_2935 = 0;
            this.var_2611 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_2934 = param1.readString();
            this.var_2935 = param1.readInteger();
            this.var_2611 = param1.readString();
            return (true);
        }

    }
}