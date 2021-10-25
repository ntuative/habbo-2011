package com.sulake.habbo.room.events
{

    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectRoomActionEvent extends RoomObjectEvent
    {

        public static const RORAE_LEAVE_ROOM: String = "RORAE_LEAVE_ROOM";
        public static const RORAE_CHANGE_ROOM: String = "RORAE_CHANGE_ROOM";
        public static const RORAE_TRY_BUS: String = "RORAE_TRY_BUS";

        private var _param: int = 0;

        public function RoomObjectRoomActionEvent(type: String, param: int, roomId: int, roomCategory: String, bubbles: Boolean = false, cancelable: Boolean = false)
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
