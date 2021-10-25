package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ObjectRemoveMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _id: int;
        private var _isExpired: Boolean;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get isExpired(): Boolean
        {
            return this._isExpired;
        }

        public function flush(): Boolean
        {
            this._id = 0;
            this._roomId = 0;
            this._roomCategory = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._id = int(data.readString());
            this._isExpired = data.readInteger() == 1;
            
            return true;
        }

    }
}
