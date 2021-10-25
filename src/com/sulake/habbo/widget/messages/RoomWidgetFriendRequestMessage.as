package com.sulake.habbo.widget.messages
{

    public class RoomWidgetFriendRequestMessage extends RoomWidgetMessage
    {

        public static const var_1315: String = "RWFRM_ACCEPT";
        public static const var_1316: String = "RWFRM_DECLINE";

        private var var_2913: int = 0;

        public function RoomWidgetFriendRequestMessage(param1: String, param2: int = 0)
        {
            super(param1);
            this.var_2913 = param2;
        }

        public function get requestId(): int
        {
            return this.var_2913;
        }

    }
}
