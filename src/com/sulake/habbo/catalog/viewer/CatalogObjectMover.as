package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import flash.display.Sprite;
    import flash.display.Bitmap;

    public class CatalogObjectMover implements IGetImageListener 
    {

        private static const var_2818:String = "CatalogOverlaySprite";

        private var _roomEngine:IRoomEngine;
        private var _mainContainer:IWindowContainer;
        private var _state:Boolean = false;

        public function set roomEngine(param1:IRoomEngine):void
        {
            this._roomEngine = param1;
        }

        public function set mainContainer(param1:IWindowContainer):void
        {
            this._mainContainer = param1;
        }

        public function get state():Boolean
        {
            return (this._state);
        }

        public function dispose():void
        {
            this.releaseOverlaySprite();
            this._mainContainer = null;
            this._roomEngine = null;
            this._state = false;
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
        }

        public function onMainContainerEvent(param1:WindowEvent, param2:IWindow, param3:ISelectedRoomObjectData):void
        {
            var _loc4_:WindowMouseEvent;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:ImageResult;
            if (this._roomEngine == null)
            {
                return;
            };
            _loc4_ = (param1 as WindowMouseEvent);
            switch (param1.type)
            {
                case WindowMouseEvent.var_632:
                    if (((param3 == null) || (!(param3.operation == RoomObjectOperationEnum.OBJECT_PLACE))))
                    {
                        return;
                    };
                    _loc5_ = _loc4_.stageX;
                    _loc6_ = _loc4_.stageY;
                    if (this.getIconSprite() == null)
                    {
                        _loc7_ = this.getFurniImageResult(param3);
                        if (_loc7_ == null)
                        {
                            return;
                        };
                        this.createOverlaySprite(_loc7_.data.clone());
                    };
                    this._state = true;
                    this.moveOverlaySprite(_loc5_, _loc6_);
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                case WindowMouseEvent.var_633:
                case WindowMouseEvent.var_634:
                case WindowMouseEvent.var_626:
                    this.releaseOverlaySprite();
                    this._state = false;
                    return;
            };
        }

        private function getFurniImageResult(param1:ISelectedRoomObjectData):ImageResult
        {
            var _loc2_:ImageResult;
            if (((param1 == null) || (this._roomEngine == null)))
            {
                return (null);
            };
            if (param1.category == RoomObjectCategoryEnum.var_72)
            {
                return (this._roomEngine.getFurnitureIcon(param1.typeId, this));
            };
            if (param1.category == RoomObjectCategoryEnum.var_73)
            {
                return (this._roomEngine.getWallItemIcon(param1.typeId, this, param1.instanceData));
            };
            return (null);
        }

        private function createOverlaySprite(param1:BitmapData):void
        {
            if (((((param1 == null) || (this._mainContainer == null)) || (this._mainContainer.desktop == null)) || (!(this.getIconSprite() == null))))
            {
                return;
            };
            var _loc2_:Sprite = (this._mainContainer.desktop.getDisplayObject() as Sprite);
            var _loc3_:Sprite = new Sprite();
            _loc3_.name = var_2818;
            _loc3_.mouseEnabled = true;
            _loc3_.visible = true;
            var _loc4_:Bitmap = new Bitmap(param1);
            _loc3_.addChild(_loc4_);
            _loc2_.addChild(_loc3_);
        }

        private function getIconSprite():Sprite
        {
            if (((this._mainContainer == null) || (this._mainContainer.desktop == null)))
            {
                return (null);
            };
            var _loc1_:Sprite = (this._mainContainer.desktop.getDisplayObject() as Sprite);
            return (_loc1_.getChildByName(var_2818) as Sprite);
        }

        private function moveOverlaySprite(param1:int, param2:int):void
        {
            var _loc3_:Sprite = this.getIconSprite();
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.x = param1;
            _loc3_.y = param2;
        }

        private function releaseOverlaySprite():void
        {
            if ((((this._mainContainer == null) || (this._mainContainer.desktop == null)) || (this.getIconSprite() == null)))
            {
                return;
            };
            var _loc1_:Sprite = (this._mainContainer.desktop.getDisplayObject() as Sprite);
            var _loc2_:Sprite = (_loc1_.getChildByName(var_2818) as Sprite);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.removeChildAt(0);
            _loc1_.removeChild(_loc1_.getChildByName(var_2818));
        }

    }
}