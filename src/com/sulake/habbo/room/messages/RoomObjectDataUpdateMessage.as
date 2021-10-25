package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage
    {

        private var _state: int;
        private var _data: String;
        private var _extra: Number = NaN;

        public function RoomObjectDataUpdateMessage(state: int, data: String, extra: Number = NaN)
        {
            super(null, null);
            this._state = state;
            this._data = data;
            this._extra = extra;
        }

        public function get state(): int
        {
            return this._state;
        }

        public function get data(): String
        {
            return this._data;
        }

        public function get extra(): Number
        {
            return this._extra;
        }

    }
}
