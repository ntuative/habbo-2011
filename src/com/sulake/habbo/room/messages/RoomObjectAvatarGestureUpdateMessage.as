package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3293:int = 0;

        public function RoomObjectAvatarGestureUpdateMessage(param1:int)
        {
            this.var_3293 = param1;
        }

        public function get gesture():int
        {
            return (this.var_3293);
        }

    }
}