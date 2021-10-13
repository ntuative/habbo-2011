package com.sulake.habbo.widget.messages
{
    public class RoomWidgetOpenCatalogMessage extends RoomWidgetMessage 
    {

        public static const var_1815:String = "RWGOI_MESSAGE_OPEN_CATALOG";
        public static const var_1816:String = "RWOCM_CLUB_MAIN";
        public static const var_1283:String = "RWOCM_PIXELS";
        public static const var_1282:String = "RWOCM_CREDITS";

        private var var_4859:String = "";

        public function RoomWidgetOpenCatalogMessage(param1:String)
        {
            super(var_1815);
            this.var_4859 = param1;
        }

        public function get pageKey():String
        {
            return (this.var_4859);
        }

    }
}