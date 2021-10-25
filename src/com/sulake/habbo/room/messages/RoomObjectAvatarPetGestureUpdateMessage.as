package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _gesture: String;

        public function RoomObjectAvatarPetGestureUpdateMessage(gesture: String)
        {
            this._gesture = gesture;
        }

        public function get gesture(): String
        {
            return this._gesture;
        }

    }
}
