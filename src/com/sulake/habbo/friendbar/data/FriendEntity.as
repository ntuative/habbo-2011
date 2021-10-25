package com.sulake.habbo.friendbar.data
{

    public class FriendEntity implements IFriendEntity
    {

        private var _id: int;
        private var _name: String;
        private var _gender: int;
        private var _online: Boolean;
        private var _allowFollow: Boolean;
        private var _figure: String;
        private var _categoryId: int;
        private var _motto: String;
        private var _lastAccess: String;
        private var _realName: String;

        public function FriendEntity(id: int, name: String, realName: String, motto: String, gender: int, online: Boolean, allowFollow: Boolean, figure: String, categoryId: int, lastAccess: String)
        {
            this._id = id;
            this._name = name;
            this._realName = realName;
            this._motto = motto;
            this._gender = gender;
            this._online = online;
            this._allowFollow = allowFollow;
            this._figure = figure;
            this._categoryId = categoryId;
            this._lastAccess = lastAccess;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get gender(): int
        {
            return this._gender;
        }

        public function get online(): Boolean
        {
            return this._online;
        }

        public function get allowFollow(): Boolean
        {
            return this._allowFollow;
        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get categoryId(): int
        {
            return this._categoryId;
        }

        public function get motto(): String
        {
            return this._motto;
        }

        public function get lastAccess(): String
        {
            return this._lastAccess;
        }

        public function get realName(): String
        {
            return this._realName;
        }

        public function set name(value: String): void
        {
            this._name = value;
        }

        public function set gender(value: int): void
        {
            this._gender = value;
        }

        public function set online(value: Boolean): void
        {
            this._online = value;
        }

        public function set allowFollow(value: Boolean): void
        {
            this._allowFollow = value;
        }

        public function set figure(value: String): void
        {
            this._figure = value;
        }

        public function set categoryId(value: int): void
        {
            this._categoryId = value;
        }

        public function set motto(value: String): void
        {
            this._motto = value;
        }

        public function set lastAccess(value: String): void
        {
            this._lastAccess = value;
        }

        public function set realName(value: String): void
        {
            this._realName = value;
        }

    }
}
