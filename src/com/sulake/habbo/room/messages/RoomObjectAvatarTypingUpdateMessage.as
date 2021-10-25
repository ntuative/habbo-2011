package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _typing: Boolean;

        public function RoomObjectAvatarTypingUpdateMessage(typing: Boolean = false)
        {
            this._typing = typing;
        }

        public function get typing(): Boolean
        {
            return this._typing;
        }

    }
}
