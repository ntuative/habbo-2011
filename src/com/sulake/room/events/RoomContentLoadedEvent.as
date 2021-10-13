package com.sulake.room.events
{
    import flash.events.Event;

    public class RoomContentLoadedEvent extends Event 
    {

        public static const var_293:String = "RCLE_SUCCESS";
        public static const var_294:String = "RCLE_FAILURE";
        public static const var_295:String = "RCLE_CANCEL";

        private var var_4977:String;

        public function RoomContentLoadedEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this.var_4977 = param2;
        }

        public function get contentType():String
        {
            return (this.var_4977);
        }

    }
}