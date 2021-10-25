package com.sulake.core.window.utils
{

    import com.sulake.core.window.IWindow;

    public class WindowRectLimits implements IRectLimiter
    {

        private var _minWidth: int = -2147483648;
        private var _maxWidth: int = 2147483647;
        private var _minHeight: int = -2147483648;
        private var _maxHeight: int = 2147483647;
        private var _target: IWindow;

        public function WindowRectLimits(param1: IWindow)
        {
            this._target = param1;
        }

        public function get minWidth(): int
        {
            return this._minWidth;
        }

        public function get maxWidth(): int
        {
            return this._maxWidth;
        }

        public function get minHeight(): int
        {
            return this._minHeight;
        }

        public function get maxHeight(): int
        {
            return this._maxHeight;
        }

        public function set minWidth(param1: int): void
        {
            this._minWidth = param1;
            if (this._minWidth > int.MIN_VALUE && !this._target.disposed && this._target.width < this._minWidth)
            {
                this._target.width = this._minWidth;
            }

        }

        public function set maxWidth(param1: int): void
        {
            this._maxWidth = param1;
            if (this._maxWidth < int.MAX_VALUE && !this._target.disposed && this._target.width > this._maxWidth)
            {
                this._target.width = this._maxWidth;
            }

        }

        public function set minHeight(param1: int): void
        {
            this._minHeight = param1;
            if (this._minHeight > int.MIN_VALUE && !this._target.disposed && this._target.height < this._minHeight)
            {
                this._target.height = this._minHeight;
            }

        }

        public function set maxHeight(param1: int): void
        {
            this._maxHeight = param1;
            if (this._maxHeight < int.MAX_VALUE && !this._target.disposed && this._target.height > this._maxHeight)
            {
                this._target.height = this._maxHeight;
            }

        }

        public function get isEmpty(): Boolean
        {
            return this._minWidth == int.MIN_VALUE && this._maxWidth == int.MAX_VALUE && this._minHeight == int.MIN_VALUE && this._maxHeight == int.MAX_VALUE;
        }

        public function setEmpty(): void
        {
            this._minWidth = int.MIN_VALUE;
            this._maxWidth = int.MAX_VALUE;
            this._minHeight = int.MIN_VALUE;
            this._maxHeight = int.MAX_VALUE;
        }

        public function limit(): void
        {
            if (!this.isEmpty && this._target)
            {
                if (this._target.width < this._minWidth)
                {
                    this._target.width = this._minWidth;
                }
                else
                {
                    if (this._target.width > this._maxWidth)
                    {
                        this._target.width = this._maxWidth;
                    }

                }

                if (this._target.height < this._minHeight)
                {
                    this._target.height = this._minHeight;
                }
                else
                {
                    if (this._target.height > this._maxHeight)
                    {
                        this._target.height = this._maxHeight;
                    }

                }

            }

        }

        public function assign(param1: int, param2: int, param3: int, param4: int): void
        {
            this._minWidth = param1;
            this._maxWidth = param2;
            this._minHeight = param3;
            this._maxHeight = param4;
            this.limit();
        }

        public function clone(window: IWindow): WindowRectLimits
        {
            var copy: WindowRectLimits = new WindowRectLimits(window);

            copy._minWidth = this._minWidth;
            copy._maxWidth = this._maxWidth;
            copy._minHeight = this._minHeight;
            copy._maxHeight = this._maxHeight;

            return copy;
        }

    }
}
