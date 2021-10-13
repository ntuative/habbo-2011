package com.sulake.habbo.room.object
{
    public class RoomPlaneMaskData 
    {

        private var var_4250:Number = 0;
        private var var_4251:Number = 0;
        private var var_4252:Number = 0;
        private var var_4253:Number = 0;

        public function RoomPlaneMaskData(param1:Number, param2:Number, param3:Number, param4:Number)
        {
            this.var_4250 = param1;
            this.var_4251 = param2;
            this.var_4252 = param3;
            this.var_4253 = param4;
        }

        public function get leftSideLoc():Number
        {
            return (this.var_4250);
        }

        public function get rightSideLoc():Number
        {
            return (this.var_4251);
        }

        public function get leftSideLength():Number
        {
            return (this.var_4252);
        }

        public function get rightSideLength():Number
        {
            return (this.var_4253);
        }

    }
}