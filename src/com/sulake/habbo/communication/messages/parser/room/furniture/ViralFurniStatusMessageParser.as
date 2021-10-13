package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniStatusMessageParser implements IMessageParser 
    {

        private var var_3314:String;
        private var var_2358:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3315:int = 0;
        private var var_2101:int;
        private var _shareId:String;
        private var var_3312:String;

        public function get campaignID():String
        {
            return (this.var_3314);
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get itemCategory():int
        {
            return (this.var_3315);
        }

        public function get shareId():String
        {
            return (this._shareId);
        }

        public function get status():int
        {
            return (this.var_2101);
        }

        public function get firstClickUserName():String
        {
            return (this.var_3312);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3314 = param1.readString();
            this.var_2358 = param1.readInteger();
            this.var_2101 = param1.readInteger();
            this._shareId = param1.readString();
            this.var_3312 = param1.readString();
            this.var_3315 = param1.readInteger();
            return (true);
        }

    }
}