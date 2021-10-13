package com.sulake.habbo.room.object.visualization.room
{
    public class RoomPlaneBitmapMask 
    {

        private var _type:String = null;
        private var var_4250:Number = 0;
        private var var_4251:Number = 0;

        public function RoomPlaneBitmapMask(param1:String, param2:Number, param3:Number)
        {
            this._type = param1;
            this.var_4250 = param2;
            this.var_4251 = param3;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get leftSideLoc():Number
        {
            return (this.var_4250);
        }

        public function get rightSideLoc():Number
        {
            return (this.var_4251);
        }

    }
}