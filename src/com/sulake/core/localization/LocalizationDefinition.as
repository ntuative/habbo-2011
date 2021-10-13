package com.sulake.core.localization
{
    public class LocalizationDefinition implements ILocalizationDefinition 
    {

        private var var_2165:String;
        private var var_2166:String;
        private var var_2167:String;
        private var _name:String;
        private var var_2104:String;

        public function LocalizationDefinition(param1:String, param2:String, param3:String)
        {
            var _loc4_:Array = param1.split("_");
            this.var_2165 = _loc4_[0];
            var _loc5_:Array = String(_loc4_[1]).split(".");
            this.var_2166 = _loc5_[0];
            this.var_2167 = _loc5_[1];
            this._name = param2;
            this.var_2104 = param3;
        }

        public function get id():String
        {
            return ((((this.var_2165 + "_") + this.var_2166) + ".") + this.var_2167);
        }

        public function get languageCode():String
        {
            return (this.var_2165);
        }

        public function get countryCode():String
        {
            return (this.var_2166);
        }

        public function get encoding():String
        {
            return (this.var_2167);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get url():String
        {
            return (this.var_2104);
        }

    }
}