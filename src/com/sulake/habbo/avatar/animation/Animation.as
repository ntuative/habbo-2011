package com.sulake.habbo.avatar.animation
{

    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.AvatarStructure;
    import com.sulake.habbo.avatar.actions.IActionDefinition;

    public class Animation implements IAnimation
    {

        private var _id: String;
        private var _description: String;
        private var _frames: Array = [];
        private var _spriteData: Array = [];
        private var _avatarData: AvatarDataContainer;
        private var _canvasData: Array = [];
        private var _directionData: DirectionDataContainer;
        private var _shadowData: ShadowDataContainer;
        private var _removeData: Array = [];
        private var _addData: Array = [];
        private var var_2399: Map;
        private var _overrideFrames: Map;

        public function Animation(param1: AvatarStructure, param2: XML)
        {
            var _loc3_: XML;
            var _loc4_: XML;
            var _loc5_: XML;
            var _loc6_: XML;
            var _loc7_: XML;
            var _loc8_: String;
            var _loc9_: String;
            var _loc10_: Array;
            super();
            this._id = String(param2.@name);
            if (param2.hasOwnProperty("@desc"))
            {
                this._description = String(param2.@desc);
            }
            else
            {
                this._description = this._id;
            }

            if (param2.hasOwnProperty("sprite"))
            {
                for each (_loc3_ in param2.sprite)
                {
                    this._spriteData.push(new SpriteDataContainer(this as IAnimation, _loc3_));
                }

            }

            if (param2.hasOwnProperty("avatar"))
            {
                this._avatarData = new AvatarDataContainer(param2.avatar[0]);
            }

            if (param2.hasOwnProperty("canvas"))
            {
                for each (_loc4_ in param2.canvas)
                {
                    this._canvasData.push(new CanvasDataContainer(_loc4_));
                }

            }

            if (param2.hasOwnProperty("direction"))
            {
                this._directionData = new DirectionDataContainer(param2.direction[0]);
            }

            if (param2.hasOwnProperty("shadow"))
            {
                this._shadowData = new ShadowDataContainer(param2.shadow[0]);
            }

            if (param2.hasOwnProperty("remove"))
            {
                for each (_loc5_ in param2.remove)
                {
                    this._removeData.push(String(_loc5_.@id));
                }

            }

            if (param2.hasOwnProperty("add"))
            {
                for each (_loc6_ in param2.add)
                {
                    this._addData.push(new AddDataContainer(_loc6_));
                }

            }

            if (param2.hasOwnProperty("override"))
            {
                this._overrideFrames = new Map();
                this.var_2399 = new Map();
                for each (_loc7_ in param2.override)
                {
                    _loc8_ = _loc7_.@name;
                    _loc9_ = _loc7_.@override;
                    this.var_2399.add(_loc9_, _loc8_);
                    _loc10_ = [];
                    this.parseFrames(_loc10_, _loc7_.frame, param1);
                    this._overrideFrames.add(_loc8_, _loc10_);
                }

            }

            this.parseFrames(this._frames, param2.frame, param1);
        }

        private function parseFrames(param1: Array, param2: XMLList, param3: AvatarStructure): void
        {
            var _loc4_: Array;
            var _loc5_: IActionDefinition;
            var _loc7_: XML;
            var _loc8_: XML;
            var _loc9_: XML;
            var _loc10_: AnimationLayerData;
            var _loc11_: AnimationLayerData;
            var _loc6_: int;
            for each (_loc7_ in param2)
            {
                _loc4_ = [];
                for each (_loc8_ in _loc7_.bodypart)
                {
                    _loc5_ = param3.getActionDefinition(String(_loc8_.@action));
                    _loc10_ = new AnimationLayerData(param3, _loc8_, AnimationLayerData.var_1708, _loc6_, _loc5_);
                    _loc4_.push(_loc10_);
                }

                for each (_loc9_ in _loc7_.fx)
                {
                    _loc5_ = param3.getActionDefinition(String(_loc9_.@action));
                    _loc11_ = new AnimationLayerData(param3, _loc9_, AnimationLayerData.var_1709, _loc6_, _loc5_);
                    _loc4_.push(_loc11_);
                    if (_loc5_ != null)
                    {
                    }

                }

                param1.push(_loc4_);
                _loc6_++;
            }

        }

        public function frameCount(param1: String = null): int
        {
            var _loc2_: Array;
            if (!param1)
            {
                return this._frames.length;
            }

            if (this._overrideFrames)
            {
                _loc2_ = this._overrideFrames.getValue(param1);
                if (_loc2_)
                {
                    return _loc2_.length;
                }

            }

            return 0;
        }

        public function hasOverriddenActions(): Boolean
        {
            if (!this.var_2399)
            {
                return false;
            }

            return this.var_2399.length > 0;
        }

        public function overriddenActionNames(): Array
        {
            if (!this.var_2399)
            {
                return null;
            }

            return this.var_2399.getKeys();
        }

        public function overridingAction(param1: String): String
        {
            if (!this.var_2399)
            {
                return null;
            }

            return this.var_2399.getValue(param1);
        }

        private function getFrame(param1: int, param2: String = null): Array
        {
            var _loc4_: Array;
            var _loc3_: Array = [];
            if (!param2)
            {
                if (this._frames.length > 0)
                {
                    _loc3_ = this._frames[(param1 % this._frames.length)];
                }

            }
            else
            {
                _loc4_ = (this._overrideFrames.getValue(param2) as Array);
                if (_loc4_ && _loc4_.length > 0)
                {
                    _loc3_ = _loc4_[(param1 % _loc4_.length)];
                }

            }

            return _loc3_;
        }

        public function getAnimatedBodyPartIds(param1: int, param2: String = null): Array
        {
            var _loc4_: AnimationLayerData;
            var _loc5_: AddDataContainer;
            var _loc3_: Array = [];
            for each (_loc4_ in this.getFrame(param1, param2))
            {
                if (_loc4_.type == AnimationLayerData.var_1708)
                {
                    _loc3_.push(_loc4_.id);
                }
                else
                {
                    if (_loc4_.type == AnimationLayerData.var_1709)
                    {
                        for each (_loc5_ in this._addData)
                        {
                            if (_loc5_.id == _loc4_.id)
                            {
                                _loc3_.push(_loc5_.align);
                            }

                        }

                    }

                }

            }

            return _loc3_;
        }

        public function getLayerData(param1: int, param2: String, param3: String = null): AnimationLayerData
        {
            var _loc4_: AnimationLayerData;
            var _loc5_: AddDataContainer;
            for each (_loc4_ in this.getFrame(param1, param3))
            {
                if (_loc4_.id == param2)
                {
                    return _loc4_ as AnimationLayerData;
                }

                if (_loc4_.type == AnimationLayerData.var_1709)
                {
                    for each (_loc5_ in this._addData)
                    {
                        if (_loc5_.align == param2 && _loc5_.id == _loc4_.id)
                        {
                            return _loc4_ as AnimationLayerData;
                        }

                    }

                }

            }

            return null;
        }

        public function hasSpriteData(): Boolean
        {
            return this._spriteData != null;
        }

        public function hasAvatarData(): Boolean
        {
            return this._avatarData != null;
        }

        public function hasCanvasData(): Boolean
        {
            return this._canvasData != null;
        }

        public function hasDirectionData(): Boolean
        {
            return this._directionData != null;
        }

        public function hasShadowData(): Boolean
        {
            return this._shadowData != null;
        }

        public function hasRemoveData(): Boolean
        {
            return this._removeData != null;
        }

        public function hasAddData(): Boolean
        {
            return this._addData != null;
        }

        public function getAddData(param1: String): AddDataContainer
        {
            var _loc2_: AddDataContainer;
            for each (_loc2_ in this._addData)
            {
                if (_loc2_.id == param1)
                {
                    return _loc2_;
                }

            }

            return null;
        }

        public function get id(): String
        {
            return this._id;
        }

        public function get spriteData(): Array
        {
            return this._spriteData;
        }

        public function get avatarData(): AvatarDataContainer
        {
            return this._avatarData;
        }

        public function get canvasData(): Array
        {
            return this._canvasData;
        }

        public function get directionData(): DirectionDataContainer
        {
            return this._directionData;
        }

        public function get shadowData(): ShadowDataContainer
        {
            return this._shadowData;
        }

        public function get removeData(): Array
        {
            return this._removeData;
        }

        public function get addData(): Array
        {
            return this._addData;
        }

        public function get description(): String
        {
            return this._description;
        }

    }
}
