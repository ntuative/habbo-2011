package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _gesture: int = 0;

        public function RoomObjectAvatarGestureUpdateMessage(gesture: int)
        {
            this._gesture = gesture;
        }

        public function get gesture(): int
        {
            return this._gesture;
        }

    }
}
