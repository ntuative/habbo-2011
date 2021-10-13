package com.sulake.core.window.utils
{
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContextStateListener;

    public class EventProcessorState 
    {

        public var renderer:IWindowRenderer;
        public var desktop:IDesktopWindow;
        public var var_1766:IWindow;
        public var var_1767:IWindow;
        public var var_1768:IWindowContextStateListener;

        public function EventProcessorState(param1:IWindowRenderer, param2:IDesktopWindow, param3:IWindow, param4:IWindow, param5:IWindowContextStateListener)
        {
            this.renderer = param1;
            this.desktop = param2;
            this.var_1766 = param3;
            this.var_1767 = param4;
            this.var_1768 = param5;
        }

    }
}