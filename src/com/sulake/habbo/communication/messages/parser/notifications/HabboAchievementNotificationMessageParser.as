package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementNotificationMessageParser implements IMessageParser
    {

        private var _type: int;
        private var _level: int;
        private var _points: int;
        private var _levelRewardPoints: int;
        private var _levelRewardPointType: int;
        private var _bonusPoints: int;
        private var _badgeId: String = "";
        private var _removedBadgeId: String = "";
        private var _achievementId: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._type = data.readInteger();
            this._level = data.readInteger();
            this._badgeId = data.readString();
            this._points = data.readInteger();
            this._levelRewardPoints = data.readInteger();
            this._levelRewardPointType = data.readInteger();
            this._bonusPoints = data.readInteger();
            this._achievementId = data.readInteger();
            this._removedBadgeId = data.readString();

            return true;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get level(): int
        {
            return this._level;
        }

        public function get points(): int
        {
            return this._points;
        }

        public function get levelRewardPoints(): int
        {
            return this._levelRewardPoints;
        }

        public function get levelRewardPointType(): int
        {
            return this._levelRewardPointType;
        }

        public function get bonusPoints(): int
        {
            return this._bonusPoints;
        }

        public function get badgeID(): String
        {
            return this._badgeId;
        }

        public function get achievementID(): int
        {
            return this._achievementId;
        }

        public function get removedBadgeID(): String
        {
            return this._removedBadgeId;
        }

    }
}
