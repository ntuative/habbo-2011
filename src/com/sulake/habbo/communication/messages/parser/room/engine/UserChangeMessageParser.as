package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserChangeMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int;
        private var var_2534:String;
        private var var_3044:String;
        private var var_3310:String;
        private var var_3046:int;

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function get sex():String
        {
            return (this.var_3044);
        }

        public function get customInfo():String
        {
            return (this.var_3310);
        }

        public function get achievementScore():int
        {
            return (this.var_3046);
        }

        public function flush():Boolean
        {
            this._id = 0;
            this.var_2534 = "";
            this.var_3044 = "";
            this.var_3310 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._id = param1.readInteger();
            this.var_2534 = param1.readString();
            this.var_3044 = param1.readString();
            this.var_3310 = param1.readString();
            this.var_3046 = param1.readInteger();
            if (this.var_3044)
            {
                this.var_3044 = this.var_3044.toUpperCase();
            };
            return (true);
        }

    }
}