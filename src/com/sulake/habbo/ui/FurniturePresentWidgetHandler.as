package com.sulake.habbo.ui
{

    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetPresentOpenMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.widget.events.RoomWidgetPresentDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    import flash.display.BitmapData;

    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    import flash.events.Event;

    public class FurniturePresentWidgetHandler implements IRoomWidgetHandler, IGetImageListener
    {

        private static const var_1488: String = "floor";
        private static const var_2794: String = "wallpaper";
        private static const TYPE_LANDSCAPE: String = "landscape";
        private static const var_778: String = "poster";

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;
        private var var_2358: int = -1;
        private var _name: String = "";

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_264;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function dispose(): void
        {
            this.var_978 = true;
            this._container = null;
        }

        public function getWidgetMessages(): Array
        {
            return [RoomWidgetFurniToWidgetMessage.var_1537, RoomWidgetPresentOpenMessage.var_1281];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetFurniToWidgetMessage;
            var _loc3_: IRoomObject;
            var _loc4_: RoomWidgetPresentOpenMessage;
            var _loc5_: IRoomObjectModel;
            var _loc6_: String;
            var _loc7_: int;
            var _loc8_: String;
            var _loc9_: ImageResult;
            var _loc10_: Boolean;
            var _loc11_: RoomWidgetPresentDataUpdateEvent;
            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1537:
                    _loc2_ = (param1 as RoomWidgetFurniToWidgetMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId, _loc2_.roomCategory, _loc2_.id, _loc2_.category);
                    if (_loc3_ != null)
                    {
                        _loc5_ = _loc3_.getModel();
                        if (_loc5_ != null)
                        {
                            this.var_2358 = _loc2_.id;
                            _loc6_ = _loc5_.getString(RoomObjectVariableEnum.FURNITURE_DATA);
                            if (_loc6_ == null)
                            {
                                _loc6_ = "";
                            }

                            _loc6_ = _loc6_.substr(1);
                            _loc7_ = _loc5_.getNumber(RoomObjectVariableEnum.FURNITURE_TYPE_ID);
                            _loc8_ = _loc5_.getString(RoomObjectVariableEnum.FURNITURE_EXTRAS);
                            _loc9_ = this._container.roomEngine.getFurnitureImage(_loc7_, new Vector3d(180), 64, null, 0, _loc8_);
                            _loc10_ = this._container.roomSession.isRoomOwner || this._container.sessionDataManager.isAnyRoomController;
                            _loc11_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1274, _loc2_.id, _loc6_, _loc10_, _loc9_.data);
                            this._container.events.dispatchEvent(_loc11_);
                        }

                    }

                    break;
                case RoomWidgetPresentOpenMessage.var_1281:
                    _loc4_ = (param1 as RoomWidgetPresentOpenMessage);
                    if (_loc4_.objectId != this.var_2358)
                    {
                        return null;
                    }

                    if (this._container != null && this._container.roomSession != null)
                    {
                        this._container.roomSession.sendPresentOpenMessage(_loc4_.objectId);
                    }

                    break;
            }

            return null;
        }

        public function imageReady(param1: int, param2: BitmapData): void
        {
            var _loc3_: RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1275, 0, this._name, false, param2);
            this._container.events.dispatchEvent(_loc3_);
        }

        public function getProcessedEvents(): Array
        {
            return [RoomSessionPresentEvent.var_371];
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: RoomSessionPresentEvent;
            var _loc3_: IFurnitureData;
            var _loc4_: ImageResult;
            var _loc5_: RoomWidgetPresentDataUpdateEvent;
            var _loc6_: IProductData;
            if (param1 == null)
            {
                return;
            }

            if (this._container != null && this._container.events != null && param1 != null)
            {
                switch (param1.type)
                {
                    case RoomSessionPresentEvent.var_371:
                        _loc2_ = (param1 as RoomSessionPresentEvent);
                        if (_loc2_ != null)
                        {
                            this._name = "";
                            _loc4_ = null;
                            if (_loc2_.itemType == ProductTypeEnum.var_112)
                            {
                                _loc3_ = this._container.sessionDataManager.getFloorItemData(_loc2_.classId);
                            }
                            else
                            {
                                if (_loc2_.itemType == ProductTypeEnum.var_113)
                                {
                                    _loc3_ = this._container.sessionDataManager.getWallItemData(_loc2_.classId);
                                }

                            }

                            switch (_loc2_.itemType)
                            {
                                case ProductTypeEnum.var_113:
                                    if (_loc3_ != null && _loc3_.name == var_1488)
                                    {
                                        _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1277, 0, this._container.localization.getKey("inventory.furni.item.floor.name"), false, null);
                                    }
                                    else
                                    {
                                        if (_loc3_ != null && _loc3_.name == TYPE_LANDSCAPE)
                                        {
                                            _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1278, 0, this._container.localization.getKey("inventory.furni.item.landscape.name"), false, null);
                                        }
                                        else
                                        {
                                            if (_loc3_ != null && _loc3_.name == var_2794)
                                            {
                                                _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1279, 0, this._container.localization.getKey("inventory.furni.item.wallpaper.name"), false, null);
                                            }
                                            else
                                            {
                                                if (_loc3_ != null && _loc3_.name == var_778)
                                                {
                                                    break;
                                                }
                                                _loc4_ = this._container.roomEngine.getWallItemIcon(_loc2_.classId, this);
                                                if (_loc3_ != null)
                                                {
                                                    this._name = _loc3_.title;
                                                }

                                                if (_loc4_ != null)
                                                {
                                                    _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1275, 0, this._name, false, _loc4_.data);
                                                }

                                            }

                                        }

                                    }

                                    break;
                                case ProductTypeEnum.var_153:
                                    _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1276, 0, this._container.localization.getKey("widget.furni.present.hc"), false, null);
                                    break;
                                default:
                                    _loc4_ = this._container.roomEngine.getFurnitureImage(_loc2_.classId, new Vector3d(180), 32, this);
                                    _loc6_ = this._container.sessionDataManager.getProductData(_loc2_.productCode);
                                    if (_loc6_ != null)
                                    {
                                        this._name = _loc6_.name;
                                    }
                                    else
                                    {
                                        if (_loc3_ != null)
                                        {
                                            this._name = _loc3_.title;
                                        }

                                    }

                                    if (_loc4_ != null)
                                    {
                                        _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.var_1275, 0, this._name, false, _loc4_.data);
                                    }

                            }

                            if (_loc5_ != null)
                            {
                                this._container.events.dispatchEvent(_loc5_);
                            }

                        }

                }

            }

        }

        public function update(): void
        {
        }

    }
}
