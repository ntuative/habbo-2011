package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSleepUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3949:Boolean;

        public function RoomObjectAvatarSleepUpdateMessage(param1:Boolean=false)
        {
            this.var_3949 = param1;
        }

        public function get isSleeping():Boolean
        {
            return (this.var_3949);
        }

    }
}