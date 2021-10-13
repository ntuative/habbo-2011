package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.utils.ICaption;

    internal class AlertDialogCaption implements ICaption 
    {

        private var _text:String;
        private var var_4967:String;
        private var var_1023:Boolean;

        public function AlertDialogCaption(param1:String, param2:String, param3:Boolean)
        {
            this._text = param1;
            this.var_4967 = param2;
            this.var_1023 = param3;
        }

        public function get text():String
        {
            return (this._text);
        }

        public function set text(param1:String):void
        {
            this._text = param1;
        }

        public function get toolTip():String
        {
            return (this.var_4967);
        }

        public function set toolTip(param1:String):void
        {
            this.var_4967 = param1;
        }

        public function get visible():Boolean
        {
            return (this.var_1023);
        }

        public function set visible(param1:Boolean):void
        {
            this.var_1023 = param1;
        }

    }
}