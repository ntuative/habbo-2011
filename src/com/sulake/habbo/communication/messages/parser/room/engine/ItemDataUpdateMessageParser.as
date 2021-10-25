package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemDataUpdateMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _id: int = 0;
        private var _itemData: String;

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

        public function get itemData(): String
        {
            return this._itemData;
        }

        public function flush(): Boolean
        {
            this._id = 0;
            this._itemData = "";
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

            var id: String = data.readString();
            this._id = int(id);
            this._itemData = data.readString();
            
            return true;
        }

    }
}
