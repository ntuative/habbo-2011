package com.sulake.habbo.widget.events
{

    public class RoomWidgetWaveUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_1298: String = "RWUE_WAVE";

        public function RoomWidgetWaveUpdateEvent(param1: Boolean = false, param2: Boolean = false)
        {
            super(var_1298, param1, param2);
        }

    }
}
