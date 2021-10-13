package com.sulake.habbo.session
{
    public class PetInfo implements IPetInfo 
    {

        private var var_3097:int;
        private var var_2924:int;
        private var var_4424:int;
        private var var_3324:int;
        private var var_4425:int;
        private var _energy:int;
        private var var_4426:int;
        private var _nutrition:int;
        private var var_4427:int;
        private var var_2975:int;
        private var _ownerName:String;
        private var var_3328:int;
        private var var_3329:int;

        public function get petId():int
        {
            return (this.var_3097);
        }

        public function get level():int
        {
            return (this.var_2924);
        }

        public function get levelMax():int
        {
            return (this.var_4424);
        }

        public function get experience():int
        {
            return (this.var_3324);
        }

        public function get experienceMax():int
        {
            return (this.var_4425);
        }

        public function get energy():int
        {
            return (this._energy);
        }

        public function get energyMax():int
        {
            return (this.var_4426);
        }

        public function get nutrition():int
        {
            return (this._nutrition);
        }

        public function get nutritionMax():int
        {
            return (this.var_4427);
        }

        public function get ownerId():int
        {
            return (this.var_2975);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get respect():int
        {
            return (this.var_3328);
        }

        public function get age():int
        {
            return (this.var_3329);
        }

        public function set petId(param1:int):void
        {
            this.var_3097 = param1;
        }

        public function set level(param1:int):void
        {
            this.var_2924 = param1;
        }

        public function set levelMax(param1:int):void
        {
            this.var_4424 = param1;
        }

        public function set experience(param1:int):void
        {
            this.var_3324 = param1;
        }

        public function set experienceMax(param1:int):void
        {
            this.var_4425 = param1;
        }

        public function set energy(param1:int):void
        {
            this._energy = param1;
        }

        public function set energyMax(param1:int):void
        {
            this.var_4426 = param1;
        }

        public function set nutrition(param1:int):void
        {
            this._nutrition = param1;
        }

        public function set nutritionMax(param1:int):void
        {
            this.var_4427 = param1;
        }

        public function set ownerId(param1:int):void
        {
            this.var_2975 = param1;
        }

        public function set ownerName(param1:String):void
        {
            this._ownerName = param1;
        }

        public function set respect(param1:int):void
        {
            this.var_3328 = param1;
        }

        public function set age(param1:int):void
        {
            this.var_3329 = param1;
        }

    }
}