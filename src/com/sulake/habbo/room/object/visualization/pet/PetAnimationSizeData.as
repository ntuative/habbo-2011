package com.sulake.habbo.room.object.visualization.pet
{

    import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.visualization.data.*;

    public class PetAnimationSizeData extends AnimationSizeData
    {

        public static const var_1478: int = -1;

        private var var_4177: Map = new Map();
        private var var_4178: Map = new Map();
        private var var_4179: String;

        public function PetAnimationSizeData(param1: int, param2: int)
        {
            super(param1, param2);
        }

        public function definePostures(param1: XML): Boolean
        {
            var _loc5_: XML;
            var _loc6_: String;
            var _loc7_: int;
            if (param1 == null)
            {
                return false;
            }

            if (XMLValidator.checkRequiredAttributes(param1, ["defaultPosture"]))
            {
                this.var_4179 = param1.@defaultPosture;
            }
            else
            {
                this.var_4179 = null;
            }

            var _loc2_: Array = ["id", "animationId"];
            var _loc3_: XMLList = param1.posture;
            var _loc4_: int;
            while (_loc4_ < _loc3_.length())
            {
                _loc5_ = _loc3_[_loc4_];
                if (!XMLValidator.checkRequiredAttributes(_loc5_, _loc2_))
                {
                    return false;
                }

                _loc6_ = String(_loc5_.@id);
                _loc7_ = int(_loc5_.@animationId);
                this.var_4177.add(_loc6_, _loc7_);
                if (this.var_4179 == null)
                {
                    this.var_4179 = _loc6_;
                }

                _loc4_++;
            }

            return this.var_4177.getValue(this.var_4179) != null;


        }

        public function defineGestures(param1: XML): Boolean
        {
            var _loc5_: XML;
            var _loc6_: String;
            var _loc7_: int;
            if (param1 == null)
            {
                return true;
            }

            var _loc2_: Array = ["id", "animationId"];
            var _loc3_: XMLList = param1.gesture;
            var _loc4_: int;
            while (_loc4_ < _loc3_.length())
            {
                _loc5_ = _loc3_[_loc4_];
                if (!XMLValidator.checkRequiredAttributes(_loc5_, _loc2_))
                {
                    return false;
                }

                _loc6_ = String(_loc5_.@id);
                _loc7_ = int(_loc5_.@animationId);
                this.var_4178.add(_loc6_, _loc7_);
                _loc4_++;
            }

            return true;
        }

        public function getAnimationForPosture(param1: String): int
        {
            if (this.var_4177.getValue(param1) == null)
            {
                param1 = this.var_4179;
            }

            return this.var_4177.getValue(param1);
        }

        public function getAnimationForGesture(param1: String): int
        {
            if (this.var_4178.getValue(param1) == null)
            {
                return var_1478;
            }

            return this.var_4178.getValue(param1);
        }

        public function getPostureForAnimation(param1: int): String
        {
            if (param1 >= 0 && param1 < this.var_4177.length)
            {
                return this.var_4177.getKey(param1);
            }

            return this.var_4179;
        }

        public function getGestureForAnimation(param1: int): String
        {
            if (param1 >= 0 && param1 < this.var_4178.length)
            {
                return this.var_4178.getKey(param1);
            }

            return null;
        }

        public function getPostureCount(): int
        {
            return this.var_4177.length;
        }

        public function getGestureCount(): int
        {
            return this.var_4178.length;
        }

    }
}
