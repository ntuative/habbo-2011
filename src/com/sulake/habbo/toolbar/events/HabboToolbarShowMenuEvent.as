package com.sulake.habbo.toolbar.events
{

    import flash.events.Event;

    import com.sulake.core.window.IWindowContainer;

    public class HabboToolbarShowMenuEvent extends Event
    {

        public static const HTSME_ANIMATE_MENU_IN: String = "HTSME_ANIMATE_MENU_IN";
        public static const HTSME_ANIMATE_MENU_OUT: String = "HTSME_ANIMATE_MENU_OUT";
        public static const HTSME_DISPLAY_WINDOW: String = "HTSME_DISPLAY_WINDOW";
        public static const HTSME_HIDE_WINDOW: String = "HTSME_HIDE_WINDOW";

        private var _menuId: String;
        private var _window: IWindowContainer;
        private var _alignToIcon: Boolean;

        public function HabboToolbarShowMenuEvent(type: String, menuId: String, window: IWindowContainer, alignToIcon: Boolean = true, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            this._menuId = menuId;
            this._window = window;
            this._alignToIcon = alignToIcon;

            super(type, bubbles, cancelable);
        }

        public function get menuId(): String
        {
            return this._menuId;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        public function get alignToIcon(): Boolean
        {
            return this._alignToIcon;
        }

    }
}
