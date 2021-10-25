package com.sulake.habbo.catalog.marketplace
{

    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.display.Shape;
    import flash.display.BitmapData;
    import flash.geom.Matrix;

    public class MarketplaceChart
    {

        private var _x: Array;
        private var var_2497: Array;
        private var var_2625: int;
        private var var_2626: int;
        private var var_2627: int = -30;
        private var var_2628: int;

        public function MarketplaceChart(param1: Array, param2: Array)
        {
            this._x = param1.slice();
            this.var_2497 = param2.slice();
        }

        public function draw(param1: int, param2: int): BitmapData
        {
            var _loc4_: int;
            var _loc5_: int;
            var _loc6_: TextField;
            var _loc7_: TextFormat;
            var _loc8_: int;
            var _loc9_: Shape;
            var _loc10_: int;
            var _loc3_: BitmapData = new BitmapData(param1, param2);
            if (!this.available)
            {
                return _loc3_;
            }

            this.var_2628 = 0;
            for each (_loc4_ in this.var_2497)
            {
                if (_loc4_ > this.var_2628)
                {
                    this.var_2628 = _loc4_;
                }

            }

            _loc5_ = Math.pow(10, int(this.var_2628).toString().length - 1);
            this.var_2628 = Math.ceil(this.var_2628 / _loc5_) * _loc5_;
            _loc6_ = new TextField();
            _loc7_ = new TextFormat();
            _loc6_.embedFonts = true;
            _loc7_.font = "Volter";
            _loc7_.size = 9;
            _loc6_.defaultTextFormat = _loc7_;
            _loc6_.text = this.var_2628.toString();
            _loc3_.draw(_loc6_);
            this.var_2625 = param1 - _loc6_.textWidth - 2;
            this.var_2626 = param2 - _loc6_.textHeight;
            _loc8_ = _loc6_.textWidth;
            _loc6_.text = "0";
            _loc3_.draw(_loc6_, new Matrix(1, 0, 0, 1, (_loc8_ - _loc6_.textWidth) + 1, param2 - _loc6_.textHeight - 1));
            _loc9_ = new Shape();
            _loc9_.graphics.lineStyle(1, 0xCCCCCC);
            _loc9_.graphics.moveTo(0, 0);
            _loc9_.graphics.lineTo(0, this.var_2626);
            _loc10_ = 0;
            while (_loc10_ <= 5)
            {
                _loc4_ = int(((this.var_2626 - 1) / 5) * _loc10_);
                _loc9_.graphics.moveTo(0, _loc4_);
                _loc9_.graphics.lineTo(this.var_2625 - 1, _loc4_);
                _loc10_++;
            }

            _loc9_.graphics.lineStyle(2, 0xFF);
            _loc9_.graphics.moveTo(this.getX(0), this.getY(0));
            _loc10_ = 1;
            while (_loc10_ < this._x.length)
            {
                _loc9_.graphics.lineTo(this.getX(_loc10_), this.getY(_loc10_));
                _loc10_++;
            }

            _loc3_.draw(_loc9_, new Matrix(1, 0, 0, 1, param1 - this.var_2625, (param2 - this.var_2626) / 2));
            return _loc3_;
        }

        private function getX(param1: int): Number
        {
            return this.var_2625 + (this.var_2625 / -this.var_2627) * this._x[param1];
        }

        private function getY(param1: int): Number
        {
            return this.var_2626 - (this.var_2626 / this.var_2628) * this.var_2497[param1];
        }

        public function get available(): Boolean
        {
            return this._x && this.var_2497 && this._x.length > 1;
        }

    }
}
