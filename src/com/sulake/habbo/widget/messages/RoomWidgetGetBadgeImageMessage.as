package com.sulake.habbo.widget.messages
{

    public class RoomWidgetGetBadgeImageMessage extends RoomWidgetMessage
    {

        public static const var_1907: String = "RWGOI_MESSAGE_GET_BADGE_IMAGE";

        private var var_2925: String = "";

        public function RoomWidgetGetBadgeImageMessage(param1: String)
        {
            super(var_1907);
            this.var_2925 = param1;
        }

        public function get badgeId(): String
        {
            return this.var_2925;
        }

    }
}
