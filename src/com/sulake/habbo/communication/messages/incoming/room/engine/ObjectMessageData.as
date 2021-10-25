package com.sulake.habbo.communication.messages.incoming.room.engine
{

    public class ObjectMessageData
    {

        private var _id: int = 0;
        private var _x: Number = 0;
        private var _y: Number = 0;
        private var _z: Number = 0;
        private var _dir: int = 0;
        private var _sizeX: int = 0;
        private var _sizeY: int = 0;
        private var _type: int = 0;
        private var var_3036: String = "";
        private var _extra: int = -1;
        private var _state: int = 0;
        private var _data: String = "";
        private var _expiryTime: int = 0;
        private var _staticClass: String = null;
        private var _readonly: Boolean = false;

        public function ObjectMessageData(id: int)
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

        public function set x(param1: Number): void
        {
            if (!this._readonly)
            {
                this._x = param1;
            }

        }

        public function get y(): Number
        {
            return this._y;
        }

        public function set y(param1: Number): void
        {
            if (!this._readonly)
            {
                this._y = param1;
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

        public function get type(): int
        {
            return this._type;
        }

        public function set type(param1: int): void
        {
            if (!this._readonly)
            {
                this._type = param1;
            }

        }

        public function get state(): int
        {
            return this._state;
        }

        public function set state(param1: int): void
        {
            if (!this._readonly)
            {
                this._state = param1;
            }

        }

        public function get data(): String
        {
            return this._data;
        }

        public function set data(param1: String): void
        {
            if (!this._readonly)
            {
                this._data = param1;
            }

        }

        public function get staticClass(): String
        {
            return this._staticClass;
        }

        public function set staticClass(param1: String): void
        {
            if (!this._readonly)
            {
                this._staticClass = param1;
            }

        }

        public function get extra(): int
        {
            return this._extra;
        }

        public function set extra(param1: int): void
        {
            if (!this._readonly)
            {
                this._extra = param1;
            }

        }

        public function get expiryTime(): int
        {
            return this._expiryTime;
        }

        public function set expiryTime(param1: int): void
        {
            if (!this._readonly)
            {
                this._expiryTime = param1;
            }

        }

    }
}
