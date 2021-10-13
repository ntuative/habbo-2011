﻿package com.sulake.habbo.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetBadgeImageUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1343:String = "RWBIUE_BADGE_IMAGE";

        private var var_3262:String;
        private var var_4694:BitmapData;

        public function RoomWidgetBadgeImageUpdateEvent(param1:String, param2:BitmapData, param3:Boolean=false, param4:Boolean=false)
        {
            super(var_1343, param3, param4);
            this.var_3262 = param1;
            this.var_4694 = param2;
        }

        public function get badgeID():String
        {
            return (this.var_3262);
        }

        public function get badgeImage():BitmapData
        {
            return (this.var_4694);
        }

    }
}