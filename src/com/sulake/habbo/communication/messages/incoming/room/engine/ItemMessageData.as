package com.sulake.habbo.communication.messages.incoming.room.engine
{

    public class ItemMessageData
    {

        private var _id: int = 0;
        private var _isOldFormat: Boolean = false;
        private var _wallX: int = 0;
        private var _wallY: int = 0;
        private var _localX: int = 0;
        private var _localY: int = 0;
        private var _y: Number = 0;
        private var _z: Number = 0;
        private var _dir: String = "";
        private var _type: int = 0;
        private var _unknown1: String = "";
        private var _unknown2: int = 0;
        private var _state: int = 0;
        private var _data: String = "";
        private var _readonly: Boolean = false;

        public function ItemMessageData(id: int, type: int, isOldFormat: Boolean)
        {
            this._id = id;
            this._type = type;
            this._isOldFormat = isOldFormat;
        }

        public function setReadOnly(): void
        {
            this._readonly = true;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get isOldFormat(): Boolean
        {
            return this._isOldFormat;
        }

        public function get wallX(): Number
        {
            return this._wallX;
        }

        public function set wallX(param1: Number): void
        {
            if (!this._readonly)
            {
                this._wallX = param1;
            }

        }

        public function get wallY(): Number
        {
            return this._wallY;
        }

        public function set wallY(param1: Number): void
        {
            if (!this._readonly)
            {
                this._wallY = param1;
            }

        }

        public function get localX(): Number
        {
            return this._localX;
        }

        public function set localX(param1: Number): void
        {
            if (!this._readonly)
            {
                this._localX = param1;
            }

        }

        public function get localY(): Number
        {
            return this._localY;
        }

        public function set localY(param1: Number): void
        {
            if (!this._readonly)
            {
                this._localY = param1;
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

        public function get dir(): String
        {
            return this._dir;
        }

        public function set dir(param1: String): void
        {
            if (!this._readonly)
            {
                this._dir = param1;
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

    }
}
