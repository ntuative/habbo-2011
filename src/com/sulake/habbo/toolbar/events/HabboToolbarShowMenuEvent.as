package com.sulake.habbo.toolbar.events
{
    import flash.events.Event;
    import com.sulake.core.window.IWindowContainer;

    public class HabboToolbarShowMenuEvent extends Event 
    {

        public static const var_146:String = "HTSME_ANIMATE_MENU_IN";
        public static const var_433:String = "HTSME_ANIMATE_MENU_OUT";
        public static const var_434:String = "HTSME_DISPLAY_WINDOW";
        public static const var_435:String = "HTSME_HIDE_WINDOW";

        private var var_4522:String;
        private var _window:IWindowContainer;
        private var var_4523:Boolean;

        public function HabboToolbarShowMenuEvent(param1:String, param2:String, param3:IWindowContainer, param4:Boolean=true, param5:Boolean=false, param6:Boolean=false)
        {
            this.var_4522 = param2;
            this._window = param3;
            this.var_4523 = param4;
            super(param1, param5, param6);
        }

        public function get menuId():String
        {
            return (this.var_4522);
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        public function get alignToIcon():Boolean
        {
            return (this.var_4523);
        }

    }
}