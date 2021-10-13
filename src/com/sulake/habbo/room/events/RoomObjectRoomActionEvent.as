package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectRoomActionEvent extends RoomObjectEvent 
    {

        public static const var_1617:String = "RORAE_LEAVE_ROOM";
        public static const var_1197:String = "RORAE_CHANGE_ROOM";
        public static const var_1198:String = "RORAE_TRY_BUS";

        private var var_1013:int = 0;

        public function RoomObjectRoomActionEvent(param1:String, param2:int, param3:int, param4:String, param5:Boolean=false, param6:Boolean=false)
        {
            super(param1, param3, param4, param5, param6);
            this.var_1013 = param2;
        }

        public function get param():int
        {
            return (this.var_1013);
        }

    }
}