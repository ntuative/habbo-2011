package com.sulake.habbo.help.cfh.data
{

    public class UserRegistryItem
    {

        private var _userId: int;
        private var _userName: String = "";
        private var _roomName: String = "";

        public function UserRegistryItem(userId: int, userName: String, roomName: String = "")
        {
            this._userId = userId;
            this._userName = userName;
            this._roomName = roomName;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get userName(): String
        {
            return this._userName;
        }

        public function get roomName(): String
        {
            return this._roomName;
        }

        public function set roomName(value: String): void
        {
            this._roomName = value;
        }

    }
}
