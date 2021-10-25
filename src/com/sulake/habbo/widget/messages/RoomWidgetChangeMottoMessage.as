package com.sulake.habbo.widget.messages
{

    public class RoomWidgetChangeMottoMessage extends RoomWidgetMessage
    {

        public static const CHANGE_MOTTO: String = "RWVM_CHANGE_MOTTO_MESSAGE";

        private var var_2910: String;

        public function RoomWidgetChangeMottoMessage(param1: String)
        {
            super(CHANGE_MOTTO);
            this.var_2910 = param1;
        }

        public function get motto(): String
        {
            return this.var_2910;
        }

    }
}
