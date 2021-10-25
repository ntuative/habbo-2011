package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorUserInfoData
    {

        private var _userId: int;
        private var _userName: String;
        private var _minutesSinceRegistration: int;
        private var _minutesSinceLastLogin: int;
        private var _online: Boolean;
        private var _cfhCount: int;
        private var _abusiveCfhCount: int;
        private var _cautionCount: int;
        private var _banCount: int;

        public function ModeratorUserInfoData(data: IMessageDataWrapper)
        {
            this._userId = data.readInteger();
            this._userName = data.readString();
            this._minutesSinceRegistration = data.readInteger();
            this._minutesSinceLastLogin = data.readInteger();
            this._online = data.readBoolean();
            this._cfhCount = data.readInteger();
            this._abusiveCfhCount = data.readInteger();
            this._cautionCount = data.readInteger();
            this._banCount = data.readInteger();
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get userName(): String
        {
            return this._userName;
        }

        public function get minutesSinceRegistration(): int
        {
            return this._minutesSinceRegistration;
        }

        public function get minutesSinceLastLogin(): int
        {
            return this._minutesSinceLastLogin;
        }

        public function get online(): Boolean
        {
            return this._online;
        }

        public function get cfhCount(): int
        {
            return this._cfhCount;
        }

        public function get abusiveCfhCount(): int
        {
            return this._abusiveCfhCount;
        }

        public function get cautionCount(): int
        {
            return this._cautionCount;
        }

        public function get banCount(): int
        {
            return this._banCount;
        }

    }
}
