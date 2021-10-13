package com.sulake.habbo.ui
{
    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetShowPlaceholderEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class PlaceholderWidgetHandler implements IRoomWidgetHandler 
    {

        private var _container:IRoomWidgetHandlerContainer = null;

        public function dispose():void
        {
            this._container = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }

        public function get type():String
        {
            return (null);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function getWidgetMessages():Array
        {
            return ([RoomWidgetFurniToWidgetMessage.var_1542]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetShowPlaceholderEvent;
            switch (param1.type)
            {
                default:
                    _loc2_ = new RoomWidgetShowPlaceholderEvent(RoomWidgetShowPlaceholderEvent.var_1264);
                    this._container.events.dispatchEvent(_loc2_);
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return (null);
        }

        public function processEvent(param1:Event):void
        {
        }

        public function update():void
        {
        }

    }
}