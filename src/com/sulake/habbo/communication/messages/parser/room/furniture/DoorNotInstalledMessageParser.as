package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DoorNotInstalledMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _objectId: int;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._objectId = -1;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            return data != null;


        }

    }
}
