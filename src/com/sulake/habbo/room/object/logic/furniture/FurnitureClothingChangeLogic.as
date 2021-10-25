package com.sulake.habbo.room.object.logic.furniture
{

    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomObjectEvent;

    import flash.events.MouseEvent;

    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureClothingChangeLogic extends FurnitureLogic
    {

        override public function getEventTypes(): Array
        {
            var _loc1_: Array = [RoomObjectWidgetRequestEvent.var_418];
            return getAllEventTypes(super.getEventTypes(), _loc1_);
        }

        override public function initialize(param1: XML): void
        {
            super.initialize(param1);
            if (object == null || object.getModel() == null)
            {
                return;
            }

            var _loc2_: String = object.getModel().getString(RoomObjectVariableEnum.FURNITURE_DATA);
            this.updateClothingData(_loc2_);
        }

        override public function processUpdateMessage(param1: RoomObjectUpdateMessage): void
        {
            super.processUpdateMessage(param1);
            var _loc2_: RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
            if (_loc2_ != null)
            {
                this.updateClothingData(_loc2_.data);
            }

        }

        private function updateClothingData(param1: String): void
        {
            var _loc2_: Array;
            if (param1 != null && param1.length > 0)
            {
                _loc2_ = param1.split(",");
                if (_loc2_.length > 0)
                {
                    object.getModelController().setString(RoomObjectVariableEnum.var_753, _loc2_[0]);
                }

                if (_loc2_.length > 1)
                {
                    object.getModelController().setString(RoomObjectVariableEnum.var_752, _loc2_[1]);
                }

            }

        }

        override public function mouseEvent(param1: RoomSpriteMouseEvent, param2: IRoomGeometry): void
        {
            var _loc3_: int;
            var _loc4_: String;
            var _loc5_: RoomObjectEvent;
            if (param1 == null || param2 == null)
            {
                return;
            }

            if (object == null)
            {
                return;
            }

            switch (param1.type)
            {
                case MouseEvent.DOUBLE_CLICK:
                    if (eventDispatcher != null)
                    {
                        _loc3_ = object.getId();
                        _loc4_ = object.getType();
                        _loc5_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_418, _loc3_, _loc4_);
                        eventDispatcher.dispatchEvent(_loc5_);
                    }

                    return;
                default:
                    super.mouseEvent(param1, param2);
            }

        }

    }
}
