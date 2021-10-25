package com.sulake.habbo.widget
{

    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    public interface IRoomWidgetMessageListener
    {

        function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent;

    }
}
