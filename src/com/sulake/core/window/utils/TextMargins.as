package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public class TextMargins implements IMargins, IDisposable 
    {

        private var var_2307:int;
        private var _right:int;
        private var _top:int;
        private var var_2308:int;
        private var var_1095:Function;
        private var _disposed:Boolean = false;

        public function TextMargins(param1:int, param2:int, param3:int, param4:int, param5:Function)
        {
            this.var_2307 = param1;
            this._top = param2;
            this._right = param3;
            this.var_2308 = param4;
            this.var_1095 = ((param5 != null) ? param5 : this.nullCallback);
        }

        public function get left():int
        {
            return (this.var_2307);
        }

        public function get right():int
        {
            return (this._right);
        }

        public function get top():int
        {
            return (this._top);
        }

        public function get bottom():int
        {
            return (this.var_2308);
        }

        public function set left(param1:int):void
        {
            this.var_2307 = param1;
            this.var_1095(this);
        }

        public function set right(param1:int):void
        {
            this._right = param1;
            this.var_1095(this);
        }

        public function set top(param1:int):void
        {
            this._top = param1;
            this.var_1095(this);
        }

        public function set bottom(param1:int):void
        {
            this.var_2308 = param1;
            this.var_1095(this);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get isZeroes():Boolean
        {
            return ((((this.var_2307 == 0) && (this._right == 0)) && (this._top == 0)) && (this.var_2308 == 0));
        }

        public function assign(param1:int, param2:int, param3:int, param4:int, param5:Function):void
        {
            this.var_2307 = param1;
            this._top = param2;
            this._right = param3;
            this.var_2308 = param4;
            this.var_1095 = ((param5 != null) ? param5 : this.nullCallback);
        }

        public function clone(param1:Function):TextMargins
        {
            return (new TextMargins(this.var_2307, this._top, this._right, this.var_2308, param1));
        }

        public function dispose():void
        {
            this.var_1095 = null;
            this._disposed = true;
        }

        private function nullCallback(param1:IMargins):void
        {
        }

    }
}