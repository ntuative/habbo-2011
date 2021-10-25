package com.sulake.habbo.catalog.recycler
{

    public class FurniSlotItem
    {

        private var _id: int = 0;
        private var _category: int = 0;
        private var _typeId: int = 0;
        private var _extra: String = null;

        public function FurniSlotItem(id: int, category: int, typeId: int = 0, extra: String = null)
        {
            this._id = id;
            this._category = category;
            this._typeId = typeId;
            this._extra = extra;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get category(): int
        {
            return this._category;
        }

        public function get typeId(): int
        {
            return this._typeId;
        }

        public function get xxxExtra(): String
        {
            return this._extra;
        }

        public function set id(param1: int): void
        {
            this._id = param1;
        }

    }
}
