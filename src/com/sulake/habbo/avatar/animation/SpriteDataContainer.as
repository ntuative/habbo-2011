package com.sulake.habbo.avatar.animation
{

    public class SpriteDataContainer implements ISpriteDataContainer
    {

        private var _animation: IAnimation;
        private var _id: String;
        private var _ink: int;
        private var _member: String;
        private var _hasDirections: Boolean;
        private var _dx: Array;
        private var var_2405: Array;
        private var var_2406: Array;

        public function SpriteDataContainer(param1: IAnimation, param2: XML)
        {
            var _loc3_: XML;
            var _loc4_: int;
            super();
            this._animation = param1;
            this._id = String(param2.@id);
            this._ink = parseInt(param2.@ink);
            this._member = String(param2.@member);
            this._hasDirections = Boolean(parseInt(param2.@directions));
            this._dx = [];
            this.var_2405 = [];
            this.var_2406 = [];
            for each (_loc3_ in param2.direction)
            {
                _loc4_ = parseInt(_loc3_.@id);
                this._dx[_loc4_] = parseInt(_loc3_.@dx);
                this.var_2405[_loc4_] = parseInt(_loc3_.@dy);
                this.var_2406[_loc4_] = parseInt(_loc3_.@dz);
            }

        }

        public function getDirectionOffsetX(param1: int): int
        {
            if (param1 < this._dx.length)
            {
                return this._dx[param1];
            }

            return 0;
        }

        public function getDirectionOffsetY(param1: int): int
        {
            if (param1 < this.var_2405.length)
            {
                return this.var_2405[param1];
            }

            return 0;
        }

        public function getDirectionOffsetZ(param1: int): int
        {
            if (param1 < this.var_2406.length)
            {
                return this.var_2406[param1];
            }

            return 0;
        }

        public function get animation(): IAnimation
        {
            return this._animation;
        }

        public function get id(): String
        {
            return this._id;
        }

        public function get ink(): int
        {
            return this._ink;
        }

        public function get member(): String
        {
            return this._member;
        }

        public function get hasDirections(): Boolean
        {
            return this._hasDirections;
        }

    }
}
