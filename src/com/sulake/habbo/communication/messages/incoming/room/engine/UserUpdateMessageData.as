package com.sulake.habbo.communication.messages.incoming.room.engine
{

    public class UserUpdateMessageData
    {

        private var _id: int = 0;
        private var _x: Number = 0;
        private var _y: Number = 0;
        private var _z: Number = 0;
        private var _localZ: Number = 0;
        private var _targetX: Number = 0;
        private var _targetY: Number = 0;
        private var _targetZ: Number = 0;
        private var _dir: int = 0;
        private var _dirHead: int = 0;
        private var _actions: Array = [];
        private var _isMoving: Boolean = false;

        public function UserUpdateMessageData(id: int, x: Number, y: Number, z: Number, localZ: Number, dir: int, dirHead: int, targetX: Number, targetY: Number, targetZ: Number, isMoving: Boolean, actions: Array)
        {
            this._id = id;
            this._x = x;
            this._y = y;
            this._z = z;
            this._localZ = localZ;
            this._dir = dir;
            this._dirHead = dirHead;
            this._targetX = targetX;
            this._targetY = targetY;
            this._targetZ = targetZ;
            this._isMoving = isMoving;
            this._actions = actions;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get x(): Number
        {
            return this._x;
        }

        public function get y(): Number
        {
            return this._y;
        }

        public function get z(): Number
        {
            return this._z;
        }

        public function get localZ(): Number
        {
            return this._localZ;
        }

        public function get targetX(): Number
        {
            return this._targetX;
        }

        public function get targetY(): Number
        {
            return this._targetY;
        }

        public function get targetZ(): Number
        {
            return this._targetZ;
        }

        public function get dir(): int
        {
            return this._dir;
        }

        public function get dirHead(): int
        {
            return this._dirHead;
        }

        public function get isMoving(): Boolean
        {
            return this._isMoving;
        }

        public function get actions(): Array
        {
            return this._actions.slice();
        }

    }
}
