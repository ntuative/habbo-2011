package com.sulake.habbo.widget.events
{

    public class RoomWidgetDanceUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_1299: String = "RWUE_DANCE";

        private var var_1025: int;

        public function RoomWidgetDanceUpdateEvent(param1: int, param2: Boolean = false, param3: Boolean = false)
        {
            super(var_1299, param2, param3);
            this.var_1025 = param1;
        }

        public function get style(): int
        {
            return this.var_1025;
        }

    }
}
