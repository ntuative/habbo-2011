package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarChatUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3942:int;

        public function RoomObjectAvatarChatUpdateMessage(param1:int)
        {
            this.var_3942 = param1;
        }

        public function get numberOfWords():int
        {
            return (this.var_3942);
        }

    }
}