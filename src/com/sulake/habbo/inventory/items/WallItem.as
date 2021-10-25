package com.sulake.habbo.inventory.items
{

    public class WallItem implements IItem
    {

        protected var _id: int;
        protected var _type: int;
        protected var _ref: int;
        protected var _category: int;
        protected var _extra: Number;
        protected var _stuffData: String;
        protected var _recyclable: Boolean;
        protected var _tradeable: Boolean;
        protected var _groupable: Boolean;
        protected var _sellable: Boolean;
        protected var _locked: Boolean;

        public function WallItem(id: int, type: int, ref: int, category: int, groupable: Boolean, tradeable: Boolean, recyclable: Boolean, sellable: Boolean, stuffData: String, extra: Number)
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
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get ref(): int
        {
            return this._ref;
        }

        public function get category(): int
        {
            return this._category;
        }

        public function get extra(): Number
        {
            return this._extra;
        }

        public function get stuffData(): String
        {
            return this._stuffData;
        }

        public function set stuffData(value: String): void
        {
            this._stuffData = value;
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

        public function get locked(): Boolean
        {
            return this._locked;
        }

        public function set locked(value: Boolean): void
        {
            this._locked = value;
        }

    }
}
