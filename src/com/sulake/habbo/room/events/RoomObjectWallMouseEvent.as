package com.sulake.habbo.room.events
{

    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectWallMouseEvent extends RoomObjectMouseEvent
    {

        private var _x: Number;
        private var _y: Number;
        private var _direction: Number;
        private var _wallLocation: Vector3d = null;
        private var _wallWidth: Vector3d = null;
        private var _wallHeight: Vector3d = null;

        public function RoomObjectWallMouseEvent(type: String, eventId: String, objectId: int, objectType: String, wallLocation: IVector3d, wallWidth: IVector3d, wallHeight: IVector3d, x: Number, y: Number, direction: Number, altKey: Boolean = false, ctrlKey: Boolean = false, shiftKey: Boolean = false, buttonDown: Boolean = false, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, eventId, objectId, objectType, altKey, ctrlKey, shiftKey, buttonDown, bubbles, cancelable);
            
            this._wallLocation = new Vector3d();
            this._wallLocation.assign(wallLocation);

            this._wallWidth = new Vector3d();
            this._wallWidth.assign(wallWidth);

            this._wallHeight = new Vector3d();
            this._wallHeight.assign(wallHeight);

            this._x = x;
            this._y = y;
            this._direction = direction;
        }

        public function get wallLocation(): IVector3d
        {
            return this._wallLocation;
        }

        public function get wallWidth(): IVector3d
        {
            return this._wallWidth;
        }

        public function get wallHeight(): IVector3d
        {
            return this._wallHeight;
        }

        public function get x(): Number
        {
            return this._x;
        }

        public function get y(): Number
        {
            return this._y;
        }

        public function get direction(): Number
        {
            return this._direction;
        }

    }
}
