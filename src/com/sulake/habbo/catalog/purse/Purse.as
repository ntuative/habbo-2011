package com.sulake.habbo.catalog.purse
{
    import flash.utils.Dictionary;

    public class Purse implements IPurse 
    {

        public static const var_142:int = 0;

        private var var_2696:int = 0;
        private var var_2697:Dictionary = new Dictionary();
        private var var_2698:int = 0;
        private var var_2699:int = 0;
        private var var_2700:Boolean = false;
        private var var_2701:int = 0;
        private var var_2702:int = 0;

        public function get credits():int
        {
            return (this.var_2696);
        }

        public function set credits(param1:int):void
        {
            this.var_2696 = param1;
        }

        public function get clubDays():int
        {
            return (this.var_2698);
        }

        public function set clubDays(param1:int):void
        {
            this.var_2698 = param1;
        }

        public function get clubPeriods():int
        {
            return (this.var_2699);
        }

        public function set clubPeriods(param1:int):void
        {
            this.var_2699 = param1;
        }

        public function get hasClubLeft():Boolean
        {
            return ((this.var_2698 > 0) || (this.var_2699 > 0));
        }

        public function get isVIP():Boolean
        {
            return (this.var_2700);
        }

        public function set isVIP(param1:Boolean):void
        {
            this.var_2700 = param1;
        }

        public function get pastClubDays():int
        {
            return (this.var_2701);
        }

        public function set pastClubDays(param1:int):void
        {
            this.var_2701 = param1;
        }

        public function get pastVipDays():int
        {
            return (this.var_2702);
        }

        public function set pastVipDays(param1:int):void
        {
            this.var_2702 = param1;
        }

        public function get activityPoints():Dictionary
        {
            return (this.var_2697);
        }

        public function set activityPoints(param1:Dictionary):void
        {
            this.var_2697 = param1;
        }

        public function getActivityPointsForType(param1:int):int
        {
            return (this.var_2697[param1]);
        }

    }
}