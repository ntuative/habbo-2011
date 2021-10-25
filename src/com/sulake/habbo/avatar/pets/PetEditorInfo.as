package com.sulake.habbo.avatar.pets
{

    public class PetEditorInfo
    {

        private var _isClub: Boolean;
        private var _isSelectable: Boolean;

        public function PetEditorInfo(param1: XML)
        {
            this._isClub = Boolean(parseInt(param1.@club));
            this._isSelectable = Boolean(parseInt(param1.@selectable));
        }

        public function get isClub(): Boolean
        {
            return this._isClub;
        }

        public function get isSelectable(): Boolean
        {
            return this._isSelectable;
        }

    }
}
