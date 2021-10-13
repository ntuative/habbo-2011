package com.sulake.habbo.session
{
    public class UserData implements IUserData 
    {

        private var _id:int = -1;
        private var _name:String = "";
        private var _type:int = 0;
        private var var_3044:String = "";
        private var var_2534:String = "";
        private var var_3045:String = "";
        private var var_3046:int;
        private var var_3047:int = 0;
        private var var_3048:String = "";
        private var var_3049:int = 0;
        private var var_3050:int = 0;

        public function UserData(param1:int)
        {
            this._id = param1;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get achievementScore():int
        {
            return (this.var_3046);
        }

        public function set achievementScore(param1:int):void
        {
            this.var_3046 = param1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function get type():int
        {
            return (this._type);
        }

        public function set type(param1:int):void
        {
            this._type = param1;
        }

        public function get sex():String
        {
            return (this.var_3044);
        }

        public function set sex(param1:String):void
        {
            this.var_3044 = param1;
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function set figure(param1:String):void
        {
            this.var_2534 = param1;
        }

        public function get custom():String
        {
            return (this.var_3045);
        }

        public function set custom(param1:String):void
        {
            this.var_3045 = param1;
        }

        public function get webID():int
        {
            return (this.var_3047);
        }

        public function set webID(param1:int):void
        {
            this.var_3047 = param1;
        }

        public function get groupID():String
        {
            return (this.var_3048);
        }

        public function set groupID(param1:String):void
        {
            this.var_3048 = param1;
        }

        public function get groupStatus():int
        {
            return (this.var_3049);
        }

        public function set groupStatus(param1:int):void
        {
            this.var_3049 = param1;
        }

        public function get xp():int
        {
            return (this.var_3050);
        }

        public function set xp(param1:int):void
        {
            this.var_3050 = param1;
        }

    }
}