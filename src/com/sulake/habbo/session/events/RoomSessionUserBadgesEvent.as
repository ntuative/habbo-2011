package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserBadgesEvent extends RoomSessionEvent 
    {

        public static const var_368:String = "RSUBE_BADGES";

        private var _userId:int = 0;
        private var var_3350:Array = [];

        public function RoomSessionUserBadgesEvent(param1:IRoomSession, param2:int, param3:Array, param4:Boolean=false, param5:Boolean=false)
        {
            super(var_368, param1, param4, param5);
            this._userId = param2;
            this.var_3350 = param3;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get badges():Array
        {
            return (this.var_3350);
        }

    }
}