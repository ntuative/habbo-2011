package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectVisibilityUpdateMessage extends RoomObjectUpdateMessage
    {

        public static const var_1185: String = "ROVUM_ENABLED";
        public static const var_1186: String = "ROVUM_DISABLED";

        private var _type: String;

        public function RoomObjectVisibilityUpdateMessage(param1: String)
        {
            super(null, null);
            this._type = param1;
        }

        public function get type(): String
        {
            return this._type;
        }

    }
}
