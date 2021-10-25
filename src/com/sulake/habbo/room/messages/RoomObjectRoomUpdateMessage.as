package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomUpdateMessage extends RoomObjectUpdateMessage
    {

        public static const RORUM_ROOM_WALL_UPDATE: String = "RORUM_ROOM_WALL_UPDATE";
        public static const RORUM_ROOM_FLOOR_UPDATE: String = "RORUM_ROOM_FLOOR_UPDATE";
        public static const RORUM_ROOM_LANDSCAPE_UPDATE: String = "RORUM_ROOM_LANDSCAPE_UPDATE";

        private var _type: String = "";
        private var _value: String = "";

        public function RoomObjectRoomUpdateMessage(type: String, value: String)
        {
            super(null, null);
            this._type = type;
            this._value = value;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get value(): String
        {
            return this._value;
        }

    }
}
