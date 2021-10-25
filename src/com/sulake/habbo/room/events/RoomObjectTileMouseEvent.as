package com.sulake.habbo.room.events
{

    import com.sulake.room.events.RoomObjectMouseEvent;

    public class RoomObjectTileMouseEvent extends RoomObjectMouseEvent
    {

        private var _tileX: Number;
        private var _tileY: Number;
        private var _tileZ: Number;

        public function RoomObjectTileMouseEvent(type: String, eventId: String, objectId: int, objectType: String, tileX: Number, tileY: Number, tileZ: Number, altKey: Boolean = false, ctrlKey: Boolean = false, shiftKey: Boolean = false, buttonDown: Boolean = false, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, eventId, objectId, objectType, altKey, ctrlKey, shiftKey, buttonDown, bubbles, cancelable);
            
            this._tileX = tileX;
            this._tileY = tileY;
            this._tileZ = tileZ;
        }

        public function get tileX(): Number
        {
            return this._tileX;
        }

        public function get tileY(): Number
        {
            return this._tileY;
        }

        public function get tileZ(): Number
        {
            return this._tileZ;
        }

    }
}
