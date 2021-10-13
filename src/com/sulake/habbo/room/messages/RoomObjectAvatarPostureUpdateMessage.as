package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3947:String;
        private var var_2724:String;

        public function RoomObjectAvatarPostureUpdateMessage(param1:String, param2:String="")
        {
            this.var_3947 = param1;
            this.var_2724 = param2;
        }

        public function get postureType():String
        {
            return (this.var_3947);
        }

        public function get parameter():String
        {
            return (this.var_2724);
        }

    }
}