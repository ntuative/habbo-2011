package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_2534:String;
        private var var_3944:String;
        private var var_2071:String;

        public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String=null, param3:String=null)
        {
            this.var_2534 = param1;
            this.var_2071 = param2;
            this.var_3944 = param3;
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function get race():String
        {
            return (this.var_3944);
        }

        public function get gender():String
        {
            return (this.var_2071);
        }

    }
}