package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.geom.Point;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.animation.Animation;
    import flash.utils.getTimer;
    import flash.filters.ColorMatrixFilter;

    public class AvatarImage implements IAvatarImage, IDisposable 
    {

        private static const CHANNELS_EQUAL:String = "CHANNELS_EQUAL";
        private static const CHANNELS_UNIQUE:String = "CHANNELS_UNIQUE";
        private static const CHANNELS_RED:String = "CHANNELS_RED";
        private static const CHANNELS_GREEN:String = "CHANNELS_GREEN";
        private static const CHANNELS_BLUE:String = "CHANNELS_BLUE";
        private static const CHANNELS_SATURATED:String = "CHANNELS_SATURATED";
        private static const var_943:String = "Default";
        private static const var_942:int = 2;
        private static const var_941:String = AvatarSetType.var_136;//"full"

        protected var _structure:AvatarStructure;
        protected var _scale:String;
        protected var var_979:int;
        protected var var_2567:int;
        protected var var_977:IActiveActionData;
        protected var var_978:Boolean;
        protected var var_2383:Array = new Array();
        protected var _assets:AssetAliasCollection;
        protected var var_2422:AvatarImageCache;
        protected var var_2534:AvatarFigureContainer;
        protected var var_2568:IAvatarDataContainer;
        protected var var_2390:Array = [];
        protected var var_988:BitmapData;
        private var var_2392:IActiveActionData;
        private var var_2408:int = 0;
        private var var_2407:int = 0;
        private var var_2569:Boolean;
        private var var_2570:Array;
        private var var_2571:Boolean;
        private var var_2572:Boolean = false;
        private var var_2573:Array;
        private var var_2574:String;
        private var var_2575:String;
        private var var_986:Map;
        protected var var_987:Boolean = false;
        private var var_2576:Boolean;
        private var var_2577:int = -1;
        private var var_2578:int;
        private var var_2579:int;
        private var var_2580:Array = [];
        private var var_2581:int = -1;
        private var var_2582:String = null;
        private var var_2583:String = null;

        public function AvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String)
        {
            this.var_2569 = true;
            this._structure = param1;
            this._assets = param2;
            this._scale = param4;
            if (this._scale == null)
            {
                this._scale = AvatarScaleType.var_106;
            };
            if (param3 == null)
            {
                param3 = new AvatarFigureContainer("hr-893-45.hd-180-2.ch-210-66.lg-270-82.sh-300-91.wa-2007-.ri-1-");
                Logger.log("Using default avatar figure");
            };
            this.var_2534 = param3;
            this.var_2422 = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            this.setDirection(var_941, var_942);
            this.var_2390 = new Array();
            this.var_2392 = new ActiveActionData(AvatarAction.var_944);
            this.var_2392.definition = this._structure.getActionDefinition(var_943);
            this.resetActions();
            this.var_986 = new Map();
        }

        public function dispose():void
        {
            var _loc1_:AvatarImageCache;
            var _loc2_:BitmapData;
            if (!this.var_978)
            {
                this._structure = null;
                this._assets = null;
                this.var_2422 = null;
                this.var_977 = null;
                this.var_2534 = null;
                this.var_2568 = null;
                this.var_2390 = null;
                if (this.var_988)
                {
                    this.var_988.dispose();
                };
                _loc1_ = this.getCache();
                if (_loc1_)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                };
                if (this.var_986)
                {
                    for each (_loc2_ in this.var_986)
                    {
                        _loc2_.dispose();
                    };
                    this.var_986.dispose();
                    this.var_986 = null;
                };
                this.var_988 = null;
                this.var_2383 = null;
                this.var_978 = true;
            };
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        public function getFigure():IAvatarFigureContainer
        {
            return (this.var_2534);
        }

        public function getScale():String
        {
            return (this._scale);
        }

        public function getPartColor(param1:String):IPartColor
        {
            return (this._structure.getPartColor(this.var_2534, param1));
        }

        public function setDirection(param1:String, param2:int):void
        {
            param2 = (param2 + this.var_2407);
            if (param2 < AvatarDirectionAngle.var_945)
            {
                param2 = (AvatarDirectionAngle.var_946 + (param2 + 1));
            };
            if (param2 > AvatarDirectionAngle.var_946)
            {
                param2 = (param2 - (AvatarDirectionAngle.var_946 + 1));
            };
            if (this._structure.isMainAvatarSet(param1))
            {
                this.var_979 = param2;
            };
            if (((param1 == AvatarSetType.var_107) || (param1 == AvatarSetType.var_136)))
            {
                if (((param1 == AvatarSetType.var_107) && (this.isHeadTurnPreventedByAction())))
                {
                    param2 = this.var_979;
                };
                this.var_2567 = param2;
            };
            this.getCache().setDirection(param1, param2);
            this.var_2569 = true;
        }

        public function setDirectionAngle(param1:String, param2:int):void
        {
            var _loc3_:int;
            _loc3_ = int((param2 / 45));
            this.setDirection(param1, _loc3_);
        }

        public function getSprites():Array
        {
            return (this.var_2570);
        }

        public function getCanvasOffsets():Array
        {
            return (this.var_2383);
        }

        public function getLayerData(param1:ISpriteDataContainer):IAnimationLayerData
        {
            return (this._structure.getBodyPartData(param1.animation.id, this.var_2408, param1.id));
        }

        public function updateAnimationByFrames(param1:int=1):void
        {
            this.var_2408 = (this.var_2408 + param1);
            this.var_2569 = true;
        }

        private function getFullImageCacheKey():String
        {
            var _loc1_:IActiveActionData;
            var _loc2_:int;
            if (!this.var_2576)
            {
                return (null);
            };
            if (((this.var_2573.length == 1) && (this.var_979 == this.var_2567)))
            {
                return ((this.var_979 + this.var_2575) + (this.var_2408 % 4));
            };
            if (this.var_2573.length == 2)
            {
                for each (_loc1_ in this.var_2573)
                {
                    if (((_loc1_.actionType == "fx") && ((((_loc1_.actionParameter == "33") || (_loc1_.actionParameter == "34")) || (_loc1_.actionParameter == "35")) || (_loc1_.actionParameter == "36"))))
                    {
                        return ((this.var_979 + this.var_2575) + 0);
                    };
                    if (((_loc1_.actionType == "fx") && ((_loc1_.actionParameter == "38") || (_loc1_.actionParameter == "39"))))
                    {
                        _loc2_ = (this.var_2408 % 11);
                        return ((((this.var_979 + "_") + this.var_2567) + this.var_2575) + _loc2_);
                    };
                };
            };
            return (null);
        }

        private function getBodyParts(param1:String, param2:String, param3:int):Array
        {
            if ((((!(param3 == this.var_2581)) || (!(param2 == this.var_2582))) || (!(param1 == this.var_2583))))
            {
                this.var_2581 = param3;
                this.var_2582 = param2;
                this.var_2583 = param1;
                this.var_2580 = this._structure.getBodyParts(param1, param2, param3);
            };
            return (this.var_2580);
        }

        public function getImage(param1:String, param2:Boolean):BitmapData
        {
            var _loc8_:String;
            var _loc9_:AvatarImageBodyPartContainer;
            var _loc10_:BitmapData;
            var _loc11_:Point;
            var _loc13_:BitmapData;
            if (!this.var_2569)
            {
                return (this.var_988);
            };
            if (this.var_977 == null)
            {
                return (null);
            };
            if (!this.var_2572)
            {
                this.endActionAppends();
            };
            var _loc3_:String = this.getFullImageCacheKey();
            if (_loc3_ != null)
            {
                if (this.getFullImage(_loc3_))
                {
                    this.var_2569 = false;
                    if (param2)
                    {
                        return ((this.getFullImage(_loc3_) as BitmapData).clone());
                    };
                    this.var_988 = (this.getFullImage(_loc3_) as BitmapData);
                    this.var_987 = true;
                    return (this.var_988);
                };
            };
            var _loc4_:AvatarImageCache = this.getCache();
            var _loc5_:AvatarCanvas = this._structure.getCanvas(this._scale, this.var_977.definition.geometryType);
            if (_loc5_ == null)
            {
                return (null);
            };
            if ((((this.var_987) || (this.var_988 == null)) || ((!(this.var_988.width == _loc5_.width)) || (!(this.var_988.height == _loc5_.height)))))
            {
                if (((!(this.var_988 == null)) && (!(this.var_987))))
                {
                    this.var_988.dispose();
                };
                this.var_988 = new BitmapData(_loc5_.width, _loc5_.height, true, 0xFFFFFF);
                this.var_987 = false;
            };
            var _loc6_:Array = this.getBodyParts(param1, this.var_977.definition.geometryType, this.var_979);
            this.var_988.lock();
            this.var_988.fillRect(this.var_988.rect, 0xFFFFFF);
            var _loc7_:Point = _loc5_.offset;
            if (_loc7_ == null)
            {
                _loc7_ = new Point(0, 0);
            };
            var _loc12_:int = (_loc6_.length - 1);
            while (_loc12_ >= 0)
            {
                _loc8_ = _loc6_[_loc12_];
                _loc9_ = _loc4_.getImageContainer(_loc8_, this.var_2408);
                if ((((_loc9_) && (_loc9_.image)) && (_loc9_.regPoint)))
                {
                    _loc10_ = _loc9_.image;
                    _loc11_ = _loc9_.regPoint.clone();
                    this.var_988.copyPixels(_loc10_, _loc10_.rect, _loc11_.add(_loc7_), null, null, true);
                };
                _loc12_--;
            };
            this.var_988.unlock();
            this.var_2569 = false;
            if (this.var_2568 != null)
            {
                if (this.var_2568.paletteIsGrayscale)
                {
                    _loc13_ = this.convertToGrayscale(this.var_988);
                    if (this.var_988)
                    {
                        this.var_988.dispose();
                    };
                    this.var_988 = _loc13_;
                    this.var_988.paletteMap(this.var_988, this.var_988.rect, new Point(0, 0), this.var_2568.reds, [], []);
                }
                else
                {
                    this.var_988.copyChannel(this.var_988, this.var_988.rect, new Point(0, 0), 2, 8);
                };
            };
            if (_loc3_ != null)
            {
                this.cacheFullImage(_loc3_, this.var_988.clone());
            };
            if (((this.var_988) && (param2)))
            {
                return (this.var_988.clone());
            };
            return (this.var_988);
        }

        public function getCroppedImage(param1:String):BitmapData
        {
            var _loc6_:Rectangle;
            var _loc7_:String;
            var _loc8_:AvatarImageBodyPartContainer;
            var _loc9_:BitmapData;
            var _loc10_:Point;
            if (this.var_977 == null)
            {
                return (null);
            };
            var _loc2_:AvatarImageCache = this.getCache();
            var _loc3_:AvatarCanvas = this._structure.getCanvas(this._scale, this.var_977.definition.geometryType);
            if (_loc3_ == null)
            {
                return (null);
            };
            var _loc4_:BitmapData = new BitmapData(_loc3_.width, _loc3_.height, true, 0xFFFFFF);
            var _loc5_:Array = this._structure.getBodyParts(param1, this.var_977.definition.geometryType, this.var_979);
            var _loc11_:Rectangle = new Rectangle();
            var _loc12_:int = (_loc5_.length - 1);
            while (_loc12_ >= 0)
            {
                _loc7_ = _loc5_[_loc12_];
                _loc8_ = _loc2_.getImageContainer(_loc7_, this.var_2408);
                if (_loc8_ != null)
                {
                    _loc9_ = _loc8_.image;
                    if (_loc9_ == null)
                    {
                        _loc4_.dispose();
                        return (null);
                    };
                    _loc10_ = _loc8_.regPoint.clone();
                    _loc4_.copyPixels(_loc9_, _loc9_.rect, _loc10_, null, null, true);
                    _loc11_.x = _loc10_.x;
                    _loc11_.y = _loc10_.y;
                    _loc11_.width = _loc9_.width;
                    _loc11_.height = _loc9_.height;
                    if (_loc6_ == null)
                    {
                        _loc6_ = _loc11_;
                    }
                    else
                    {
                        _loc6_ = _loc6_.union(_loc11_);
                    };
                };
                _loc12_--;
            };
            if (_loc6_ == null)
            {
                _loc6_ = new Rectangle(0, 0, 1, 1);
            };
            var _loc13_:BitmapData = new BitmapData(_loc6_.width, _loc6_.height, true, 0xFFFFFF);
            _loc13_.copyPixels(_loc4_, _loc6_, new Point(0, 0), null, null, true);
            _loc4_.dispose();
            return (_loc13_);
        }

        protected function getFullImage(param1:String):BitmapData
        {
            return (this.var_986[param1]);
        }

        protected function cacheFullImage(param1:String, param2:BitmapData):void
        {
            this.var_986[param1] = param2;
        }

        public function getAsset(param1:String):BitmapDataAsset
        {
            return (this._assets.getAssetByName(param1) as BitmapDataAsset);
        }

        public function getDirection():int
        {
            return (this.var_979);
        }

        public function initActionAppends():void
        {
            this.var_2390 = new Array();
            this.var_2572 = false;
            this.var_2575 = "";
            this.var_2576 = false;
        }

        public function endActionAppends():void
        {
            if (this.sortActions())
            {
                this.resetActions();
                this.setActionsToParts();
            };
        }

        public function appendAction(param1:String, ... _args):Boolean
        {
            var _loc3_:String;
            var _loc4_:ActionDefinition;
            this.var_2572 = false;
            if (((!(_args == null)) && (_args.length > 0)))
            {
                _loc3_ = _args[0];
            };
            switch (param1)
            {
                case AvatarAction.var_971:
                    switch (_loc3_)
                    {
                        case AvatarAction.var_947:
                            if (this.var_979 == 0)
                            {
                                this.setDirection(AvatarSetType.var_136, 4);
                            }
                            else
                            {
                                this.setDirection(AvatarSetType.var_136, 2);
                            };
                        case AvatarAction.var_948:
                            this.var_2576 = true;
                        case AvatarAction.var_944:
                            this.var_2576 = true;
                        case AvatarAction.var_982:
                        case AvatarAction.var_976:
                        case AvatarAction.var_949:
                        case AvatarAction.var_960:
                            this.addActionData(_loc3_);
                            break;
                        default:
                            this.errorThis(("appendAction() >> UNKNOWN POSTURE TYPE: " + _loc3_));
                    };
                    break;
                case AvatarAction.var_972:
                    switch (_loc3_)
                    {
                        case AvatarAction.var_961:
                        case AvatarAction.var_962:
                        case AvatarAction.var_963:
                        case AvatarAction.var_964:
                            this.addActionData(_loc3_);
                            break;
                        default:
                            this.errorThis(("appendAction() >> UNKNOWN GESTURE TYPE: " + _loc3_));
                    };
                    break;
                case AvatarAction.var_974:
                    if (((((((_loc3_ == "33") || (_loc3_ == "34")) || (_loc3_ == "35")) || (_loc3_ == "36")) || (_loc3_ == "38")) || (_loc3_ == "39")))
                    {
                        this.var_2576 = true;
                    };
                case AvatarAction.DANCE:
                case AvatarAction.var_973:
                case AvatarAction.WAVE:
                case AvatarAction.var_975:
                case AvatarAction.var_983:
                    this.addActionData(param1, _loc3_);
                    break;
                case AvatarAction.var_984:
                case AvatarAction.var_985:
                    _loc4_ = this._structure.getActionDefinitionWithState(param1);
                    if (_loc4_ != null)
                    {
                        this.logThis(("appendAction:" + [_loc3_, "->", _loc4_.getParameterValue(_loc3_)]));
                        _loc3_ = _loc4_.getParameterValue(_loc3_);
                    };
                    this.addActionData(param1, _loc3_);
                    break;
                default:
                    this.errorThis(("appendAction() >> UNKNOWN ACTION TYPE: " + param1));
            };
            return (true);
        }

        protected function addActionData(param1:String, param2:String=""):void
        {
            var _loc3_:ActiveActionData;
            if (this.var_2390 == null)
            {
                this.var_2390 = new Array();
            };
            var _loc4_:int;
            while (_loc4_ < this.var_2390.length)
            {
                _loc3_ = this.var_2390[_loc4_];
                if (((_loc3_.actionType == param1) && (_loc3_.actionParameter == param2)))
                {
                    return;
                };
                _loc4_++;
            };
            this.var_2390.push(new ActiveActionData(param1, param2, this.var_2408));
        }

        public function isAnimating():Boolean
        {
            return (this.var_2571);
        }

        private function resetActions():Boolean
        {
            this.var_2571 = false;
            this.var_2570 = [];
            this.var_2568 = null;
            this.var_2407 = 0;
            this._structure.removeDynamicItems();
            this.var_977 = this.var_2392;
            this.var_977.definition = this.var_2392.definition;
            this.resetBodyPartCache(this.var_2392);
            return (true);
        }

        private function isHeadTurnPreventedByAction():Boolean
        {
            var _loc2_:IActionDefinition;
            var _loc3_:ActiveActionData;
            var _loc1_:Boolean;
            if (this.var_2573 == null)
            {
                return (false);
            };
            for each (_loc3_ in this.var_2573)
            {
                _loc2_ = this._structure.getActionDefinitionWithState(_loc3_.actionType);
                if (((!(_loc2_ == null)) && (_loc2_.getPreventHeadTurn(_loc3_.actionParameter))))
                {
                    _loc1_ = true;
                };
            };
            return (_loc1_);
        }

        private function sortActions():Boolean
        {
            var _loc2_:Boolean;
            var _loc3_:Boolean;
            var _loc4_:ActiveActionData;
            var _loc5_:int;
            var _loc6_:AvatarImageCache;
            var _loc1_:Boolean;
            this.var_2575 = "";
            this.var_2573 = this._structure.sortActions(this.var_2390);
            if (this.var_2573 == null)
            {
                this.var_2383 = new Array(0, 0, 0);
                if (this.var_2574 != "")
                {
                    _loc1_ = true;
                    this.var_2574 = "";
                };
            }
            else
            {
                this.var_2383 = this._structure.getCanvasOffsets(this.var_2573, this._scale, this.var_979);
                for each (_loc4_ in this.var_2573)
                {
                    this.var_2575 = (this.var_2575 + (_loc4_.actionType + _loc4_.actionParameter));
                    if (_loc4_.actionType == AvatarAction.var_974)
                    {
                        _loc5_ = parseInt(_loc4_.actionParameter);
                        if (this.var_2577 != _loc5_)
                        {
                            _loc2_ = true;
                        };
                        this.var_2577 = _loc5_;
                        _loc3_ = true;
                    };
                };
                if (!_loc3_)
                {
                    if (this.var_2577 > -1)
                    {
                        _loc2_ = true;
                    };
                    this.var_2577 = -1;
                };
                if (_loc2_)
                {
                    _loc6_ = this.getCache();
                    if (_loc6_)
                    {
                        _loc6_.disposeInactiveActions(0);
                    };
                };
                if (this.var_2574 != this.var_2575)
                {
                    _loc1_ = true;
                    this.var_2574 = this.var_2575;
                };
            };
            this.var_2572 = true;
            return (_loc1_);
        }

        private function setActionsToParts():void
        {
            var _loc1_:ActiveActionData;
            var _loc2_:Animation;
            var _loc5_:Array;
            var _loc6_:String;
            if (this.var_2573 == null)
            {
                return;
            };
            var _loc3_:int = getTimer();
            var _loc4_:Array = new Array();
            for each (_loc1_ in this.var_2573)
            {
                _loc4_.push(_loc1_.actionType);
            };
            for each (_loc1_ in this.var_2573)
            {
                if ((((_loc1_) && (_loc1_.definition)) && (_loc1_.definition.isAnimation)))
                {
                    _loc2_ = this._structure.getAnimation(((_loc1_.definition.state + ".") + _loc1_.actionParameter));
                    if (((_loc2_) && (_loc2_.hasOverriddenActions())))
                    {
                        _loc5_ = _loc2_.overriddenActionNames();
                        if (_loc5_)
                        {
                            for each (_loc6_ in _loc5_)
                            {
                                if (_loc4_.indexOf(_loc6_) >= 0)
                                {
                                    _loc1_.overridingAction = _loc2_.overridingAction(_loc6_);
                                };
                            };
                        };
                    };
                };
            };
            for each (_loc1_ in this.var_2573)
            {
                if (!((!(_loc1_)) || (!(_loc1_.definition))))
                {
                    if (((_loc1_.definition.isAnimation) && (_loc1_.actionParameter == "")))
                    {
                        _loc1_.actionParameter = "1";
                    };
                    this.setActionToParts(_loc1_, _loc3_);
                    if (_loc1_.definition.isAnimation)
                    {
                        this.var_2571 = _loc1_.definition.isAnimated(_loc1_.actionParameter);
                        _loc2_ = this._structure.getAnimation(((_loc1_.definition.state + ".") + _loc1_.actionParameter));
                        if (_loc2_ != null)
                        {
                            this.var_2570 = this.var_2570.concat(_loc2_.spriteData);
                            if (_loc2_.hasDirectionData())
                            {
                                this.var_2407 = _loc2_.directionData.offset;
                            };
                            if (_loc2_.hasAvatarData())
                            {
                                this.var_2568 = _loc2_.avatarData;
                            };
                        };
                    };
                    if ((((_loc1_.actionType == AvatarAction.var_973) || (_loc1_.actionType == AvatarAction.WAVE)) || (_loc1_.actionType == AvatarAction.var_976)))
                    {
                        this.var_2571 = true;
                    };
                };
            };
        }

        protected function getCache():AvatarImageCache
        {
            if (this.var_2422 == null)
            {
                this.var_2422 = new AvatarImageCache(this._structure, this, this._assets, this._scale);
            };
            return (this.var_2422);
        }

        private function setActionToParts(param1:IActiveActionData, param2:int):void
        {
            if (((param1 == null) || (param1.definition == null)))
            {
                return;
            };
            if (param1.definition.assetPartDefinition == "")
            {
                return;
            };
            if (param1.definition.isMain)
            {
                this.var_977 = param1;
                this.getCache().setGeometryType(param1.definition.geometryType);
            };
            this.getCache().setAction(param1, param2);
            this.var_2569 = true;
        }

        private function resetBodyPartCache(param1:IActiveActionData):void
        {
            if (param1 == null)
            {
                return;
            };
            if (param1.definition.assetPartDefinition == "")
            {
                return;
            };
            if (param1.definition.isMain)
            {
                this.var_977 = param1;
                this.getCache().setGeometryType(param1.definition.geometryType);
            };
            this.getCache().resetBodyPartCache(param1);
            this.var_2569 = true;
        }

        public function get avatarSpriteData():IAvatarDataContainer
        {
            return (this.var_2568);
        }

        private function convertToGrayscale(param1:BitmapData, param2:String="CHANNELS_EQUAL"):BitmapData
        {
            var _loc3_:Number = 0.33;
            var _loc4_:Number = 0.33;
            var _loc5_:Number = 0.33;
            var _loc6_:Number = 1;
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
            };
            var _loc7_:Array = [_loc3_, _loc4_, _loc5_, 0, 0, _loc3_, _loc4_, _loc5_, 0, 0, _loc3_, _loc4_, _loc5_, 0, 0, 0, 0, 0, 1, 0];
            var _loc8_:ColorMatrixFilter = new ColorMatrixFilter(_loc7_);
            var _loc9_:BitmapData = new BitmapData(param1.width, param1.height, param1.transparent, 0xFFFFFFFF);
            _loc9_.copyPixels(param1, param1.rect, new Point(0, 0), null, null, false);
            _loc9_.applyFilter(_loc9_, _loc9_.rect, new Point(0, 0), _loc8_);
            return (_loc9_);
        }

        private function errorThis(param1:String):void
        {
            Logger.log(("[AvatarImageError] " + param1));
        }

        private function logThis(param1:String):void
        {
        }

        public function getSubType():int
        {
            return (-1);
        }

        public function get petType():int
        {
            return (-1);
        }

        public function get petBreed():int
        {
            return (-1);
        }

        public function isPlaceholder():Boolean
        {
            return (false);
        }

    }
}