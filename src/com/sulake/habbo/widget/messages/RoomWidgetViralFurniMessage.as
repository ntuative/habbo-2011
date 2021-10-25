package com.sulake.habbo.widget.messages
{

    public class RoomWidgetViralFurniMessage extends RoomWidgetMessage
    {

        public static const var_1380: String = "RWVFM_VIRAL_FOUND";
        public static const var_1281: String = "RWVFM_OPEN_PRESENT";

        private var var_2358: int;

        public function RoomWidgetViralFurniMessage(param1: String)
        {
            super(param1);
        }

        public function get objectId(): int
        {
            return this.var_2358;
        }

        public function set objectId(param1: int): void
        {
            this.var_2358 = param1;
        }

    }
}
