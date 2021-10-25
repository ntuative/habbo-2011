package com.sulake.core.window
{

    import com.sulake.core.runtime.IDisposable;

    import flash.geom.Rectangle;

    import com.sulake.core.window.utils.WindowRectLimits;
    import com.sulake.core.window.enum.WindowState;

    import flash.geom.Point;

    import com.sulake.core.window.utils.IRectLimiter;

    public class WindowModel implements IDisposable
    {

        protected var _current: Rectangle;
        protected var _initial: Rectangle;
        protected var _previous: Rectangle;
        protected var _minimized: Rectangle;
        protected var _maximized: Rectangle;
        protected var _limits: WindowRectLimits;
        protected var _context: WindowContext;
        protected var _background: Boolean = false;
        protected var _color: uint = 0xFFFFFF;
        protected var _alpha: uint;
        protected var _mouseThreshold: uint = 10;
        protected var _clipping: Boolean = true;
        protected var _visible: Boolean = true;
        protected var _blend: Number = 1;
        protected var _param: uint;
        protected var _state: uint;
        protected var _style: uint;
        protected var _type: uint;
        protected var _caption: String = "";
        protected var _name: String;
        protected var _id: uint;
        protected var _tags: Array;
        protected var _disposed: Boolean = false;

        public function WindowModel(id: uint, name: String, type: uint, style: uint, param: uint, context: WindowContext, rect: Rectangle, tags: Array = null)
        {
            this._id = id;
            this._name = name;
            this._type = type;
            this._param = param;
            this._state = WindowState.var_990;
            this._style = style;
            this._tags = tags == null ? [] : tags;
            this._context = context;
            this._current = rect.clone();
            this._initial = rect.clone();
            this._previous = rect.clone();
            this._minimized = new Rectangle();
            this._maximized = null;
            this._limits = new WindowRectLimits(this as IWindow);
        }

        public function get x(): int
        {
            return this._current.x;
        }

        public function get y(): int
        {
            return this._current.y;
        }

        public function get width(): int
        {
            return this._current.width;
        }

        public function get height(): int
        {
            return this._current.height;
        }

        public function get position(): Point
        {
            return this._current.topLeft;
        }

        public function get rectangle(): Rectangle
        {
            return this._current;
        }

        public function get limits(): IRectLimiter
        {
            return this._limits;
        }

        public function get context(): IWindowContext
        {
            return this._context;
        }

        public function get mouseThreshold(): uint
        {
            return this._mouseThreshold;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get background(): Boolean
        {
            return this._background;
        }

        public function get clipping(): Boolean
        {
            return this._clipping;
        }

        public function get visible(): Boolean
        {
            return this._visible;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function get alpha(): uint
        {
            return this._alpha >>> 24;
        }

        public function get blend(): Number
        {
            return this._blend;
        }

        public function get param(): uint
        {
            return this._param;
        }

        public function get state(): uint
        {
            return this._state;
        }

        public function get style(): uint
        {
            return this._style;
        }

        public function get type(): uint
        {
            return this._type;
        }

        public function get caption(): String
        {
            return this._caption;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get id(): uint
        {
            return this._id;
        }

        public function get tags(): Array
        {
            return this._tags;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this._current = null;
                this._context = null;
                this._state = WindowState.var_991;
                this._tags = null;
            }

        }

        public function invalidate(param1: Rectangle = null): void
        {
        }

        public function getInitialWidth(): int
        {
            return this._initial.width;
        }

        public function getInitialHeight(): int
        {
            return this._initial.height;
        }

        public function getPreviousWidth(): int
        {
            return this._previous.width;
        }

        public function getPreviousHeight(): int
        {
            return this._previous.height;
        }

        public function getMinimizedWidth(): int
        {
            return this._minimized.width;
        }

        public function getMinimizedHeight(): int
        {
            return this._minimized.height;
        }

        public function getMaximizedWidth(): int
        {
            return this._maximized.width;
        }

        public function getMaximizedHeight(): int
        {
            return this._maximized.height;
        }

        public function hasMaxWidth(): Boolean
        {
            return this._limits.maxWidth < int.MAX_VALUE;
        }

        public function getMaxWidth(): int
        {
            return this._limits.maxWidth;
        }

        public function setMaxWidth(maxWidth: int): int
        {
            var previous: int = this._limits.maxWidth;
            this._limits.maxWidth = maxWidth;

            return previous;
        }

        public function hasMinWidth(): Boolean
        {
            return this._limits.minWidth > int.MIN_VALUE;
        }

        public function getMinWidth(): int
        {
            return this._limits.minWidth;
        }

        public function setMinWidth(minWidth: int): int
        {
            var previous: int = this._limits.minWidth;
            this._limits.minWidth = minWidth;
            return previous;
        }

        public function hasMaxHeight(): Boolean
        {
            return this._limits.maxHeight < int.MAX_VALUE;
        }

        public function getMaxHeight(): int
        {
            return this._limits.maxHeight;
        }

        public function setMaxHeight(maxHeight: int): int
        {
            var previous: int = this._limits.maxHeight;
            this._limits.maxHeight = maxHeight;
            return previous;
        }

        public function hasMinHeight(): Boolean
        {
            return this._limits.minHeight > int.MIN_VALUE;
        }

        public function getMinHeight(): int
        {
            return this._limits.minHeight;
        }

        public function setMinHeight(minHeight: int): int
        {
            var previous: int = this._limits.minHeight;
            this._limits.minHeight = minHeight;
            return previous;
        }

        public function testTypeFlag(param1: uint, param2: uint = 0): Boolean
        {
            if (param2 > 0)
            {
                return (this._type & param2 ^ param1) == 0;
            }

            return (this._type & param1) == param1;
        }

        public function testStateFlag(param1: uint, param2: uint = 0): Boolean
        {
            if (param2 > 0)
            {
                return (this._state & param2 ^ param1) == 0;
            }

            return (this._state & param1) == param1;
        }

        public function testStyleFlag(param1: uint, param2: uint = 0): Boolean
        {
            if (param2 > 0)
            {
                return (this._style & param2 ^ param1) == 0;
            }

            return (this._style & param1) == param1;
        }

        public function testParamFlag(param1: uint, param2: uint = 0): Boolean
        {
            if (param2 > 0)
            {
                return (this._param & param2 ^ param1) == 0;
            }

            return (this._param & param1) == param1;
        }

    }
}
