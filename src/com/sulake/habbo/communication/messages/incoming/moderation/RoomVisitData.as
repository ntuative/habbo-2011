package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisitData
    {

        private var _isPublic: Boolean;
        private var _roomId: int;
        private var _roomName: String;
        private var _enterHour: int;
        private var _enterMinute: int;

        public function RoomVisitData(data: IMessageDataWrapper)
        {
            this._isPublic = data.readBoolean();
            this._roomId = data.readInteger();
            this._roomName = data.readString();
            this._enterHour = data.readInteger();
            this._enterMinute = data.readInteger();
        }

        public function get isPublic(): Boolean
        {
            return this._isPublic;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomName(): String
        {
            return this._roomName;
        }

        public function get enterHour(): int
        {
            return this._enterHour;
        }

        public function get enterMinute(): int
        {
            return this._enterMinute;
        }

    }
}
