package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurniturePresentLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectWidgetRequestEvent.var_408];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc3_:int;
            var _loc4_:String;
            var _loc5_:RoomObjectEvent;
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            switch (param1.type)
            {
                case MouseEvent.ROLL_OVER:
                    _loc3_ = object.getId();
                    _loc4_ = object.getType();
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_445, _loc3_, _loc4_));
                    super.mouseEvent(param1, param2);
                    return;
                case MouseEvent.ROLL_OUT:
                    _loc3_ = object.getId();
                    _loc4_ = object.getType();
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1181, _loc3_, _loc4_));
                    super.mouseEvent(param1, param2);
                    return;
                case MouseEvent.DOUBLE_CLICK:
                    if (eventDispatcher != null)
                    {
                        _loc3_ = object.getId();
                        _loc4_ = object.getType();
                        _loc5_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_408, _loc3_, _loc4_);
                        eventDispatcher.dispatchEvent(_loc5_);
                    };
                    return;
                default:
                    super.mouseEvent(param1, param2);
            };
        }

    }
}