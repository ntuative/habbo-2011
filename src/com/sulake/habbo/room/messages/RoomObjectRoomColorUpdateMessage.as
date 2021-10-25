package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectRoomColorUpdateMessage extends RoomObjectUpdateMessage
    {

        public static const RORCUM_BACKGROUND_COLOR: String = "RORCUM_BACKGROUND_COLOR";

        private var _type: String = "";
        private var _color: uint = 0;
        private var _light: int = 0;
        private var _bgOnly: Boolean = true;

        public function RoomObjectRoomColorUpdateMessage(type: String, color: uint, light: int, bgOnly: Boolean)
        {
            super(null, null);
            this._type = type;
            this._color = color;
            this._light = light;
            this._bgOnly = bgOnly;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function get light(): uint
        {
            return this._light;
        }

        public function get bgOnly(): Boolean
        {
            return this._bgOnly;
        }

    }
}
