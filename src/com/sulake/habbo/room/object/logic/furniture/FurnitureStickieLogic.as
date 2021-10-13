package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureStickieLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectWidgetRequestEvent.var_407, RoomObjectFurnitureActionEvent.var_1189];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function initialize(param1:XML):void
        {
            super.initialize(param1);
            this.setColorIndexFromItemData();
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:RoomObjectWidgetRequestEvent;
            super.processUpdateMessage(param1);
            if ((param1 is RoomObjectItemDataUpdateMessage))
            {
                _loc2_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_407, object.getId(), object.getType());
                if (_loc2_ != null)
                {
                    eventDispatcher.dispatchEvent(_loc2_);
                };
            };
            this.setColorIndexFromItemData();
        }

        private function setColorIndexFromItemData():void
        {
            var _loc1_:String;
            var _loc2_:Array;
            var _loc3_:int;
            if (object != null)
            {
                _loc1_ = object.getModel().getString(RoomObjectVariableEnum.var_503);
                _loc2_ = new Array("9CCEFF", "FF9CFF", "9CFF9C", "FFFF33");
                _loc3_ = _loc2_.indexOf(_loc1_);
                if (_loc3_ < 0)
                {
                    _loc3_ = 3;
                };
                object.getModelController().setNumber(RoomObjectVariableEnum.var_486, (_loc3_ + 1));
                object.setDirty();
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
                        _loc5_ = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1189, _loc3_, _loc4_);
                        if (_loc5_ != null)
                        {
                            eventDispatcher.dispatchEvent(_loc5_);
                        };
                    };
                    return;
                default:
                    super.mouseEvent(param1, param2);
            };
        }

    }
}