package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniStatusMessageParser implements IMessageParser
    {

        private var _campaignId: String;
        private var _objectId: int;
        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _itemCategory: int = 0;
        private var _status: int;
        private var _shareId: String;
        private var _firstClickUserName: String;

        public function get campaignID(): String
        {
            return this._campaignId;
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get itemCategory(): int
        {
            return this._itemCategory;
        }

        public function get shareId(): String
        {
            return this._shareId;
        }

        public function get status(): int
        {
            return this._status;
        }

        public function get firstClickUserName(): String
        {
            return this._firstClickUserName;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._campaignId = data.readString();
            this._objectId = data.readInteger();
            this._status = data.readInteger();
            this._shareId = data.readString();
            this._firstClickUserName = data.readString();
            this._itemCategory = data.readInteger();
            
            return true;
        }

    }
}
