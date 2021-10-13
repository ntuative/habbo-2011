package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class RoomPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener 
    {

        private var var_2786:int = -1;
        private var var_2787:int = -1;
        private var var_2788:BitmapData = null;
        private var _imageStoreWindow:BitmapData = null;

        public function RoomPreviewCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            if (this.var_2788 != null)
            {
                this.var_2788.dispose();
                this.var_2788 = null;
            };
            if (this._imageStoreWindow != null)
            {
                this._imageStoreWindow.dispose();
                this._imageStoreWindow = null;
            };
            events.removeEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, this.onUpdateRoomPreview);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, this.onUpdateRoomPreview);
            return (true);
        }

        private function onUpdateRoomPreview(param1:CatalogWidgetUpdateRoomPreviewEvent):void
        {
            var _loc5_:BitmapData;
            var _loc6_:BitmapData;
            var _loc2_:String = "window_romantic_wide";
            var _loc3_:ImageResult = page.viewer.roomEngine.getRoomImage(param1.floorType, param1.wallType, param1.landscapeType, param1.tileSize, this, _loc2_);
            var _loc4_:ImageResult = page.viewer.roomEngine.getGenericRoomObjectImage(_loc2_, "", new Vector3d(180, 0, 0), param1.tileSize, this);
            if (((!(_loc3_ == null)) && (!(_loc4_ == null))))
            {
                this.var_2786 = _loc3_.id;
                this.var_2787 = _loc4_.id;
                _loc5_ = (_loc3_.data as BitmapData);
                _loc6_ = (_loc4_.data as BitmapData);
                if (this.var_2788 != null)
                {
                    this.var_2788.dispose();
                };
                if (this._imageStoreWindow != null)
                {
                    this._imageStoreWindow.dispose();
                };
                this.var_2788 = _loc5_;
                this._imageStoreWindow = _loc6_;
                this.setRoomImage(_loc5_, _loc6_);
            };
        }

        private function setRoomImage(param1:BitmapData, param2:BitmapData):void
        {
            var _loc3_:Point;
            var _loc4_:BitmapData;
            var _loc5_:IBitmapWrapperWindow;
            var _loc6_:int;
            var _loc7_:int;
            if ((((!(param1 == null)) && (!(param2 == null))) && (!(window.disposed))))
            {
                _loc3_ = new Point((((param1.width / 2) + 4) + 19), ((((param1.height / 2) - (param2.height / 2)) - 24) + 10));
                _loc4_ = new BitmapData(param1.width, param1.height, param1.transparent);
                _loc4_.copyPixels(param1, param1.rect, new Point(0, 0), null, null, true);
                _loc4_.copyPixels(param2, param2.rect, _loc3_, null, null, true);
                _loc5_ = (window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow);
                if (_loc5_ != null)
                {
                    if (_loc5_.bitmap == null)
                    {
                        _loc5_.bitmap = new BitmapData(_loc5_.width, _loc5_.height, true, 0xFFFFFF);
                    };
                    _loc5_.bitmap.fillRect(_loc5_.bitmap.rect, 0xFFFFFF);
                    _loc6_ = int((((_loc5_.width - _loc4_.width) / 2) - 20));
                    _loc7_ = int(((_loc5_.height - _loc4_.height) / 2));
                    _loc5_.bitmap.copyPixels(_loc4_, _loc4_.rect, new Point(_loc6_, _loc7_), null, null, true);
                    _loc5_.invalidate();
                };
                _loc4_.dispose();
            };
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            switch (param1)
            {
                case this.var_2786:
                    this.var_2786 = 0;
                    if (this.var_2788 != null)
                    {
                        this.var_2788.dispose();
                    };
                    this.var_2788 = param2;
                    break;
                case this.var_2787:
                    this.var_2787 = 0;
                    if (this._imageStoreWindow != null)
                    {
                        this._imageStoreWindow.dispose();
                    };
                    this._imageStoreWindow = param2;
                    break;
            };
            if (((!(this.var_2788 == null)) && (!(this._imageStoreWindow == null))))
            {
                this.setRoomImage(this.var_2788, this._imageStoreWindow);
            };
        }

    }
}