package com.sulake.habbo.widget.messages
{

    public class RoomWidgetChatMessage extends RoomWidgetMessage
    {

        public static const RWCM_MESSAGE_CHAT: String = "RWCM_MESSAGE_CHAT";
        public static const CHAT_TYPE_NORMAL: int = 0;
        public static const CHAT_TYPE_WHISPER: int = 1;
        public static const CHAT_TYPE_SHOUT: int = 2;

        private var _chatType: int = 0;
        private var _text: String = "";
        private var _recipientName: String = "";

        public function RoomWidgetChatMessage(type: String, text: String, chatType: int = 0, recipientName: String = "")
        {
            super(type);

            this._text = text;
            this._chatType = chatType;
            this._recipientName = recipientName;
        }

        public function get chatType(): int
        {
            return this._chatType;
        }

        public function get text(): String
        {
            return this._text;
        }

        public function get recipientName(): String
        {
            return this._recipientName;
        }

    }
}
