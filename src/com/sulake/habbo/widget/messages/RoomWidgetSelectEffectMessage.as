package com.sulake.habbo.widget.messages
{

    public class RoomWidgetSelectEffectMessage extends RoomWidgetMessage
    {

        public static const var_1826: String = "RWCM_MESSAGE_SELECT_EFFECT";
        public static const var_1825: String = "RWCM_MESSAGE_UNSELECT_EFFECT";
        public static const var_1828: String = "RWCM_MESSAGE_UNSELECT_ALL_EFFECTS";

        private var var_4019: int;

        public function RoomWidgetSelectEffectMessage(param1: String, param2: int = -1)
        {
            super(param1);
            this.var_4019 = param2;
        }

        public function get effectType(): int
        {
            return this.var_4019;
        }

    }
}
