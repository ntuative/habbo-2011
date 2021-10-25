package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ItemRemoveMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _itemId: int = 0;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get itemId(): int
        {
            return this._itemId;
        }

        public function flush(): Boolean
        {
            this._itemId = 0;
            this._roomId = 0;
            this._roomCategory = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            if (param1 == null)
            {
                return false;
            }

            this._itemId = int(param1.readString());
            return true;
        }

    }
}
