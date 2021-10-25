package com.sulake.habbo.communication.messages.incoming.inventory.trading
{

    public class ItemDataStructure
    {

        private var _itemId: int;
        private var _itemType: String;
        private var _roomItemId: int;
        private var _itemTypeId: int;
        private var _category: int;
        private var _stuffData: String;
        private var _extra: int;
        private var _timeToExpiration: int;
        private var _creationDay: int;
        private var _creationMonth: int;
        private var _creationYear: int;
        private var _groupable: Boolean;
        private var _unknown1: int;

        public function ItemDataStructure(itemId: int, itemType: String, roomItemId: int, itemTypeId: int, category: int, stuffData: String, extra: int, timeToExpiration: int, creationDay: int, creationMonth: int, creationYear: int, groupable: Boolean)
        {
            this._itemId = itemId;
            this._itemType = itemType;
            this._roomItemId = roomItemId;
            this._itemTypeId = itemTypeId;
            this._category = category;
            this._stuffData = stuffData;
            this._extra = extra;
            this._timeToExpiration = timeToExpiration;
            this._creationDay = creationDay;
            this._creationMonth = creationMonth;
            this._creationYear = creationYear;
            this._groupable = groupable;
        }

        public function get itemID(): int
        {
            return this._itemId;
        }

        public function get itemType(): String
        {
            return this._itemType;
        }

        public function get roomItemID(): int
        {
            return this._roomItemId;
        }

        public function get itemTypeID(): int
        {
            return this._itemTypeId;
        }

        public function get category(): int
        {
            return this._category;
        }

        public function get stuffData(): String
        {
            return this._stuffData;
        }

        public function get extra(): int
        {
            return this._extra;
        }

        public function get timeToExpiration(): int
        {
            return this._timeToExpiration;
        }

        public function get creationDay(): int
        {
            return this._creationDay;
        }

        public function get creationMonth(): int
        {
            return this._creationMonth;
        }

        public function get creationYear(): int
        {
            return this._creationYear;
        }

        public function get groupable(): Boolean
        {
            return this._groupable;
        }

        public function get songID(): int
        {
            return this._extra;
        }

    }
}
