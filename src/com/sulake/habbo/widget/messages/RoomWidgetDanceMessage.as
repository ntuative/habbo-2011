package com.sulake.habbo.widget.messages
{

    public class RoomWidgetDanceMessage extends RoomWidgetMessage
    {

        public static const var_1892: String = "RWCM_MESSAGE_DANCE";
        public static const var_1819: int = 0;
        public static const var_1829: Array = [2, 3, 4];

        private var var_1025: int = 0;

        public function RoomWidgetDanceMessage(param1: int)
        {
            super(var_1892);
            this.var_1025 = param1;
        }

        public function get style(): int
        {
            return this.var_1025;
        }

    }
}
