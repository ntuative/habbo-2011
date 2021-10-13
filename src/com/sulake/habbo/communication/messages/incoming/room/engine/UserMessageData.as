package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class UserMessageData 
    {

        public static const var_1648:String = "M";
        public static const var_1649:String = "F";

        private var _id:int = 0;
        private var _x:Number = 0;
        private var var_2497:Number = 0;
        private var var_2498:Number = 0;
        private var var_3035:int = 0;
        private var _name:String = "";
        private var var_3043:int = 0;
        private var var_3044:String = "";
        private var var_2534:String = "";
        private var var_3045:String = "";
        private var var_3046:int;
        private var var_3047:int = 0;
        private var var_3048:String = "";
        private var var_3049:int = 0;
        private var var_3050:int = 0;
        private var var_3051:String = "";
        private var var_3037:Boolean = false;

        public function UserMessageData(param1:int)
        {
            this._id = param1;
        }

        public function setReadOnly():void
        {
            this.var_3037 = true;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function set x(param1:Number):void
        {
            if (!this.var_3037)
            {
                this._x = param1;
            };
        }

        public function get y():Number
        {
            return (this.var_2497);
        }

        public function set y(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_2497 = param1;
            };
        }

        public function get z():Number
        {
            return (this.var_2498);
        }

        public function set z(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_2498 = param1;
            };
        }

        public function get dir():int
        {
            return (this.var_3035);
        }

        public function set dir(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3035 = param1;
            };
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(param1:String):void
        {
            if (!this.var_3037)
            {
                this._name = param1;
            };
        }

        public function get userType():int
        {
            return (this.var_3043);
        }

        public function set userType(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3043 = param1;
            };
        }

        public function get sex():String
        {
            return (this.var_3044);
        }

        public function set sex(param1:String):void
        {
            if (!this.var_3037)
            {
                this.var_3044 = param1;
            };
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function set figure(param1:String):void
        {
            if (!this.var_3037)
            {
                this.var_2534 = param1;
            };
        }

        public function get custom():String
        {
            return (this.var_3045);
        }

        public function set custom(param1:String):void
        {
            if (!this.var_3037)
            {
                this.var_3045 = param1;
            };
        }

        public function get achievementScore():int
        {
            return (this.var_3046);
        }

        public function set achievementScore(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3046 = param1;
            };
        }

        public function get webID():int
        {
            return (this.var_3047);
        }

        public function set webID(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3047 = param1;
            };
        }

        public function get groupID():String
        {
            return (this.var_3048);
        }

        public function set groupID(param1:String):void
        {
            if (!this.var_3037)
            {
                this.var_3048 = param1;
            };
        }

        public function get groupStatus():int
        {
            return (this.var_3049);
        }

        public function set groupStatus(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3049 = param1;
            };
        }

        public function get xp():int
        {
            return (this.var_3050);
        }

        public function set xp(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3050 = param1;
            };
        }

        public function get subType():String
        {
            return (this.var_3051);
        }

        public function set subType(param1:String):void
        {
            if (!this.var_3037)
            {
                this.var_3051 = param1;
            };
        }

    }
}