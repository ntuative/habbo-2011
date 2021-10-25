package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomModerationData implements IDisposable
    {

        private var _flatId: int;
        private var _userCount: int;
        private var _ownerInRoom: Boolean;
        private var _ownerId: int;
        private var _ownerName: String;
        private var _room: RoomData;
        private var _event: RoomData;
        private var _disposed: Boolean;

        public function RoomModerationData(data: IMessageDataWrapper)
        {
            this._flatId = data.readInteger();
            this._userCount = data.readInteger();
            this._ownerInRoom = data.readBoolean();
            this._ownerId = data.readInteger();
            this._ownerName = data.readString();
            this._room = new RoomData(data);
            this._event = new RoomData(data);
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }


            this._disposed = true;

            if (this._room != null)
            {
                this._room.dispose();
                this._room = null;
            }


            if (this._event != null)
            {
                this._event.dispose();
                this._event = null;
            }

        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get userCount(): int
        {
            return this._userCount;
        }

        public function get ownerInRoom(): Boolean
        {
            return this._ownerInRoom;
        }

        public function get ownerId(): int
        {
            return this._ownerId;
        }

        public function get ownerName(): String
        {
            return this._ownerName;
        }

        public function get room(): RoomData
        {
            return this._room;
        }

        public function get event(): RoomData
        {
            return this._event;
        }

    }
}
