﻿package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomPlaneVisibilityUpdateMessage extends RoomObjectUpdateMessage
    {

        public static const RORPVUM_WALL_VISIBILITY: String = "RORPVUM_WALL_VISIBILITY";
        public static const RORPVUM_FLOOR_VISIBILITY: String = "RORPVUM_FLOOR_VISIBILITY";

        private var _type: String = "";
        private var _visible: Boolean = false;

        public function RoomObjectRoomPlaneVisibilityUpdateMessage(type: String, visible: Boolean)
        {
            super(null, null);
            this._type = type;
            this._visible = visible;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get visible(): Boolean
        {
            return this._visible;
        }

    }
}
