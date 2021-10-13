package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ClubGiftNotification 
    {

        private var _window:IFrameWindow;
        private var _catalog:IHabboCatalog;

        public function ClubGiftNotification(param1:int, param2:IAssetLibrary, param3:IHabboWindowManager, param4:IHabboCatalog)
        {
            if ((((!(param2)) || (!(param3))) || (!(param4))))
            {
                return;
            };
            this._catalog = param4;
            var _loc5_:XmlAsset = (param2.getAssetByName("club_gift_notification_xml") as XmlAsset);
            if (_loc5_ == null)
            {
                return;
            };
            this._window = (param3.buildFromXML((_loc5_.content as XML)) as IFrameWindow);
            if (this._window == null)
            {
                return;
            };
            this._window.procedure = this.eventHandler;
            this._window.center();
        }

        public function get visible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this._catalog = null;
        }

        private function setImage(param1:String, param2:BitmapData):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc3_:IBitmapWrapperWindow = (this._window.findChildByName(param1) as IBitmapWrapperWindow);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:BitmapData = new BitmapData(_loc3_.width, _loc3_.height, true, 0);
            var _loc5_:int = ((_loc4_.width * 0.5) - param2.width);
            var _loc6_:int = ((_loc4_.height * 0.5) - param2.height);
            _loc4_.draw(param2, new Matrix(2, 0, 0, 2, _loc5_, _loc6_));
            _loc3_.bitmap = _loc4_;
        }

        private function eventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "open_catalog_button":
                    if (this._catalog)
                    {
                        this._catalog.openCatalogPage(CatalogPageName.var_604, true);
                    };
                    this.dispose();
                    return;
                case "header_button_close":
                case "cancel_button":
                    this.dispose();
                    return;
            };
        }

    }
}