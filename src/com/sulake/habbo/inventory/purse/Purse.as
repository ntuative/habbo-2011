package com.sulake.habbo.inventory.purse
{

    public class Purse
    {

        private var _clubDays: int = 0;
        private var _clubPeriods: int = 0;
        private var _clubPastPeriods: int = 0;
        private var _clubHasEverBeenMember: Boolean = false;
        private var _isVip: Boolean = false;

        public function set clubDays(value: int): void
        {
            this._clubDays = Math.max(0, value);
        }

        public function set clubPeriods(value: int): void
        {
            this._clubPeriods = Math.max(0, value);
        }

        public function set clubPastPeriods(value: int): void
        {
            this._clubPastPeriods = Math.max(0, value);
        }

        public function set clubHasEverBeenMember(value: Boolean): void
        {
            this._clubHasEverBeenMember = value;
        }

        public function set isVIP(value: Boolean): void
        {
            this._isVip = value;
        }

        public function get clubDays(): int
        {
            return this._clubDays;
        }

        public function get clubPeriods(): int
        {
            return this._clubPeriods;
        }

        public function get clubPastPeriods(): int
        {
            return this._clubPastPeriods;
        }

        public function get clubHasEverBeenMember(): Boolean
        {
            return this._clubHasEverBeenMember;
        }

        public function get isVIP(): Boolean
        {
            return this._isVip;
        }

    }
}
