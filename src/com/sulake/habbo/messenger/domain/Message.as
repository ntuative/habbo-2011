package com.sulake.habbo.messenger.domain
{
    public class Message 
    {

        public static const var_1433:int = 1;
        public static const var_307:int = 2;
        public static const var_1434:int = 3;
        public static const var_309:int = 4;
        public static const var_1435:int = 5;
        public static const var_308:int = 6;

        private var _type:int;
        private var var_3158:int;
        private var var_3159:String;
        private var var_3625:String;

        public function Message(param1:int, param2:int, param3:String, param4:String)
        {
            this._type = param1;
            this.var_3158 = param2;
            this.var_3159 = param3;
            this.var_3625 = param4;
        }

        public function get messageText():String
        {
            return (this.var_3159);
        }

        public function get time():String
        {
            return (this.var_3625);
        }

        public function get senderId():int
        {
            return (this.var_3158);
        }

        public function get type():int
        {
            return (this._type);
        }

    }
}