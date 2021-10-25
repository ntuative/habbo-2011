package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{

    public class AvatarEffect
    {

        private var _type: int;
        private var _duration: int;
        private var _inactiveEffectsInInventory: int;
        private var _secondsLeftIfActive: int;

        public function get type(): int
        {
            return this._type;
        }

        public function set type(value: int): void
        {
            this._type = value;
        }

        public function get duration(): int
        {
            return this._duration;
        }

        public function set duration(value: int): void
        {
            this._duration = value;
        }

        public function get inactiveEffectsInInventory(): int
        {
            return this._inactiveEffectsInInventory;
        }

        public function set inactiveEffectsInInventory(count: int): void
        {
            this._inactiveEffectsInInventory = count;
        }

        public function get secondsLeftIfActive(): int
        {
            return this._secondsLeftIfActive;
        }

        public function set secondsLeftIfActive(seconds: int): void
        {
            this._secondsLeftIfActive = seconds;
        }

    }
}
