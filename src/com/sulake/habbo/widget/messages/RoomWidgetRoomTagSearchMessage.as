package com.sulake.habbo.widget.messages
{
    public class RoomWidgetRoomTagSearchMessage extends RoomWidgetMessage 
    {

        public static const var_1905:String = "RWRTSM_ROOM_TAG_SEARCH";

        private var var_2997:String = "";

        public function RoomWidgetRoomTagSearchMessage(param1:String)
        {
            super(var_1905);
            this.var_2997 = param1;
        }

        public function get tag():String
        {
            return (this.var_2997);
        }

    }
}