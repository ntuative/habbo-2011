package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementData
    {

        private var _type: int;
        private var _level: int;
        private var _badgeId: String;
        private var _scoreLimit: int;
        private var _levelRewardPoints: int;
        private var _levelRewardPointType: int;
        private var _currentPoints: int;

        public function AchievementData(data: IMessageDataWrapper)
        {
            this._type = data.readInteger();
            this._level = data.readInteger();
            this._badgeId = data.readString();
            this._scoreLimit = data.readInteger();
            this._levelRewardPoints = data.readInteger();
            this._levelRewardPointType = data.readInteger();
            this._currentPoints = data.readInteger();
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get badgeId(): String
        {
            return this._badgeId;
        }

        public function get level(): int
        {
            return this._level;
        }

        public function get scoreLimit(): int
        {
            return this._scoreLimit;
        }

        public function get levelRewardPoints(): int
        {
            return this._levelRewardPoints;
        }

        public function get levelRewardPointType(): int
        {
            return this._levelRewardPointType;
        }

        public function get currentPoints(): int
        {
            return this._currentPoints;
        }

    }
}
