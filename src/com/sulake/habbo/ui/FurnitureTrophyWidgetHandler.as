package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.widget.events.RoomWidgetTrophyDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    import flash.events.Event;

    public class FurnitureTrophyWidgetHandler implements IRoomWidgetHandler
    {

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_265;
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
            return [RoomWidgetFurniToWidgetMessage.var_1538];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetFurniToWidgetMessage;
            var _loc3_: IRoomObject;
            var _loc4_: IRoomObjectModel;
            var _loc5_: Number;
            var _loc6_: String;
            var _loc7_: String;
            var _loc8_: String;
            var _loc9_: String;
            var _loc10_: RoomWidgetTrophyDataUpdateEvent;
            if (this.disposed || param1 == null)
            {
                return null;
            }

            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1538:
                    _loc2_ = (param1 as RoomWidgetFurniToWidgetMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId, _loc2_.roomCategory, _loc2_.id, _loc2_.category);
                    if (_loc3_ != null)
                    {
                        _loc4_ = _loc3_.getModel();
                        if (_loc4_ != null)
                        {
                            _loc5_ = _loc4_.getNumber(RoomObjectVariableEnum.FURNITURE_COLOR);
                            _loc6_ = _loc4_.getString(RoomObjectVariableEnum.FURNITURE_DATA);
                            _loc7_ = _loc6_.substring(0, _loc6_.indexOf("\t"));
                            _loc6_ = _loc6_.substring(_loc7_.length + 1, _loc6_.length);
                            _loc8_ = _loc6_.substring(0, _loc6_.indexOf("\t"));
                            _loc9_ = _loc6_.substring(_loc8_.length + 1, _loc6_.length);
                            _loc10_ = new RoomWidgetTrophyDataUpdateEvent(RoomWidgetTrophyDataUpdateEvent.var_1288, _loc5_, _loc7_, _loc8_, _loc9_);
                            this._container.events.dispatchEvent(_loc10_);
                        }

                    }

                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            return [];
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: Event;
        }

        public function update(): void
        {
        }

    }
}
