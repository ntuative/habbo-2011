package com.sulake.habbo.widget.messages
{

    public class RoomWidgetDimmerPreviewMessage extends RoomWidgetMessage
    {

        public static const var_1817: String = "RWDPM_PREVIEW_DIMMER_PRESET";

        private var _color: uint;
        private var var_3932: int;
        private var var_3935: Boolean;

        public function RoomWidgetDimmerPreviewMessage(param1: uint, param2: int, param3: Boolean)
        {
            super(var_1817);
            this._color = param1;
            this.var_3932 = param2;
            this.var_3935 = param3;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function get brightness(): int
        {
            return this.var_3932;
        }

        public function get bgOnly(): Boolean
        {
            return this.var_3935;
        }

    }
}
