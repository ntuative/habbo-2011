package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarSignUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _signType: int;

        public function RoomObjectAvatarSignUpdateMessage(signType: int)
        {
            this._signType = signType;
        }

        public function get signType(): int
        {
            return this._signType;
        }

    }
}
