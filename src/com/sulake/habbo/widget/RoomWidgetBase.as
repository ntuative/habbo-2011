package com.sulake.habbo.widget
{

    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;

    import flash.events.IEventDispatcher;

    import com.sulake.core.window.IWindow;

    public class RoomWidgetBase implements IRoomWidget
    {

        private var _disposed: Boolean = false;
        private var _events: EventDispatcher;
        private var var_4418: IRoomWidgetMessageListener;
        private var _windowManager: IHabboWindowManager;
        protected var _assets: IAssetLibrary;
        protected var var_1364: IHabboLocalizationManager;

        public function RoomWidgetBase(param1: IHabboWindowManager, param2: IAssetLibrary = null, param3: IHabboLocalizationManager = null)
        {
            this._windowManager = param1;
            this._assets = param2;
            this.var_1364 = param3;
        }

        public function get state(): int
        {
            return 0;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function initialize(param1: int = 0): void
        {
        }

        public function dispose(): void
        {
            if (this.disposed)
            {
                return;
            }

            this.var_4418 = null;
            this._windowManager = null;
            if (this._events != null && !this._events.disposed)
            {
                this.unregisterUpdateEvents(this._events);
            }

            this._events = null;
            this._assets = null;
            this.var_1364 = null;
            this._disposed = true;
        }

        public function set messageListener(param1: IRoomWidgetMessageListener): void
        {
            this.var_4418 = param1;
        }

        public function get messageListener(): IRoomWidgetMessageListener
        {
            return this.var_4418;
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get assets(): IAssetLibrary
        {
            return this._assets;
        }

        public function get localizations(): IHabboLocalizationManager
        {
            return this.var_1364;
        }

        public function registerUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 is EventDispatcher)
            {
                this._events = (param1 as EventDispatcher);
            }

        }

        public function unregisterUpdateEvents(param1: IEventDispatcher): void
        {
        }

        public function get mainWindow(): IWindow
        {
            return null;
        }

    }
}
