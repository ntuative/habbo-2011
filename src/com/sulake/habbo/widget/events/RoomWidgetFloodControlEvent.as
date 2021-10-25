package com.sulake.habbo.widget.events
{

    public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent
    {

        public static const RWFCE_FLOOD_CONTROL: String = "RWFCE_FLOOD_CONTROL";

        private var _seconds: int = 0;

        public function RoomWidgetFloodControlEvent(seconds: int)
        {
            super(RWFCE_FLOOD_CONTROL, false, false);
            
            this._seconds = seconds;
        }

        public function get seconds(): int
        {
            return this._seconds;
        }

    }
}
