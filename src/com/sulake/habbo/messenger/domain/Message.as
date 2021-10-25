package com.sulake.habbo.messenger.domain
{

    public class Message
    {

        public static const MESSAGE_PREVIOUS: int = 1;
        public static const MESSAGE_NEW: int = 2;
        public static const MESSAGE_MODERATION: int = 3;
        public static const MESSAGE_ERROR: int = 4;
        public static const MESSAGE_ONLINE: int = 5;
        public static const MESSAGE_ROOM_INVITE: int = 6;

        private var _type: int;
        private var _senderId: int;
        private var _messageText: String;
        private var _time: String;

        public function Message(type: int, senderId: int, messageText: String, time: String)
        {
            this._type = type;
            this._senderId = senderId;
            this._messageText = messageText;
            this._time = time;
        }

        public function get messageText(): String
        {
            return this._messageText;
        }

        public function get time(): String
        {
            return this._time;
        }

        public function get senderId(): int
        {
            return this._senderId;
        }

        public function get type(): int
        {
            return this._type;
        }

    }
}
