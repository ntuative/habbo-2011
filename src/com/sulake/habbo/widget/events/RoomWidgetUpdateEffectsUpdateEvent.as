package com.sulake.habbo.widget.events
{

    public class RoomWidgetUpdateEffectsUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_1300: String = "RWUEUE_UPDATE_EFFECTS";

        private var var_3192: Array;

        public function RoomWidgetUpdateEffectsUpdateEvent(param1: Array = null, param2: Boolean = false, param3: Boolean = false)
        {
            super(var_1300, param2, param3);
            this.var_3192 = param1;
        }

        public function get effects(): Array
        {
            return this.var_3192;
        }

    }
}
