package com.sulake.habbo.avatar.structure.figure
{
    import flash.geom.ColorTransform;

    public class PartColor implements IPartColor 
    {

        private var _id:int;
        private var _index:int;
        private var var_2521:int;
        private var var_2513:Boolean = false;
        private var _rgb:uint;
        private var var_2410:uint;
        private var var_2411:uint;
        private var _b:uint;
        private var var_2412:Number;
        private var var_2413:Number;
        private var var_2414:Number;
        private var var_2230:ColorTransform;

        public function PartColor(param1:XML)
        {
            this._id = parseInt(param1.@id);
            this._index = parseInt(param1.@index);
            this.var_2521 = parseInt(param1.@club);
            this.var_2513 = Boolean(parseInt(param1.@selectable));
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

        public function get colorTransform():ColorTransform
        {
            return (this.var_2230);
        }

        public function get redMultiplier():Number
        {
            return (this.var_2412);
        }

        public function get greenMultiplier():Number
        {
            return (this.var_2413);
        }

        public function get blueMultiplier():Number
        {
            return (this.var_2414);
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

        public function get id():int
        {
            return (this._id);
        }

        public function get index():int
        {
            return (this._index);
        }

        public function get clubLevel():int
        {
            return (this.var_2521);
        }

        public function get isSelectable():Boolean
        {
            return (this.var_2513);
        }

    }
}