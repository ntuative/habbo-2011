package com.sulake.habbo.widget.messages
{

    public class RoomWidgetChatTypingMessage extends RoomWidgetMessage
    {

        public static const RWCTM_TYPING_STATUS: String = "RWCTM_TYPING_STATUS";

        private var _isTyping: Boolean;

        public function RoomWidgetChatTypingMessage(isTyping: Boolean)
        {
            super(RWCTM_TYPING_STATUS);
            this._isTyping = isTyping;
        }

        public function get isTyping(): Boolean
        {
            return this._isTyping;
        }

    }
}
