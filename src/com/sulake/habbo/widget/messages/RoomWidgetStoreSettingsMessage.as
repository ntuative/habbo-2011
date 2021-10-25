package com.sulake.habbo.widget.messages
{

    public class RoomWidgetStoreSettingsMessage extends RoomWidgetMessage
    {

        public static const var_1900: String = "RWSSM_STORE_SETTINGS";
        public static const var_1831: String = "RWSSM_STORE_SOUND";
        public static const var_1832: String = "RWSSM_PREVIEW_SOUND";

        private var var_3346: Number;

        public function RoomWidgetStoreSettingsMessage(param1: String)
        {
            super(param1);
        }

        public function get volume(): Number
        {
            return this.var_3346;
        }

        public function set volume(param1: Number): void
        {
            this.var_3346 = param1;
        }

    }
}
