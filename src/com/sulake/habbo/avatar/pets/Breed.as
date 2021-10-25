package com.sulake.habbo.avatar.pets
{

    public class Breed extends PetEditorInfo implements IBreed
    {

        private var _id: int;
        private var _localizationKey: String = "";
        private var _gender: String;
        private var _isColorable: Boolean;
        private var _isSellable: Boolean = true;
        private var _patternId: int;
        private var _avatarFigureString: String;

        public function Breed(param1: XML)
        {
            super(param1);
            this._id = parseInt(param1.@id);
            this._patternId = parseInt(param1.@pattern);
            this._gender = String(param1.@gender);
            this._isColorable = Boolean(parseInt(param1.@colorable));
            this._localizationKey = String(param1.@localizationKey);
            if (Boolean(param1.@sellable) && param1.@sellable == "0")
            {
                this._isSellable = false;
            }

        }

        public function get id(): int
        {
            return this._id;
        }

        public function get gender(): String
        {
            return this._gender;
        }

        public function get isColorable(): Boolean
        {
            return this._isColorable;
        }

        public function get isSellable(): Boolean
        {
            return this._isSellable;
        }

        public function get patternId(): int
        {
            return this._patternId;
        }

        public function get avatarFigureString(): String
        {
            return this._avatarFigureString;
        }

        public function set avatarFigureString(param1: String): void
        {
            this._avatarFigureString = param1;
        }

        public function get localizationKey(): String
        {
            return this._localizationKey;
        }

    }
}
