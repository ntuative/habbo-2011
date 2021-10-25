package com.sulake.habbo.communication.messages.incoming.inventory.furni
{

    public class FurniData
    {

        private var _stripId: int;
        private var _itemType: String;
        private var _objId: int;
        private var _classId: int;
        private var _category: int;
        private var _stuffData: String;
        private var _isGroupable: Boolean;
        private var _isRecyclable: Boolean;
        private var _isTradeable: Boolean;
        private var _isSellable: Boolean;
        private var _expiryTime: int;
        private var _extra: int;
        private var _slotId: String = "";
        private var _songId: int = -1;

        public function FurniData(stripId: int, itemType: String, objId: int, classId: int, category: int, stuffData: String, isGroupable: Boolean, isRecyclable: Boolean, isTradeable: Boolean, isSellable: Boolean, expiryTime: int)
        {
            this._stripId = stripId;
            this._itemType = itemType;
            this._objId = objId;
            this._classId = classId;
            this._category = category;
            this._stuffData = stuffData;
            this._isGroupable = isGroupable;
            this._isRecyclable = isRecyclable;
            this._isTradeable = isTradeable;
            this._isSellable = isSellable;
            this._expiryTime = expiryTime;
        }

        public function setExtraData(slotId: String, extra: int): void
        {
            this._slotId = slotId;
            this._extra = extra;
        }

        public function get stripId(): int
        {
            return this._stripId;
        }

        public function get itemType(): String
        {
            return this._itemType;
        }

        public function get objId(): int
        {
            return this._objId;
        }

        public function get classId(): int
        {
            return this._classId;
        }

        public function get category(): int
        {
            return this._category;
        }

        public function get stuffData(): String
        {
            return this._stuffData;
        }

        public function get isGroupable(): Boolean
        {
            return this._isGroupable;
        }

        public function get isRecyclable(): Boolean
        {
            return this._isRecyclable;
        }

        public function get isTradeable(): Boolean
        {
            return this._isTradeable;
        }

        public function get isSellable(): Boolean
        {
            return this._isSellable;
        }

        public function get expiryTime(): int
        {
            return this._expiryTime;
        }

        public function get slotId(): String
        {
            return this._slotId;
        }

        public function get songId(): int
        {
            return this._songId;
        }

        public function get extra(): int
        {
            return this._extra;
        }

    }
}
