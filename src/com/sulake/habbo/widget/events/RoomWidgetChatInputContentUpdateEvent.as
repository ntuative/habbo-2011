﻿package com.sulake.habbo.widget.events
{
    public class RoomWidgetChatInputContentUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1353:String = "RWWCIDE_CHAT_INPUT_CONTENT";
        public static const var_1355:String = "whisper";
        public static const var_1356:String = "shout";

        private var var_4695:String = "";
        private var _userName:String = "";

        public function RoomWidgetChatInputContentUpdateEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false)
        {
            super(var_1353, param3, param4);
            this.var_4695 = param1;
            this._userName = param2;
        }

        public function get messageType():String
        {
            return (this.var_4695);
        }

        public function get userName():String
        {
            return (this._userName);
        }

    }
}