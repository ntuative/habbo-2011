package com.sulake.room.renderer.utils
{

    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class ExtendedSprite extends Bitmap
    {

        private var _alphaTolerance: int = 128;
        private var _alphaActive: Boolean = false;
        private var _loc: Point;
        private var _tag: String = "";
        private var _identifier: String = "";
        private var _clickHandling: Boolean = false;
        private var _varyingDepth: Boolean = false;
        private var _bitmapData: ExtendedBitmapData = null;
        private var _width: int = 0;
        private var _height: int = 0;
        private var _x: int = -1;
        private var _y: int = -1;

        public function ExtendedSprite(): void
        {
            this._loc = new Point();
            cacheAsBitmap = false;
            this.enableAlpha();
        }

        public function get alphaActive(): Boolean
        {
            return this._alphaActive;
        }

        public function get alphaTolerance(): int
        {
            return this._alphaTolerance;
        }

        public function set alphaTolerance(param1: int): void
        {
            this._alphaTolerance = param1;
        }

        public function get tag(): String
        {
            return this._tag;
        }

        public function set tag(param1: String): void
        {
            this._tag = param1;
        }

        public function get identifier(): String
        {
            return this._identifier;
        }

        public function set identifier(param1: String): void
        {
            this._identifier = param1;
        }

        public function get varyingDepth(): Boolean
        {
            return this._varyingDepth;
        }

        public function set varyingDepth(param1: Boolean): void
        {
            this._varyingDepth = param1;
        }

        public function get clickHandling(): Boolean
        {
            return this._clickHandling;
        }

        public function set clickHandling(param1: Boolean): void
        {
            this._clickHandling = param1;
        }

        public function dispose(): void
        {
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            }

        }

        override public function set bitmapData(param1: BitmapData): void
        {
            var _loc2_: ExtendedBitmapData;
            if (param1 == bitmapData)
            {
                return;
            }

            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            }

            if (param1 != null)
            {
                this._width = param1.width;
                this._height = param1.height;
                _loc2_ = (param1 as ExtendedBitmapData);
                if (_loc2_ != null)
                {
                    _loc2_.addReference();
                    this._bitmapData = _loc2_;
                }

            }
            else
            {
                this._width = 0;
                this._height = 0;
                this._x = -1;
                this._y = -1;
            }

            super.bitmapData = param1;
        }

        public function needsUpdate(param1: int, param2: int): Boolean
        {
            if (param1 != this._x || param2 != this._y)
            {
                this._x = param1;
                this._y = param2;
                return true;
            }

            return this._bitmapData != null && this._bitmapData.disposed;


        }

        public function disableAlpha(): void
        {
            this._alphaActive = false;
        }

        public function enableAlpha(): void
        {
            this.disableAlpha();
            this._alphaActive = true;
        }

        override public function hitTestPoint(param1: Number, param2: Number, param3: Boolean = false): Boolean
        {
            return this.hitTest(param1, param2);
        }

        public function hitTest(param1: int, param2: int): Boolean
        {
            if (this._alphaTolerance > 0xFF || bitmapData == null)
            {
                return false;
            }

            if (param1 < 0 || param2 < 0 || param1 >= this._width || param2 >= this._height)
            {
                return false;
            }

            return this.hitTestBitmapData(param1, param2);
        }

        private function hitTestBitmapData(x: int, y: int): Boolean
        {
            var pixel: uint;
            var retVal: Boolean;
            try
            {
                if (!this._alphaActive || !bitmapData.transparent)
                {
                    retVal = true;
                }
                else
                {
                    pixel = bitmapData.getPixel32(x, y);
                    pixel = pixel >> 24;
                    retVal = pixel > this._alphaTolerance;
                }

            }
            catch (e: Error)
            {
            }

            return retVal;
        }

    }
}
