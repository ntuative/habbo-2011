package com.sulake.habbo.widget.memenu
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class MeMenuRoomsView implements IMeMenuView
    {

        private var _widget: MeMenuWidget;
        private var _window: IWindowContainer;

        public function init(param1: MeMenuWidget, param2: String): void
        {
            this._widget = param1;
            this.createWindow(param2);
        }

        public function dispose(): void
        {
            this._widget = null;
            this._window.dispose();
            this._window = null;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        private function createWindow(param1: String): void
        {
            var _loc3_: IWindow;
            var _loc2_: XmlAsset = this._widget.assets.getAssetByName("memenu_rooms") as XmlAsset;
            Logger.log("Me Menu Room View: " + _loc2_);
            this._window = (this._widget.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer);
            if (this._window == null)
            {
                throw new Error("Failed to construct window from XML!");
            }

            this._window.name = param1;
            var _loc4_: int;
            while (_loc4_ < this._window.numChildren)
            {
                _loc3_ = this._window.getChildAt(_loc4_);
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                _loc4_++;
            }

            this._widget.mainContainer.addChild(this._window);
        }

        private function onResized(param1: WindowEvent): void
        {
            this._window.x = 0;
            this._window.y = 0;
        }

        private function onButtonClicked(param1: WindowMouseEvent): void
        {
            var _loc2_: String;
            var _loc3_: IWindow = param1.target as IWindow;
            var _loc4_: String = _loc3_.name;
            switch (_loc4_)
            {
                case "back_btn":
                    this._widget.changeView(MeMenuWidget.var_1291);
                    return;
                default:
                    Logger.log("Me Menu xx View: unknown button: " + _loc4_);
            }

        }

    }
}
