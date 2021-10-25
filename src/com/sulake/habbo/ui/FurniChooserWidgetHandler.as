package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.widget.events.ChooserItem;
    import com.sulake.habbo.widget.events.RoomWidgetChooserContentEvent;

    import flash.events.Event;

    public class FurniChooserWidgetHandler implements IRoomWidgetHandler
    {

        private var _container: IRoomWidgetHandlerContainer = null;
        private var var_978: Boolean = false;

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_275;
        }

        public function dispose(): void
        {
            this.var_978 = true;
            this._container = null;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function getWidgetMessages(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomWidgetRequestWidgetMessage.REQUEST_FURNI_CHOOSER);
            _loc1_.push(RoomWidgetRoomObjectMessage.var_1265);
            return _loc1_;
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetRoomObjectMessage;
            if (param1 == null)
            {
                return null;
            }

            switch (param1.type)
            {
                case RoomWidgetRequestWidgetMessage.REQUEST_FURNI_CHOOSER:
                    this.handleFurniChooserRequest();
                    break;
                case RoomWidgetRoomObjectMessage.var_1265:
                    _loc2_ = (param1 as RoomWidgetRoomObjectMessage);
                    if (_loc2_ == null)
                    {
                        return null;
                    }

                    this._container.roomEngine.selectRoomObject(this._container.roomSession.roomId, this._container.roomSession.roomCategory, _loc2_.id, _loc2_.category);
                    break;
            }

            return null;
        }

        private function handleFurniChooserRequest(): void
        {
            var _loc4_: int;
            var _loc5_: int;
            var _loc6_: IFurnitureData;
            var _loc7_: String;
            var _loc8_: IRoomObject;
            var _loc10_: String;
            var _loc11_: int;
            if (this._container == null || this._container.roomSession == null || this._container.roomEngine == null)
            {
                return;
            }

            if (this._container.roomSession.userDataManager == null)
            {
                return;
            }

            var _loc1_: int = this._container.roomSession.roomId;
            var _loc2_: int = this._container.roomSession.roomCategory;
            var _loc3_: Array = [];
            var _loc9_: int = this._container.roomEngine.getRoomObjectCount(_loc1_, _loc2_, RoomObjectCategoryEnum.var_72);
            _loc4_ = 0;
            while (_loc4_ < _loc9_)
            {
                _loc8_ = this._container.roomEngine.getRoomObjectWithIndex(_loc1_, _loc2_, _loc4_, RoomObjectCategoryEnum.var_72);
                if (_loc8_ != null)
                {
                    _loc5_ = _loc8_.getModel().getNumber(RoomObjectVariableEnum.FURNITURE_TYPE_ID);
                    _loc6_ = this._container.sessionDataManager.getFloorItemData(_loc5_);
                    if (_loc6_ != null)
                    {
                        _loc7_ = _loc6_.title;
                    }
                    else
                    {
                        _loc7_ = _loc8_.getType();
                    }

                    _loc3_.push(new ChooserItem(_loc8_.getId(), RoomObjectCategoryEnum.var_72, _loc7_));
                }

                _loc4_++;
            }

            _loc9_ = this._container.roomEngine.getRoomObjectCount(_loc1_, _loc2_, RoomObjectCategoryEnum.var_73);
            _loc4_ = 0;
            while (_loc4_ < _loc9_)
            {
                _loc8_ = this._container.roomEngine.getRoomObjectWithIndex(_loc1_, _loc2_, _loc4_, RoomObjectCategoryEnum.var_73);
                if (_loc8_ != null)
                {
                    _loc10_ = _loc8_.getType();
                    if (_loc10_.indexOf("poster") == 0)
                    {
                        _loc11_ = int(_loc10_.replace("poster", ""));
                        _loc7_ = this._container.localization.getKey("poster_" + _loc11_ + "_name", "poster_" + _loc11_ + "_name");
                    }
                    else
                    {
                        _loc5_ = _loc8_.getModel().getNumber(RoomObjectVariableEnum.FURNITURE_TYPE_ID);
                        _loc6_ = this._container.sessionDataManager.getWallItemData(_loc5_);
                        if (_loc6_ != null && _loc6_.title.length > 0)
                        {
                            _loc7_ = _loc6_.title;
                        }
                        else
                        {
                            _loc7_ = _loc10_;
                        }

                    }

                    _loc3_.push(new ChooserItem(_loc8_.getId(), RoomObjectCategoryEnum.var_73, _loc7_));
                }

                _loc4_++;
            }

            _loc3_.sort(this.compareItems);
            this._container.events.dispatchEvent(new RoomWidgetChooserContentEvent(RoomWidgetChooserContentEvent.var_1317, _loc3_, this._container.sessionDataManager.isAnyRoomController));
        }

        private function compareItems(param1: ChooserItem, param2: ChooserItem): int
        {
            if (param1 == null || param2 == null || param1.name == param2.name || param1.name.length == 0 || param2.name.length == 0)
            {
                return 1;
            }

            var _loc3_: Array = [param1.name.toUpperCase(), param2.name.toUpperCase()].sort();
            if (_loc3_.indexOf(param1.name.toUpperCase()) == 0)
            {
                return -1;
            }

            return 1;
        }

        public function getProcessedEvents(): Array
        {
            return null;
        }

        public function processEvent(param1: Event): void
        {
        }

        public function update(): void
        {
        }

    }
}
