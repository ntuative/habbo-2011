package com.sulake.habbo.communication.messages.parser.room.action
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CarryObjectMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _userId: int = 0;
        private var _itemType: int;
        private var _itemName: String;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get itemType(): int
        {
            return this._itemType;
        }

        public function get itemName(): String
        {
            return this._itemName;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;
            this._itemType = 0;
            this._itemName = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._userId = data.readInteger();
            this._itemType = data.readInteger();
            
            if (this._itemType > 0)
            {
                this._itemName = data.readString();
            }

            return true;
        }

    }
}
