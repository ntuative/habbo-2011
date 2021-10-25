package com.sulake.habbo.communication.messages.incoming.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageProductData
    {

        public static const WALL_ITEM: String = "i";
        public static const FLOOR_ITEM: String = "s";
        public static const EFFECT_ITEM: String = "e";

        private var _productType: String;
        private var _furniClassId: int;
        private var _extraParam: String;
        private var _productCount: int;
        private var _expiration: int;

        public function CatalogPageMessageProductData(data: IMessageDataWrapper)
        {
            this._productType = data.readString();
            this._furniClassId = data.readInteger();
            this._extraParam = data.readString();
            this._productCount = data.readInteger();
            this._expiration = data.readInteger();
        }

        public function get productType(): String
        {
            return this._productType;
        }

        public function get furniClassId(): int
        {
            return this._furniClassId;
        }

        public function get extraParam(): String
        {
            return this._extraParam;
        }

        public function get productCount(): int
        {
            return this._productCount;
        }

        public function get expiration(): int
        {
            return this._expiration;
        }

    }
}
