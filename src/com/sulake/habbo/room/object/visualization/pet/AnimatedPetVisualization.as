package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.habbo.room.object.visualization.data.AnimationData;
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.habbo.room.object.visualization.data.LayerData;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.data.DirectionData;

    public class AnimatedPetVisualization extends AnimatedFurnitureVisualization 
    {

        private static const var_1468:String = "head";
        private static const var_1467:int = 1;
        private static const var_1464:int = 1000;
        private static const var_1463:String = "pet_experience_bubble_png";
        private static const var_1465:int = 0;
        private static const var_1466:int = 1;
        private static const ANIMATION_INDEX_COUNT:int = 2;

        private var var_4016:String = "";
        private var var_3293:String = "";
        private var var_3949:Boolean = false;
        private var var_2567:int = 0;
        private var var_4169:ExperienceData;
        private var var_4170:int = 0;
        private var var_3324:int = 0;
        private var _animationData:AnimatedPetVisualizationData = null;
        private var var_4171:String = "";
        private var var_4172:int = -1;
        private var var_4168:Array = [];
        private var var_4050:Boolean = false;
        private var var_4173:Array = [];
        private var var_4174:int = -1;

        public function AnimatedPetVisualization()
        {
            while (this.var_4168.length < ANIMATION_INDEX_COUNT)
            {
                this.var_4168.push(new AnimationStateData());
            };
        }

        override public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:AnimationStateData;
            super.dispose();
            if (this.var_4168 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4168.length)
                {
                    _loc2_ = (this.var_4168[_loc1_] as AnimationStateData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_4168 = null;
            };
            if (this.var_4169)
            {
                this.var_4169.dispose();
                this.var_4169 = null;
            };
        }

        override protected function getAnimationId(param1:AnimationStateData):int
        {
            return (param1.animationId);
        }

        override public function initialize(param1:IRoomObjectVisualizationData):Boolean
        {
            var _loc3_:BitmapDataAsset;
            if (!(param1 is AnimatedPetVisualizationData))
            {
                return (false);
            };
            this._animationData = (param1 as AnimatedPetVisualizationData);
            var _loc2_:BitmapData;
            if (this._animationData.commonAssets != null)
            {
                _loc3_ = (this._animationData.commonAssets.getAssetByName(var_1463) as BitmapDataAsset);
                if (_loc3_ != null)
                {
                    _loc2_ = (_loc3_.content as BitmapData).clone();
                    this.var_4169 = new ExperienceData(_loc2_);
                };
            };
            if (super.initialize(param1))
            {
                return (true);
            };
            return (false);
        }

        override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean):void
        {
            super.update(param1, param2, param3, param4);
            this.updateExperienceBubble(param2);
        }

        override protected function updateAnimation(param1:Number):int
        {
            var _loc3_:int;
            var _loc2_:IRoomObject = object;
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.getDirection().x;
                if (_loc3_ != this.var_4174)
                {
                    this.var_4174 = _loc3_;
                    this.resetAllAnimationFrames();
                };
            };
            return (super.updateAnimation(param1));
        }

        override protected function updateModel(param1:Number):Boolean
        {
            var _loc4_:String;
            var _loc5_:String;
            var _loc6_:Number;
            var _loc7_:Number;
            var _loc8_:Number;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:int;
            var _loc2_:IRoomObject = object;
            if (_loc2_ == null)
            {
                return (false);
            };
            var _loc3_:IRoomObjectModel = _loc2_.getModel();
            if (_loc3_ == null)
            {
                return (false);
            };
            if (_loc3_.getUpdateID() != var_1460)
            {
                _loc4_ = _loc3_.getString(RoomObjectVariableEnum.var_728);
                _loc5_ = _loc3_.getString(RoomObjectVariableEnum.var_727);
                _loc6_ = _loc3_.getNumber(RoomObjectVariableEnum.var_728);
                if (!isNaN(_loc6_))
                {
                    _loc10_ = this._animationData.getPostureCount(var_1459);
                    if (_loc10_ > 0)
                    {
                        _loc4_ = this._animationData.getPostureForAnimation(var_1459, (_loc6_ % _loc10_));
                        _loc5_ = null;
                    };
                };
                _loc7_ = _loc3_.getNumber(RoomObjectVariableEnum.var_727);
                if (!isNaN(_loc7_))
                {
                    _loc11_ = this._animationData.getGestureCount(var_1459);
                    if (_loc11_ > 0)
                    {
                        _loc5_ = this._animationData.getGestureForAnimation(var_1459, (_loc7_ % _loc11_));
                    };
                };
                this.validateActions(_loc4_, _loc5_);
                this.var_3949 = (_loc3_.getNumber(RoomObjectVariableEnum.var_722) > 0);
                _loc8_ = _loc3_.getNumber(RoomObjectVariableEnum.var_495);
                if (!isNaN(_loc8_))
                {
                    this.var_2567 = _loc8_;
                }
                else
                {
                    this.var_2567 = direction;
                };
                this.var_4170 = _loc3_.getNumber(RoomObjectVariableEnum.AVATAR_EXPERIENCE_TIMESTAMP);
                this.var_3324 = _loc3_.getNumber(RoomObjectVariableEnum.var_736);
                _loc9_ = _loc3_.getNumber(RoomObjectVariableEnum.var_502);
                if (_loc9_ != this.var_4172)
                {
                    this.var_4172 = _loc9_;
                    this.var_4171 = this.var_4172.toString();
                };
                var_1460 = _loc3_.getUpdateID();
                return (true);
            };
            return (false);
        }

        private function updateExperienceBubble(param1:int):void
        {
            var _loc2_:int;
            var _loc3_:IRoomObjectSprite;
            if (this.var_4169 != null)
            {
                this.var_4169.alpha = 0;
                if (this.var_4170 > 0)
                {
                    _loc2_ = (param1 - this.var_4170);
                    if (_loc2_ < var_1464)
                    {
                        this.var_4169.alpha = int((Math.sin(((_loc2_ / var_1464) * Math.PI)) * 0xFF));
                        this.var_4169.setExperience(this.var_3324);
                    }
                    else
                    {
                        this.var_4170 = 0;
                    };
                    _loc3_ = getSprite((spriteCount - 1));
                    if (_loc3_ != null)
                    {
                        if (this.var_4169.alpha > 0)
                        {
                            _loc3_.asset = this.var_4169.image;
                            _loc3_.offsetX = -20;
                            _loc3_.offsetY = -80;
                            _loc3_.alpha = this.var_4169.alpha;
                            _loc3_.visible = true;
                        }
                        else
                        {
                            _loc3_.asset = null;
                            _loc3_.visible = false;
                        };
                    };
                };
            };
        }

        private function validateActions(param1:String, param2:String):void
        {
            var _loc3_:int;
            if (param1 != this.var_4016)
            {
                this.var_4016 = param1;
                _loc3_ = this._animationData.getAnimationForPosture(var_1459, param1);
                this.setAnimationForIndex(var_1465, _loc3_);
            };
            if (param2 != this.var_3293)
            {
                this.var_3293 = param2;
                _loc3_ = this._animationData.getAnimationForGesture(var_1459, param2);
                this.setAnimationForIndex(var_1466, _loc3_);
            };
        }

        override protected function updateLayerCount(param1:int):void
        {
            super.updateLayerCount(param1);
            this.var_4173 = [];
        }

        override protected function getAdditionalSpriteCount():int
        {
            return (super.getAdditionalSpriteCount() + var_1467);
        }

        override protected function setAnimation(param1:int):void
        {
        }

        private function getAnimationStateData(param1:int):AnimationStateData
        {
            var _loc2_:AnimationStateData;
            if (((param1 >= 0) && (param1 < this.var_4168.length)))
            {
                return (this.var_4168[param1]);
            };
            return (null);
        }

        private function setAnimationForIndex(param1:int, param2:int):void
        {
            var _loc3_:AnimationStateData = this.getAnimationStateData(param1);
            if (_loc3_ != null)
            {
                if (setSubAnimation(_loc3_, param2))
                {
                    this.var_4050 = false;
                };
            };
        }

        override protected function resetAllAnimationFrames():void
        {
            var _loc2_:AnimationStateData;
            this.var_4050 = false;
            var _loc1_:int = (this.var_4168.length - 1);
            while (_loc1_ >= 0)
            {
                _loc2_ = this.var_4168[_loc1_];
                if (_loc2_ != null)
                {
                    _loc2_.setLayerCount(layerCount);
                };
                _loc1_--;
            };
        }

        override protected function updateAnimations(param1:Number):int
        {
            var _loc5_:AnimationStateData;
            var _loc6_:int;
            if (this.var_4050)
            {
                return (0);
            };
            var _loc2_:Boolean = true;
            var _loc3_:int;
            var _loc4_:int;
            while (_loc4_ < this.var_4168.length)
            {
                _loc5_ = this.var_4168[_loc4_];
                if (_loc5_ != null)
                {
                    if (!_loc5_.animationOver)
                    {
                        _loc6_ = updateFramesForAnimation(_loc5_, param1);
                        _loc3_ = (_loc3_ | _loc6_);
                        if (!_loc5_.animationOver)
                        {
                            _loc2_ = false;
                        }
                        else
                        {
                            if (((AnimationData.isTransitionFromAnimation(_loc5_.animationId)) || (AnimationData.isTransitionToAnimation(_loc5_.animationId))))
                            {
                                this.setAnimationForIndex(_loc4_, _loc5_.animationAfterTransitionId);
                                _loc2_ = false;
                            };
                        };
                    };
                };
                _loc4_++;
            };
            this.var_4050 = _loc2_;
            return (_loc3_);
        }

        override protected function getFrameNumber(param1:int, param2:int):int
        {
            var _loc4_:AnimationStateData;
            var _loc5_:AnimationFrame;
            var _loc3_:int = (this.var_4168.length - 1);
            while (_loc3_ >= 0)
            {
                _loc4_ = this.var_4168[_loc3_];
                if (_loc4_ != null)
                {
                    _loc5_ = _loc4_.getFrame(param2);
                    if (_loc5_ != null)
                    {
                        return (_loc5_.id);
                    };
                };
                _loc3_--;
            };
            return (super.getFrameNumber(param1, param2));
        }

        override protected function getSpriteXOffset(param1:int, param2:int, param3:int):int
        {
            var _loc6_:AnimationStateData;
            var _loc7_:AnimationFrame;
            var _loc4_:int = super.getSpriteXOffset(param1, param2, param3);
            var _loc5_:int = (this.var_4168.length - 1);
            while (_loc5_ >= 0)
            {
                _loc6_ = this.var_4168[_loc5_];
                if (_loc6_ != null)
                {
                    _loc7_ = _loc6_.getFrame(param3);
                    if (_loc7_ != null)
                    {
                        _loc4_ = (_loc4_ + _loc7_.x);
                    };
                };
                _loc5_--;
            };
            return (_loc4_);
        }

        override protected function getSpriteYOffset(param1:int, param2:int, param3:int):int
        {
            var _loc6_:AnimationStateData;
            var _loc7_:AnimationFrame;
            var _loc4_:int = super.getSpriteYOffset(param1, param2, param3);
            var _loc5_:int = (this.var_4168.length - 1);
            while (_loc5_ >= 0)
            {
                _loc6_ = this.var_4168[_loc5_];
                if (_loc6_ != null)
                {
                    _loc7_ = _loc6_.getFrame(param3);
                    if (_loc7_ != null)
                    {
                        _loc4_ = (_loc4_ + _loc7_.y);
                    };
                };
                _loc5_--;
            };
            return (_loc4_);
        }

        override protected function getAsset(param1:String):IGraphicAsset
        {
            var _loc2_:IGraphicAsset;
            if (assetCollection != null)
            {
                return (assetCollection.getAssetWithPalette(param1, this.var_4171));
            };
            return (null);
        }

        override protected function getSpriteZOffset(param1:int, param2:int, param3:int):Number
        {
            if (this._animationData == null)
            {
                return (LayerData.var_1453);
            };
            return (this._animationData.getZOffset(param1, this.getDirection(param1, param3), param3));
        }

        override protected function getSpriteAssetName(param1:int, param2:int):String
        {
            var _loc4_:int;
            var _loc5_:String;
            var _loc3_:int = spriteCount;
            if (param2 < (_loc3_ - var_1467))
            {
                _loc4_ = getSize(param1);
                if (param2 < (_loc3_ - (1 + var_1467)))
                {
                    if (param2 >= FurnitureVisualizationData.var_1445.length)
                    {
                        return (null);
                    };
                    _loc5_ = FurnitureVisualizationData.var_1445[param2];
                    if (_loc4_ == 1)
                    {
                        return ((type + "_icon_") + _loc5_);
                    };
                    return ((((((((type + "_") + _loc4_) + "_") + _loc5_) + "_") + this.getDirection(param1, param2)) + "_") + this.getFrameNumber(_loc4_, param2));
                };
                return (((((type + "_") + _loc4_) + "_sd_") + this.getDirection(param1, param2)) + "_0");
            };
            return (null);
        }

        private function getDirection(param1:int, param2:int):int
        {
            if (this.isHeadSprite(param2))
            {
                return (this._animationData.getDirectionValue(param1, this.var_2567));
            };
            return (direction);
        }

        private function isHeadSprite(param1:int):Boolean
        {
            if (this.var_4173[param1] == null)
            {
                if (this._animationData.getTag(var_1459, DirectionData.USE_DEFAULT_DIRECTION, param1) == var_1468)
                {
                    this.var_4173[param1] = true;
                }
                else
                {
                    this.var_4173[param1] = false;
                };
            };
            return (this.var_4173[param1]);
        }

    }
}