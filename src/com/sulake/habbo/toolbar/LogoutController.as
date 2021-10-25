package com.sulake.habbo.toolbar
{

    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;

    import flash.events.IEventDispatcher;

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    import flash.external.ExternalInterface;

    import com.sulake.core.window.events.WindowEvent;

    public class LogoutController
    {

        private const var_1147: int = 46;
        private const var_1149: int = 3;

        private var _windowManager: IHabboWindowManager;
        private var _assets: IAssetLibrary;
        private var _events: IEventDispatcher;
        private var _button: IWindowContainer;
        private var var_4524: IWindowContainer;

        public function LogoutController(param1: IHabboWindowManager, param2: IAssetLibrary, param3: IEventDispatcher)
        {
            var _loc4_: IWindow;
            super();
            this._windowManager = param1;
            this._assets = param2;
            this._events = param3;
            this._button = (this.createWindow("logout_xml") as IWindowContainer);
            _loc4_ = this._button.findChildByName("help_text");
            _loc4_.caption = "$" + "{" + _loc4_.caption + "}";
            _loc4_ = this._button.findChildByName("logout_text");
            _loc4_.caption = "$" + "{" + _loc4_.caption + "}";
        }

        public function dispose(): void
        {
            this._windowManager = null;
            this._assets = null;
            this._events = null;
            if (this._button)
            {
                this._button.dispose();
                this._button = null;
            }

            if (this.var_4524)
            {
                this.var_4524.dispose();
                this.var_4524 = null;
            }

        }

        private function createWindow(param1: String): IWindow
        {
            var _loc2_: XmlAsset = this._assets.getAssetByName(param1) as XmlAsset;
            var _loc3_: IWindow = this._windowManager.buildFromXML(_loc2_.content as XML);
            _loc3_.procedure = this.onClick;
            var _loc4_: IWindowContainer = _loc3_.desktop;
            _loc3_.x = _loc4_.width - _loc3_.width - this.var_1149;
            _loc3_.y = this.var_1147;
            return _loc3_;
        }

        private function showConfirmation(): void
        {
            if (!this.var_4524)
            {
                this.var_4524 = (this.createWindow("logout_confirmation_xml") as IWindowContainer);
            }

        }

        private function closeConfirmation(): void
        {
            if (this.var_4524)
            {
                this.var_4524.dispose();
                this.var_4524 = null;
            }

        }

        private function onClick(param1: WindowEvent, param2: IWindow): void
        {
            var _loc3_: HabboToolbarEvent;
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            switch (param2.name)
            {
                case "logout_region":
                    this.showConfirmation();
                    return;
                case "help_region":
                    _loc3_ = new HabboToolbarEvent(HabboToolbarEvent.HTE_TOOLBAR_CLICK);
                    _loc3_.iconId = HabboToolbarIconEnum.HELP;
                    this._events.dispatchEvent(_loc3_);
                    return;
                case "confirm":
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("FlashExternalInterface.logout");
                    }

                    this.closeConfirmation();
                    return;
                case "cancel":
                    this.closeConfirmation();
                    return;
            }

        }

    }
}
