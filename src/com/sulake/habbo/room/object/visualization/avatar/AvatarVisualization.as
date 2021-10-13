package com.sulake.habbo.room.object.visualization.avatar
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import flash.display.BlendMode;
    import com.sulake.habbo.avatar.enum.AvatarAction;

    public class AvatarVisualization extends RoomObjectSpriteVisualization implements IAvatarImageListener 
    {

        private static const var_1514:String = "avatar";
        private static const var_1513:Number = -0.01;
        private static const var_1512:Number = -0.409;
        private static const var_1508:int = 2;
        private static const var_1509:Array = [0, 0, 0];
        private static const var_1511:int = 3;

        private const var_4010:int = 0;
        private const var_4011:int = 1;
        private const var_4012:int = 2;
        private const var_4013:int = 3;
        private const var_4014:int = 4;

        private var var_4000:AvatarVisualizationData = null;
        private var var_4001:Map;
        private var var_4002:Map;
        private var var_4003:int = 0;
        private var var_2571:Boolean;
        private var var_2534:String;
        private var var_2071:String;
        private var var_4004:int = 0;
        private var var_4005:BitmapDataAsset;
        private var var_4006:BitmapDataAsset;
        private var var_4007:int = -1;
        private var var_4008:int = -1;
        private var var_4009:int = -1;
        private var var_4015:int = -1;
        private var var_4016:String = "";
        private var _postureParameter:String = "";
        private var var_4017:Boolean = false;
        private var var_3291:Boolean = false;
        private var var_3949:Boolean = false;
        private var var_4018:Boolean = false;
        private var var_3296:Boolean = false;
        private var var_3293:int = 0;
        private var var_3289:int = 0;
        private var var_3948:int = 0;
        private var var_4019:int = 0;
        private var var_4020:int = 0;
        private var var_4021:int = 0;
        private var var_4022:int = 0;
        private var var_4023:Boolean = false;
        private var var_4024:Boolean = false;
        private var var_4025:int = 0;
        private var var_4026:int = 0;
        private var var_4027:Boolean = false;
        private var var_4028:int = 0;
        private var var_4029:IAvatarImage = null;
        private var var_978:Boolean;

        public function AvatarVisualization()
        {
            this.var_4001 = new Map();
            this.var_4002 = new Map();
            this.var_2571 = false;
        }

        override public function dispose():void
        {
            if (this.var_4001 != null)
            {
                this.resetImages();
                this.var_4001.dispose();
                this.var_4002.dispose();
                this.var_4001 = null;
            };
            this.var_4000 = null;
            this.var_4005 = null;
            this.var_4006 = null;
            super.dispose();
            this.var_978 = true;
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        override public function initialize(param1:IRoomObjectVisualizationData):Boolean
        {
            this.var_4000 = (param1 as AvatarVisualizationData);
            createSprites(this.var_4014);
            return (true);
        }

        private function updateModel(param1:IRoomObjectModel, param2:Number, param3:Boolean):Boolean
        {
            var _loc4_:Boolean;
            var _loc5_:Boolean;
            var _loc6_:int;
            var _loc7_:String;
            var _loc8_:String;
            if (param1.getUpdateID() != var_1460)
            {
                _loc4_ = false;
                _loc5_ = false;
                _loc6_ = 0;
                _loc7_ = "";
                _loc5_ = ((param1.getNumber(RoomObjectVariableEnum.var_720) > 0) && (param3));
                if (_loc5_ != this.var_4017)
                {
                    this.var_4017 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = (param1.getNumber(RoomObjectVariableEnum.var_721) > 0);
                if (_loc5_ != this.var_3291)
                {
                    this.var_3291 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = (param1.getNumber(RoomObjectVariableEnum.var_722) > 0);
                if (_loc5_ != this.var_3949)
                {
                    this.var_3949 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = ((param1.getNumber(RoomObjectVariableEnum.var_723) > 0) && (param3));
                if (_loc5_ != this.var_4018)
                {
                    this.var_4018 = _loc5_;
                    _loc4_ = true;
                };
                _loc5_ = (param1.getNumber(RoomObjectVariableEnum.var_734) > 0);
                if (_loc5_ != this.var_3296)
                {
                    this.var_3296 = _loc5_;
                    _loc4_ = true;
                    this.updateTypingBubble(param2);
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_727);
                if (_loc6_ != this.var_3293)
                {
                    this.var_3293 = _loc6_;
                    _loc4_ = true;
                };
                _loc7_ = param1.getString(RoomObjectVariableEnum.var_728);
                if (_loc7_ != this.var_4016)
                {
                    this.var_4016 = _loc7_;
                    _loc4_ = true;
                };
                _loc7_ = param1.getString(RoomObjectVariableEnum.var_729);
                if (_loc7_ != this._postureParameter)
                {
                    this._postureParameter = _loc7_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.set);
                if (_loc6_ != this.var_3289)
                {
                    this.var_3289 = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_724);
                if (_loc6_ != this.var_4019)
                {
                    this.var_4019 = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_725);
                if (_loc6_ != this.var_4020)
                {
                    this.var_4020 = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_726);
                if (_loc6_ != this.var_4021)
                {
                    this.var_4021 = _loc6_;
                    _loc4_ = true;
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_495);
                if (_loc6_ != this.var_4007)
                {
                    this.var_4007 = _loc6_;
                    _loc4_ = true;
                };
                if (((this.var_4020 > 0) && (param1.getNumber(RoomObjectVariableEnum.var_726) > 0)))
                {
                    if (this.var_4021 != this.var_4020)
                    {
                        this.var_4021 = this.var_4020;
                        _loc4_ = true;
                    };
                }
                else
                {
                    if (this.var_4021 != 0)
                    {
                        this.var_4021 = 0;
                        _loc4_ = true;
                    };
                };
                _loc6_ = param1.getNumber(RoomObjectVariableEnum.var_737);
                if (_loc6_ != this.var_4025)
                {
                    this.var_4025 = _loc6_;
                    _loc4_ = true;
                    this.updateNumberBubble(param2);
                };
                this.validateActions(param2);
                _loc7_ = param1.getString(RoomObjectVariableEnum.var_719);
                if (_loc7_ != this.var_2071)
                {
                    this.var_2071 = _loc7_;
                    _loc4_ = true;
                };
                _loc8_ = param1.getString(RoomObjectVariableEnum.var_497);
                if (this.updateFigure(_loc8_))
                {
                    _loc4_ = true;
                };
                var_1460 = param1.getUpdateID();
                return (_loc4_);
            };
            return (false);
        }

        private function updateFigure(param1:String):Boolean
        {
            if (this.var_2534 != param1)
            {
                this.var_2534 = param1;
                this.resetImages();
                return (true);
            };
            return (false);
        }

        private function resetImages():void
        {
            var _loc1_:IAvatarImage;
            var _loc2_:IRoomObjectSprite;
            for each (_loc1_ in this.var_4001)
            {
                if (_loc1_)
                {
                    _loc1_.dispose();
                };
            };
            for each (_loc1_ in this.var_4002)
            {
                if (_loc1_)
                {
                    _loc1_.dispose();
                };
            };
            this.var_4001.reset();
            this.var_4002.reset();
            this.var_4029 = null;
            _loc2_ = getSprite(this.var_4010);
            if (_loc2_ != null)
            {
                _loc2_.asset = null;
                _loc2_.alpha = 0xFF;
            };
        }

        private function validateActions(param1:Number):void
        {
            var _loc2_:int;
            if (param1 < 48)
            {
                this.var_4018 = false;
            };
            if (((this.var_4016 == "sit") || (this.var_4016 == "lay")))
            {
                this.var_4022 = (param1 / 2);
            }
            else
            {
                this.var_4022 = 0;
            };
            this.var_4024 = false;
            this.var_4023 = false;
            if (this.var_4016 == "lay")
            {
                this.var_4023 = true;
                _loc2_ = int(this._postureParameter);
                if (_loc2_ < 0)
                {
                    this.var_4024 = true;
                };
            };
        }

        private function getAvatarImage(param1:Number, param2:int):IAvatarImage
        {
            var _loc3_:IAvatarImage;
            var _loc4_:String = ("avatarImage" + param1.toString());
            if (param2 == 0)
            {
                _loc3_ = (this.var_4001.getValue(_loc4_) as IAvatarImage);
            }
            else
            {
                _loc4_ = (_loc4_ + ("-" + param2));
                _loc3_ = (this.var_4002.getValue(_loc4_) as IAvatarImage);
            };
            if (_loc3_ == null)
            {
                _loc3_ = this.var_4000.getAvatar(this.var_2534, param1, this.var_2071, this);
                if (_loc3_ != null)
                {
                    if (param2 == 0)
                    {
                        this.var_4001.add(_loc4_, _loc3_);
                    }
                    else
                    {
                        if (this.var_4002.length >= var_1511)
                        {
                            this.var_4002.remove(this.var_4002.getKeys().shift());
                        };
                        this.var_4002.add(_loc4_, _loc3_);
                    };
                };
            };
            return (_loc3_);
        }

        private function updateObject(param1:IRoomObject, param2:IRoomGeometry, param3:Boolean, param4:Boolean=false):Boolean
        {
            var _loc5_:Boolean;
            var _loc6_:int;
            var _loc7_:int;
            if ((((param4) || (!(var_1458 == param1.getUpdateID()))) || (!(this.var_4015 == param2.updateId))))
            {
                _loc5_ = param3;
                _loc6_ = (param1.getDirection().x - param2.direction.x);
                _loc6_ = (((_loc6_ % 360) + 360) % 360);
                _loc7_ = this.var_4007;
                if (this.var_4016 == "float")
                {
                    _loc7_ = _loc6_;
                }
                else
                {
                    _loc7_ = (_loc7_ - param2.direction.x);
                };
                _loc7_ = (((_loc7_ % 360) + 360) % 360);
                if (((!(_loc6_ == this.var_4008)) || (param4)))
                {
                    _loc5_ = true;
                    this.var_4008 = _loc6_;
                    _loc6_ = (_loc6_ - (135 - 22.5));
                    _loc6_ = ((_loc6_ + 360) % 360);
                    this.var_4029.setDirectionAngle(AvatarSetType.var_136, _loc6_);
                };
                if (((!(_loc7_ == this.var_4009)) || (param4)))
                {
                    _loc5_ = true;
                    this.var_4009 = _loc7_;
                    if (this.var_4009 != this.var_4008)
                    {
                        _loc7_ = (_loc7_ - (135 - 22.5));
                        _loc7_ = ((_loc7_ + 360) % 360);
                        this.var_4029.setDirectionAngle(AvatarSetType.var_107, _loc7_);
                    };
                };
                var_1458 = param1.getUpdateID();
                this.var_4015 = param2.updateId;
                return (_loc5_);
            };
            return (false);
        }

        private function updateShadow(param1:Number):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc2_:IRoomObjectSprite = getSprite(this.var_4011);
            this.var_4005 = null;
            if (((this.var_4016 == "mv") || (this.var_4016 == "std")))
            {
                _loc2_.visible = true;
                if (((this.var_4005 == null) || (!(param1 == var_1459))))
                {
                    _loc3_ = 0;
                    _loc4_ = 0;
                    if (param1 < 48)
                    {
                        this.var_4005 = this.var_4029.getAsset("sh_std_sd_1_0_0");
                        _loc3_ = -8;
                        _loc4_ = -3;
                    }
                    else
                    {
                        this.var_4005 = this.var_4029.getAsset("h_std_sd_1_0_0");
                        _loc3_ = -17;
                        _loc4_ = -7;
                    };
                    if (this.var_4005 != null)
                    {
                        _loc2_.asset = (this.var_4005.content as BitmapData);
                        _loc2_.offsetX = _loc3_;
                        _loc2_.offsetY = _loc4_;
                        _loc2_.alpha = 50;
                        _loc2_.relativeDepth = 1;
                    }
                    else
                    {
                        _loc2_.visible = false;
                    };
                };
            }
            else
            {
                this.var_4005 = null;
                _loc2_.visible = false;
            };
        }

        private function updateTypingBubble(param1:Number):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            this.var_4006 = null;
            var _loc2_:IRoomObjectSprite = getSprite(this.var_4012);
            if (this.var_3296)
            {
                _loc2_.visible = true;
                _loc5_ = 64;
                if (param1 < 48)
                {
                    this.var_4006 = (this.var_4000.getAvatarRendererAsset("user_typing_small_png") as BitmapDataAsset);
                    _loc3_ = 3;
                    _loc4_ = -42;
                    _loc5_ = 32;
                }
                else
                {
                    this.var_4006 = (this.var_4000.getAvatarRendererAsset("user_typing_png") as BitmapDataAsset);
                    _loc3_ = 14;
                    _loc4_ = -83;
                };
                if (this.var_4016 == "sit")
                {
                    _loc4_ = int((_loc4_ + (_loc5_ / 2)));
                }
                else
                {
                    if (this.var_4016 == "lay")
                    {
                        _loc4_ = (_loc4_ + _loc5_);
                    };
                };
                if (this.var_4006 != null)
                {
                    _loc2_.asset = (this.var_4006.content as BitmapData);
                    _loc2_.offsetX = _loc3_;
                    _loc2_.offsetY = _loc4_;
                    _loc2_.relativeDepth = (-0.02 + 0);
                };
            }
            else
            {
                _loc2_.visible = false;
            };
        }

        private function updateNumberBubble(param1:Number):void
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc2_:BitmapDataAsset;
            var _loc3_:IRoomObjectSprite = getSprite(this.var_4013);
            if (this.var_4025 > 0)
            {
                _loc6_ = 64;
                if (param1 < 48)
                {
                    _loc2_ = (this.var_4000.getAvatarRendererAsset((("number_" + this.var_4025) + "_small_png")) as BitmapDataAsset);
                    _loc4_ = -6;
                    _loc5_ = -52;
                    _loc6_ = 32;
                }
                else
                {
                    _loc2_ = (this.var_4000.getAvatarRendererAsset((("number_" + this.var_4025) + "_png")) as BitmapDataAsset);
                    _loc4_ = -8;
                    _loc5_ = -105;
                };
                if (this.var_4016 == "sit")
                {
                    _loc5_ = int((_loc5_ + (_loc6_ / 2)));
                }
                else
                {
                    if (this.var_4016 == "lay")
                    {
                        _loc5_ = (_loc5_ + _loc6_);
                    };
                };
                if (_loc2_ != null)
                {
                    _loc3_.visible = true;
                    _loc3_.asset = (_loc2_.content as BitmapData);
                    _loc3_.offsetX = _loc4_;
                    _loc3_.offsetY = _loc5_;
                    _loc3_.relativeDepth = -0.01;
                    this.var_4026 = 1;
                    this.var_4027 = true;
                    this.var_4028 = 0;
                    _loc3_.alpha = 0;
                }
                else
                {
                    _loc3_.visible = false;
                };
            }
            else
            {
                if (_loc3_.visible)
                {
                    this.var_4026 = -1;
                };
            };
        }

        private function animateNumberBubble(param1:int):Boolean
        {
            var _loc5_:int;
            var _loc2_:IRoomObjectSprite = getSprite(this.var_4013);
            var _loc3_:int = _loc2_.alpha;
            var _loc4_:Boolean;
            if (this.var_4027)
            {
                this.var_4028++;
                if (this.var_4028 < 10)
                {
                    return (false);
                };
                if (this.var_4026 < 0)
                {
                    if (param1 < 48)
                    {
                        _loc2_.offsetY = (_loc2_.offsetY - 2);
                    }
                    else
                    {
                        _loc2_.offsetY = (_loc2_.offsetY - 4);
                    };
                }
                else
                {
                    _loc5_ = 4;
                    if (param1 < 48)
                    {
                        _loc5_ = 8;
                    };
                    if ((this.var_4028 % _loc5_) == 0)
                    {
                        _loc2_.offsetY--;
                        _loc4_ = true;
                    };
                };
            };
            if (this.var_4026 > 0)
            {
                if (_loc3_ < 0xFF)
                {
                    _loc3_ = (_loc3_ + 32);
                };
                if (_loc3_ >= 0xFF)
                {
                    _loc3_ = 0xFF;
                    this.var_4026 = 0;
                };
                _loc2_.alpha = _loc3_;
                return (true);
            };
            if (this.var_4026 < 0)
            {
                if (_loc3_ >= 0)
                {
                    _loc3_ = (_loc3_ - 32);
                };
                if (_loc3_ <= 0)
                {
                    this.var_4026 = 0;
                    this.var_4027 = false;
                    _loc3_ = 0;
                    _loc2_.visible = false;
                };
                _loc2_.alpha = _loc3_;
                return (true);
            };
            return (_loc4_);
        }

        override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
            var _loc16_:IRoomObjectSprite;
            var _loc17_:IRoomObjectSprite;
            var _loc18_:Array;
            var _loc19_:int;
            var _loc20_:ISpriteDataContainer;
            var _loc21_:BitmapData;
            var _loc22_:IAnimationLayerData;
            var _loc23_:int;
            var _loc24_:int;
            var _loc25_:IAnimationLayerData;
            var _loc26_:int;
            var _loc27_:int;
            var _loc28_:int;
            var _loc29_:int;
            var _loc30_:int;
            var _loc31_:String;
            var _loc32_:BitmapDataAsset;
            var _loc5_:IRoomObject = object;
            if (_loc5_ == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            if (this.var_4000 == null)
            {
                return;
            };
            var _loc6_:IRoomObjectModel = _loc5_.getModel();
            var _loc7_:Number = param1.scale;
            var _loc8_:Boolean;
            var _loc9_:Boolean;
            var _loc10_:Boolean;
            var _loc11_:int = this.var_4019;
            var _loc12_:Boolean;
            var _loc13_:Boolean = this.updateModel(_loc6_, _loc7_, param3);
            if (this.animateNumberBubble(_loc7_))
            {
                increaseUpdateId();
            };
            if ((((_loc13_) || (!(_loc7_ == var_1459))) || (this.var_4029 == null)))
            {
                if (_loc7_ != var_1459)
                {
                    _loc9_ = true;
                    this.validateActions(_loc7_);
                };
                if (_loc11_ != this.var_4019)
                {
                    _loc12_ = true;
                };
                if ((((_loc9_) || (this.var_4029 == null)) || (_loc12_)))
                {
                    this.var_4029 = this.getAvatarImage(_loc7_, this.var_4019);
                    if (this.var_4029 == null)
                    {
                        return;
                    };
                    _loc8_ = true;
                    _loc16_ = getSprite(this.var_4010);
                    if ((((_loc16_) && (this.var_4029)) && (this.var_4029.isPlaceholder())))
                    {
                        _loc16_.alpha = 150;
                    }
                    else
                    {
                        if (_loc16_)
                        {
                            _loc16_.alpha = 0xFF;
                        };
                    };
                };
                if (this.var_4029 == null)
                {
                    return;
                };
                this.updateShadow(_loc7_);
                if (_loc9_)
                {
                    this.updateTypingBubble(_loc7_);
                    this.updateNumberBubble(_loc7_);
                };
                _loc10_ = this.updateObject(_loc5_, param1, param3, true);
                this.updateActions(this.var_4029);
                var_1459 = _loc7_;
            }
            else
            {
                _loc10_ = this.updateObject(_loc5_, param1, param3);
            };
            var _loc14_:Boolean = (((_loc10_) || (_loc13_)) || (_loc9_));
            var _loc15_:Boolean = (((this.var_2571) || (this.var_4004 > 0)) && (param3));
            if (_loc14_)
            {
                this.var_4004 = var_1508;
            };
            if (((_loc14_) || (_loc15_)))
            {
                increaseUpdateId();
                this.var_4004--;
                this.var_4003--;
                if (((((this.var_4003 <= 0) || (_loc9_)) || (_loc13_)) || (_loc8_)))
                {
                    this.var_4029.updateAnimationByFrames(1);
                    this.var_4003 = var_1508;
                }
                else
                {
                    return;
                };
                _loc18_ = this.var_4029.getCanvasOffsets();
                if (((_loc18_ == null) || (_loc18_.length < 3)))
                {
                    _loc18_ = var_1509;
                };
                _loc17_ = getSprite(this.var_4010);
                if (_loc17_ != null)
                {
                    _loc21_ = this.var_4029.getImage(AvatarSetType.var_136, false);
                    if (_loc21_ != null)
                    {
                        _loc17_.asset = _loc21_;
                    };
                    if (_loc17_.asset)
                    {
                        _loc17_.offsetX = (((-1 * _loc7_) / 2) + _loc18_[0]);
                        _loc17_.offsetY = (((-(_loc17_.asset.height) + (_loc7_ / 4)) + _loc18_[1]) + this.var_4022);
                    };
                    if (this.var_4023)
                    {
                        if (this.var_4024)
                        {
                            _loc17_.relativeDepth = -0.5;
                        }
                        else
                        {
                            _loc17_.relativeDepth = (var_1512 + _loc18_[2]);
                        };
                    }
                    else
                    {
                        _loc17_.relativeDepth = (var_1513 + _loc18_[2]);
                    };
                };
                _loc17_ = getSprite(this.var_4012);
                if (((!(_loc17_ == null)) && (_loc17_.visible)))
                {
                    if (!this.var_4023)
                    {
                        _loc17_.relativeDepth = ((var_1513 - 0.01) + _loc18_[2]);
                    }
                    else
                    {
                        _loc17_.relativeDepth = ((var_1512 - 0.01) + _loc18_[2]);
                    };
                };
                this.var_2571 = this.var_4029.isAnimating();
                _loc19_ = this.var_4014;
                for each (_loc20_ in this.var_4029.getSprites())
                {
                    if (_loc20_.id == var_1514)
                    {
                        _loc17_ = getSprite(this.var_4010);
                        _loc22_ = this.var_4029.getLayerData(_loc20_);
                        _loc23_ = _loc20_.getDirectionOffsetX(this.var_4029.getDirection());
                        _loc24_ = _loc20_.getDirectionOffsetY(this.var_4029.getDirection());
                        if (_loc22_ != null)
                        {
                            _loc23_ = (_loc23_ + _loc22_.dx);
                            _loc24_ = (_loc24_ + _loc22_.dy);
                        };
                        if (_loc7_ < 48)
                        {
                            _loc23_ = int((_loc23_ / 2));
                            _loc24_ = int((_loc24_ / 2));
                        };
                        _loc17_.offsetX = (_loc17_.offsetX + _loc23_);
                        _loc17_.offsetY = (_loc17_.offsetY + _loc24_);
                    }
                    else
                    {
                        _loc17_ = getSprite(_loc19_);
                        if (_loc17_ != null)
                        {
                            _loc17_.capturesMouse = false;
                            _loc17_.visible = true;
                            _loc25_ = this.var_4029.getLayerData(_loc20_);
                            _loc26_ = 0;
                            _loc27_ = _loc20_.getDirectionOffsetX(this.var_4029.getDirection());
                            _loc28_ = _loc20_.getDirectionOffsetY(this.var_4029.getDirection());
                            _loc29_ = _loc20_.getDirectionOffsetZ(this.var_4029.getDirection());
                            _loc30_ = 0;
                            if (_loc20_.hasDirections)
                            {
                                _loc30_ = this.var_4029.getDirection();
                            };
                            if (_loc25_ != null)
                            {
                                _loc26_ = _loc25_.animationFrame;
                                _loc27_ = (_loc27_ + _loc25_.dx);
                                _loc28_ = (_loc28_ + _loc25_.dy);
                                _loc30_ = (_loc30_ + _loc25_.directionOffset);
                            };
                            if (_loc7_ < 48)
                            {
                                _loc27_ = int((_loc27_ / 2));
                                _loc28_ = int((_loc28_ / 2));
                            };
                            if (_loc30_ < 0)
                            {
                                _loc30_ = (_loc30_ + 8);
                            }
                            else
                            {
                                if (_loc30_ > 7)
                                {
                                    _loc30_ = (_loc30_ - 8);
                                };
                            };
                            _loc31_ = ((((((this.var_4029.getScale() + "_") + _loc20_.member) + "_") + _loc30_) + "_") + _loc26_);
                            _loc32_ = this.var_4029.getAsset(_loc31_);
                            if (_loc32_ == null) continue;
                            _loc17_.asset = (_loc32_.content as BitmapData);
                            _loc17_.offsetX = ((-(_loc32_.offset.x) - (_loc7_ / 2)) + _loc27_);
                            _loc17_.offsetY = ((-(_loc32_.offset.y) + _loc28_) + this.var_4022);
                            if (this.var_4023)
                            {
                                _loc17_.relativeDepth = (var_1512 - ((0.001 * spriteCount) * _loc29_));
                            }
                            else
                            {
                                _loc17_.relativeDepth = (var_1513 - ((0.001 * spriteCount) * _loc29_));
                            };
                            if (_loc20_.ink == 33)
                            {
                                _loc17_.blendMode = BlendMode.ADD;
                            }
                            else
                            {
                                _loc17_.blendMode = BlendMode.NORMAL;
                            };
                        };
                        _loc19_++;
                    };
                };
            };
        }

        private function updateActions(param1:IAvatarImage):void
        {
            var _loc3_:ISpriteDataContainer;
            if (param1 == null)
            {
                return;
            };
            param1.initActionAppends();
            param1.appendAction(AvatarAction.var_971, this.var_4016, this._postureParameter);
            if (this.var_3293 > 0)
            {
                param1.appendAction(AvatarAction.var_972, AvatarAction.var_1515[this.var_3293]);
            };
            if (this.var_3289 > 0)
            {
                param1.appendAction(AvatarAction.DANCE, this.var_3289);
            };
            if (this.var_3948 > 0)
            {
                param1.appendAction(AvatarAction.var_983, this.var_3948);
            };
            if (this.var_4020 > 0)
            {
                param1.appendAction(AvatarAction.var_984, this.var_4020);
            };
            if (this.var_4021 > 0)
            {
                param1.appendAction(AvatarAction.var_985, this.var_4021);
            };
            if (this.var_4017)
            {
                param1.appendAction(AvatarAction.var_973);
            };
            if (((this.var_3949) || (this.var_4018)))
            {
                param1.appendAction(AvatarAction.var_975);
            };
            if (this.var_3291)
            {
                param1.appendAction(AvatarAction.WAVE);
            };
            if (this.var_4019 > 0)
            {
                param1.appendAction(AvatarAction.var_974, this.var_4019);
            };
            param1.endActionAppends();
            this.var_2571 = param1.isAnimating();
            var _loc2_:int = this.var_4014;
            for each (_loc3_ in this.var_4029.getSprites())
            {
                if (_loc3_.id != var_1514)
                {
                    _loc2_++;
                };
            };
            if (_loc2_ != spriteCount)
            {
                createSprites(_loc2_);
            };
        }

        public function avatarImageReady(param1:String):void
        {
            this.resetImages();
        }

    }
}