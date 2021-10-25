package com.sulake.habbo.session.events
{

    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionChatEvent extends RoomSessionEvent
    {

        public static const RSCE_CHAT_EVENT: String = "RSCE_CHAT_EVENT";
        public static const RSCE_FLOOD_EVENT: String = "RSCE_FLOOD_EVENT";
        public static const CHAT_TYPE_NORMAL: int = 0;
        public static const CHAT_TYPE_WHISPER: int = 1;
        public static const CHAT_TYPE_SHOUT: int = 2;
        public static const CHAT_TYPE_USER_RESPECT: int = 3;
        public static const CHAT_TYPE_PET_RESPECT: int = 4;

        private var _userId: int = 0;
        private var _text: String = "";
        private var _chatType: int = 0;
        private var _links: Array;

        public function RoomSessionChatEvent(type: String, session: IRoomSession, userId: int, text: String, chatType: int = 0, links: Array = null, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, session, bubbles, cancelable);

            this._userId = userId;
            this._text = text;
            this._chatType = chatType;
            this._links = links;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get text(): String
        {
            return this._text;
        }

        public function get chatType(): int
        {
            return this._chatType;
        }

        public function get links(): Array
        {
            return this._links;
        }

    }
}
