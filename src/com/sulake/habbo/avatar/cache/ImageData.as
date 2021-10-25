package com.sulake.habbo.avatar.cache
{

    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class ImageData
    {

        private var _bitmap: BitmapData;
        private var _regpoint: Point;

        public function ImageData(param1: BitmapData, param2: Point, param3: Boolean)
        {
            var _loc4_: Matrix;
            var _loc5_: BitmapData;
            super();
            this._regpoint = param2;
            if (param3)
            {
                _loc4_ = new Matrix(-1, 0, 0, 1, param1.width, 0);
                _loc5_ = new BitmapData(param1.width, param1.height, true, 0xFFFFFF);
                _loc5_.draw(param1, _loc4_);
                this._regpoint.x = -1 * this._regpoint.x + param1.width;
                this._bitmap = _loc5_;
                param1.dispose();
            }
            else
            {
                this._bitmap = param1;
            }

        }

        public function dispose(): void
        {
            if (this._bitmap)
            {
                this._bitmap.dispose();
            }

            this._bitmap = null;
            this._regpoint = null;
        }

        public function get bitmap(): BitmapData
        {
            return this._bitmap;
        }

        public function set bitmap(param1: BitmapData): void
        {
            this._bitmap = param1;
        }

        public function get regpoint(): Point
        {
            return this._regpoint;
        }

        public function get offsetRect(): Rectangle
        {
            var _loc1_: Rectangle = this._bitmap.rect.clone();
            _loc1_.offset(-this._regpoint.x, -this._regpoint.y);
            return _loc1_;
        }

    }
}
