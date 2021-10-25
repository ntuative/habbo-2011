﻿package com.sulake.habbo.room.object.visualization.furniture
{

    import com.sulake.room.utils.Vector3d;

    import flash.display.BitmapData;

    import com.sulake.core.utils.Map;

    import flash.geom.Point;

    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.IRoomGeometry;

    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class FurniturePlane
    {

        private var var_4015: int = -1;
        private var var_4116: Number = 0;
        private var var_4117: Number = 0;
        private var var_4118: Number = 0;
        private var var_4119: Number = 0;
        private var var_4120: Vector3d = null;
        private var _location: Vector3d = null;
        private var var_4112: Vector3d = null;
        private var var_4113: Vector3d = null;
        private var var_4114: Vector3d = null;
        private var var_4115: Vector3d = null;
        private var var_2490: Vector3d = null;
        private var _isVisible: Boolean = true;
        private var _bitmapData: BitmapData = null;
        private var var_4121: Map = null;
        private var _offset: Point = null;
        private var var_4122: Number = 0;
        private var _color: uint = 0;
        private var var_4123: Boolean = false;
        private var _id: String = null;
        private var var_4124: Vector3d = null;
        private var var_4125: Vector3d = null;
        private var var_4126: Vector3d = null;
        private var var_4127: Vector3d = null;
        private var var_2237: Number = 0;
        private var _height: Number = 0;

        public function FurniturePlane(param1: IVector3d, param2: IVector3d, param3: IVector3d)
        {
            this.var_4120 = new Vector3d();
            this._location = new Vector3d();
            this._location.assign(param1);
            this.var_4112 = new Vector3d();
            this.var_4112.assign(param2);
            this.var_4113 = new Vector3d();
            this.var_4113.assign(param3);
            this.var_4114 = new Vector3d();
            this.var_4114.assign(param2);
            this.var_4115 = new Vector3d();
            this.var_4115.assign(param3);
            this.var_2490 = Vector3d.crossProduct(this.var_4112, this.var_4113);
            if (this.var_2490.length > 0)
            {
                this.var_2490.mul(1 / this.var_2490.length);
            }

            this._offset = new Point();
            this.var_4124 = new Vector3d();
            this.var_4125 = new Vector3d();
            this.var_4126 = new Vector3d();
            this.var_4127 = new Vector3d();
            this.var_4121 = new Map();
        }

        public function get bitmapData(): BitmapData
        {
            if (this._isVisible)
            {
                if (this._bitmapData != null)
                {
                    return this._bitmapData.clone();
                }

            }

            return null;
        }

        public function get visible(): Boolean
        {
            return this._isVisible;
        }

        public function get offset(): Point
        {
            return this._offset;
        }

        public function get relativeDepth(): Number
        {
            return this.var_4122;
        }

        public function get color(): uint
        {
            return this._color;
        }

        public function set color(param1: uint): void
        {
            this._color = param1;
        }

        public function get leftSide(): IVector3d
        {
            return this.var_4112;
        }

        public function get rightSide(): IVector3d
        {
            return this.var_4113;
        }

        public function get location(): IVector3d
        {
            return this._location;
        }

        public function get normal(): IVector3d
        {
            return this.var_2490;
        }

        public function dispose(): void
        {
            var _loc1_: int;
            var _loc2_: BitmapData;
            if (this._bitmapData != null)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            }

            if (this.var_4121 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4121.length)
                {
                    _loc2_ = (this.var_4121.getWithIndex(_loc1_) as BitmapData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    }

                    _loc1_++;
                }

                this.var_4121.dispose();
                this.var_4121 = null;
            }

            this.var_4120 = null;
            this._location = null;
            this.var_4112 = null;
            this.var_4113 = null;
            this.var_4114 = null;
            this.var_4115 = null;
            this.var_2490 = null;
            this.var_4124 = null;
            this.var_4125 = null;
            this.var_4126 = null;
            this.var_4127 = null;
        }

        public function setRotation(param1: Boolean): void
        {
            if (param1 != this.var_4123)
            {
                if (!param1)
                {
                    this.var_4112.assign(this.var_4114);
                    this.var_4113.assign(this.var_4115);
                }
                else
                {
                    this.var_4112.assign(this.var_4114);
                    this.var_4112.mul(this.var_4115.length / this.var_4114.length);
                    this.var_4113.assign(this.var_4115);
                    this.var_4113.mul(this.var_4114.length / this.var_4115.length);
                }

                this.var_4015 = -1;
                this.var_4116 = this.var_4116 - 1;
                this.var_4123 = param1;
                this.resetTextureCache();
            }

        }

        private function cacheTexture(param1: String, param2: BitmapData): Boolean
        {
            var _loc3_: BitmapData = this.var_4121.remove(param1) as BitmapData;
            if (_loc3_ != null && param2 != _loc3_)
            {
                _loc3_.dispose();
            }

            this.var_4121.add(param1, param2);
            return true;
        }

        private function resetTextureCache(): void
        {
            var _loc1_: int;
            var _loc2_: BitmapData;
            if (this.var_4121 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4121.length)
                {
                    _loc2_ = (this.var_4121.getWithIndex(_loc1_) as BitmapData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    }

                    _loc1_++;
                }

                this.var_4121.reset();
            }

        }

        private function getTextureIdentifier(param1: IRoomGeometry): String
        {
            if (param1 == null)
            {
                return null;
            }

            return String(param1.scale);
        }

        private function needsNewTexture(param1: IRoomGeometry): Boolean
        {
            if (param1 == null)
            {
                return false;
            }

            var _loc2_: String = this.getTextureIdentifier(param1);
            var _loc3_: BitmapData = this.var_4121.getValue(_loc2_) as BitmapData;
            if (this.var_2237 > 0 && this._height > 0)
            {
                if (_loc3_ == null)
                {
                    return true;
                }

            }

            return false;
        }

        private function getTexture(param1: IRoomGeometry, param2: int): BitmapData
        {
            var _loc5_: Number;
            var _loc6_: Number;
            var _loc7_: IVector3d;
            if (param1 == null)
            {
                return null;
            }

            var _loc3_: String = this.getTextureIdentifier(param1);
            var _loc4_: BitmapData;
            if (this.needsNewTexture(param1))
            {
                _loc5_ = this.var_4112.length * param1.scale;
                _loc6_ = this.var_4113.length * param1.scale;
                if (_loc5_ < 1)
                {
                    _loc5_ = 1;
                }

                if (_loc6_ < 1)
                {
                    _loc6_ = 1;
                }

                _loc7_ = param1.getCoordinatePosition(this.var_2490);
                _loc4_ = (this.var_4121.getValue(_loc3_) as BitmapData);
                if (_loc4_ == null)
                {
                    _loc4_ = new BitmapData(_loc5_, _loc6_, true, 0xFF000000 | this._color);
                    if (_loc4_ != null)
                    {
                        this.cacheTexture(_loc3_, _loc4_);
                    }

                }

            }
            else
            {
                _loc4_ = (this.var_4121.getValue(_loc3_) as BitmapData);
            }

            if (_loc4_ != null)
            {
                return _loc4_;
            }

            return null;
        }

        public function update(param1: IRoomGeometry, param2: int): Boolean
        {
            var _loc4_: IVector3d;
            var _loc5_: Number;
            var _loc6_: IVector3d;
            var _loc7_: Number;
            var _loc8_: Number;
            var _loc9_: BitmapData;
            if (param1 == null || this._location == null && this.var_4120 != null || this.var_4112 == null || this.var_4113 == null || this.var_2490 == null)
            {
                return false;
            }

            var _loc3_: Boolean;
            if (param1.updateId != this.var_4015)
            {
                this.var_4015 = param1.updateId;
                _loc4_ = param1.direction;
                if (_loc4_ != null && (_loc4_.x != this.var_4116 || _loc4_.y != this.var_4117 || _loc4_.z != this.var_4118 || param1.scale != this.var_4119))
                {
                    this.var_4116 = _loc4_.x;
                    this.var_4117 = _loc4_.y;
                    this.var_4118 = _loc4_.z;
                    this.var_4119 = param1.scale;
                    _loc3_ = true;
                    _loc5_ = 0;
                    _loc5_ = Vector3d.cosAngle(param1.directionAxis, this.normal);
                    if (_loc5_ > -0.001)
                    {
                        if (this._isVisible)
                        {
                            this._isVisible = false;
                            return true;
                        }

                        return false;
                    }

                    this.updateCorners(param1);
                    _loc6_ = param1.getScreenPosition(this.var_4120);
                    _loc7_ = _loc6_.z;
                    _loc8_ = Math.max(this.var_4124.z - _loc7_, this.var_4125.z - _loc7_, this.var_4126.z - _loc7_, this.var_4127.z - _loc7_);
                    this.var_4122 = _loc8_;
                    this._isVisible = true;
                }

            }

            if (this.needsNewTexture(param1) || _loc3_)
            {
                if (this._bitmapData == null || this.var_2237 != this._bitmapData.width || this._height != this._bitmapData.height)
                {
                    if (this._bitmapData != null)
                    {
                        this._bitmapData.dispose();
                        this._bitmapData = null;
                        if (this.var_2237 < 1 || this._height < 1)
                        {
                            return true;
                        }

                    }
                    else
                    {
                        if (this.var_2237 < 1 || this._height < 1)
                        {
                            return false;
                        }

                    }

                    this._bitmapData = new BitmapData(this.var_2237, this._height, true, 0xFFFFFF);
                    this._bitmapData.lock();
                }
                else
                {
                    this._bitmapData.lock();
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                }

                _loc9_ = this.getTexture(param1, param2);
                if (_loc9_ != null)
                {
                    this.renderTexture(param1, _loc9_);
                }

                this._bitmapData.unlock();
                return true;
            }

            return false;
        }

        private function updateCorners(param1: IRoomGeometry): void
        {
            this.var_4124.assign(param1.getScreenPosition(this._location));
            this.var_4125.assign(param1.getScreenPosition(Vector3d.sum(this._location, this.var_4113)));
            this.var_4126.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(this._location, this.var_4112), this.var_4113)));
            this.var_4127.assign(param1.getScreenPosition(Vector3d.sum(this._location, this.var_4112)));
            this._offset = param1.getScreenPoint(this.var_4120);
            this.var_4124.x = Math.round(this.var_4124.x);
            this.var_4124.y = Math.round(this.var_4124.y);
            this.var_4125.x = Math.round(this.var_4125.x);
            this.var_4125.y = Math.round(this.var_4125.y);
            this.var_4126.x = Math.round(this.var_4126.x);
            this.var_4126.y = Math.round(this.var_4126.y);
            this.var_4127.x = Math.round(this.var_4127.x);
            this.var_4127.y = Math.round(this.var_4127.y);
            this._offset.x = Math.round(this._offset.x);
            this._offset.y = Math.round(this._offset.y);
            var _loc2_: Number = Math.min(this.var_4124.x, this.var_4125.x, this.var_4126.x, this.var_4127.x);
            var _loc3_: Number = Math.max(this.var_4124.x, this.var_4125.x, this.var_4126.x, this.var_4127.x);
            var _loc4_: Number = Math.min(this.var_4124.y, this.var_4125.y, this.var_4126.y, this.var_4127.y);
            var _loc5_: Number = Math.max(this.var_4124.y, this.var_4125.y, this.var_4126.y, this.var_4127.y);
            _loc3_ = _loc3_ - _loc2_;
            this._offset.x = this._offset.x - _loc2_;
            this.var_4124.x = this.var_4124.x - _loc2_;
            this.var_4125.x = this.var_4125.x - _loc2_;
            this.var_4126.x = this.var_4126.x - _loc2_;
            this.var_4127.x = this.var_4127.x - _loc2_;
            _loc5_ = _loc5_ - _loc4_;
            this._offset.y = this._offset.y - _loc4_;
            this.var_4124.y = this.var_4124.y - _loc4_;
            this.var_4125.y = this.var_4125.y - _loc4_;
            this.var_4126.y = this.var_4126.y - _loc4_;
            this.var_4127.y = this.var_4127.y - _loc4_;
            this.var_2237 = _loc3_;
            this._height = _loc5_;
        }

        private function renderTexture(param1: IRoomGeometry, param2: BitmapData): void
        {
            if (this.var_4124 == null || this.var_4125 == null || this.var_4126 == null || this.var_4127 == null || param2 == null || this._bitmapData == null)
            {
                return;
            }

            var _loc3_: Number = this.var_4127.x - this.var_4126.x;
            var _loc4_: Number = this.var_4127.y - this.var_4126.y;
            var _loc5_: Number = this.var_4125.x - this.var_4126.x;
            var _loc6_: Number = this.var_4125.y - this.var_4126.y;
            if (Math.abs(_loc5_ - param2.width) <= 1)
            {
                _loc5_ = param2.width;
            }

            if (Math.abs(_loc6_ - param2.width) <= 1)
            {
                _loc6_ = param2.width;
            }

            if (Math.abs(_loc3_ - param2.height) <= 1)
            {
                _loc3_ = param2.height;
            }

            if (Math.abs(_loc4_ - param2.height) <= 1)
            {
                _loc4_ = param2.height;
            }

            var _loc7_: Number = _loc5_ / param2.width;
            var _loc8_: Number = _loc6_ / param2.width;
            var _loc9_: Number = _loc3_ / param2.height;
            var _loc10_: Number = _loc4_ / param2.height;
            var _loc11_: Matrix = new Matrix();
            _loc11_.a = _loc7_;
            _loc11_.b = _loc8_;
            _loc11_.c = _loc9_;
            _loc11_.d = _loc10_;
            _loc11_.translate(this.var_4126.x, this.var_4126.y);
            this.draw(param2, _loc11_);
        }

        private function draw(param1: BitmapData, param2: Matrix): void
        {
            var _loc3_: int;
            var _loc4_: int;
            var _loc5_: Number;
            var _loc6_: int;
            var _loc7_: int;
            if (this._bitmapData != null)
            {
                if (param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1)
                {
                    _loc3_ = 0;
                    _loc4_ = 0;
                    _loc5_ = 0;
                    _loc6_ = 0;
                    if (param2.b > 0)
                    {
                        param2.ty++;
                    }

                    _loc7_ = 0;
                    while (_loc3_ < param1.width)
                    {
                        _loc3_++;
                        _loc5_ = _loc5_ + Math.abs(param2.b);
                        if (_loc5_ >= 1)
                        {
                            this._bitmapData.copyPixels(param1, new Rectangle(_loc4_ + _loc6_, 0, _loc3_ - _loc4_, param1.height), new Point(param2.tx + _loc4_, param2.ty + _loc7_), null, null, true);
                            _loc4_ = _loc3_;
                            if (param2.b > 0)
                            {
                                _loc7_++;
                            }
                            else
                            {
                                _loc7_--;
                            }

                            _loc5_ = 0;
                        }

                    }

                    if (_loc5_ > 0)
                    {
                        this._bitmapData.copyPixels(param1, new Rectangle(_loc4_, 0, _loc3_ - _loc4_, param1.height), new Point(param2.tx + _loc4_, param2.ty + _loc7_), null, null, true);
                    }

                    return;
                }

                this._bitmapData.draw(param1, param2, null, null, null, false);
            }

        }

    }
}
