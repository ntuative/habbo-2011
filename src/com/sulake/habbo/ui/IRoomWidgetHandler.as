package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public interface IRoomWidgetHandler extends IDisposable 
    {

        function get type():String;
        function set container(param1:IRoomWidgetHandlerContainer):void;
        function getWidgetMessages():Array;
        function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent;
        function getProcessedEvents():Array;
        function processEvent(param1:Event):void;
        function update():void;

    }
}