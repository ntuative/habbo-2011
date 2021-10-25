package com.sulake.habbo.catalog.purse
{

    import flash.utils.Dictionary;

    public class Purse implements IPurse
    {

        public static const ACTIVITY_POINTS_TYPE_PIXELS: int = 0;

        private var _credits: int = 0;
        private var _activityPoints: Dictionary = new Dictionary();
        private var _clubDays: int = 0;
        private var _clubPeriods: int = 0;
        private var _isVip: Boolean = false;
        private var _pastClubDays: int = 0;
        private var _pastVipDays: int = 0;

        public function get credits(): int
        {
            return this._credits;
        }

        public function set credits(param1: int): void
        {
            this._credits = param1;
        }

        public function get clubDays(): int
        {
            return this._clubDays;
        }

        public function set clubDays(param1: int): void
        {
            this._clubDays = param1;
        }

        public function get clubPeriods(): int
        {
            return this._clubPeriods;
        }

        public function set clubPeriods(param1: int): void
        {
            this._clubPeriods = param1;
        }

        public function get hasClubLeft(): Boolean
        {
            return this._clubDays > 0 || this._clubPeriods > 0;
        }

        public function get isVIP(): Boolean
        {
            return this._isVip;
        }

        public function set isVIP(param1: Boolean): void
        {
            this._isVip = param1;
        }

        public function get pastClubDays(): int
        {
            return this._pastClubDays;
        }

        public function set pastClubDays(param1: int): void
        {
            this._pastClubDays = param1;
        }

        public function get pastVipDays(): int
        {
            return this._pastVipDays;
        }

        public function set pastVipDays(param1: int): void
        {
            this._pastVipDays = param1;
        }

        public function get activityPoints(): Dictionary
        {
            return this._activityPoints;
        }

        public function set activityPoints(param1: Dictionary): void
        {
            this._activityPoints = param1;
        }

        public function getActivityPointsForType(param1: int): int
        {
            return this._activityPoints[param1];
        }

    }
}
