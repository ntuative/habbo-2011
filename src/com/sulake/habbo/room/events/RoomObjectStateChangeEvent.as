package com.sulake.habbo.room.events
{

    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectStateChangeEvent extends RoomObjectEvent
    {

        public static const ROSCE_STATE_CHANGE: String = "ROSCE_STATE_CHANGE";
        public static const ROSCE_STATE_RANDOM: String = "ROSCE_STATE_RANDOM";

        private var _param: int = 0;

        public function RoomObjectStateChangeEvent(type: String, roomId: int, roomCategory: String, param4: int = 0, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, roomId, roomCategory, bubbles, cancelable);
            
            this._param = param;
        }

        public function get param(): int
        {
            return this._param;
        }

    }
}
