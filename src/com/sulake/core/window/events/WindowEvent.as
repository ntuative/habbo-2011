package com.sulake.core.window.events
{

    import com.sulake.core.window.IWindow;

    public class WindowEvent
    {

        public static const var_545: String = "WE_DESTROY";
        public static const var_546: String = "WE_DESTROYED";
        public static const var_547: String = "WE_OPEN";
        public static const var_548: String = "WE_OPENED";
        public static const var_549: String = "WE_CLOSE";
        public static const var_550: String = "WE_CLOSED";
        public static const var_551: String = "WE_FOCUS";
        public static const var_552: String = "WE_FOCUSED";
        public static const var_553: String = "WE_UNFOCUS";
        public static const var_554: String = "WE_UNFOCUSED";
        public static const var_555: String = "WE_ACTIVATE";
        public static const var_556: String = "WE_ACTIVATED";
        public static const var_557: String = "WE_DEACTIVATE";
        public static const var_558: String = "WE_DEACTIVATED";
        public static const var_559: String = "WE_SELECT";
        public static const var_560: String = "WE_SELECTED";
        public static const var_561: String = "WE_UNSELECT";
        public static const var_562: String = "WE_UNSELECTED";
        public static const var_563: String = "WE_LOCK";
        public static const var_564: String = "WE_LOCKED";
        public static const var_565: String = "WE_UNLOCK";
        public static const var_566: String = "WE_UNLOCKED";
        public static const var_567: String = "WE_ENABLE";
        public static const var_568: String = "WE_ENABLED";
        public static const var_569: String = "WE_DISABLE";
        public static const var_570: String = "WE_DISABLED";
        public static const WINDOW_EVENT_RELOCATE: String = "WE_RELOCATE";
        public static const var_571: String = "WE_RELOCATED";
        public static const var_572: String = "WE_RESIZE";
        public static const var_573: String = "WE_RESIZED";
        public static const var_574: String = "WE_MINIMIZE";
        public static const var_575: String = "WE_MINIMIZED";
        public static const var_576: String = "WE_MAXIMIZE";
        public static const var_577: String = "WE_MAXIMIZED";
        public static const var_578: String = "WE_RESTORE";
        public static const var_579: String = "WE_RESTORED";
        public static const var_580: String = "WE_CHILD_ADDED";
        public static const var_581: String = "WE_CHILD_REMOVED";
        public static const var_582: String = "WE_CHILD_RELOCATED";
        public static const var_583: String = "WE_CHILD_RESIZED";
        public static const var_584: String = "WE_CHILD_ACTIVATED";
        public static const var_585: String = "WE_PARENT_ADDED";
        public static const var_586: String = "WE_PARENT_REMOVED";
        public static const var_587: String = "WE_PARENT_RELOCATED";
        public static const var_588: String = "WE_PARENT_RESIZED";
        public static const var_589: String = "WE_PARENT_ACTIVATED";
        public static const var_138: String = "WE_OK";
        public static const var_139: String = "WE_CANCEL";
        public static const var_590: String = "WE_CHANGE";
        public static const var_591: String = "WE_SCROLL";
        public static const var_592: String = "";
        private static const POOL: Array = [];

        protected var _type: String;
        protected var _window: IWindow;
        protected var _related: IWindow;
        protected var _isDefaultPrevented: Boolean;
        protected var _cancelable: Boolean;
        protected var var_2223: Boolean;
        protected var var_2224: Array;

        public static function allocate(param1: String, param2: IWindow, param3: IWindow, param4: Boolean = false): WindowEvent
        {
            var _loc5_: WindowEvent = POOL.length > 0 ? POOL.pop() : new WindowEvent();
            _loc5_._type = param1;
            _loc5_._window = param2;
            _loc5_._related = param3;
            _loc5_._cancelable = param4;
            _loc5_.var_2223 = false;
            _loc5_.var_2224 = POOL;
            return _loc5_;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get target(): IWindow
        {
            return this._window;
        }

        public function get window(): IWindow
        {
            return this._window;
        }

        public function get related(): IWindow
        {
            return this._related;
        }

        public function get cancelable(): Boolean
        {
            return this._cancelable;
        }

        public function recycle(): void
        {
            if (this.var_2223)
            {
                throw new Error("Event already recycled!");
            }

            this._window = (this._related = null);
            this.var_2223 = true;
            this._isDefaultPrevented = false;
            this.var_2224.push(this);
        }

        public function clone(): WindowEvent
        {
            return allocate(this._type, this.window, this.related, this.cancelable);
        }

        public function preventDefault(): void
        {
            this.preventWindowOperation();
        }

        public function isDefaultPrevented(): Boolean
        {
            return this._isDefaultPrevented;
        }

        public function preventWindowOperation(): void
        {
            if (this.cancelable)
            {
                this._isDefaultPrevented = true;
            }
            else
            {
                throw new Error("Attempted to prevent window operation that is not cancelable!");
            }

        }

        public function isWindowOperationPrevented(): Boolean
        {
            return this._isDefaultPrevented;
        }

        public function stopPropagation(): void
        {
            this._isDefaultPrevented = true;
        }

        public function stopImmediatePropagation(): void
        {
            this._isDefaultPrevented = true;
        }

        public function toString(): String
        {
            return "WindowEvent { type: " + this._type + " cancelable: " + this._cancelable + " window: " + this._window + " }";
        }

    }
}
