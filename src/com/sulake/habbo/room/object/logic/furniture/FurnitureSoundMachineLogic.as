package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureSoundMachineLogic extends FurnitureMultiStateLogic 
    {

        private var var_3958:Boolean;
        private var var_2067:Boolean = false;
        private var var_3563:int = -1;

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectFurnitureActionEvent.var_1191, RoomObjectFurnitureActionEvent.var_1192, RoomObjectFurnitureActionEvent.var_1193, RoomObjectFurnitureActionEvent.var_1194];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            this.requestDispose();
            super.dispose();
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(param1);
            if (object == null)
            {
                return;
            };
            if (!this.var_2067)
            {
                this.requestInitialize();
            };
            var _loc2_:RoomObjectDataUpdateMessage = (param1 as RoomObjectDataUpdateMessage);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = object.getState(0);
            if (_loc3_ != this.var_3563)
            {
                this.var_3563 = _loc3_;
                if (_loc3_ == 1)
                {
                    this.requestPlayList();
                }
                else
                {
                    if (_loc3_ == 0)
                    {
                        this.requestStopPlaying();
                    };
                };
            };
        }

        private function requestInitialize():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            this.var_3958 = true;
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1194, object.getId(), object.getType());
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
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1191, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestStopPlaying():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1192, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestDispose():void
        {
            if (!this.var_3958)
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1193, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

    }
}