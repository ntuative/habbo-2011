package com.sulake.habbo.room.messages
{

    import com.sulake.room.utils.IVector3d;

    public class RoomObjectAvatarUpdateMessage extends RoomObjectMoveUpdateMessage
    {

        private var _dirHead: int;

        public function RoomObjectAvatarUpdateMessage(loc: IVector3d, realTargetLoc: IVector3d, dir: IVector3d, dirHead: int)
        {
            super(loc, realTargetLoc, dir);
            
            this._dirHead = dirHead;
        }

        public function get dirHead(): int
        {
            return this._dirHead;
        }

    }
}
