package com.sulake.habbo.avatar.structure.parts
{
    public class PartDefinition 
    {

        private var var_2524:String;
        private var var_2525:String;
        private var var_2526:String;
        private var var_2527:Boolean;
        private var var_2528:int = -1;

        public function PartDefinition(param1:XML)
        {
            this.var_2524 = String(param1.@["set-type"]);
            this.var_2525 = String(param1.@["flipped-set-type"]);
            this.var_2526 = String(param1.@["remove-set-type"]);
            this.var_2527 = false;
        }

        public function hasStaticId():Boolean
        {
            return (this.var_2528 >= 0);
        }

        public function get staticId():int
        {
            return (this.var_2528);
        }

        public function set staticId(param1:int):void
        {
            this.var_2528 = param1;
        }

        public function get setType():String
        {
            return (this.var_2524);
        }

        public function get flippedSetType():String
        {
            return (this.var_2525);
        }

        public function get removeSetType():String
        {
            return (this.var_2526);
        }

        public function get appendToFigure():Boolean
        {
            return (this.var_2527);
        }

        public function set appendToFigure(param1:Boolean):void
        {
            this.var_2527 = param1;
        }

        public function set flippedSetType(param1:String):void
        {
            this.var_2525 = param1;
        }

    }
}