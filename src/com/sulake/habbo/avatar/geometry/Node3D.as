package com.sulake.habbo.avatar.geometry
{
    public class Node3D 
    {

        private var var_2494:Vector3D;
        private var var_2495:Vector3D = new Vector3D();
        private var var_2496:Boolean = false;

        public function Node3D(param1:Number, param2:Number, param3:Number)
        {
            this.var_2494 = new Vector3D(param1, param2, param3);
            if ((((!(param1 == 0)) || (!(param2 == 0))) || (!(param3 == 0))))
            {
                this.var_2496 = true;
            };
        }

        public function get location():Vector3D
        {
            return (this.var_2494);
        }

        public function get transformedLocation():Vector3D
        {
            return (this.var_2495);
        }

        public function applyTransform(param1:Matrix4x4):void
        {
            if (this.var_2496)
            {
                this.var_2495 = param1.vectorMultiplication(this.var_2494);
            };
        }

    }
}