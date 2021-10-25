package com.sulake.habbo.room.events
{

    import flash.events.Event;

    public class RoomEngineEvent extends Event
    {

        public static const REE_ENGINE_INITIALIZED: String = "REE_ENGINE_INITIALIZED";
        public static const REE_INITIALIZED: String = "REE_INITIALIZED";
        public static const REE_DISPOSED: String = "REE_DISPOSED";
        public static const REE_GAME_MODE: String = "REE_GAME_MODE";
        public static const REE_NORMAL_MODE: String = "REE_NORMAL_MODE";

        private var _roomId: int;
        private var _roomCategory: int;

        public function RoomEngineEvent(type: String, roomId: int, roomCategory: int, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, bubbles, cancelable);
            
            this._roomId = roomId;
            this._roomCategory = roomCategory;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

    }
}
