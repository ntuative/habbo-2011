package com.sulake.habbo.room.events
{

    public class RoomEngineObjectPlacedEvent extends RoomEngineObjectEvent
    {

        private var _wallLocation: String = "";
        private var _x: Number = 0;
        private var _y: Number = 0;
        private var _z: Number = 0;
        private var _direction: int = 0;
        private var _placedInRoom: Boolean = false;

        public function RoomEngineObjectPlacedEvent(type: String, roomId: int, roomCategory: int, objectId: int, category: int, wallLocation: String, x: Number, y: Number, z: Number, direction: int, placedInRoom: Boolean, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, roomId, roomCategory, objectId, category, bubbles, cancelable);
            
            this._wallLocation = wallLocation;
            this._x = x;
            this._y = y;
            this._z = z;
            this._direction = direction;
            this._placedInRoom = placedInRoom;
        }

        public function get wallLocation(): String
        {
            return this._wallLocation;
        }

        public function get x(): Number
        {
            return this._x;
        }

        public function get y(): Number
        {
            return this._y;
        }

        public function get z(): Number
        {
            return this._z;
        }

        public function get direction(): int
        {
            return this._direction;
        }

        public function get placedInRoom(): Boolean
        {
            return this._placedInRoom;
        }

    }
}
