﻿package com.sulake.habbo.avatar.animation
{
    import flash.geom.ColorTransform;
    import com.sulake.core.utils.Map;

    public class AvatarDataContainer implements IAvatarDataContainer 
    {

        private var var_2394:int;
        private var var_2416:uint;
        private var var_2415:uint;
        private var var_2230:ColorTransform;
        private var _rgb:uint;
        private var var_2410:uint;
        private var var_2411:uint;
        private var _b:uint;
        private var var_2412:Number = 1;
        private var var_2413:Number = 1;
        private var var_2414:Number = 1;
        private var _alphaMultiplier:Number = 1;
        private var var_2417:Map;
        private var var_2418:Boolean = true;

        public function AvatarDataContainer(param1:XML)
        {
            this.var_2394 = parseInt(param1.@ink);
            var _loc2_:String = String(param1.@foreground);
            _loc2_ = _loc2_.replace("#", "");
            var _loc3_:String = String(param1.@background);
            _loc3_ = _loc3_.replace("#", "");
            this.var_2416 = parseInt(_loc2_, 16);
            this.var_2415 = parseInt(_loc3_, 16);
            this._rgb = parseInt(_loc2_, 16);
            this.var_2410 = ((this._rgb >> 16) & 0xFF);
            this.var_2411 = ((this._rgb >> 8) & 0xFF);
            this._b = ((this._rgb >> 0) & 0xFF);
            this.var_2412 = ((this.var_2410 / 0xFF) * 1);
            this.var_2413 = ((this.var_2411 / 0xFF) * 1);
            this.var_2414 = ((this._b / 0xFF) * 1);
            if (this.var_2394 == 37)
            {
                this._alphaMultiplier = 0.5;
                this.var_2418 = false;
            };
            this.var_2230 = new ColorTransform(this.var_2412, this.var_2413, this.var_2414, this._alphaMultiplier);
            this.var_2417 = this.generatePaletteMapForGrayscale(this.var_2415, this.var_2416);
        }

        public function get ink():int
        {
            return (this.var_2394);
        }

        public function get colorTransform():ColorTransform
        {
            return (this.var_2230);
        }

        public function get reds():Array
        {
            return (this.var_2417.getValue("reds") as Array);
        }

        public function get greens():Array
        {
            return (this.var_2417.getValue("greens") as Array);
        }

        public function get blues():Array
        {
            return (this.var_2417.getValue("blues") as Array);
        }

        public function get alphas():Array
        {
            return (this.var_2417.getValue("alphas") as Array);
        }

        public function get paletteIsGrayscale():Boolean
        {
            return (this.var_2418);
        }

        private function generatePaletteMapForGrayscale(param1:uint, param2:uint):Map
        {
            var _loc3_:* = ((param1 >> 24) & 0xFF);
            var _loc4_:* = ((param1 >> 16) & 0xFF);
            var _loc5_:* = ((param1 >> 8) & 0xFF);
            var _loc6_:* = ((param1 >> 0) & 0xFF);
            var _loc7_:* = ((param2 >> 24) & 0xFF);
            var _loc8_:* = ((param2 >> 16) & 0xFF);
            var _loc9_:* = ((param2 >> 8) & 0xFF);
            var _loc10_:* = ((param2 >> 0) & 0xFF);
            var _loc11_:Number = ((_loc7_ - _loc3_) / 0xFF);
            var _loc12_:Number = ((_loc8_ - _loc4_) / 0xFF);
            var _loc13_:Number = ((_loc9_ - _loc5_) / 0xFF);
            var _loc14_:Number = ((_loc10_ - _loc6_) / 0xFF);
            var _loc15_:Map = new Map();
            var _loc16_:Array = [];
            var _loc17_:Array = [];
            var _loc18_:Array = [];
            var _loc19_:Array = [];
            var _loc20_:Number = _loc3_;
            var _loc21_:Number = _loc4_;
            var _loc22_:Number = _loc5_;
            var _loc23_:Number = _loc6_;
            var _loc24_:int;
            while (_loc24_ < 0x0100)
            {
                if ((((_loc21_ == _loc4_) && (_loc22_ == _loc5_)) && (_loc23_ == _loc6_)))
                {
                    _loc20_ = 0;
                };
                _loc20_ = (_loc20_ + _loc11_);
                _loc21_ = (_loc21_ + _loc12_);
                _loc22_ = (_loc22_ + _loc13_);
                _loc23_ = (_loc23_ + _loc14_);
                _loc19_.push((_loc20_ << 24));
                _loc16_.push(((((_loc20_ << 24) | (_loc21_ << 16)) | (_loc22_ << 8)) | _loc23_));
                _loc17_.push(((((_loc20_ << 24) | (_loc21_ << 16)) | (_loc22_ << 8)) | _loc23_));
                _loc18_.push(((((_loc20_ << 24) | (_loc21_ << 16)) | (_loc22_ << 8)) | _loc23_));
                _loc24_++;
            };
            _loc15_.add("alphas", _loc16_);
            _loc15_.add("reds", _loc16_);
            _loc15_.add("greens", _loc17_);
            _loc15_.add("blues", _loc18_);
            return (_loc15_);
        }

    }
}