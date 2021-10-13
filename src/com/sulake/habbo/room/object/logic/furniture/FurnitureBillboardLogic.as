package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.utils.HabboWebTools;

    public class FurnitureBillboardLogic extends FurnitureLogic 
    {

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectRoomAdEvent.ROOM_AD_LOAD_IMAGE];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function initialize(param1:XML):void
        {
            super.initialize(param1);
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:RoomObjectRoomAdUpdateMessage;
            var _loc3_:Boolean;
            super.processUpdateMessage(param1);
            if ((param1 is RoomObjectDataUpdateMessage))
            {
                this.setupBillBoard();
            };
            if ((param1 is RoomObjectRoomAdUpdateMessage))
            {
                _loc2_ = (param1 as RoomObjectRoomAdUpdateMessage);
                _loc3_ = false;
                switch (_loc2_.type)
                {
                    case RoomObjectRoomAdUpdateMessage.var_509:
                        object.getModelController().setString(RoomObjectVariableEnum.var_750, "true");
                        _loc3_ = true;
                        break;
                    case RoomObjectRoomAdUpdateMessage.var_510:
                        object.getModelController().setString(RoomObjectVariableEnum.var_750, "error");
                        Logger.log(("failed to load billboard image from url " + object.getModelController().getString(RoomObjectVariableEnum.var_751)));
                        break;
                };
                if (_loc3_)
                {
                    object.setDirty();
                };
            };
        }

        override protected function getAdClickUrl(param1:IRoomObjectModelController):String
        {
            return (param1.getString(RoomObjectVariableEnum.FURNITURE_BILLBOARD_CLICK_URL));
        }

        private function setupBillBoard():void
        {
            var _loc1_:String;
            var _loc2_:Array;
            var _loc3_:String;
            var _loc4_:String;
            if (object != null)
            {
                _loc1_ = object.getModel().getString(RoomObjectVariableEnum.var_503);
                if (_loc1_ != null)
                {
                    _loc2_ = _loc1_.split("\t");
                    if (((!(_loc2_ == null)) && (_loc2_.length >= 2)))
                    {
                        _loc3_ = _loc2_[0];
                        _loc4_ = _loc2_[1];
                        object.getModelController().setString(RoomObjectVariableEnum.var_751, _loc3_);
                        object.getModelController().setString(RoomObjectVariableEnum.FURNITURE_BILLBOARD_CLICK_URL, _loc4_);
                        object.getModelController().setString(RoomObjectVariableEnum.var_750, "loading");
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.ROOM_AD_LOAD_IMAGE, object.getId(), object.getType(), _loc3_, _loc4_));
                    };
                };
            };
        }

        override protected function handleAdClick(param1:int, param2:String, param3:String):void
        {
            HabboWebTools.openWebPage(param3);
        }

    }
}