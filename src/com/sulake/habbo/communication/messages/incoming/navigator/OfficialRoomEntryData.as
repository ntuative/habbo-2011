package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomEntryData implements IDisposable
    {

        public static const UNKNOWN1: int = 1;
        public static const GUEST_ROOM: int = 2;
        public static const PUBLIC_ROOM: int = 3;
        public static const UNKNOWN2: int = 4;

        private var _index: int;
        private var _popupCaption: String;
        private var _popupDesc: String;
        private var _showDetails: Boolean;
        private var _picText: String;
        private var _picRef: String;
        private var _folderId: int;
        private var _userCount: int;
        private var _type: int;
        private var _tag: String;
        private var _guestRoomData: GuestRoomData;
        private var _publicRoomData: PublicRoomData;
        private var _open: Boolean;
        private var _disposed: Boolean;

        public function OfficialRoomEntryData(data: IMessageDataWrapper)
        {
            this._index = data.readInteger();
            this._popupCaption = data.readString();
            this._popupDesc = data.readString();
            this._showDetails = data.readInteger() == 1;
            this._picText = data.readString();
            this._picRef = data.readString();
            this._folderId = data.readInteger();
            this._userCount = data.readInteger();
            this._type = data.readInteger();

            if (this._type == UNKNOWN1)
            {
                this._tag = data.readString();
            }
            else if (this._type == PUBLIC_ROOM)
            {
                this._publicRoomData = new PublicRoomData(data);
            }
            else if (this._type == GUEST_ROOM)
            {
                this._guestRoomData = new GuestRoomData(data);
            }
            else
            {
                this._open = data.readBoolean();
            }


        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }


            this._disposed = true;

            if (this._guestRoomData != null)
            {
                this._guestRoomData.dispose();
                this._guestRoomData = null;
            }


            if (this._publicRoomData != null)
            {
                this._publicRoomData.dispose();
                this._publicRoomData = null;
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get index(): int
        {
            return this._index;
        }

        public function get popupCaption(): String
        {
            return this._popupCaption;
        }

        public function get popupDesc(): String
        {
            return this._popupDesc;
        }

        public function get showDetails(): Boolean
        {
            return this._showDetails;
        }

        public function get picText(): String
        {
            return this._picText;
        }

        public function get picRef(): String
        {
            return this._picRef;
        }

        public function get folderId(): int
        {
            return this._folderId;
        }

        public function get tag(): String
        {
            return this._tag;
        }

        public function get userCount(): int
        {
            return this._userCount;
        }

        public function get guestRoomData(): GuestRoomData
        {
            return this._guestRoomData;
        }

        public function get publicRoomData(): PublicRoomData
        {
            return this._publicRoomData;
        }

        public function get open(): Boolean
        {
            return this._open;
        }

        public function toggleOpen(): void
        {
            this._open = !this._open;
        }

        public function get maxUsers(): int
        {
            if (this.type == UNKNOWN1)
            {
                return 0;
            }


            if (this.type == GUEST_ROOM)
            {
                return this._guestRoomData.maxUserCount;
            }


            if (this.type == PUBLIC_ROOM)
            {
                return this._publicRoomData.maxUsers;
            }


            return 0;
        }

    }
}
