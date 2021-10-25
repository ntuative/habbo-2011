package com.sulake.habbo.communication.messages.parser.room.session
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomReadyMessageParser implements IMessageParser
    {

        private var _roomType: String = "";
        private var _roomId: int = 0;
        private var _roomCategory: int = 0;

        public function get roomType(): String
        {
            return this._roomType;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function flush(): Boolean
        {
            this._roomType = "";
            this._roomId = 0;
            this._roomCategory = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._roomType = data.readString();
            this._roomId = data.readInteger();
            
            return true;
        }

    }
}
