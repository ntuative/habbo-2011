package com.sulake.habbo.avatar.structure.parts
{

    public class PartDefinition
    {

        private var _setType: String;
        private var _flippedSetType: String;
        private var _removeSetType: String;
        private var _appendToFigure: Boolean;
        private var _staticId: int = -1;

        public function PartDefinition(data: XML)
        {
            this._setType = String(data.@["set-type"]);
            this._flippedSetType = String(data.@["flipped-set-type"]);
            this._removeSetType = String(data.@["remove-set-type"]);
            this._appendToFigure = false;
        }

        public function hasStaticId(): Boolean
        {
            return this._staticId >= 0;
        }

        public function get staticId(): int
        {
            return this._staticId;
        }

        public function set staticId(id: int): void
        {
            this._staticId = id;
        }

        public function get setType(): String
        {
            return this._setType;
        }

        public function get flippedSetType(): String
        {
            return this._flippedSetType;
        }

        public function get removeSetType(): String
        {
            return this._removeSetType;
        }

        public function get appendToFigure(): Boolean
        {
            return this._appendToFigure;
        }

        public function set appendToFigure(value: Boolean): void
        {
            this._appendToFigure = value;
        }

        public function set flippedSetType(value: String): void
        {
            this._flippedSetType = value;
        }

    }
}
