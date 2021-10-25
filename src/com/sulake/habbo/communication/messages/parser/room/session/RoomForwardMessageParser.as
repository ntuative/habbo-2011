package com.sulake.habbo.communication.messages.parser.room.session
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomForwardMessageParser implements IMessageParser
    {

        private var _publicRoom: Boolean;
        private var _roomId: int;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get publicRoom(): Boolean
        {
            return this._publicRoom;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._publicRoom = data.readBoolean();
            this._roomId = data.readInteger();
            
            return true;
        }

    }
}
