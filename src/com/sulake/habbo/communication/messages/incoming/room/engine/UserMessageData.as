package com.sulake.habbo.communication.messages.incoming.room.engine
{

    public class UserMessageData
    {

        public static const MALE: String = "M";
        public static const FEMALE: String = "F";

        private var _id: int = 0;
        private var _x: Number = 0;
        private var _y: Number = 0;
        private var _z: Number = 0;
        private var _dir: int = 0;
        private var _name: String = "";
        private var _userType: int = 0;
        private var _sex: String = "";
        private var _figure: String = "";
        private var _custom: String = "";
        private var _achievementScore: int;
        private var _webId: int = 0;
        private var _groupId: String = "";
        private var _groupStatus: int = 0;
        private var _xp: int = 0;
        private var _subType: String = "";
        private var _readonly: Boolean = false;

        public function UserMessageData(id: int)
        {
            this._id = id;
        }

        public function setReadOnly(): void
        {
            this._readonly = true;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get x(): Number
        {
            return this._x;
        }

        public function set x(value: Number): void
        {
            if (!this._readonly)
            {
                this._x = value;
            }

        }

        public function get y(): Number
        {
            return this._y;
        }

        public function set y(value: Number): void
        {
            if (!this._readonly)
            {
                this._y = value;
            }

        }

        public function get z(): Number
        {
            return this._z;
        }

        public function set z(value: Number): void
        {
            if (!this._readonly)
            {
                this._z = value;
            }

        }

        public function get dir(): int
        {
            return this._dir;
        }

        public function set dir(value: int): void
        {
            if (!this._readonly)
            {
                this._dir = value;
            }

        }

        public function get name(): String
        {
            return this._name;
        }

        public function set name(value: String): void
        {
            if (!this._readonly)
            {
                this._name = value;
            }

        }

        public function get userType(): int
        {
            return this._userType;
        }

        public function set userType(value: int): void
        {
            if (!this._readonly)
            {
                this._userType = value;
            }

        }

        public function get sex(): String
        {
            return this._sex;
        }

        public function set sex(value: String): void
        {
            if (!this._readonly)
            {
                this._sex = value;
            }

        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function set figure(value: String): void
        {
            if (!this._readonly)
            {
                this._figure = value;
            }

        }

        public function get custom(): String
        {
            return this._custom;
        }

        public function set custom(value: String): void
        {
            if (!this._readonly)
            {
                this._custom = value;
            }

        }

        public function get achievementScore(): int
        {
            return this._achievementScore;
        }

        public function set achievementScore(value: int): void
        {
            if (!this._readonly)
            {
                this._achievementScore = value;
            }

        }

        public function get webID(): int
        {
            return this._webId;
        }

        public function set webID(value: int): void
        {
            if (!this._readonly)
            {
                this._webId = value;
            }

        }

        public function get groupID(): String
        {
            return this._groupId;
        }

        public function set groupID(value: String): void
        {
            if (!this._readonly)
            {
                this._groupId = value;
            }

        }

        public function get groupStatus(): int
        {
            return this._groupStatus;
        }

        public function set groupStatus(value: int): void
        {
            if (!this._readonly)
            {
                this._groupStatus = value;
            }

        }

        public function get xp(): int
        {
            return this._xp;
        }

        public function set xp(value: int): void
        {
            if (!this._readonly)
            {
                this._xp = value;
            }

        }

        public function get subType(): String
        {
            return this._subType;
        }

        public function set subType(value: String): void
        {
            if (!this._readonly)
            {
                this._subType = value;
            }

        }

    }
}
