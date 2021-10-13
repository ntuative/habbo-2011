package com.sulake.habbo.help.help.data
{
    public class FaqItem 
    {

        private var var_3086:int;
        private var var_3475:String;
        private var var_3187:String;
        private var _index:int;
        private var _category:FaqCategory;
        private var var_3476:Boolean = false;

        public function FaqItem(param1:int, param2:String, param3:int, param4:FaqCategory)
        {
            this.var_3086 = param1;
            this.var_3475 = param2;
            this._index = param3;
            this._category = param4;
        }

        public function get questionId():int
        {
            return (this.var_3086);
        }

        public function get questionText():String
        {
            return (this.var_3475);
        }

        public function get answerText():String
        {
            return (this.var_3187);
        }

        public function get hasAnswer():Boolean
        {
            return (this.var_3476);
        }

        public function get index():int
        {
            return (this._index);
        }

        public function get category():FaqCategory
        {
            return (this._category);
        }

        public function set answerText(param1:String):void
        {
            this.var_3187 = param1;
            this.var_3476 = true;
        }

    }
}