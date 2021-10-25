package com.sulake.habbo.room.object
{

    public class RoomPlaneMaskData
    {

        private var _leftSideLoc: Number = 0;
        private var _rightSideLoc: Number = 0;
        private var _leftSideLength: Number = 0;
        private var _rightSideLength: Number = 0;

        public function RoomPlaneMaskData(leftSideLoc: Number, rightSideLoc: Number, leftSideLength: Number, rightSideLength: Number)
        {
            this._leftSideLoc = leftSideLoc;
            this._rightSideLoc = rightSideLoc;
            this._leftSideLength = leftSideLength;
            this._rightSideLength = rightSideLength;
        }

        public function get leftSideLoc(): Number
        {
            return this._leftSideLoc;
        }

        public function get rightSideLoc(): Number
        {
            return this._rightSideLoc;
        }

        public function get leftSideLength(): Number
        {
            return this._leftSideLength;
        }

        public function get rightSideLength(): Number
        {
            return this._rightSideLength;
        }

    }
}
