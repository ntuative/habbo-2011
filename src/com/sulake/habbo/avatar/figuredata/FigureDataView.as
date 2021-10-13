package com.sulake.habbo.avatar.figuredata
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Point;

    public class FigureDataView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _window:IWindowContainer;
        private var var_2430:IBitmapWrapperWindow;
        private var var_2475:BitmapData;

        public function FigureDataView(param1:IHabboWindowManager, param2:IAssetLibrary)
        {
            this._assetLibrary = param2;
            this._windowManager = param1;
            var _loc3_:XmlAsset = (this._assetLibrary.getAssetByName("AvatarEditorImage") as XmlAsset);
            if (_loc3_)
            {
                this._window = IWindowContainer(this._windowManager.buildFromXML((_loc3_.content as XML)));
            };
            var _loc4_:BitmapDataAsset = (this._assetLibrary.getAssetByName("platform") as BitmapDataAsset);
            if (_loc4_)
            {
                this.var_2475 = (_loc4_.content as BitmapData);
            };
            if (this._window != null)
            {
                this.var_2430 = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            };
        }

        public function udpate(param1:BitmapData):void
        {
            if (((this.var_2430) && (this.var_2475)))
            {
                this.var_2430.bitmap = new BitmapData(this.var_2430.width, this.var_2430.height, true, 0xFFFFFF);
                this.var_2430.bitmap.copyPixels(this.var_2475, this.var_2475.rect, new Point(0, ((this.var_2430.height - this.var_2475.height) - 8)));
                this.var_2430.bitmap.copyPixels(param1, param1.rect, new Point(4, 0), null, null, true);
            };
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

    }
}