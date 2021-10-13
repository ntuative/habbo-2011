package com.sulake.habbo.widget.messages
{
    public class RoomWidgetChatMessage extends RoomWidgetMessage 
    {

        public static const var_1352:String = "RWCM_MESSAGE_CHAT";
        public static const var_530:int = 0;
        public static const var_533:int = 1;
        public static const var_534:int = 2;

        private var var_4404:int = 0;
        private var _text:String = "";
        private var var_3096:String = "";

        public function RoomWidgetChatMessage(param1:String, param2:String, param3:int=0, param4:String="")
        {
            super(param1);
            this._text = param2;
            this.var_4404 = param3;
            this.var_3096 = param4;
        }

        public function get chatType():int
        {
            return (this.var_4404);
        }

        public function get text():String
        {
            return (this._text);
        }

        public function get recipientName():String
        {
            return (this.var_3096);
        }

    }
}