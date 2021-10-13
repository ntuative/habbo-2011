package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3296:Boolean;

        public function RoomObjectAvatarTypingUpdateMessage(param1:Boolean=false)
        {
            this.var_3296 = param1;
        }

        public function get var_1215():Boolean
        {
            return (this.var_3296);
        }

    }
}