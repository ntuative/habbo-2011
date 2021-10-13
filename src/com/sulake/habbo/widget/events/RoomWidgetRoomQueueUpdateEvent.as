package com.sulake.habbo.widget.events
{
    public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1269:String = "RWRQUE_VISITOR_QUEUE_STATUS";
        public static const var_1270:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";

        private var var_2084:int;
        private var var_4712:Boolean;
        private var var_3542:Boolean;
        private var var_4713:Boolean;

        public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_2084 = param2;
            this.var_4712 = param3;
            this.var_3542 = param4;
            this.var_4713 = param5;
        }

        public function get position():int
        {
            return (this.var_2084);
        }

        public function get hasHabboClub():Boolean
        {
            return (this.var_4712);
        }

        public function get isActive():Boolean
        {
            return (this.var_3542);
        }

        public function get isClubQueue():Boolean
        {
            return (this.var_4713);
        }

    }
}