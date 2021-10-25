package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomData implements IDisposable
    {

        private var _flatId: int;
        private var _event: Boolean;
        private var _roomName: String;
        private var _ownerName: String;
        private var _doorMode: int;
        private var _userCount: int;
        private var _maxUserCount: int;
        private var _description: String;
        private var _srchSpecPrm: int;
        private var _allowTrading: Boolean;
        private var _score: int;
        private var _categoryId: int;
        private var _eventCreationTime: String;
        private var _tags: Array = [];
        private var _thumbnail: RoomThumbnailData;
        private var _allowPets: Boolean;
        private var _disposed: Boolean;

        public function GuestRoomData(data: IMessageDataWrapper)
        {
            super();
            this._flatId = data.readInteger();
            this._event = data.readBoolean();
            this._roomName = data.readString();
            this._ownerName = data.readString();
            this._doorMode = data.readInteger();
            this._userCount = data.readInteger();
            this._maxUserCount = data.readInteger();
            this._description = data.readString();
            this._srchSpecPrm = data.readInteger();
            this._allowTrading = data.readBoolean();
            this._score = data.readInteger();
            this._categoryId = data.readInteger();
            this._eventCreationTime = data.readString();

            var tag: String;
            var tagCount: int = data.readInteger();
            var i: int;

            while (i < tagCount)
            {
                tag = data.readString();
                this._tags.push(tag);
                i++;
            }


            this._thumbnail = new RoomThumbnailData(data);
            this._allowPets = data.readBoolean();
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }


            this._disposed = true;
            this._tags = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get event(): Boolean
        {
            return this._event;
        }

        public function get roomName(): String
        {
            return this._roomName;
        }

        public function get ownerName(): String
        {
            return this._ownerName;
        }

        public function get doorMode(): int
        {
            return this._doorMode;
        }

        public function get userCount(): int
        {
            return this._userCount;
        }

        public function get maxUserCount(): int
        {
            return this._maxUserCount;
        }

        public function get description(): String
        {
            return this._description;
        }

        public function get srchSpecPrm(): int
        {
            return this._srchSpecPrm;
        }

        public function get allowTrading(): Boolean
        {
            return this._allowTrading;
        }

        public function get score(): int
        {
            return this._score;
        }

        public function get categoryId(): int
        {
            return this._categoryId;
        }

        public function get eventCreationTime(): String
        {
            return this._eventCreationTime;
        }

        public function get tags(): Array
        {
            return this._tags;
        }

        public function get thumbnail(): RoomThumbnailData
        {
            return this._thumbnail;
        }

        public function get allowPets(): Boolean
        {
            return this._allowPets;
        }

    }
}
