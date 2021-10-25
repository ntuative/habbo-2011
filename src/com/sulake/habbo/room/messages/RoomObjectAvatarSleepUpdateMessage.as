package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarSleepUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _isSleeping: Boolean;

        public function RoomObjectAvatarSleepUpdateMessage(isSleeping: Boolean = false)
        {
            this._isSleeping = isSleeping;
        }

        public function get isSleeping(): Boolean
        {
            return this._isSleeping;
        }

    }
}
