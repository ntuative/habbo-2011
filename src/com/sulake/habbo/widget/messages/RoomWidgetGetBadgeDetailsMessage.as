package com.sulake.habbo.widget.messages
{

    public class RoomWidgetGetBadgeDetailsMessage extends RoomWidgetMessage
    {

        public static const var_1906: String = "RWGOI_MESSAGE_GET_BADGE_DETAILS";

        private var var_3351: int = 0;

        public function RoomWidgetGetBadgeDetailsMessage(param1: int)
        {
            super(var_1906);
            this.var_3351 = param1;
        }

        public function get groupId(): int
        {
            return this.var_3351;
        }

    }
}
