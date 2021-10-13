package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFlatControlUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3945:Boolean = false;
        private var var_3946:String;

        public function RoomObjectAvatarFlatControlUpdateMessage(param1:String)
        {
            this.var_3946 = param1;
            if (((!(param1 == null)) && (!(param1.indexOf("useradmin") == -1))))
            {
                this.var_3945 = true;
            };
        }

        public function get isAdmin():Boolean
        {
            return (this.var_3945);
        }

        public function get rawData():String
        {
            return (this.var_3946);
        }

    }
}