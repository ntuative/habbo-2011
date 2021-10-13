package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarDanceUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3289:int;

        public function RoomObjectAvatarDanceUpdateMessage(param1:int=0)
        {
            this.var_3289 = param1;
        }

        public function get danceStyle():int
        {
            return (this.var_3289);
        }

    }
}