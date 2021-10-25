package com.sulake.room.events
{

    import flash.events.Event;

    public class RoomObjectEvent extends Event
    {

        private var _objectId: int = 0;
        private var _objectType: String = "";

        public function RoomObjectEvent(type: String, objectId: int, objectType: String, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, bubbles, cancelable);

            this._objectId = objectId;
            this._objectType = objectType;
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function get objectType(): String
        {
            return this._objectType;
        }

    }
}
