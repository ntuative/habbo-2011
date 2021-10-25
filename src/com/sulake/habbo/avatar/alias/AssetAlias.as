package com.sulake.habbo.avatar.alias
{

    public class AssetAlias
    {

        private var _name: String;
        private var _link: String;
        private var _flipH: Boolean;
        private var _flipV: Boolean;

        public function AssetAlias(param1: XML)
        {
            this._name = String(param1.@name);
            this._link = String(param1.@link);
            this._flipH = Boolean(parseInt(param1.@fliph));
            this._flipV = Boolean(parseInt(param1.@flipv));
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get link(): String
        {
            return this._link;
        }

        public function get flipH(): Boolean
        {
            return this._flipH;
        }

        public function get flipV(): Boolean
        {
            return this._flipV;
        }

    }
}
