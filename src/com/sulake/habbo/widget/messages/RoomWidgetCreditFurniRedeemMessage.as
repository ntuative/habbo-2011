package com.sulake.habbo.widget.messages
{
    public class RoomWidgetCreditFurniRedeemMessage extends RoomWidgetMessage 
    {

        public static const var_1360:String = "RWFCRM_REDEEM";

        private var var_2358:int;

        public function RoomWidgetCreditFurniRedeemMessage(param1:String, param2:int)
        {
            super(param1);
            this.var_2358 = param2;
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

    }
}