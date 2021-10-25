package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PresentOpenedMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _itemType: String;
        private var _classId: int;
        private var _productCode: String;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get itemType(): String
        {
            return this._itemType;
        }

        public function get classId(): int
        {
            return this._classId;
        }

        public function get productCode(): String
        {
            return this._productCode;
        }

        public function flush(): Boolean
        {
            this._itemType = "";
            this._classId = 0;
            this._productCode = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._itemType = data.readString();
            this._classId = data.readInteger();
            this._productCode = data.readString();
            
            return true;
        }

    }
}
