package com.sulake.habbo.room
{

    public class PetColorResult
    {

        private var _primaryColor: int = 0;
        private var _secondaryColor: int = 0;

        public function PetColorResult(primaryColor: int, secondaryColor: int)
        {
            this._primaryColor = primaryColor & 0xFFFFFF;
            this._secondaryColor = secondaryColor & 0xFFFFFF;
        }

        public function get primaryColor(): int
        {
            return this._primaryColor;
        }

        public function get secondaryColor(): int
        {
            return this._secondaryColor;
        }

    }
}
