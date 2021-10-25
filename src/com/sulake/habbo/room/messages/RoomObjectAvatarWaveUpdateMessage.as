package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarWaveUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _isWaving: Boolean = false;

        public function RoomObjectAvatarWaveUpdateMessage(isWaving: Boolean = false)
        {
            this._isWaving = isWaving;
        }

        public function get isWaving(): Boolean
        {
            return this._isWaving;
        }

    }
}
