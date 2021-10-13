package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarSignUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3948:int;

        public function RoomObjectAvatarSignUpdateMessage(param1:int)
        {
            this.var_3948 = param1;
        }

        public function get signType():int
        {
            return (this.var_3948);
        }

    }
}