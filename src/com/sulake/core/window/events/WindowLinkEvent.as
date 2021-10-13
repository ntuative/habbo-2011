package com.sulake.core.window.events
{
    import com.sulake.core.window.IWindow;

    public class WindowLinkEvent extends WindowEvent 
    {

        public static const var_1788:String = "WE_LINK";
        private static const POOL:Array = [];

        private var var_2228:String;

        public function WindowLinkEvent()
        {
            _type = var_1788;
        }

        public static function allocate(param1:String, param2:IWindow, param3:IWindow):WindowEvent
        {
            var _loc4_:WindowLinkEvent = ((POOL.length > 0) ? POOL.pop() : new (WindowLinkEvent)());
            _loc4_.var_2228 = param1;
            _loc4_._window = param2;
            _loc4_.var_2225 = param3;
            _loc4_.var_2223 = false;
            _loc4_.var_2224 = POOL;
            return (_loc4_);
        }

        public function get link():String
        {
            return (this.var_2228);
        }

        override public function clone():WindowEvent
        {
            return (allocate(this.var_2228, window, related));
        }

        override public function toString():String
        {
            return (((((((("WindowLinkEvent { type: " + _type) + " link: ") + this.link) + " cancelable: ") + var_642) + " window: ") + _window) + " }");
        }

    }
}