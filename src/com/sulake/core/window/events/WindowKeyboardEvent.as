package com.sulake.core.window.events
{

    import flash.events.KeyboardEvent;
    import flash.events.Event;

    import com.sulake.core.window.IWindow;

    public class WindowKeyboardEvent extends WindowEvent
    {

        public static const var_715: String = "WKE_KEY_UP";
        public static const var_1156: String = "WKE_KEY_DOWN";
        private static const POOL: Array = [];

        private var var_2227: KeyboardEvent;

        public static function allocate(param1: String, param2: Event, param3: IWindow, param4: IWindow, param5: Boolean = false): WindowKeyboardEvent
        {
            var _loc6_: WindowKeyboardEvent = POOL.length > 0 ? POOL.pop() : new WindowKeyboardEvent();
            _loc6_._type = param1;
            _loc6_.var_2227 = (param2 as KeyboardEvent);
            _loc6_._window = param3;
            _loc6_._related = param4;
            _loc6_.var_2223 = false;
            _loc6_._cancelable = param5;
            _loc6_.var_2224 = POOL;
            return _loc6_;
        }

        public function get charCode(): uint
        {
            return this.var_2227.charCode;
        }

        public function get keyCode(): uint
        {
            return this.var_2227.keyCode;
        }

        public function get keyLocation(): uint
        {
            return this.var_2227.keyLocation;
        }

        public function get altKey(): Boolean
        {
            return this.var_2227.altKey;
        }

        public function get shiftKey(): Boolean
        {
            return this.var_2227.shiftKey;
        }

        override public function clone(): WindowEvent
        {
            return allocate(_type, this.var_2227, window, related, cancelable);
        }

        override public function toString(): String
        {
            return "WindowKeyboardEvent { type: " + _type + " cancelable: " + _cancelable + " window: " + _window + " charCode: " + this.charCode + " }";
        }

    }
}
