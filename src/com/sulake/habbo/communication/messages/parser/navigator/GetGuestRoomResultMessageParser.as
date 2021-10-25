package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GetGuestRoomResultMessageParser implements IMessageParser
    {

        private var _enterRoom: Boolean;
        private var _roomForward: Boolean;
        private var _staffPick: Boolean;
        private var _data: GuestRoomData;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._enterRoom = data.readBoolean();
            this._data = new GuestRoomData(data);
            this._roomForward = data.readBoolean();
            this._staffPick = data.readBoolean();

            return true;
        }

        public function get enterRoom(): Boolean
        {
            return this._enterRoom;
        }

        public function get data(): GuestRoomData
        {
            return this._data;
        }

        public function get roomForward(): Boolean
        {
            return this._roomForward;
        }

        public function get staffPick(): Boolean
        {
            return this._staffPick;
        }

    }
}
