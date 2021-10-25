package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _effect: int;
        private var _delayMilliSeconds: int;

        public function RoomObjectAvatarEffectUpdateMessage(effect: int = 0, delayMilliSeconds: int = 0)
        {
            this._effect = effect;
            this._delayMilliSeconds = delayMilliSeconds;
        }

        public function get effect(): int
        {
            return this._effect;
        }

        public function get delayMilliSeconds(): int
        {
            return this._delayMilliSeconds;
        }

    }
}
