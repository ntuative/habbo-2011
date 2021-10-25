package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectMoveUpdateMessage extends RoomObjectUpdateMessage
    {

        private var _realTargetLoc: IVector3d;
        private var _isSlideUpdate: Boolean;

        public function RoomObjectMoveUpdateMessage(loc: IVector3d, realTargetLoc: IVector3d, dir: IVector3d, isSlideUpdate: Boolean = false)
        {
            super(loc, dir);
            
            this._isSlideUpdate = isSlideUpdate;
            this._realTargetLoc = realTargetLoc;
        }

        public function get targetLoc(): IVector3d
        {
            if (this._realTargetLoc == null)
            {
                return loc;
            }

            return this._realTargetLoc;
        }

        public function get realTargetLoc(): IVector3d
        {
            return this._realTargetLoc;
        }

        public function get isSlideUpdate(): Boolean
        {
            return this._isSlideUpdate;
        }

    }
}
