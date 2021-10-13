package com.sulake.habbo.avatar.pets
{
    import flash.geom.ColorTransform;

    public class PetColor extends PetEditorInfo implements IPetColor 
    {

        private var _id:int;
        private var _rgb:uint;
        private var var_2410:uint;
        private var var_2411:uint;
        private var _b:uint;
        private var var_2230:ColorTransform;
        private var var_2412:Number;
        private var var_2413:Number;
        private var var_2414:Number;
        private var var_2507:int;

        public function PetColor(param1:XML)
        {
            super(param1);
            this._id = parseInt(param1.@id);
            var _loc2_:String = param1.text();
            this._rgb = parseInt(_loc2_, 16);
            this.var_2410 = ((this._rgb >> 16) & 0xFF);
            this.var_2411 = ((this._rgb >> 8) & 0xFF);
            this._b = ((this._rgb >> 0) & 0xFF);
            this.var_2412 = ((this.var_2410 / 0xFF) * 1);
            this.var_2413 = ((this.var_2411 / 0xFF) * 1);
            this.var_2414 = ((this._b / 0xFF) * 1);
            this.var_2230 = new ColorTransform(this.var_2412, this.var_2413, this.var_2414);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get rgb():uint
        {
            return (this._rgb);
        }

        public function get r():uint
        {
            return (this.var_2410);
        }

        public function get g():uint
        {
            return (this.var_2411);
        }

        public function get b():uint
        {
            return (this._b);
        }

        public function get colorTransform():ColorTransform
        {
            return (this.var_2230);
        }

        public function get figurePartPaletteColorId():int
        {
            return (this.var_2507);
        }

        public function set figurePartPaletteColorId(param1:int):void
        {
            this.var_2507 = param1;
        }

    }
}