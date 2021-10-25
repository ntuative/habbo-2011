package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisitsData
    {

        private var _userId: int;
        private var _userName: String;
        private var _rooms: Array = [];

        public function RoomVisitsData(data: IMessageDataWrapper)
        {
            this._userId = data.readInteger();
            this._userName = data.readString();

            var roomCount: int = data.readInteger();
            var i: int;

            while (i < roomCount)
            {
                this._rooms.push(new RoomVisitData(data));
                i++;
            }

        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get userName(): String
        {
            return this._userName;
        }

        public function get rooms(): Array
        {
            return this._rooms;
        }

    }
}
