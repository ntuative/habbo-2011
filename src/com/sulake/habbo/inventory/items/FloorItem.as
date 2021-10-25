package com.sulake.habbo.inventory.items
{

    public class FloorItem implements IItem
    {

        protected var _id: int;
        protected var _ref: int;
        protected var _category: int;
        protected var _type: int;
        protected var _stuffData: String;
        protected var _extra: Number;
        protected var _recyclable: Boolean;
        protected var _tradeable: Boolean;
        protected var _groupable: Boolean;
        protected var _sellable: Boolean;
        protected var _expires: int;
        protected var _creationDay: int;
        protected var _creationMonth: int;
        protected var _creationYear: int;
        protected var _slotId: String;
        protected var _songId: int;
        protected var _locked: Boolean;

        public function FloorItem(id: int, type: int, ref: int, category: int, groupable: Boolean, tradeable: Boolean, recyclable: Boolean, sellable: Boolean, stuffData: String, extra: Number, expires: int, creationDay: int, creationMonth: int, creationYear: int, slotId: String, songId: int)
        {
            this._id = id;
            this._type = type;
            this._ref = ref;
            this._category = category;
            this._groupable = groupable;
            this._tradeable = tradeable;
            this._recyclable = recyclable;
            this._sellable = sellable;
            this._stuffData = stuffData;
            this._extra = extra;
            this._expires = expires;
            this._creationDay = creationDay;
            this._creationMonth = creationMonth;
            this._creationYear = creationYear;
            this._slotId = slotId;
            this._songId = songId;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get ref(): int
        {
            return this._ref;
        }

        public function get category(): int
        {
            return this._category;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get stuffData(): String
        {
            return this._stuffData;
        }

        public function get extra(): Number
        {
            return this._extra;
        }

        public function get recyclable(): Boolean
        {
            return this._recyclable;
        }

        public function get tradeable(): Boolean
        {
            return this._tradeable;
        }

        public function get groupable(): Boolean
        {
            return this._groupable;
        }

        public function get sellable(): Boolean
        {
            return this._sellable;
        }

        public function get expires(): int
        {
            return this._expires;
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

        public function get slotId(): String
        {
            return this._slotId;
        }

        public function get songId(): int
        {
            return this._songId;
        }

        public function set locked(value: Boolean): void
        {
            this._locked = value;
        }

        public function get locked(): Boolean
        {
            return this._locked;
        }

    }
}
