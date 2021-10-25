package com.sulake.core.window.utils
{

    import com.sulake.core.runtime.IDisposable;

    public class TextMargins implements IMargins, IDisposable
    {

        private var _left: int;
        private var _right: int;
        private var _top: int;
        private var _bottom: int;
        private var _callback: Function;
        private var _disposed: Boolean = false;

        public function TextMargins(param1: int, param2: int, param3: int, param4: int, param5: Function)
        {
            this._left = param1;
            this._top = param2;
            this._right = param3;
            this._bottom = param4;
            this._callback = param5 != null ? param5 : this.nullCallback;
        }

        public function get left(): int
        {
            return this._left;
        }

        public function get right(): int
        {
            return this._right;
        }

        public function get top(): int
        {
            return this._top;
        }

        public function get bottom(): int
        {
            return this._bottom;
        }

        public function set left(param1: int): void
        {
            this._left = param1;
            this._callback(this);
        }

        public function set right(param1: int): void
        {
            this._right = param1;
            this._callback(this);
        }

        public function set top(param1: int): void
        {
            this._top = param1;
            this._callback(this);
        }

        public function set bottom(param1: int): void
        {
            this._bottom = param1;
            this._callback(this);
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get isZeroes(): Boolean
        {
            return this._left == 0 && this._right == 0 && this._top == 0 && this._bottom == 0;
        }

        public function assign(param1: int, param2: int, param3: int, param4: int, param5: Function): void
        {
            this._left = param1;
            this._top = param2;
            this._right = param3;
            this._bottom = param4;
            this._callback = param5 != null ? param5 : this.nullCallback;
        }

        public function clone(param1: Function): TextMargins
        {
            return new TextMargins(this._left, this._top, this._right, this._bottom, param1);
        }

        public function dispose(): void
        {
            this._callback = null;
            this._disposed = true;
        }

        private function nullCallback(param1: IMargins): void
        {
        }

    }
}
