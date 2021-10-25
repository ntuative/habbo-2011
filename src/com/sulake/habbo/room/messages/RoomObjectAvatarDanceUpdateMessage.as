package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarDanceUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _danceStyle: int;

        public function RoomObjectAvatarDanceUpdateMessage(danceStyle: int = 0)
        {
            this._danceStyle = danceStyle;
        }

        public function get danceStyle(): int
        {
            return this._danceStyle;
        }

    }
}
