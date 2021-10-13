package com.sulake.habbo.toolbar
{
    public class MenuSettingsItem 
    {

        private var var_4522:String;
        private var var_4527:Array;
        private var var_4526:Boolean;

        public function MenuSettingsItem(param1:String, param2:Array=null, param3:Boolean=false)
        {
            this.var_4522 = param1;
            this.var_4527 = param2;
            this.var_4526 = param3;
        }

        public function get menuId():String
        {
            return (this.var_4522);
        }

        public function get yieldList():Array
        {
            return (this.var_4527);
        }

        public function get lockToIcon():Boolean
        {
            return (this.var_4526);
        }

    }
}