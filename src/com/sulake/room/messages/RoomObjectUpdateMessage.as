package com.sulake.room.messages
{

    import com.sulake.room.utils.IVector3d;

    public class RoomObjectUpdateMessage
    {

        protected var _loc: IVector3d;
        protected var _dir: IVector3d;

        public function RoomObjectUpdateMessage(loc: IVector3d, dir: IVector3d)
        {
            this._loc = loc;
            this._dir = dir;
        }

        public function get loc(): IVector3d
        {
            return this._loc;
        }

        public function get dir(): IVector3d
        {
            return this._dir;
        }

    }
}
