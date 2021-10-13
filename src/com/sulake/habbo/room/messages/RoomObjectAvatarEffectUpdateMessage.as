package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var var_3943:int;
        private var var_3287:int;

        public function RoomObjectAvatarEffectUpdateMessage(param1:int=0, param2:int=0)
        {
            this.var_3943 = param1;
            this.var_3287 = param2;
        }

        public function get effect():int
        {
            return (this.var_3943);
        }

        public function get delayMilliSeconds():int
        {
            return (this.var_3287);
        }

    }
}