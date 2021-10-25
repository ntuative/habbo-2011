package com.sulake.habbo.room.events
{

    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectDimmerStateUpdateEvent extends RoomObjectEvent
    {

        public static const RODSUE_DIMMER_STATE: String = "RODSUE_DIMMER_STATE";

        private var _state: int;
        private var _presetId: int;
        private var _effectId: int;
        private var _color: uint;
        private var _brightness: int;

        public function RoomObjectDimmerStateUpdateEvent(roomId: int, roomCategory: String, state: int, presetId: int, effectId: int, color: uint, brightness: int, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(RODSUE_DIMMER_STATE, roomId, roomCategory, bubbles, cancelable);
            
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
