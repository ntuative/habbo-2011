package com.sulake.habbo.widget.events
{
    public class RoomWidgetShowPlaceholderEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1264:String = "RWSPE_SHOW_PLACEHOLDER";

        public function RoomWidgetShowPlaceholderEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

    }
}