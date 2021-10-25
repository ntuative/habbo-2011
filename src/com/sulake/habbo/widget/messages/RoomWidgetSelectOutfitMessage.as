package com.sulake.habbo.widget.messages
{

    public class RoomWidgetSelectOutfitMessage extends RoomWidgetMessage
    {

        public static const var_1823: String = "select_outfit";

        private var var_4864: int;

        public function RoomWidgetSelectOutfitMessage(param1: int)
        {
            super(var_1823);
            this.var_4864 = param1;
        }

        public function get outfitId(): int
        {
            return this.var_4864;
        }

    }
}
