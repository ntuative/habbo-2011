package com.sulake.habbo.room.object.visualization.data
{

    public class AnimationFrame
    {

        public static const FRAME_REPEAT_FOREVER: int = -1;
        public static const var_1461: int = -1;
        private static const POOL_SIZE_MAX: int = 3000;
        private static const POOL: Array = [];

        private var _id: int = 0;
        private var _x: int = 0;
        private var _y: int = 0;
        private var _repeats: int = 1;
        private var _frameRepeats: int = 1;
        private var _remainingFrameRepeats: int = 1;
        private var _activeSequence: int = -1;
        private var _activeSequenceOffset: int = 0;
        private var _isLastFrame: Boolean = false;
        private var _isRecycled: Boolean = false;

        public static function allocate(param1: int, param2: int, param3: int, param4: int, param5: int, param6: Boolean, param7: int = -1, param8: int = 0): AnimationFrame
        {
            var _loc9_: AnimationFrame = POOL.length > 0 ? POOL.pop() : new AnimationFrame();
            _loc9_._isRecycled = false;
            _loc9_._id = param1;
            _loc9_._x = param2;
            _loc9_._y = param3;
            _loc9_._isLastFrame = param6;
            if (param4 < 1)
            {
                param4 = 1;
            }

            _loc9_._repeats = param4;
            if (param5 < 0)
            {
                param5 = FRAME_REPEAT_FOREVER;
            }

            _loc9_._frameRepeats = param5;
            _loc9_._remainingFrameRepeats = param5;
            if (param7 >= 0)
            {
                _loc9_._activeSequence = param7;
                _loc9_._activeSequenceOffset = param8;
            }

            return _loc9_;
        }

        public function get id(): int
        {
            if (this._id >= 0)
            {
                return this._id;
            }

            return -this._id * Math.random();
        }

        public function get x(): int
        {
            return this._x;
        }

        public function get y(): int
        {
            return this._y;
        }

        public function get repeats(): int
        {
            return this._repeats;
        }

        public function get frameRepeats(): int
        {
            return this._frameRepeats;
        }

        public function get isLastFrame(): Boolean
        {
            return this._isLastFrame;
        }

        public function get remainingFrameRepeats(): int
        {
            if (this._frameRepeats < 0)
            {
                return FRAME_REPEAT_FOREVER;
            }

            return this._remainingFrameRepeats;
        }

        public function set remainingFrameRepeats(param1: int): void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }

            if (this._frameRepeats > 0 && param1 > this._frameRepeats)
            {
                param1 = this._frameRepeats;
            }

            this._remainingFrameRepeats = param1;
        }

        public function get activeSequence(): int
        {
            return this._activeSequence;
        }

        public function get activeSequenceOffset(): int
        {
            return this._activeSequenceOffset;
        }

        public function recycle(): void
        {
            if (!this._isRecycled)
            {
                this._isRecycled = true;
                if (POOL.length < POOL_SIZE_MAX)
                {
                    POOL.push(this);
                }

            }

        }

    }
}
