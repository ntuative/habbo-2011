package com.sulake.habbo.room.object.logic.furniture
{

    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomObjectEvent;

    import flash.events.MouseEvent;

    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureTeaserLogic extends FurnitureLogic
    {

        private const var_3970: String = "TYPE_INJECTED";

        override public function getEventTypes(): Array
        {
            var _loc1_: Array = [RoomObjectWidgetRequestEvent.var_409, RoomObjectFurnitureActionEvent.var_1184];
            return getAllEventTypes(super.getEventTypes(), _loc1_);
        }

        override public function mouseEvent(param1: RoomSpriteMouseEvent, param2: IRoomGeometry): void
        {
            var _loc7_: int;
            var _loc8_: String;
            var _loc9_: RoomObjectEvent;
            if (param1 == null || param2 == null)
            {
                return;
            }

            if (object == null)
            {
                return;
            }

            if (param1.type != MouseEvent.CLICK && param1.type != MouseEvent.DOUBLE_CLICK && param1.type != MouseEvent.MOUSE_DOWN && param1.type != MouseEvent.MOUSE_UP)
            {
                return;
            }

            var _loc3_: IRoomObjectModelController = object.getModelController();
            var _loc4_: String = _loc3_.getString(RoomObjectVariableEnum.FURNITURE_DATA);
            var _loc5_: String = _loc4_;
            var _loc6_: String = "+";
            if (_loc4_)
            {
                if (_loc4_.indexOf(_loc6_) > -1)
                {
                    _loc5_ = _loc4_.substring(0, _loc4_.indexOf(_loc6_));
                }

            }

            if (_loc5_ == this.var_3970)
            {
                if (param1.type == MouseEvent.MOUSE_UP)
                {
                    if (eventDispatcher != null)
                    {
                        _loc7_ = object.getId();
                        _loc8_ = object.getType();
                        _loc9_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_409, _loc7_, _loc8_);
                        eventDispatcher.dispatchEvent(_loc9_);
                        object.setVisualization(null);
                    }

                }
                else
                {
                    super.mouseEvent(param1, param2);
                }

            }
            else
            {
                if (param1.type == MouseEvent.DOUBLE_CLICK)
                {
                    if (eventDispatcher != null)
                    {
                        _loc7_ = object.getId();
                        _loc8_ = object.getType();
                        _loc9_ = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1184, _loc7_, _loc8_);
                        eventDispatcher.dispatchEvent(_loc9_);
                    }

                }
                else
                {
                    if (param1.type == MouseEvent.MOUSE_DOWN || param1.type == MouseEvent.CLICK)
                    {
                        super.mouseEvent(param1, param2);
                    }

                }

            }

        }

    }
}
