package com.sulake.habbo.communication.messages.incoming.room.furniture
{

    public class RoomDimmerPresetsMessageData
    {

        private var _id: int = 0;
        private var _type: int = 0;
        private var _color: uint = 0;
        private var _light: uint = 0;
        private var _readonly: Boolean = false;

        public function RoomDimmerPresetsMessageData(value: int)
        {
            this._id = value;
        }

        public function setReadOnly(): void
        {
            this._readonly = true;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function set type(value: int): void
        {
            if (!this._readonly)
            {
                this._type = value;
            }

        }

        public function get color(): uint
        {
            return this._color;
        }

        public function set color(value: uint): void
        {
            if (!this._readonly)
            {
                this._color = value;
            }

        }

        public function get light(): int
        {
            return this._light;
        }

        public function set light(value: int): void
        {
            if (!this._readonly)
            {
                this._light = value;
            }

        }

    }
}
