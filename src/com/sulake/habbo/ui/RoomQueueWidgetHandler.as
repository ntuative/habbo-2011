package com.sulake.habbo.ui
{
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomQueueMessage;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomQueueUpdateEvent;
    import flash.events.Event;

    public class RoomQueueWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_978:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_258);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function dispose():void
        {
            this.var_978 = true;
            this._container = null;
        }

        public function getWidgetMessages():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetRoomQueueMessage.var_1271);
            _loc1_.push(RoomWidgetRoomQueueMessage.CHANGE_TO_SPECTATOR_QUEUE);
            _loc1_.push(RoomWidgetRoomQueueMessage.var_1273);
            _loc1_.push(RoomWidgetRoomQueueMessage.var_1272);
            return (_loc1_);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (((this._container == null) || (this._container.roomSession == null)))
            {
                return (null);
            };
            var _loc2_:RoomWidgetRoomQueueMessage = (param1 as RoomWidgetRoomQueueMessage);
            if (_loc2_ == null)
            {
                return (null);
            };
            switch (param1.type)
            {
                case RoomWidgetRoomQueueMessage.var_1271:
                    this._container.roomSession.quit();
                    break;
                case RoomWidgetRoomQueueMessage.CHANGE_TO_SPECTATOR_QUEUE:
                    this._container.roomSession.changeQueue(RoomSessionQueueEvent.var_1551);
                    break;
                case RoomWidgetRoomQueueMessage.var_1273:
                    this._container.roomSession.changeQueue(RoomSessionQueueEvent.var_1550);
                    break;
                case RoomWidgetRoomQueueMessage.var_1272:
                    if (this._container.catalog != null)
                    {
                        this._container.catalog.openCatalogPage(CatalogPageName.var_159, true);
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionQueueEvent.var_393]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomSessionQueueEvent;
            var _loc3_:String;
            var _loc4_:Boolean;
            var _loc5_:Array;
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:RoomWidgetRoomQueueUpdateEvent;
            if (((this._container == null) || (this._container.events == null)))
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionQueueEvent.var_393:
                    _loc2_ = (param1 as RoomSessionQueueEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    switch (_loc2_.queueSetTarget)
                    {
                        case RoomSessionQueueEvent.var_1550:
                            _loc3_ = RoomWidgetRoomQueueUpdateEvent.var_1269;
                            break;
                        case RoomSessionQueueEvent.var_1551:
                            _loc3_ = RoomWidgetRoomQueueUpdateEvent.var_1270;
                            break;
                    };
                    if (_loc3_ == null)
                    {
                        return;
                    };
                    _loc4_ = true;
                    if (this._container.inventory != null)
                    {
                        _loc4_ = (this._container.inventory.clubDays > 0);
                    };
                    _loc5_ = _loc2_.queueTypes;
                    _loc7_ = false;
                    if (_loc5_.length > 1)
                    {
                        if (((_loc4_) && (!(_loc2_.queueTypes.indexOf(RoomSessionQueueEvent.var_1548) == -1))))
                        {
                            _loc6_ = (_loc2_.getQueueSize(RoomSessionQueueEvent.var_1548) + 1);
                            _loc7_ = true;
                        }
                        else
                        {
                            _loc6_ = (_loc2_.getQueueSize(RoomSessionQueueEvent.var_1549) + 1);
                        };
                    }
                    else
                    {
                        _loc6_ = (_loc2_.getQueueSize(_loc5_[0]) + 1);
                    };
                    _loc8_ = new RoomWidgetRoomQueueUpdateEvent(_loc3_, _loc6_, _loc4_, _loc2_.isActive, _loc7_);
                    this._container.events.dispatchEvent(_loc8_);
                    return;
            };
        }

        public function update():void
        {
        }

    }
}