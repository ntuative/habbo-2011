package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class UserUpdateMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var var_2497:Number = 0;
        private var var_2498:Number = 0;
        private var var_3052:Number = 0;
        private var var_3053:Number = 0;
        private var var_3054:Number = 0;
        private var var_3055:Number = 0;
        private var var_3035:int = 0;
        private var var_3056:int = 0;
        private var var_2390:Array = [];
        private var var_3057:Boolean = false;

        public function UserUpdateMessageData(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Array)
        {
            this._id = param1;
            this._x = param2;
            this.var_2497 = param3;
            this.var_2498 = param4;
            this.var_3052 = param5;
            this.var_3035 = param6;
            this.var_3056 = param7;
            this.var_3053 = param8;
            this.var_3054 = param9;
            this.var_3055 = param10;
            this.var_3057 = param11;
            this.var_2390 = param12;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function get y():Number
        {
            return (this.var_2497);
        }

        public function get z():Number
        {
            return (this.var_2498);
        }

        public function get localZ():Number
        {
            return (this.var_3052);
        }

        public function get targetX():Number
        {
            return (this.var_3053);
        }

        public function get targetY():Number
        {
            return (this.var_3054);
        }

        public function get targetZ():Number
        {
            return (this.var_3055);
        }

        public function get dir():int
        {
            return (this.var_3035);
        }

        public function get dirHead():int
        {
            return (this.var_3056);
        }

        public function get isMoving():Boolean
        {
            return (this.var_3057);
        }

        public function get actions():Array
        {
            return (this.var_2390.slice());
        }

    }
}