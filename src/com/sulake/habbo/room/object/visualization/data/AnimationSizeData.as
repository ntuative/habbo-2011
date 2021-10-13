package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;

    public class AnimationSizeData extends SizeData 
    {

        private var var_2409:Map = null;

        public function AnimationSizeData(param1:int, param2:int)
        {
            super(param1, param2);
            this.var_2409 = new Map();
        }

        override public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:AnimationData;
            super.dispose();
            if (this.var_2409 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_2409.length)
                {
                    _loc2_ = (this.var_2409.getWithIndex(_loc1_) as AnimationData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    };
                    _loc1_++;
                };
                this.var_2409.dispose();
                this.var_2409 = null;
            };
        }

        public function defineAnimations(param1:XML):Boolean
        {
            var _loc5_:XML;
            var _loc6_:int;
            var _loc7_:String;
            var _loc8_:AnimationData;
            var _loc9_:int;
            var _loc10_:int;
            var _loc11_:Array;
            var _loc12_:Array;
            var _loc13_:String;
            var _loc14_:int;
            if (param1 == null)
            {
                return (true);
            };
            var _loc2_:Array = ["id"];
            var _loc3_:XMLList = param1.animation;
            var _loc4_:int;
            while (_loc4_ < _loc3_.length())
            {
                _loc5_ = _loc3_[_loc4_];
                if (!XMLValidator.checkRequiredAttributes(_loc5_, _loc2_))
                {
                    return (false);
                };
                _loc6_ = int(_loc5_.@id);
                _loc7_ = _loc5_.@transitionTo;
                if (_loc7_.length > 0)
                {
                    _loc9_ = int(_loc7_);
                    _loc6_ = AnimationData.getTransitionToAnimationId(_loc9_);
                };
                _loc7_ = _loc5_.@transitionFrom;
                if (_loc7_.length > 0)
                {
                    _loc10_ = int(_loc7_);
                    _loc6_ = AnimationData.getTransitionFromAnimationId(_loc10_);
                };
                _loc8_ = this.createAnimationData();
                if (!_loc8_.initialize(_loc5_))
                {
                    _loc8_.dispose();
                    return (false);
                };
                _loc7_ = _loc5_.@immediateChangeFrom;
                if (_loc7_.length > 0)
                {
                    _loc11_ = _loc7_.split(",");
                    _loc12_ = [];
                    for each (_loc13_ in _loc11_)
                    {
                        _loc14_ = int(_loc13_);
                        if (_loc12_.indexOf(_loc14_) < 0)
                        {
                            _loc12_.push(_loc14_);
                        };
                    };
                    _loc8_.setImmediateChanges(_loc12_);
                };
                this.var_2409.add(_loc6_, _loc8_);
                _loc4_++;
            };
            return (true);
        }

        protected function createAnimationData():AnimationData
        {
            return (new AnimationData());
        }

        public function hasAnimation(param1:int):Boolean
        {
            if (this.var_2409.getValue(param1) != null)
            {
                return (true);
            };
            return (false);
        }

        public function isImmediateChange(param1:int, param2:int):Boolean
        {
            var _loc3_:AnimationData = (this.var_2409.getValue(param1) as AnimationData);
            if (_loc3_ != null)
            {
                _loc3_.isImmediateChange(param2);
            };
            return (false);
        }

        public function getStartFrame(param1:int, param2:int):int
        {
            var _loc3_:AnimationData = (this.var_2409.getValue(param1) as AnimationData);
            if (_loc3_ != null)
            {
                return (_loc3_.getStartFrame(param2));
            };
            return (0);
        }

        public function getFrame(param1:int, param2:int, param3:int, param4:int):AnimationFrame
        {
            var _loc6_:AnimationFrame;
            var _loc5_:AnimationData = (this.var_2409.getValue(param1) as AnimationData);
            if (_loc5_ != null)
            {
                return (_loc5_.getFrame(param2, param3, param4));
            };
            return (null);
        }

        public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int):AnimationFrame
        {
            var _loc8_:AnimationFrame;
            var _loc7_:AnimationData = (this.var_2409.getValue(param1) as AnimationData);
            if (_loc7_ != null)
            {
                return (_loc7_.getFrameFromSequence(param2, param3, param4, param5, param6));
            };
            return (null);
        }

    }
}