package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureCreditLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function initialize(param1:XML):void
        {
            var _loc4_:IRoomObjectModelController;
            super.initialize(param1);
            if (param1 == null)
            {
                return;
            };
            var _loc2_:XMLList = param1.credits;
            if (_loc2_.length() == 0)
            {
                return;
            };
            var _loc3_:Number = Number(_loc2_[0].@value);
            if (object != null)
            {
                _loc4_ = object.getModelController();
                if (_loc4_ != null)
                {
                    _loc4_.setNumber(RoomObjectVariableEnum.var_747, _loc3_);
                };
            };
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
                case MouseEvent.DOUBLE_CLICK:
                    if (eventDispatcher != null)
                    {
                        _loc3_ = object.getId();
                        _loc4_ = object.getType();
                        _loc5_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI, _loc3_, _loc4_);
                        eventDispatcher.dispatchEvent(_loc5_);
                    };
                    return;
                default:
                    super.mouseEvent(param1, param2);
            };
        }

    }
}