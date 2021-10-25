package com.sulake.habbo.avatar.animation
{

    import com.sulake.habbo.avatar.actions.IActiveActionData;

    import flash.utils.Dictionary;

    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.AvatarStructure;
    import com.sulake.habbo.avatar.actions.IActionDefinition;

    public class AnimationLayerData implements IAnimationLayerData
    {

        public static const var_1708: String = "bodypart";
        public static const var_1709: String = "fx";

        private var _id: String;
        private var _action: IActiveActionData;
        private var _animationFrame: int;
        private var _dx: int;
        private var _dy: int;
        private var _dz: int;
        private var _directionOffset: int;
        private var _type: String;
        private var _base: String;
        private var var_2408: int;
        private var _items: Dictionary = new Dictionary();

        public function AnimationLayerData(param1: AvatarStructure, param2: XML, param3: String, param4: int, param5: IActionDefinition)
        {
            var _loc6_: XML;
            var _loc7_: String;
            super();
            this.var_2408 = param4;
            this._id = String(param2.@id);
            this._animationFrame = parseInt(param2.@frame);
            this._dx = parseInt(param2.@dx);
            this._dy = parseInt(param2.@dy);
            this._dz = parseInt(param2.@dz);
            this._directionOffset = parseInt(param2.@dd);
            this._type = param3;
            this._base = String(param2.@base);
            for each (_loc6_ in param2.item)
            {
                this._items[String(_loc6_.@id)] = String(_loc6_.@base);
            }

            _loc7_ = "";
            if (this._base != "")
            {
                _loc7_ = String(this.baseAsInt());
            }

            if (param5 != null)
            {
                this._action = new ActiveActionData(param5.state, this.base);
                this._action.definition = param5;
            }

        }

        public function get items(): Dictionary
        {
            return this._items;
        }

        private function baseAsInt(): int
        {
            var _loc1_: int;
            var _loc2_: int;
            while (_loc2_ < this._base.length)
            {
                _loc1_ = _loc1_ + this._base.charCodeAt(_loc2_);
                _loc2_++;
            }

            return _loc1_;
        }

        public function get id(): String
        {
            return this._id;
        }

        public function get animationFrame(): int
        {
            return this._animationFrame;
        }

        public function get dx(): int
        {
            return this._dx;
        }

        public function get dy(): int
        {
            return this._dy;
        }

        public function get dz(): int
        {
            return this._dz;
        }

        public function get directionOffset(): int
        {
            return this._directionOffset;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get base(): String
        {
            return this._base;
        }

        public function get action(): IActiveActionData
        {
            return this._action;
        }

    }
}
