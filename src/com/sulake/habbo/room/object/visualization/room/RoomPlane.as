package com.sulake.habbo.room.object.visualization.room
{

    import flash.geom.Point;

    import com.sulake.room.utils.Vector3d;

    import flash.display.BitmapData;

    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;

    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.display.BitmapDataChannel;
    import flash.display.BlendMode;

    public class RoomPlane
    {

        private static const var_4232: Point = new Point(0, 0);
        public static const var_1487: int = 0;
        public static const var_1489: int = 1;
        public static const var_1488: int = 2;
        public static const TYPE_LANDSCAPE: int = 3;

        private var _disposed: Boolean = false;
        private var var_4233: int = 0;
        private var var_4120: Vector3d = null;
        private var _location: Vector3d = null;
        private var var_4112: Vector3d = null;
        private var var_4113: Vector3d = null;
        private var var_2490: Vector3d = null;
        private var var_4231: Array = [];
        private var var_4015: int = -1;
        private var _type: int = 0;
        private var _isVisible: Boolean = false;
        private var _bitmapData: BitmapData = null;
        private var var_4234: Boolean = true;
        private var _offset: Point = null;
        private var var_4122: Number = 0;
        private var _color: uint = 0;
        private var var_4235: IPlaneRasterizer = null;
        private var var_4236: PlaneMaskManager = null;
        private var _id: String = null;
        private var var_4237: Number = 0;
        private var var_4238: Number = 0;
        private var var_4239: Number = 0;
        private var var_4240: Number = 0;
        private var var_4121: Map = null;
        private var var_4241: PlaneBitmapData = null;
        private var var_4242: Boolean = false;
        private var var_4243: Array = [];
        private var var_4244: Array = [];
        private var var_4245: Boolean = false;
        private var var_4166: BitmapData = null;
        private var var_4246: BitmapData = null;
        private var var_4247: Array = [];
        private var var_4248: Array = [];
        private var var_4124: Vector3d = null;
        private var var_4125: Vector3d = null;
        private var var_4126: Vector3d = null;
        private var var_4127: Vector3d = null;
        private var var_2237: Number = 0;
        private var _height: Number = 0;
        private var var_4249: Boolean = true;

        public function RoomPlane(param1: IVector3d, param2: IVector3d, param3: IVector3d, param4: IVector3d, param5: int, param6: Boolean, param7: Array, param8: int, param9: Number = 0, param10: Number = 0, param11: Number = 0, param12: Number = 0)
        {
            var _loc13_: int;
            var _loc14_: IVector3d;
            var _loc15_: Vector3d;
            super();
            this.var_4233 = param8;
            this.var_4120 = new Vector3d();
            this.var_4120.assign(param1);
            this._location = new Vector3d();
            this._location.assign(param2);
            this.var_4112 = new Vector3d();
            this.var_4112.assign(param3);
            this.var_4113 = new Vector3d();
            this.var_4113.assign(param4);
            this.var_2490 = Vector3d.crossProduct(this.var_4112, this.var_4113);
            if (this.var_2490.length > 0)
            {
                this.var_2490.mul(1 / this.var_2490.length);
            }

            if (param7 != null)
            {
                _loc13_ = 0;
                while (_loc13_ < param7.length)
                {
                    _loc14_ = (param7[_loc13_] as IVector3d);
                    if (_loc14_ != null)
                    {
                        _loc15_ = new Vector3d();
                        _loc15_.assign(_loc14_);
                        this.var_4231.push(_loc15_);
                    }

                    _loc13_++;
                }

            }

            this._offset = new Point();
            this._type = param5;
            this.var_4121 = new Map();
            this.var_4124 = new Vector3d();
            this.var_4125 = new Vector3d();
            this.var_4126 = new Vector3d();
            this.var_4127 = new Vector3d();
            this.var_4237 = param9;
            this.var_4238 = param10;
            this.var_4239 = param11;
            this.var_4240 = param12;
            this.var_4242 = param6;
        }

        public function set canBeVisible(param1: Boolean): void
        {
            if (param1 != this.var_4249)
            {
                if (!this.var_4249)
                {
                    this.resetTextureCache();
                }

                this.var_4249 = param1;
            }

        }

        public function get canBeVisible(): Boolean
        {
            return this.var_4249;
        }

        public function get bitmapData(): BitmapData
        {
            var bitmap: BitmapData;
            if (this.visible)
            {
                if (this._bitmapData != null)
                {
                    try
                    {
                        bitmap = this._bitmapData.clone();
                    }
                    catch (e: Error)
                    {
                    }

                }

            }

            return bitmap;
        }

        public function get visible(): Boolean
        {
            return this._isVisible && this.var_4249;
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

        public function get type(): int
        {
            return this._type;
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

        public function get hasTexture(): Boolean
        {
            return this.var_4234;
        }

        public function set hasTexture(param1: Boolean): void
        {
            this.var_4234 = param1;
        }

        public function set rasterizer(param1: IPlaneRasterizer): void
        {
            this.var_4235 = param1;
        }

        public function set maskManager(param1: PlaneMaskManager): void
        {
            this.var_4236 = param1;
        }

        public function set id(param1: String): void
        {
            if (param1 != this._id)
            {
                this.resetTextureCache();
                this._id = param1;
            }

        }

        public function dispose(): void
        {
            var _loc1_: int;
            var _loc2_: PlaneBitmapData;
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
                    _loc2_ = (this.var_4121.getWithIndex(_loc1_) as PlaneBitmapData);
                    if (_loc2_ != null)
                    {
                        if (_loc2_.bitmap != null)
                        {
                            _loc2_.bitmap.dispose();
                        }

                        _loc2_.dispose();
                    }

                    _loc1_++;
                }

                this.var_4121.dispose();
                this.var_4121 = null;
            }

            this.var_4241 = null;
            this._location = null;
            this.var_4120 = null;
            this.var_4112 = null;
            this.var_4113 = null;
            this.var_2490 = null;
            this.var_4235 = null;
            this.var_4124 = null;
            this.var_4125 = null;
            this.var_4126 = null;
            this.var_4127 = null;
            this.var_4243 = null;
            this.var_4244 = null;
            if (this.var_4166 != null)
            {
                this.var_4166.dispose();
                this.var_4166 = null;
            }

            if (this.var_4246 != null)
            {
                this.var_4246.dispose();
                this.var_4246 = null;
            }

            this._disposed = true;
        }

        public function copyBitmapData(param1: BitmapData): BitmapData
        {
            if (this.visible)
            {
                if (this._bitmapData != null && param1 != null)
                {
                    if (this._bitmapData.width == param1.width && this._bitmapData.height == param1.height)
                    {
                        param1.copyPixels(this._bitmapData, this._bitmapData.rect, var_4232);
                        return param1;
                    }

                }

            }

            return null;
        }

        private function cacheTexture(param1: String, param2: PlaneBitmapData): Boolean
        {
            var _loc3_: PlaneBitmapData = this.var_4121.remove(param1) as PlaneBitmapData;
            if (_loc3_ != null)
            {
                if (param2 != null && param2.bitmap != _loc3_.bitmap)
                {
                    _loc3_.bitmap.dispose();
                }

                _loc3_.dispose();
            }

            this.var_4241 = param2;
            this.var_4121.add(param1, param2);
            return true;
        }

        private function resetTextureCache(param1: BitmapData = null): void
        {
            var _loc2_: int;
            var _loc3_: PlaneBitmapData;
            if (this.var_4121 != null)
            {
                _loc2_ = 0;
                while (_loc2_ < this.var_4121.length)
                {
                    _loc3_ = (this.var_4121.getWithIndex(_loc2_) as PlaneBitmapData);
                    if (_loc3_ != null)
                    {
                        if (_loc3_.bitmap != null && _loc3_.bitmap != param1)
                        {
                            _loc3_.bitmap.dispose();
                        }

                        _loc3_.dispose();
                    }

                    _loc2_++;
                }

                this.var_4121.reset();
            }

            this.var_4241 = null;
        }

        private function getTextureIdentifier(param1: Number): String
        {
            if (this.var_4235 != null)
            {
                return this.var_4235.getTextureIdentifier(param1, this.normal);
            }

            return String(param1);
        }

        private function needsNewTexture(param1: IRoomGeometry, param2: int): Boolean
        {
            var _loc4_: String;
            if (param1 == null)
            {
                return false;
            }

            var _loc3_: PlaneBitmapData = this.var_4241;
            if (_loc3_ == null)
            {
                _loc4_ = this.getTextureIdentifier(param1.scale);
                _loc3_ = (this.var_4121.getValue(_loc4_) as PlaneBitmapData);
            }

            this.updateMaskChangeStatus();
            return this.var_4249 && (_loc3_ == null || _loc3_.timeStamp >= 0 && param2 > _loc3_.timeStamp || this.var_4245);


        }

        private function getTexture(param1: IRoomGeometry, param2: int): BitmapData
        {
            var _loc5_: Number;
            var _loc6_: Number;
            var _loc7_: IVector3d;
            var _loc8_: BitmapData;
            var _loc9_: BitmapData;
            if (param1 == null)
            {
                return null;
            }

            var _loc3_: PlaneBitmapData;
            var _loc4_: String;
            if (this.needsNewTexture(param1, param2))
            {
                _loc5_ = this.var_4112.length * param1.scale;
                _loc6_ = this.var_4113.length * param1.scale;
                _loc7_ = param1.getCoordinatePosition(this.var_2490);
                _loc4_ = this.getTextureIdentifier(param1.scale);
                if (this.var_4241 != null)
                {
                    _loc3_ = this.var_4241;
                }
                else
                {
                    _loc3_ = (this.var_4121.getValue(_loc4_) as PlaneBitmapData);
                }

                _loc8_ = null;
                if (_loc3_ != null)
                {
                    _loc8_ = _loc3_.bitmap;
                }

                if (this.var_4235 != null)
                {
                    _loc3_ = this.var_4235.render(_loc8_, this._id, _loc5_, _loc6_, param1.scale, _loc7_, this.var_4234, this.var_4237, this.var_4238, this.var_4239, this.var_4240, param2);
                    if (_loc3_ != null)
                    {
                        if (_loc8_ != null && _loc3_.bitmap != _loc8_)
                        {
                            _loc8_.dispose();
                        }

                    }

                }
                else
                {
                    _loc9_ = new BitmapData(_loc5_, _loc6_, true, 0xFF000000 | this._color);
                    _loc3_ = new PlaneBitmapData(_loc9_, -1);
                }

                if (_loc3_ != null)
                {
                    this.updateMask(_loc3_.bitmap, param1);
                    this.cacheTexture(_loc4_, _loc3_);
                }

            }
            else
            {
                if (this.var_4241 != null)
                {
                    _loc3_ = this.var_4241;
                }
                else
                {
                    _loc4_ = this.getTextureIdentifier(param1.scale);
                    _loc3_ = (this.var_4121.getValue(_loc4_) as PlaneBitmapData);
                }

            }

            if (_loc3_ != null)
            {
                this.var_4241 = _loc3_;
                return _loc3_.bitmap;
            }

            return null;
        }

        private function addOutlines(param1: PlaneBitmapData): void
        {
        }

        public function update(geometry: IRoomGeometry, timeSinceStartMs: int): Boolean
        {
            var cosAngle: Number;
            var i: int;
            var originPos: IVector3d;
            var originZ: Number;
            var relativeDepth: Number;
            var texture: BitmapData;
            if (geometry == null || this._disposed)
            {
                return false;
            }

            var geometryChanged: Boolean;
            if (this.var_4015 != geometry.updateId)
            {
                geometryChanged = true;
            }

            if (!geometryChanged || !this.var_4249)
            {
                if (!this.visible)
                {
                    return false;
                }

            }

            if (geometryChanged)
            {
                this.var_4241 = null;
                cosAngle = 0;
                cosAngle = Vector3d.cosAngle(geometry.directionAxis, this.normal);
                if (cosAngle > -0.001)
                {
                    if (this._isVisible)
                    {
                        this._isVisible = false;
                        return true;
                    }

                    return false;
                }

                i = 0;
                while (i < this.var_4231.length)
                {
                    cosAngle = Vector3d.cosAngle(geometry.directionAxis, this.var_4231[i]);
                    if (cosAngle > -0.001)
                    {
                        if (this._isVisible)
                        {
                            this._isVisible = false;
                            return true;
                        }

                        return false;
                    }

                    i = i + 1;
                }

                this.updateCorners(geometry);
                originPos = geometry.getScreenPosition(this.var_4120);
                originZ = originPos.z;
                relativeDepth = Math.max(this.var_4124.z - originZ, this.var_4125.z - originZ, this.var_4126.z - originZ, this.var_4127.z - originZ);
                if (this._type == TYPE_LANDSCAPE)
                {
                    relativeDepth = relativeDepth + 0.02;
                }

                this.var_4122 = relativeDepth;
                this._isVisible = true;
                this.var_4015 = geometry.updateId;
            }

            if (geometryChanged || this.needsNewTexture(geometry, timeSinceStartMs))
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

                    try
                    {
                        this._bitmapData = new BitmapData(this.var_2237, this._height, true, 0xFFFFFF);
                    }
                    catch (e: Error)
                    {
                        _bitmapData = null;
                    }

                    if (this._bitmapData == null)
                    {
                        return false;
                    }

                    this._bitmapData.lock();
                }
                else
                {
                    this._bitmapData.lock();
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                }

                Randomizer.setSeed(this.var_4233);
                texture = this.getTexture(geometry, timeSinceStartMs);
                if (texture != null)
                {
                    this.renderTexture(geometry, texture);
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
            if (this._type == var_1489 || this._type == TYPE_LANDSCAPE)
            {
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
                if (param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1 && (this._type == var_1489 || this._type == TYPE_LANDSCAPE))
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

        public function resetBitmapMasks(): void
        {
            if (this.var_4242)
            {
                if (this.var_4243.length == 0)
                {
                    return;
                }

                this.var_4245 = true;
                this.var_4243 = [];
            }

        }

        public function addBitmapMask(param1: String, param2: Number, param3: Number): Boolean
        {
            var _loc4_: RoomPlaneBitmapMask;
            var _loc5_: int;
            if (this.var_4242)
            {
                _loc4_ = null;
                _loc5_ = 0;
                while (_loc5_ < this.var_4243.length)
                {
                    _loc4_ = (this.var_4243[_loc5_] as RoomPlaneBitmapMask);
                    if (_loc4_ != null)
                    {
                        if (_loc4_.type == param1 && _loc4_.leftSideLoc == param2 && _loc4_.rightSideLoc == param3)
                        {
                            return false;
                        }

                    }

                    _loc5_++;
                }

                _loc4_ = new RoomPlaneBitmapMask(param1, param2, param3);
                this.var_4243.push(_loc4_);
                this.var_4245 = true;
                return true;
            }

            return false;
        }

        public function resetRectangleMasks(): void
        {
            if (this.var_4242)
            {
                if (this.var_4244.length == 0)
                {
                    return;
                }

                this.var_4245 = true;
                this.var_4244 = [];
            }

        }

        public function addRectangleMask(param1: Number, param2: Number, param3: Number, param4: Number): Boolean
        {
            var _loc5_: RoomPlaneRectangleMask;
            var _loc6_: int;
            if (this.var_4242)
            {
                _loc5_ = null;
                _loc6_ = 0;
                while (_loc6_ < this.var_4244.length)
                {
                    _loc5_ = (this.var_4244[_loc6_] as RoomPlaneRectangleMask);
                    if (_loc5_ != null)
                    {
                        if (_loc5_.leftSideLoc == param1 && _loc5_.rightSideLoc == param2 && _loc5_.leftSideLength == param3 && _loc5_.rightSideLength == param4)
                        {
                            return false;
                        }

                    }

                    _loc6_++;
                }

                _loc5_ = new RoomPlaneRectangleMask(param1, param2, param3, param4);
                this.var_4244.push(_loc5_);
                this.var_4245 = true;
                return true;
            }

            return false;
        }

        private function updateMaskChangeStatus(): void
        {
            var _loc6_: Boolean;
            var _loc7_: RoomPlaneBitmapMask;
            if (!this.var_4245)
            {
                return;
            }

            var _loc1_: int;
            var _loc2_: int;
            var _loc3_: Boolean = true;
            var _loc4_: RoomPlaneBitmapMask;
            var _loc5_: RoomPlaneRectangleMask;
            if (this.var_4243.length == this.var_4247.length)
            {
                while (_loc1_ < this.var_4243.length)
                {
                    _loc4_ = (this.var_4243[_loc1_] as RoomPlaneBitmapMask);
                    if (_loc4_ != null)
                    {
                        _loc6_ = false;
                        while (_loc2_ < this.var_4247.length)
                        {
                            _loc7_ = (this.var_4247[_loc2_] as RoomPlaneBitmapMask);
                            if (_loc7_ != null)
                            {
                                if (_loc7_.type == _loc4_.type && _loc7_.leftSideLoc == _loc4_.leftSideLoc && _loc7_.rightSideLoc == _loc4_.rightSideLoc)
                                {
                                    _loc6_ = true;
                                    break;
                                }

                            }

                            _loc2_++;
                        }

                        if (!_loc6_)
                        {
                            _loc3_ = false;
                            break;
                        }

                    }

                    _loc1_++;
                }

            }
            else
            {
                _loc3_ = false;
            }

            if (this.var_4244.length > this.var_4248.length)
            {
                _loc3_ = false;
            }

            if (_loc3_)
            {
                this.var_4245 = false;
            }

        }

        private function updateMask(param1: BitmapData, param2: IRoomGeometry): void
        {
            var _loc9_: IVector3d;
            var _loc10_: int;
            var _loc11_: int;
            var _loc12_: String;
            var _loc13_: int;
            var _loc14_: int;
            if (!this.var_4242 || this.var_4243.length == 0 && this.var_4244.length == 0 && !this.var_4245 || this.var_4236 == null)
            {
                return;
            }

            if (param1 == null || param2 == null)
            {
                return;
            }

            var _loc3_: RoomPlaneBitmapMask;
            var _loc4_: RoomPlaneRectangleMask;
            var _loc5_: int;
            var _loc6_: int;
            this.updateMaskChangeStatus();
            var _loc7_: Number = param1.width;
            var _loc8_: Number = param1.height;
            if (this.var_4166 == null || this.var_4166.width != _loc7_ || this.var_4166.height != _loc8_)
            {
                if (this.var_4166 != null)
                {
                    this.var_4166.dispose();
                    this.var_4166 = null;
                }

                this.var_4166 = new BitmapData(_loc7_, _loc8_, true, 0xFFFFFF);
                this.var_4245 = true;
            }

            if (this.var_4245)
            {
                this.var_4247 = [];
                this.var_4248 = [];
                if (this.var_4166 != null)
                {
                    this.var_4166.fillRect(this.var_4166.rect, 0xFFFFFF);
                }

                this.resetTextureCache(param1);
                _loc9_ = param2.getCoordinatePosition(this.var_2490);
                _loc10_ = 0;
                _loc11_ = 0;
                _loc5_ = 0;
                while (_loc5_ < this.var_4243.length)
                {
                    _loc3_ = (this.var_4243[_loc5_] as RoomPlaneBitmapMask);
                    if (_loc3_ != null)
                    {
                        _loc10_ = int(this.var_4166.width - (this.var_4166.width * _loc3_.leftSideLoc) / this.var_4112.length);
                        _loc11_ = int(this.var_4166.height - (this.var_4166.height * _loc3_.rightSideLoc) / this.var_4113.length);
                        _loc12_ = _loc3_.type;
                        this.var_4236.updateMask(this.var_4166, _loc12_, param2.scale, _loc9_, _loc10_, _loc11_);
                        this.var_4247.push(new RoomPlaneBitmapMask(_loc12_, _loc3_.leftSideLoc, _loc3_.rightSideLoc));
                    }

                    _loc5_++;
                }

                _loc6_ = 0;
                while (_loc6_ < this.var_4244.length)
                {
                    _loc4_ = (this.var_4244[_loc6_] as RoomPlaneRectangleMask);
                    if (_loc4_ != null)
                    {
                        _loc10_ = int(this.var_4166.width - (this.var_4166.width * _loc4_.leftSideLoc) / this.var_4112.length);
                        _loc11_ = int(this.var_4166.height - (this.var_4166.height * _loc4_.rightSideLoc) / this.var_4113.length);
                        _loc13_ = int((this.var_4166.width * _loc4_.leftSideLength) / this.var_4112.length);
                        _loc14_ = int((this.var_4166.height * _loc4_.rightSideLength) / this.var_4113.length);
                        this.var_4166.fillRect(new Rectangle(_loc10_ - _loc13_, _loc11_ - _loc14_, _loc13_, _loc14_), 0xFF000000);
                        this.var_4248.push(new RoomPlaneRectangleMask(_loc4_.leftSideLength, _loc4_.rightSideLoc, _loc4_.leftSideLength, _loc4_.rightSideLength));
                    }

                    _loc6_++;
                }

                this.var_4245 = false;
            }

            this.combineTextureMask(param1, this.var_4166);
        }

        private function combineTextureMask(param1: BitmapData, param2: BitmapData): void
        {
            if (param1 == null || param2 == null)
            {
                return;
            }

            if (this.var_4246 != null && (this.var_4246.width != param1.width || this.var_4246.height != param1.height))
            {
                this.var_4246.dispose();
                this.var_4246 = null;
            }

            if (this.var_4246 == null)
            {
                this.var_4246 = new BitmapData(param1.width, param1.height, true, 0xFFFFFFFF);
            }

            this.var_4246.copyChannel(param1, param1.rect, var_4232, BitmapDataChannel.ALPHA, BitmapDataChannel.RED);
            this.var_4246.draw(param2, null, null, BlendMode.DARKEN);
            param1.copyChannel(this.var_4246, this.var_4246.rect, var_4232, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
        }

    }
}
