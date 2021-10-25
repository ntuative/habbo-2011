package com.sulake.room.renderer.utils
{

    public class ObjectMouseData
    {

        private var _objectId: String = "";
        private var _spriteTag: String = "";

        public function get objectId(): String
        {
            return this._objectId;
        }

        public function set objectId(value: String): void
        {
            this._objectId = value;
        }

        public function get spriteTag(): String
        {
            return this._spriteTag;
        }

        public function set spriteTag(value: String): void
        {
            this._spriteTag = value;
        }

    }
}
