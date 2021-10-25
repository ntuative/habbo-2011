package com.sulake.habbo.communication.messages.incoming.friendlist
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendData
    {

        private var _id: int;
        private var _name: String;
        private var _gender: int;
        private var _online: Boolean;
        private var _followingAllowed: Boolean;
        private var _figure: String;
        private var _categoryId: int;
        private var _motto: String;
        private var _lastAccess: String;
        private var _realName: String;

        public function FriendData(data: IMessageDataWrapper)
        {
            this._id = data.readInteger();
            this._name = data.readString();
            this._gender = data.readInteger();
            this._online = data.readBoolean();
            this._followingAllowed = data.readBoolean();
            this._figure = data.readString();
            this._categoryId = data.readInteger();
            this._motto = data.readString();
            this._lastAccess = data.readString();
            this._realName = data.readString();
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

        public function get followingAllowed(): Boolean
        {
            return this._followingAllowed;
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

    }
}
