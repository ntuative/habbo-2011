package com.sulake.room.object.visualization
{

    import flash.display.BitmapData;
    import flash.geom.Point;

    public final class RoomObjectSprite implements IRoomObjectSprite
    {

        private static var var_1454: int = 0;

        private var _asset: BitmapData = null;
        private var _assetName: String = "";
        private var _visible: Boolean = true;
        private var _tag: String = "";
        private var _alpha: int = 0xFF;
        private var _color: int = 0xFFFFFF;
        private var _blendMode: String = "normal";
        private var _flipH: Boolean = false;
        private var _flipV: Boolean = false;
        private var _offset: Point = new Point(0, 0);
        private var _width: int = 0;
        private var _height: int = 0;
        private var _relativeDepth: Number = 0;
        private var _varyingDepth: Boolean = false;
        private var _capturesMouse: Boolean = true;
        private var _clickHandling: Boolean = false;
        private var _updateID: int = 0;
        private var _instanceId: int = 0;
        private var _filters: Array = null;

        public function RoomObjectSprite()
        {
            this._instanceId = var_1454++;
        }

        public function dispose(): void
        {
            this._asset = null;
            this._width = 0;
            this._height = 0;
        }

        public function get asset(): BitmapData
        {
            return this._asset;
        }

        public function get assetName(): String
        {
            return this._assetName;
        }

        public function get visible(): Boolean
        {
            return this._visible;
        }

        public function get tag(): String
        {
            return this._tag;
        }

        public function get alpha(): int
        {
            return this._alpha;
        }

        public function get color(): int
        {
            return this._color;
        }

        public function get blendMode(): String
        {
            return this._blendMode;
        }

        public function get flipV(): Boolean
        {
            return this._flipV;
        }

        public function get flipH(): Boolean
        {
            return this._flipH;
        }

        public function get offsetX(): int
        {
            return this._offset.x;
        }

        public function get offsetY(): int
        {
            return this._offset.y;
        }

        public function get width(): int
        {
            return this._width;
        }

        public function get height(): int
        {
            return this._height;
        }

        public function get relativeDepth(): Number
        {
            return this._relativeDepth;
        }

        public function get varyingDepth(): Boolean
        {
            return this._varyingDepth;
        }

        public function get capturesMouse(): Boolean
        {
            return this._capturesMouse;
        }

        public function get clickHandling(): Boolean
        {
            return this._clickHandling;
        }

        public function get instanceId(): int
        {
            return this._instanceId;
        }

        public function get updateId(): int
        {
            return this._updateID;
        }

        public function get filters(): Array
        {
            return this._filters;
        }

        public function set asset(param1: BitmapData): void
        {
            if (param1 != null)
            {
                this._width = param1.width;
                this._height = param1.height;
            }

            this._asset = param1;
            this._updateID++;
        }

        public function set assetName(param1: String): void
        {
            this._assetName = param1;
            this._updateID++;
        }

        public function set visible(param1: Boolean): void
        {
            this._visible = param1;
            this._updateID++;
        }

        public function set tag(param1: String): void
        {
            this._tag = param1;
            this._updateID++;
        }

        public function set alpha(param1: int): void
        {
            param1 = param1 & 0xFF;
            this._alpha = param1;
            this._updateID++;
        }

        public function set color(param1: int): void
        {
            param1 = param1 & 0xFFFFFF;
            this._color = param1;
            this._updateID++;
        }

        public function set blendMode(param1: String): void
        {
            this._blendMode = param1;
            this._updateID++;
        }

        public function set filters(param1: Array): void
        {
            this._filters = param1;
            this._updateID++;
        }

        public function set flipH(param1: Boolean): void
        {
            this._flipH = param1;
            this._updateID++;
        }

        public function set flipV(param1: Boolean): void
        {
            this._flipV = param1;
            this._updateID++;
        }

        public function set offsetX(param1: int): void
        {
            this._offset.x = param1;
            this._updateID++;
        }

        public function set offsetY(param1: int): void
        {
            this._offset.y = param1;
            this._updateID++;
        }

        public function set relativeDepth(param1: Number): void
        {
            this._relativeDepth = param1;
            this._updateID++;
        }

        public function set varyingDepth(param1: Boolean): void
        {
            this._varyingDepth = param1;
            this._updateID++;
        }

        public function set capturesMouse(param1: Boolean): void
        {
            this._capturesMouse = param1;
            this._updateID++;
        }

        public function set clickHandling(param1: Boolean): void
        {
            this._clickHandling = param1;
            this._updateID++;
        }

    }
}
