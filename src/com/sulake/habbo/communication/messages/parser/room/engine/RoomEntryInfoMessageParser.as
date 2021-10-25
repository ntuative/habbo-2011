package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEntryInfoMessageParser implements IMessageParser
    {

        private var _guestRoom: Boolean;
        private var _guestRoomId: int;
        private var _owner: Boolean;
        private var _publicSpace: PublicRoomShortData;

        public function get guestRoom(): Boolean
        {
            return this._guestRoom;
        }

        public function get guestRoomId(): int
        {
            return this._guestRoomId;
        }

        public function get publicSpace(): PublicRoomShortData
        {
            return this._publicSpace;
        }

        public function get owner(): Boolean
        {
            return this._owner;
        }

        public function flush(): Boolean
        {
            if (this._publicSpace != null)
            {
                this._publicSpace.dispose();
                this._publicSpace = null;
            }

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._guestRoom = data.readBoolean();
            
            if (this._guestRoom)
            {
                this._guestRoomId = data.readInteger();
                this._owner = data.readBoolean();
            }
            else
            {
                this._publicSpace = new PublicRoomShortData(data);
            }

            return true;
        }

    }
}
