package com.sulake.habbo.room
{
    public class PetColorResult 
    {

        private var var_4313:int = 0;
        private var var_4314:int = 0;

        public function PetColorResult(param1:int, param2:int)
        {
            this.var_4313 = (param1 & 0xFFFFFF);
            this.var_4314 = (param2 & 0xFFFFFF);
        }

        public function get primaryColor():int
        {
            return (this.var_4313);
        }

        public function get secondaryColor():int
        {
            return (this.var_4314);
        }

    }
}