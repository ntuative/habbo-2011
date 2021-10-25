package com.sulake.habbo.ui
{

    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetEcotronBoxOpenMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetEcotronBoxOpenedMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    import flash.display.BitmapData;

    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.session.furniture.IFurnitureData;

    import flash.events.Event;

    public class FurnitureEcotronBoxWidgetHandler implements IRoomWidgetHandler, IGetImageListener
    {

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
            return RoomWidgetEnum.var_267;
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
            return [
                RoomWidgetFurniToWidgetMessage.var_1540,
                RoomWidgetEcotronBoxOpenMessage.var_1370,
                RoomWidgetEcotronBoxOpenedMessage.var_1912
            ];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetFurniToWidgetMessage;
            var _loc3_: IRoomObject;
            var _loc4_: RoomWidgetEcotronBoxOpenMessage;
            var _loc5_: IRoomObjectModel;
            var _loc6_: String;
            var _loc7_: Boolean;
            var _loc8_: RoomWidgetEcotronBoxDataUpdateEvent;
            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1540:
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
                                return null;
                            }

                            _loc7_ = this._container.roomSession.isRoomOwner || this._container.sessionDataManager.isAnyRoomController;
                            _loc8_ = new RoomWidgetEcotronBoxDataUpdateEvent(RoomWidgetEcotronBoxDataUpdateEvent.var_1274, _loc2_.id, _loc6_, _loc7_);
                            this._container.events.dispatchEvent(_loc8_);
                        }

                    }

                    break;
                case RoomWidgetEcotronBoxOpenMessage.var_1370:
                    _loc4_ = (param1 as RoomWidgetEcotronBoxOpenMessage);
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
            if (this.disposed)
            {
                return;
            }

            var _loc3_: RoomWidgetEcotronBoxDataUpdateEvent = new RoomWidgetEcotronBoxDataUpdateEvent(RoomWidgetEcotronBoxDataUpdateEvent.var_1275, 0, this._name, false, param2);
            this._container.events.dispatchEvent(_loc3_);
        }

        public function getProcessedEvents(): Array
        {
            return [RoomSessionPresentEvent.var_371];
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: RoomSessionPresentEvent;
            var _loc3_: ImageResult;
            var _loc4_: IFurnitureData;
            var _loc5_: RoomWidgetEcotronBoxDataUpdateEvent;
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
                            _loc3_ = null;
                            this._name = "";
                            if (_loc2_.itemType == "s")
                            {
                                _loc3_ = this._container.roomEngine.getFurnitureIcon(_loc2_.classId, this);
                                _loc4_ = this._container.sessionDataManager.getFloorItemData(_loc2_.classId);
                            }
                            else
                            {
                                if (_loc2_.itemType == "i")
                                {
                                    _loc3_ = this._container.roomEngine.getWallItemIcon(_loc2_.classId, this);
                                    _loc4_ = this._container.sessionDataManager.getWallItemData(_loc2_.classId);
                                }

                            }

                            if (_loc4_ != null)
                            {
                                this._name = _loc4_.title;
                            }

                            if (_loc3_ != null)
                            {
                                _loc5_ = new RoomWidgetEcotronBoxDataUpdateEvent(RoomWidgetEcotronBoxDataUpdateEvent.var_1275, 0, this._name, false, _loc3_.data);
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
