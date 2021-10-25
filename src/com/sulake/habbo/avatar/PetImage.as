package com.sulake.habbo.avatar
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;

    import flash.display.BitmapData;

    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.pets.IPetData;
    import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;

    import flash.geom.Point;

    import com.sulake.habbo.avatar.cache.AvatarImageBodyPartCache;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;

    import flash.geom.Rectangle;

    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.animation.Animation;

    import flash.utils.getTimer;
    import flash.filters.ColorMatrixFilter;

    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.figure.FigurePart;
    import com.sulake.habbo.avatar.structure.figure.ISetType;

    public class PetImage implements IAvatarImage, IDisposable
    {

        private static const CHANNELS_EQUAL: String = "CHANNELS_EQUAL";
        private static const CHANNELS_UNIQUE: String = "CHANNELS_UNIQUE";
        private static const CHANNELS_RED: String = "CHANNELS_RED";
        private static const CHANNELS_GREEN: String = "CHANNELS_GREEN";
        private static const CHANNELS_BLUE: String = "CHANNELS_BLUE";
        private static const CHANNELS_SATURATED: String = "CHANNELS_SATURATED";
        private static const var_943: String = "Default";
        private static const var_942: int = 2;
        private static const var_941: String = AvatarSetType.var_136;//"full"

        protected var _structure: AvatarStructure;
        protected var _scale: String;
        protected var _direction: int;
        protected var var_977: IActiveActionData;
        protected var _disposed: Boolean;
        private var var_2392: IActiveActionData;
        private var _assets: AssetAliasCollection;
        private var var_2422: AvatarImageCache;
        private var var_2408: int = 0;
        private var var_2407: int = 0;
        private var _figure: AvatarFigureContainer;
        private var var_2569: Boolean;
        private var _sprites: Array;
        private var _avatarSpriteData: IAvatarDataContainer;
        private var var_2390: Array = [];
        private var var_988: BitmapData;
        private var _isAnimating: Boolean;
        private var _canvasOffsets: Array = [];
        private var var_2572: Boolean = false;
        private var _subType: int = 0;
        private var _petType: int;
        private var _petBreed: int;
        private var var_2605: Array;
        private var var_2574: String;
        private var var_2575: String;
        private var var_2578: int;
        private var var_2579: int;

        public function PetImage(param1: AvatarStructure, param2: AssetAliasCollection, param3: String, param4: String)
        {
            this.var_2569 = true;
            this._structure = param1;
            this._assets = param2;
            this._scale = param4;
            if (this._scale == null)
            {
                this._scale = AvatarScaleType.var_106;
            }

            if (param3 == null || param3 == "")
            {
                param3 = "phd-1-5.pbd-1-5.ptl-1-5";
                Logger.log("Using default pet figure");
            }

            this._figure = new AvatarFigureContainer(param3);
            var _loc5_: int = this._figure.getPartSetId("pbd");
            this.solvePetAvatarTypeAndBreed(_loc5_);
            this._subType = this._petType;
            this.var_2422 = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            this.setDirection(var_941, var_942);
            this.var_2390 = [];
            this.var_2392 = new ActiveActionData(AvatarAction.var_944);
            this.var_2392.definition = this._structure.getActionDefinition(var_943);
            this.resetActions();
        }

        public function dispose(): void
        {
            var _loc1_: AvatarImageCache;
            if (!this._disposed)
            {
                this._structure = null;
                this._assets = null;
                this.var_2422 = null;
                this.var_977 = null;
                this._figure = null;
                this._avatarSpriteData = null;
                this.var_2390 = null;
                if (this.var_988)
                {
                    this.var_988.dispose();
                }

                _loc1_ = this.getCache();
                if (_loc1_)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                }

                this.var_988 = null;
                this._canvasOffsets = null;
                this._disposed = true;
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function getFigure(): IAvatarFigureContainer
        {
            return this._figure;
        }

        public function getScale(): String
        {
            return this._scale;
        }

        public function getSubType(): int
        {
            return this._subType;
        }

        public function getPartColor(param1: String): IPartColor
        {
            return this._structure.getPartColor(this._figure, param1);
        }

        public function setDirection(param1: String, param2: int): void
        {
            var _loc3_: IPetData;
            param2 = param2 + this.var_2407;
            if (param2 < AvatarDirectionAngle.var_945)
            {
                param2 = AvatarDirectionAngle.var_946 + (param2 + 1);
            }

            if (param2 > AvatarDirectionAngle.var_946)
            {
                param2 = param2 - (AvatarDirectionAngle.var_946 + 1);
            }

            if (param1 == AvatarSetType.var_107)
            {
                if ((this._direction == 6 || this._direction == 0) && param2 == 7)
                {
                    param2 = this._direction;
                }

                _loc3_ = this._structure.renderManager.petDataManager.getPetData(this._subType);
                if (_loc3_ != null)
                {
                    if (_loc3_.disableHeadTurn)
                    {
                        param2 = this._direction;
                    }

                }

            }

            if (this._structure.isMainAvatarSet(param1))
            {
                this._direction = param2;
            }

            this.getCache().setDirection(param1, param2);
            this.var_2569 = true;
        }

        public function setDirectionAngle(param1: String, param2: int): void
        {
            var _loc3_: int;
            _loc3_ = int(param2 / 45);
            this.setDirection(param1, _loc3_);
        }

        public function getSprites(): Array
        {
            return this._sprites;
        }

        public function getCanvasOffsets(): Array
        {
            return this._canvasOffsets;
        }

        public function getLayerData(param1: ISpriteDataContainer): IAnimationLayerData
        {
            return this._structure.getBodyPartData(param1.animation.id, this.var_2408, param1.id);
        }

        public function updateAnimationByFrames(param1: int = 1): void
        {
            this.var_2408 = this.var_2408 + param1;
            this.var_2569 = true;
        }

        public function getImage(param1: String, param2: Boolean): BitmapData
        {
            var _loc8_: String;
            var _loc9_: AvatarImageBodyPartContainer;
            var _loc10_: BitmapData;
            var _loc11_: Point;
            var _loc12_: AvatarImageBodyPartCache;
            var _loc13_: IActiveActionData;
            var _loc14_: String;
            var _loc15_: Array;
            var _loc16_: Boolean;
            var _loc17_: int;
            var _loc18_: AvatarImagePartContainer;
            var _loc19_: int;
            var _loc20_: int;
            var _loc21_: int;
            var _loc22_: Point;
            var _loc23_: BitmapData;
            if (!this.var_2569)
            {
                return this.var_988;
            }

            if (this.var_977 == null)
            {
                return null;
            }

            if (!this.var_2572)
            {
                this.endActionAppends();
            }

            var _loc3_: AvatarImageCache = this.getCache();
            var _loc4_: AvatarCanvas = this._structure.getCanvas(this._scale, this.var_977.definition.geometryType);
            if (this.var_988 == null || _loc4_ != null && (this.var_988.width != _loc4_.width || this.var_988.height != _loc4_.height))
            {
                _loc4_ = this._structure.getCanvas(this._scale, this.var_977.definition.geometryType);
                if (_loc4_ == null)
                {
                    return null;
                }

                this.var_988 = new BitmapData(_loc4_.width, _loc4_.height, true, 0xFFFFFF);
            }

            var _loc5_: Array = this._structure.getBodyParts(param1, this.var_977.definition.geometryType, this._direction);
            this.var_988.lock();
            this.var_988.fillRect(this.var_988.rect, 0xFFFFFF);
            var _loc6_: Point = _loc4_.offset;
            if (_loc6_ == null)
            {
                _loc6_ = new Point(0, 0);
            }

            var _loc7_: int = _loc5_.length - 1;
            while (_loc7_ >= 0)
            {
                _loc8_ = _loc5_[_loc7_];
                _loc9_ = _loc3_.getImageContainer(_loc8_, this.var_2408);
                if (_loc9_ && _loc9_.image && _loc9_.regPoint)
                {
                    _loc10_ = _loc9_.image;
                    _loc11_ = _loc9_.regPoint.clone();
                    _loc12_ = this.getCache().getBodyPartCache(_loc8_);
                    _loc13_ = _loc12_.getAction();
                    _loc14_ = _loc13_.definition.assetPartDefinition;
                    _loc15_ = this._structure.getParts(_loc8_, this._figure, _loc13_, "pet", _loc12_.getDirection(), []);
                    _loc16_ = this._subType < 3;
                    _loc17_ = _loc16_ ? 32 : 67;
                    if (this._scale == AvatarScaleType.var_305)
                    {
                        _loc17_ = _loc16_ ? 6 : 31;
                    }

                    if (_loc15_.length > 0)
                    {
                        _loc18_ = _loc15_[0];
                        _loc19_ = _loc18_.getFrameIndex(this.var_2408);
                        _loc20_ = this._direction;
                        _loc21_ = 1;
                        switch (this._direction)
                        {
                            case 4:
                                _loc20_ = 2;
                                _loc21_ = -1;
                                break;
                            case 5:
                                _loc20_ = 1;
                                _loc21_ = -1;
                                break;
                            case 6:
                                _loc20_ = 0;
                                _loc21_ = -1;
                                break;
                        }

                        _loc22_ = this._structure.getPartActionOffset(this.getSubType(), this._scale, _loc8_, _loc14_, _loc19_, _loc20_);
                        if (_loc22_ != null)
                        {
                            _loc11_.x = _loc11_.x + _loc22_.x * _loc21_;
                            _loc11_.y = _loc11_.y + _loc22_.y;
                            if (this._direction == 7 && _loc12_.getDirection() == 6)
                            {
                                _loc11_.offset(-1 * _loc17_, 0);
                            }
                            else
                            {
                                if (this._direction == 4 && _loc12_.getDirection() == 3)
                                {
                                    _loc11_.offset(_loc17_, 0);
                                }
                                else
                                {
                                    if (this._direction == 3 && _loc12_.getDirection() == 4)
                                    {
                                        _loc11_.offset(-1 * _loc17_, 0);
                                    }
                                    else
                                    {
                                        if (this._direction == 6 && _loc12_.getDirection() == 7)
                                        {
                                            _loc11_.offset(_loc17_, 0);
                                        }

                                    }

                                }

                            }

                        }

                    }

                    this.var_988.copyPixels(_loc10_, _loc10_.rect, _loc11_.add(_loc6_), null, null, true);
                }

                _loc7_--;
            }

            this.var_988.unlock();
            this.var_2569 = false;
            if (this._avatarSpriteData != null)
            {
                if (this._avatarSpriteData.paletteIsGrayscale)
                {
                    _loc23_ = this.convertToGrayscale(this.var_988);
                    if (this.var_988)
                    {
                        this.var_988.dispose();
                    }

                    this.var_988 = _loc23_;
                    this.var_988.paletteMap(this.var_988, this.var_988.rect, new Point(0, 0), this._avatarSpriteData.reds, [], []);
                }
                else
                {
                    this.var_988.copyChannel(this.var_988, this.var_988.rect, new Point(0, 0), 2, 8);
                }

            }

            if (this.var_988 && param2)
            {
                return this.var_988.clone();
            }

            return this.var_988;
        }

        public function getCroppedImage(param1: String): BitmapData
        {
            var _loc6_: Rectangle;
            var _loc9_: String;
            var _loc10_: AvatarImageBodyPartContainer;
            var _loc11_: BitmapData;
            var _loc12_: Point;
            var _loc13_: AvatarImageBodyPartCache;
            var _loc14_: IActiveActionData;
            var _loc15_: String;
            var _loc16_: Array;
            var _loc17_: int;
            var _loc18_: Rectangle;
            var _loc19_: AvatarImagePartContainer;
            var _loc20_: int;
            var _loc21_: int;
            var _loc22_: int;
            var _loc23_: Point;
            if (this.var_977 == null)
            {
                return null;
            }

            var _loc2_: AvatarImageCache = this.getCache();
            var _loc3_: AvatarCanvas = this._structure.getCanvas(this._scale, this.var_977.definition.geometryType);
            if (_loc3_ == null)
            {
                return null;
            }

            var _loc4_: BitmapData = new BitmapData(_loc3_.width, _loc3_.height, true, 0xFFFFFF);
            var _loc5_: Array = this._structure.getBodyParts(param1, this.var_977.definition.geometryType, this._direction);
            var _loc7_: int = _loc5_.length - 1;
            while (_loc7_ >= 0)
            {
                _loc9_ = _loc5_[_loc7_];
                _loc10_ = _loc2_.getImageContainer(_loc9_, this.var_2408);
                if (_loc10_ != null)
                {
                    _loc11_ = _loc10_.image;
                    if (_loc11_ == null)
                    {
                        _loc4_.dispose();
                        return null;
                    }

                    _loc12_ = _loc10_.regPoint.clone();
                    _loc13_ = this.getCache().getBodyPartCache(_loc9_);
                    _loc14_ = _loc13_.getAction();
                    _loc15_ = _loc14_.definition.assetPartDefinition;
                    _loc16_ = this._structure.getParts(_loc9_, this._figure, _loc14_, "pet", _loc13_.getDirection(), []);
                    _loc17_ = 32;
                    if (this._scale == AvatarScaleType.var_305)
                    {
                        _loc17_ = 6;
                    }

                    if (_loc16_.length > 0)
                    {
                        _loc19_ = _loc16_[0];
                        _loc20_ = _loc19_.getFrameIndex(this.var_2408);
                        _loc21_ = this._direction;
                        _loc22_ = 1;
                        switch (this._direction)
                        {
                            case 4:
                                _loc21_ = 2;
                                _loc22_ = -1;
                                break;
                            case 5:
                                _loc21_ = 1;
                                _loc22_ = -1;
                                break;
                            case 6:
                                _loc21_ = 0;
                                _loc22_ = -1;
                                break;
                        }

                        _loc23_ = this._structure.getPartActionOffset(this.getSubType(), this._scale, _loc9_, _loc15_, _loc20_, _loc21_);
                        if (_loc23_ != null)
                        {
                            _loc12_.x = _loc12_.x + _loc23_.x * _loc22_;
                            _loc12_.y = _loc12_.y + _loc23_.y;
                            if (this._direction == 7 && _loc13_.getDirection() == 6)
                            {
                                _loc12_.offset(-1 * _loc17_, 0);
                            }
                            else
                            {
                                if (this._direction == 4 && _loc13_.getDirection() == 3)
                                {
                                    _loc12_.offset(_loc17_, 0);
                                }
                                else
                                {
                                    if (this._direction == 3 && _loc13_.getDirection() == 4)
                                    {
                                        _loc12_.offset(-1 * _loc17_, 0);
                                    }
                                    else
                                    {
                                        if (this._direction == 6 && _loc13_.getDirection() == 7)
                                        {
                                            _loc12_.offset(_loc17_, 0);
                                        }

                                    }

                                }

                            }

                        }

                    }

                    _loc4_.copyPixels(_loc11_, _loc11_.rect, _loc12_, null, null, true);
                    _loc18_ = new Rectangle(_loc12_.x, _loc12_.y, _loc11_.width, _loc11_.height);
                    if (_loc6_ == null)
                    {
                        _loc6_ = _loc18_;
                    }
                    else
                    {
                        _loc6_ = _loc6_.union(_loc18_);
                    }

                }

                _loc7_--;
            }

            if (_loc6_ == null)
            {
                _loc6_ = new Rectangle(0, 0, 1, 1);
            }

            var _loc8_: BitmapData = new BitmapData(_loc6_.width, _loc6_.height, true, 0xFFFFFF);
            _loc8_.copyPixels(_loc4_, _loc6_, new Point(0, 0), null, null, true);
            _loc4_.dispose();
            return _loc8_;
        }

        public function getAsset(param1: String): BitmapDataAsset
        {
            return this._assets.getAssetByName(param1) as BitmapDataAsset;
        }

        public function getDirection(): int
        {
            return this._direction;
        }

        public function initActionAppends(): void
        {
            this.var_2390 = [];
            this.var_2572 = false;
            this.var_2575 = "";
        }

        public function endActionAppends(): void
        {
            this.sortActions();
            this.resetActions();
            this.setActionsToParts();
        }

        public function appendAction(param1: String, ..._args): Boolean
        {
            var _loc3_: String;
            this.var_2572 = false;
            if (_args != null && _args.length > 0)
            {
                _loc3_ = _args[0];
            }

            this.var_2575 = this.var_2575 + param1 + _loc3_;
            switch (param1)
            {
                case AvatarAction.var_971:
                    switch (_loc3_)
                    {
                        case "wav":
                            this.addActionData("wave");
                            break;
                        case AvatarAction.var_947:
                        case AvatarAction.var_948:
                        case AvatarAction.var_949:
                        case AvatarAction.var_944:
                        case AvatarAction.var_950:
                        case AvatarAction.var_951:
                        case AvatarAction.var_952:
                        case AvatarAction.var_953:
                        case AvatarAction.var_954:
                        case AvatarAction.var_955:
                        case AvatarAction.var_956:
                        case AvatarAction.var_957:
                        case AvatarAction.var_958:
                        case AvatarAction.var_959:
                        case AvatarAction.var_960:
                            this.addActionData(_loc3_);
                            break;
                        default:
                            this.errorThis("appendAction() >> UNKNOWN POSTURE TYPE: " + _loc3_);
                    }

                    break;
                case AvatarAction.var_972:
                    switch (_loc3_)
                    {
                        case AvatarAction.var_961:
                        case AvatarAction.var_962:
                        case AvatarAction.var_963:
                        case AvatarAction.var_964:
                        case AvatarAction.var_965:
                        case AvatarAction.var_966:
                        case AvatarAction.var_967:
                        case AvatarAction.var_968:
                        case AvatarAction.var_969:
                        case AvatarAction.var_970:
                            this.addActionData(_loc3_);
                            break;
                        default:
                            this.errorThis("appendAction() >> UNKNOWN GESTURE TYPE: " + _loc3_);
                    }

                    break;
                case AvatarAction.var_973:
                case AvatarAction.WAVE:
                case AvatarAction.var_974:
                case AvatarAction.var_975:
                    this.addActionData(param1, _loc3_);
                    break;
                default:
                    this.errorThis("appendAction() >> UNKNOWN ACTION TYPE: " + param1);
            }

            return true;
        }

        private function addActionData(param1: String, param2: String = ""): void
        {
            var _loc3_: ActiveActionData;
            if (this.var_2390 == null)
            {
                this.var_2390 = [];
            }

            var _loc4_: int;
            while (_loc4_ < this.var_2390.length)
            {
                _loc3_ = this.var_2390[_loc4_];
                if (_loc3_.actionType == param1 && _loc3_.actionParameter == param2)
                {
                    return;
                }

                _loc4_++;
            }

            this.var_2390.push(new ActiveActionData(param1, param2));
        }

        public function isAnimating(): Boolean
        {
            return this._isAnimating;
        }

        private function resetActions(): Boolean
        {
            this._isAnimating = false;
            this._sprites = [];
            this._avatarSpriteData = null;
            this.var_2407 = 0;
            this.var_977 = this.var_2392;
            this.var_977.definition = this.var_2392.definition;
            this.setActionToParts(this.var_2392);
            this.getCache().resetBodyPartCache(this.var_2392);
            return true;
        }

        private function sortActions(): void
        {
            this.var_2572 = true;
            if (this.var_2574 == this.var_2575)
            {
                return;
            }

            this.var_2574 = this.var_2575;
            this.var_2605 = this._structure.sortActions(this.var_2390);
            if (this.var_2605 == null)
            {
                this._canvasOffsets = [0, 0, 0];
            }
            else
            {
                this._canvasOffsets = this._structure.getCanvasOffsets(this.var_2605, this._scale, this._direction);
            }

        }

        private function setActionsToParts(): void
        {
            var _loc1_: ActiveActionData;
            var _loc2_: Animation;
            for each (_loc1_ in this.var_2605)
            {
                if (!(!_loc1_ || !_loc1_.definition))
                {
                    if (_loc1_.definition.isAnimation && _loc1_.actionParameter == "")
                    {
                        _loc1_.actionParameter = "1";
                    }

                    this.setActionToParts(_loc1_);
                    if (_loc1_.definition.isAnimation)
                    {
                        this._isAnimating = true;
                        _loc2_ = this._structure.getAnimation(_loc1_.definition.state + "." + _loc1_.actionParameter);
                        if (_loc2_ != null)
                        {
                            this._sprites = this._sprites.concat(_loc2_.spriteData);
                            if (_loc2_.hasDirectionData())
                            {
                                this.var_2407 = _loc2_.directionData.offset;
                            }

                            if (_loc2_.hasAvatarData())
                            {
                                this._avatarSpriteData = _loc2_.avatarData;
                            }

                        }

                    }

                    if (_loc1_.actionType == AvatarAction.var_976)
                    {
                        this._isAnimating = true;
                    }

                    if (_loc1_.actionType == AvatarAction.WAVE)
                    {
                        this._isAnimating = true;
                    }

                    if (_loc1_.actionType == AvatarAction.var_973)
                    {
                        this._isAnimating = true;
                    }

                }

            }

        }

        private function getCache(): AvatarImageCache
        {
            if (this.var_2422 == null)
            {
                this.var_2422 = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            }

            return this.var_2422;
        }

        private function setActionToParts(param1: IActiveActionData): void
        {
            if (param1 == null)
            {
                return;
            }

            if (param1.definition.assetPartDefinition == "")
            {
                return;
            }

            if (param1.definition.isMain)
            {
                this.var_977 = param1;
                this.getCache().setGeometryType(param1.definition.geometryType);
            }

            this.getCache().setAction(param1, getTimer());
            this.var_2569 = true;
        }

        public function get avatarSpriteData(): IAvatarDataContainer
        {
            return this._avatarSpriteData;
        }

        private function convertToGrayscale(param1: BitmapData, param2: String = "CHANNELS_EQUAL"): BitmapData
        {
            var _loc3_: Number = 0.33;
            var _loc4_: Number = 0.33;
            var _loc5_: Number = 0.33;
            var _loc6_: Number = 1;
            switch (param2)
            {
                case "CHANNELS_UNIQUE":
                    _loc3_ = 0.3;
                    _loc4_ = 0.59;
                    _loc5_ = 0.11;
                    break;
                case "CHANNELS_RED":
                    _loc3_ = 1;
                    _loc4_ = 0;
                    _loc5_ = 0;
                    break;
                case "CHANNELS_GREEN":
                    _loc3_ = 0;
                    _loc4_ = 1;
                    _loc5_ = 0;
                    break;
                case "CHANNELS_BLUE":
                    _loc3_ = 0;
                    _loc4_ = 0;
                    _loc5_ = 1;
                    break;
                case "CHANNELS_DESATURATED":
                    _loc3_ = 0.3086;
                    _loc4_ = 0.6094;
                    _loc5_ = 0.082;
                    break;
            }

            var _loc7_: Array = [
                _loc3_,
                _loc4_,
                _loc5_,
                0,
                0,
                _loc3_,
                _loc4_,
                _loc5_,
                0,
                0,
                _loc3_,
                _loc4_,
                _loc5_,
                0,
                0,
                0,
                0,
                0,
                1,
                0
            ];
            var _loc8_: ColorMatrixFilter = new ColorMatrixFilter(_loc7_);
            var _loc9_: BitmapData = new BitmapData(param1.width, param1.height, param1.transparent, 0xFFFFFFFF);
            _loc9_.copyPixels(param1, param1.rect, new Point(0, 0), null, null, false);
            _loc9_.applyFilter(_loc9_, _loc9_.rect, new Point(0, 0), _loc8_);
            return _loc9_;
        }

        private function errorThis(param1: String): void
        {
            Logger.log("[PetImageError] " + param1);
        }

        private function logThis(param1: String): void
        {
        }

        private function solvePetAvatarTypeAndBreed(param1: int): void
        {
            var _loc3_: IFigurePartSet;
            var _loc4_: FigurePart;
            this._petType = 0;
            this._petBreed = 0;
            var _loc2_: ISetType = this._structure.figureData.getSetType("pbd");
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.getPartSet(param1);
                if (_loc3_ != null)
                {
                    for each (_loc4_ in _loc3_.parts)
                    {
                        if (_loc4_.type == "pbd")
                        {
                            this._petType = _loc4_.id;
                            this._petBreed = _loc4_.breed;
                            break;
                        }

                    }

                }

            }

        }

        public function get petType(): int
        {
            return this._petType;
        }

        public function get petBreed(): int
        {
            return this._petBreed;
        }

        public function isPlaceholder(): Boolean
        {
            return false;
        }

    }
}
