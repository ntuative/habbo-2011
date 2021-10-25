package com.sulake.habbo.communication.messages.outgoing.roomsettings
{

    public class SaveableRoomSettingsData
    {

        private var _roomId: int;
        private var _name: String;
        private var _description: String;
        private var _doorMode: int;
        private var _password: String;
        private var _categoryId: int;
        private var _maximumVisitors: int;
        private var _tags: Array;
        private var _controllers: Array;
        private var _allowPets: Boolean;
        private var _allowFoodConsume: Boolean;
        private var _allowWalkThrough: Boolean;
        private var _hideWalls: Boolean;

        public function get allowPets(): Boolean
        {
            return this._allowPets;
        }

        public function set allowPets(value: Boolean): void
        {
            this._allowPets = value;
        }

        public function get allowFoodConsume(): Boolean
        {
            return this._allowFoodConsume;
        }

        public function set allowFoodConsume(value: Boolean): void
        {
            this._allowFoodConsume = value;
        }

        public function get allowWalkThrough(): Boolean
        {
            return this._allowWalkThrough;
        }

        public function set allowWalkThrough(value: Boolean): void
        {
            this._allowWalkThrough = value;
        }

        public function get hideWalls(): Boolean
        {
            return this._hideWalls;
        }

        public function set hideWalls(value: Boolean): void
        {
            this._hideWalls = value;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function set roomId(value: int): void
        {
            this._roomId = value;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function set name(value: String): void
        {
            this._name = value;
        }

        public function get description(): String
        {
            return this._description;
        }

        public function set description(value: String): void
        {
            this._description = value;
        }

        public function get doorMode(): int
        {
            return this._doorMode;
        }

        public function set doorMode(value: int): void
        {
            this._doorMode = value;
        }

        public function get password(): String
        {
            return this._password;
        }

        public function set password(value: String): void
        {
            this._password = value;
        }

        public function get categoryId(): int
        {
            return this._categoryId;
        }

        public function set categoryId(value: int): void
        {
            this._categoryId = value;
        }

        public function get maximumVisitors(): int
        {
            return this._maximumVisitors;
        }

        public function set maximumVisitors(value: int): void
        {
            this._maximumVisitors = value;
        }

        public function get tags(): Array
        {
            return this._tags;
        }

        public function set tags(value: Array): void
        {
            this._tags = value;
        }

        public function get controllers(): Array
        {
            return this._controllers;
        }

        public function set controllers(value: Array): void
        {
            this._controllers = value;
        }

    }
}
