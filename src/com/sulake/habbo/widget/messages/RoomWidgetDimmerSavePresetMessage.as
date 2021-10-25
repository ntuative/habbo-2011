package com.sulake.habbo.widget.messages
{

    public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage
    {

        public static const var_1818: String = "RWSDPM_SAVE_PRESET";

        private var var_3101: int;
        private var var_3102: int;
        private var _color: uint;
        private var var_3932: int;
        private var var_4856: Boolean;

        public function RoomWidgetDimmerSavePresetMessage(param1: int, param2: int, param3: uint, param4: int, param5: Boolean)
        {
            super(var_1818);
            this.var_3101 = param1;
            this.var_3102 = param2;
            this._color = param3;
            this.var_3932 = param4;
            this.var_4856 = param5;
        }

        public function get presetNumber(): int
        {
            return this.var_3101;
        }

        public function get effectTypeId(): int
        {
            return this.var_3102;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function get brightness(): int
        {
            return this.var_3932;
        }

        public function get apply(): Boolean
        {
            return this.var_4856;
        }

    }
}
