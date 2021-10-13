package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPlayerValueUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_2162:int;

        public function RoomObjectAvatarPlayerValueUpdateMessage(param1:int)
        {
            this.var_2162 = param1;
        }

        public function get value():int
        {
            return (this.var_2162);
        }

    }
}