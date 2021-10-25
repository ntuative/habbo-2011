package com.sulake.habbo.room.events
{

    public class RoomEngineDimmerStateEvent extends RoomEngineEvent
    {

        public static const REDSE_ROOM_COLOR: String = "REDSE_ROOM_COLOR";

        private var _state: int;
        private var _presetId: int;
        private var _effectId: int;
        private var _color: uint;
        private var _brightness: int;

        public function RoomEngineDimmerStateEvent(roomId: int, roomCategory: int, state: int, presetId: int, effectId: int, color: uint, brightness: uint, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(REDSE_ROOM_COLOR, roomId, roomCategory, bubbles, cancelable);
            this._state = state;
            this._presetId = presetId;
            this._effectId = effectId;
            this._color = color;
            this._brightness = brightness;
        }

        public function get state(): int
        {
            return this._state;
        }

        public function get presetId(): int
        {
            return this._presetId;
        }

        public function get effectId(): int
        {
            return this._effectId;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function get brightness(): uint
        {
            return this._brightness;
        }

    }
}
