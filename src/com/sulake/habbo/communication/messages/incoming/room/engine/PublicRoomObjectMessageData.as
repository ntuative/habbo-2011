package com.sulake.habbo.communication.messages.incoming.room.engine
{

    public class PublicRoomObjectMessageData
    {

        private var _name: String = "";
        private var _type: String = "";
        private var _x: Number = 0;
        private var _id: Number = 0;
        private var _z: Number = 0;
        private var _dir: int = 0;
        private var _sizeX: int = 0;
        private var _sizeY: int = 0;
        private var _readonly: Boolean = false;

        public function setReadOnly(): void
        {
            this._readonly = true;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function set type(param1: String): void
        {
            if (!this._readonly)
            {
                this._type = param1;
            }

        }

        public function get name(): String
        {
            return this._name;
        }

        public function set name(param1: String): void
        {
            if (!this._readonly)
            {
                this._name = param1;
            }

        }

        public function get x(): Number
        {
            return this._x;
        }

        public function set x(param1: Number): void
        {
            if (!this._readonly)
            {
                this._x = param1;
            }

        }

        public function get y(): Number
        {
            return this._id;
        }

        public function set y(param1: Number): void
        {
            if (!this._readonly)
            {
                this._id = param1;
            }

        }

        public function get z(): Number
        {
            return this._z;
        }

        public function set z(param1: Number): void
        {
            if (!this._readonly)
            {
                this._z = param1;
            }

        }

        public function get dir(): int
        {
            return this._dir;
        }

        public function set dir(param1: int): void
        {
            if (!this._readonly)
            {
                this._dir = param1;
            }

        }

        public function get sizeX(): int
        {
            return this._sizeX;
        }

        public function set sizeX(param1: int): void
        {
            if (!this._readonly)
            {
                this._sizeX = param1;
            }

        }

        public function get sizeY(): int
        {
            return this._sizeY;
        }

        public function set sizeY(param1: int): void
        {
            if (!this._readonly)
            {
                this._sizeY = param1;
            }

        }

    }
}
