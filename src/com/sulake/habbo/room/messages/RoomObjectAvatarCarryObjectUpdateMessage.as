package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_2934:int;
        private var var_3288:String;

        public function RoomObjectAvatarCarryObjectUpdateMessage(param1:int, param2:String)
        {
            this.var_2934 = param1;
            this.var_3288 = param2;
        }

        public function get itemType():int
        {
            return (this.var_2934);
        }

        public function get itemName():String
        {
            return (this.var_3288);
        }

    }
}