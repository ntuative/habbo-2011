package com.sulake.habbo.widget.messages
{

    public class RoomWidgetPlayListModificationMessage extends RoomWidgetMessage
    {

        public static const var_1250: String = "RWPLAM_ADD_TO_PLAYLIST";
        public static const var_1251: String = "RWPLAM_REMOVE_FROM_PLAYLIST";

        private var var_4861: int;
        private var var_4862: int;

        public function RoomWidgetPlayListModificationMessage(param1: String, param2: int = -1, param3: int = -1)
        {
            super(param1);
            this.var_4862 = param2;
            this.var_4861 = param3;
        }

        public function get diskId(): int
        {
            return this.var_4861;
        }

        public function get slotNumber(): int
        {
            return this.var_4862;
        }

    }
}
