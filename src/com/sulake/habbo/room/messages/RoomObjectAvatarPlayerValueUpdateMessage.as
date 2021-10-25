package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarPlayerValueUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _value: int;

        public function RoomObjectAvatarPlayerValueUpdateMessage(value: int)
        {
            this._value = value;
        }

        public function get value(): int
        {
            return this._value;
        }

    }
}
