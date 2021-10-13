package com.sulake.habbo.inventory.purse
{
    public class Purse 
    {

        private var var_2698:int = 0;
        private var var_2699:int = 0;
        private var var_3582:int = 0;
        private var var_3583:Boolean = false;
        private var var_2700:Boolean = false;

        public function set clubDays(param1:int):void
        {
            this.var_2698 = Math.max(0, param1);
        }

        public function set clubPeriods(param1:int):void
        {
            this.var_2699 = Math.max(0, param1);
        }

        public function set clubPastPeriods(param1:int):void
        {
            this.var_3582 = Math.max(0, param1);
        }

        public function set clubHasEverBeenMember(param1:Boolean):void
        {
            this.var_3583 = param1;
        }

        public function set isVIP(param1:Boolean):void
        {
            this.var_2700 = param1;
        }

        public function get clubDays():int
        {
            return (this.var_2698);
        }

        public function get clubPeriods():int
        {
            return (this.var_2699);
        }

        public function get clubPastPeriods():int
        {
            return (this.var_3582);
        }

        public function get clubHasEverBeenMember():Boolean
        {
            return (this.var_3583);
        }

        public function get isVIP():Boolean
        {
            return (this.var_2700);
        }

    }
}