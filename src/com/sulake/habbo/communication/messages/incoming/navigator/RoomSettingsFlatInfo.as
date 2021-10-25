package com.sulake.habbo.communication.messages.incoming.navigator
{

    public class RoomSettingsFlatInfo
    {

        public static const DOOR_MODE_OPEN: int = 0;
        public static const DOOR_MODE_DOORBELL: int = 1;
        public static const DOOR_MODE_PASSWORD: int = 2;
        public static const DOOR_STATE: Array = ["open", "closed", "password"];

        private var _allowFurniMoving: Boolean;
        private var _doorMode: int;
        private var _id: int;
        private var _ownerName: String;
        private var _type: String;
        private var _name: String;
        private var _description: String;
        private var _showOwnerName: Boolean;
        private var _allowTrading: Boolean;
        private var _categoryAlertKey: Boolean;
        private var _password: String;

        public function get allowFurniMoving(): Boolean
        {
            return this._allowFurniMoving;
        }

        public function get doorMode(): int
        {
            return this._doorMode;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get ownerName(): String
        {
            return this._ownerName;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get description(): String
        {
            return this._description;
        }

        public function get showOwnerName(): Boolean
        {
            return this._showOwnerName;
        }

        public function get allowTrading(): Boolean
        {
            return this._allowTrading;
        }

        public function get categoryAlertKey(): Boolean
        {
            return this._categoryAlertKey;
        }

        public function get password(): String
        {
            return this._password;
        }

        public function set allowFurniMoving(param1: Boolean): void
        {
            this._allowFurniMoving = param1;
        }

        public function set doorMode(param1: int): void
        {
            this._doorMode = param1;
        }

        public function set id(param1: int): void
        {
            this._id = param1;
        }

        public function set ownerName(param1: String): void
        {
            this._ownerName = param1;
        }

        public function set type(param1: String): void
        {
            this._type = param1;
        }

        public function set name(param1: String): void
        {
            this._name = param1;
        }

        public function set description(param1: String): void
        {
            this._description = param1;
        }

        public function set showOwnerName(param1: Boolean): void
        {
            this._showOwnerName = param1;
        }

        public function set allowTrading(param1: Boolean): void
        {
            this._allowTrading = param1;
        }

        public function set categoryAlertKey(param1: Boolean): void
        {
            this._categoryAlertKey = param1;
        }

        public function set password(param1: String): void
        {
            this._password = param1;
        }

    }
}
