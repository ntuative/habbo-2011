package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3293:String;

        public function RoomObjectAvatarPetGestureUpdateMessage(param1:String)
        {
            this.var_3293 = param1;
        }

        public function get gesture():String
        {
            return (this.var_3293);
        }

    }
}