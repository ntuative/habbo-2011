package com.sulake.habbo.avatar.pets
{

    import flash.geom.ColorTransform;

    public class PetColor extends PetEditorInfo implements IPetColor
    {

        private var _id: int;
        private var _rgb: uint;
        private var _r: uint;
        private var _g: uint;
        private var _b: uint;
        private var _colorTransform: ColorTransform;
        private var var_2412: Number;
        private var var_2413: Number;
        private var var_2414: Number;
        private var _figurePartPaletteColorId: int;

        public function PetColor(param1: XML)
        {
            super(param1);
            this._id = parseInt(param1.@id);
            var _loc2_: String = param1.text();
            this._rgb = parseInt(_loc2_, 16);
            this._r = this._rgb >> 16 & 0xFF;
            this._g = this._rgb >> 8 & 0xFF;
            this._b = this._rgb >> 0 & 0xFF;
            this.var_2412 = this._r / 0xFF;
            this.var_2413 = this._g / 0xFF;
            this.var_2414 = this._b / 0xFF;
            this._colorTransform = new ColorTransform(this.var_2412, this.var_2413, this.var_2414);
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get rgb(): uint
        {
            return this._rgb;
        }

        public function get r(): uint
        {
            return this._r;
        }

        public function get g(): uint
        {
            return this._g;
        }

        public function get b(): uint
        {
            return this._b;
        }

        public function get colorTransform(): ColorTransform
        {
            return this._colorTransform;
        }

        public function get figurePartPaletteColorId(): int
        {
            return this._figurePartPaletteColorId;
        }

        public function set figurePartPaletteColorId(param1: int): void
        {
            this._figurePartPaletteColorId = param1;
        }

    }
}
