package com.sulake.habbo.widget.messages
{
    public class RoomWidgetPetCommandMessage extends RoomWidgetMessage 
    {

        public static const var_1909:String = "RWPCM_REQUEST_PET_COMMANDS";
        public static const var_1908:String = "RWPCM_PET_COMMAND";

        private var var_3097:int = 0;
        private var var_2162:String;

        public function RoomWidgetPetCommandMessage(param1:String, param2:int, param3:String=null)
        {
            super(param1);
            this.var_3097 = param2;
            this.var_2162 = param3;
        }

        public function get petId():int
        {
            return (this.var_3097);
        }

        public function get value():String
        {
            return (this.var_2162);
        }

    }
}