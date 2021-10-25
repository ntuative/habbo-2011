package com.sulake.habbo.room.object.logic.furniture
{

    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.room.events.RoomObjectEvent;

    import flash.events.MouseEvent;

    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureCounterClockLogic extends FurnitureLogic
    {

        override public function getEventTypes(): Array
        {
            var _loc1_: Array = [RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE];
            return getAllEventTypes(super.getEventTypes(), _loc1_);
        }

        override public function mouseEvent(param1: RoomSpriteMouseEvent, param2: IRoomGeometry): void
        {
            var _loc5_: int;
            var _loc6_: RoomObjectEvent;
            if (param1 == null || param2 == null)
            {
                return;
            }

            if (object == null)
            {
                return;
            }

            var _loc3_: int = object.getId();
            var _loc4_: String = object.getType();
            switch (param1.type)
            {
                case MouseEvent.DOUBLE_CLICK:
                    switch (param1.spriteTag)
                    {
                        case "start_stop":
                            _loc6_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _loc3_, _loc4_, 1);
                            break;
                        case "reset":
                            _loc6_ = new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _loc3_, _loc4_, 2);
                            break;
                    }

                    break;
            }

            if (eventDispatcher != null && _loc6_ != null)
            {
                eventDispatcher.dispatchEvent(_loc6_);
            }
            else
            {
                super.mouseEvent(param1, param2);
            }

        }

    }
}
