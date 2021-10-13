package com.sulake.habbo.widget.messages
{
    import flash.display.BitmapData;

    public class RoomWidgetSetToolbarIconMessage extends RoomWidgetMessage 
    {

        public static const var_1904:String = "RWCM_MESSAGE_SET_TOOLBAR_ICON";
        public static const var_1903:String = "me_menu";

        private var var_4865:String;
        private var _icon:BitmapData;

        public function RoomWidgetSetToolbarIconMessage(param1:String, param2:BitmapData)
        {
            super(var_1904);
            this.var_4865 = param1;
            this._icon = param2;
        }

        public function get widgetType():String
        {
            return (this.var_4865);
        }

        public function get icon():BitmapData
        {
            return (this._icon);
        }

    }
}