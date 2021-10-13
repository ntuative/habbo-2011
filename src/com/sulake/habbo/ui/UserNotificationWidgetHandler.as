package com.sulake.habbo.ui
{
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetGetUserNotificationMessage;
    import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserNotificationEvent;
    import flash.events.Event;

    public class UserNotificationWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._container = null;
                this._disposed = true;
            };
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_280);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
            this._container.roomSession.sendGetUserNotifications();
        }

        public function getWidgetMessages():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetGetUserNotificationMessage.var_1911);
            return (_loc1_);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionUserNotificationEvent.var_280]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (!param1)
            {
                return (null);
            };
            switch (param1.type)
            {
                default:
                    Logger.log(param1.type);
            };
            return (null);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomSessionUserNotificationEvent;
            var _loc3_:RoomWidgetUserNotificationEvent;
            switch (param1.type)
            {
                case RoomSessionUserNotificationEvent.var_280:
                    _loc2_ = (param1 as RoomSessionUserNotificationEvent);
                    _loc3_ = new RoomWidgetUserNotificationEvent(RoomWidgetUserNotificationEvent.var_1363);
                    _loc3_.title = _loc2_.title;
                    _loc3_.message = _loc2_.message;
                    _loc3_.parameters = _loc2_.parameters;
                    this._container.events.dispatchEvent(_loc3_);
                    return;
            };
        }

        public function update():void
        {
        }

    }
}