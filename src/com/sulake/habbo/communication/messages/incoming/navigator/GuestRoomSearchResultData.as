package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomSearchResultData implements IDisposable, MsgWithRequestId
    {

        private var _searchType: int;
        private var _searchParam: String;
        private var _rooms: Array = [];
        private var _ad: OfficialRoomEntryData;
        private var _disposed: Boolean;

        public function GuestRoomSearchResultData(data: IMessageDataWrapper): void
        {
            this._searchType = data.readInteger();
            this._searchParam = data.readString();

            var roomCount: int = data.readInteger();
            var i: int;

            while (i < roomCount)
            {
                this._rooms.push(new GuestRoomData(data));
                i++;
            }


            var hasRoomAd: Boolean = data.readBoolean();

            if (hasRoomAd)
            {
                this._ad = new OfficialRoomEntryData(data);
            }

        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }


            this._disposed = true;

            var room: GuestRoomData;
            if (this._rooms != null)
            {
                for each (room in this._rooms)
                {
                    room.dispose();
                }

            }


            if (this._ad != null)
            {
                this._ad.dispose();
                this._ad = null;
            }


            this._rooms = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get searchType(): int
        {
            return this._searchType;
        }

        public function get searchParam(): String
        {
            return this._searchParam;
        }

        public function get rooms(): Array
        {
            return this._rooms;
        }

        public function get ad(): OfficialRoomEntryData
        {
            return this._ad;
        }

    }
}
