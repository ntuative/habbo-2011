package com.sulake.habbo.widget.messages
{

    public class RoomWidgetMessage
    {

        public static const var_1547: String = "RWM_MESSAGE_TEST";

        private var _type: String = "";

        public function RoomWidgetMessage(type: String)
        {
            this._type = type;
        }

        public function get type(): String
        {
            return this._type;
        }

    }
}
