package com.sulake.habbo.help.help
{

    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;

    import flash.utils.Dictionary;

    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class HelpViewController implements IHelpViewController
    {

        private var _main: HelpUI;
        private var _windowManager: IHabboWindowManager;
        private var _assetLibrary: IAssetLibrary;
        private var _container: IWindowContainer;
        private var _roomSessionActive: Boolean = false;
        private var _disposed: Boolean = true;

        public function HelpViewController(main: HelpUI, windowManager: IHabboWindowManager, assetLibrary: IAssetLibrary)
        {
            this._main = main;
            this._windowManager = windowManager;
            this._assetLibrary = assetLibrary;
        }

        public function dispose(): void
        {
            if (this._container != null)
            {
                this._container.dispose();
                this._container = null;
            }

            this._disposed = true;
        }

        public function render(): void
        {
            this._disposed = false;
        }

        public function update(param1: * = null): void
        {
        }

        public function get container(): IWindowContainer
        {
            return this._container;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get main(): HelpUI
        {
            return this._main;
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get assetLibrary(): IAssetLibrary
        {
            return this._assetLibrary;
        }

        public function get roomSessionActive(): Boolean
        {
            return this._roomSessionActive;
        }

        public function set container(value: IWindowContainer): void
        {
            this._container = value;
        }

        public function set disposed(value: Boolean): void
        {
            this._disposed = value;
        }

        public function set roomSessionActive(value: Boolean): void
        {
            this._roomSessionActive = value;
        }

        public function getWindowContainer(): IWindowContainer
        {
            return this._container;
        }

        public function getText(key: String): String
        {
            if (this._main == null)
            {
                return null;
            }

            return this._main.getText(key);
        }

        public function getConfigurationKey(param1: String, param2: String = null, param3: Dictionary = null): String
        {
            if (this._main == null)
            {
                return null;
            }

            return this._main.getConfigurationKey(param1, param2, param3);
        }

        public function buildXmlWindow(layoutName: String): IWindow
        {
            var layout: XmlAsset = XmlAsset(this._assetLibrary.getAssetByName(layoutName + "_xml"));
            
            if (layout == null || this._windowManager == null)
            {
                return null;
            }

            return this._windowManager.buildFromXML(XML(layout.content));
        }

        protected function buildHelpCategoryListEntryItem(name: String, layoutName: String, callback: Function = null): IWindowContainer
        {
            var window: IWindow;
            var container: IWindowContainer = this.buildXmlWindow(layoutName) as IWindowContainer;
            
            if (container == null)
            {
                return null;
            }

            var textView: ITextWindow = container.findChildByTag("text") as ITextWindow;
            
            if (textView == null)
            {
                return null;
            }

            textView.text = name;
            
            if (callback != null)
            {
                window = (container.findChildByName("item_bg") as IWindow);
                
                if (window != null)
                {
                    window.setParamFlag(WindowParam.var_593);
                    window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, callback);
                }

            }

            return container;
        }

    }
}
