package com.sulake.habbo.widget.messages
{
    public class RoomWidgetEcotronBoxOpenedMessage extends RoomWidgetMessage 
    {

        public static const var_1912:String = "RWEBOM_ECOTRONBOX_OPENED";

        private var var_2934:String;
        private var var_2935:int;

        public function RoomWidgetEcotronBoxOpenedMessage(param1:String, param2:String, param3:int)
        {
            super(param1);
            this.var_2934 = param2;
            this.var_2935 = param3;
        }

        public function get itemType():String
        {
            return (this.var_2934);
        }

        public function get classId():int
        {
            return (this.var_2935);
        }

    }
}