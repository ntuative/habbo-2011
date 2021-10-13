package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureSongDiskLogic extends FurnitureLogic 
    {

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:String;
            var _loc3_:int;
            super.processUpdateMessage(param1);
            if (object == null)
            {
                return;
            };
            if (object.getModelController().getNumber(RoomObjectVariableEnum.var_489) == 1)
            {
                _loc2_ = object.getModelController().getString(RoomObjectVariableEnum.var_496);
                _loc3_ = int(_loc2_);
                object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.var_1211, (RoomWidgetInfostandExtraParamEnum.var_1221 + _loc3_));
            };
        }

    }
}