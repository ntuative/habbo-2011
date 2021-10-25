package com.sulake.habbo.room.events
{

    public class RoomEngineRoomColorEvent extends RoomEngineEvent
    {

        public static const REE_ROOM_COLOR: String = "REE_ROOM_COLOR";

        private var _color: uint;
        private var _brightness: uint;
        private var _bgOnly: Boolean;

        public function RoomEngineRoomColorEvent(roomId: int, roomCategory: int, color: uint, brightness: uint, bgOnly: Boolean, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(REE_ROOM_COLOR, roomId, roomCategory, bubbles, cancelable);
            
            this._color = color;
            this._brightness = brightness;
            this._bgOnly = bgOnly;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function get brightness(): uint
        {
            return this._brightness;
        }

        public function get bgOnly(): Boolean
        {
            return this._bgOnly;
        }

    }
}
