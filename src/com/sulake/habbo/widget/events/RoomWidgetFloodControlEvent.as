package com.sulake.habbo.widget.events
{
    public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1354:String = "RWFCE_FLOOD_CONTROL";

        private var var_3295:int = 0;

        public function RoomWidgetFloodControlEvent(param1:int)
        {
            super(var_1354, false, false);
            this.var_3295 = param1;
        }

        public function get seconds():int
        {
            return (this.var_3295);
        }

    }
}