package com.sulake.habbo.widget.messages
{

    public class RoomWidgetChangeEmailMessage extends RoomWidgetMessage
    {

        public static const var_1794: String = "rwcem_change_email";

        private var var_3123: String;

        public function RoomWidgetChangeEmailMessage(param1: String)
        {
            super(var_1794);
            this.var_3123 = param1;
        }

        public function get newEmail(): String
        {
            return this.var_3123;
        }

    }
}
