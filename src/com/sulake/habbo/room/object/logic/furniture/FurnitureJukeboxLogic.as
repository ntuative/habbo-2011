package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureJukeboxLogic extends FurnitureMultiStateLogic 
    {

        private var var_3958:Boolean;
        private var var_2067:Boolean = false;
        private var var_3563:int = -1;

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectFurnitureActionEvent.var_1207, RoomObjectFurnitureActionEvent.var_1208, RoomObjectFurnitureActionEvent.var_1209, RoomObjectFurnitureActionEvent.var_1210, RoomObjectWidgetRequestEvent.var_419];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            this.requestDispose();
            super.dispose();
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:RoomObjectDataUpdateMessage;
            var _loc3_:IRoomObjectModelController;
            var _loc4_:int;
            super.processUpdateMessage(param1);
            if (object == null)
            {
                return;
            };
            if (!this.var_2067)
            {
                this.requestInit();
            };
            if (object.getModelController().getNumber(RoomObjectVariableEnum.var_489) == 1)
            {
                object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.var_1211, RoomWidgetInfostandExtraParamEnum.var_1212);
                _loc2_ = (param1 as RoomObjectDataUpdateMessage);
                if (_loc2_ == null)
                {
                    return;
                };
                _loc3_ = object.getModelController();
                if (_loc3_ == null)
                {
                    return;
                };
                _loc4_ = object.getState(0);
                if (_loc4_ != this.var_3563)
                {
                    this.var_3563 = _loc4_;
                    if (_loc4_ == 1)
                    {
                        this.requestPlayList();
                    }
                    else
                    {
                        if (_loc4_ == 0)
                        {
                            this.requestStopPlaying();
                        };
                    };
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
                        _loc5_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_419, _loc3_, _loc4_);
                        eventDispatcher.dispatchEvent(_loc5_);
                    };
                    return;
                default:
                    super.mouseEvent(param1, param2);
            };
        }

        private function requestInit():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            this.var_3958 = true;
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1210, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
            this.var_2067 = true;
        }

        private function requestPlayList():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            this.var_3958 = true;
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1207, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestStopPlaying():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1208, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestDispose():void
        {
            if (!this.var_3958)
            {
                return;
            };
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1209, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

    }
}