package com.sulake.habbo.widget.messages
{
    public class RoomWidgetChatTypingMessage extends RoomWidgetMessage 
    {

        public static const var_1910:String = "RWCTM_TYPING_STATUS";

        private var var_3296:Boolean;

        public function RoomWidgetChatTypingMessage(param1:Boolean)
        {
            super(var_1910);
            this.var_3296 = param1;
        }

        public function get var_1215():Boolean
        {
            return (this.var_3296);
        }

    }
}