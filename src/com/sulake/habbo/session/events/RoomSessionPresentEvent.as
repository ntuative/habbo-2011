package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPresentEvent extends RoomSessionEvent 
    {

        public static const var_371:String = "RSPE_PRESENT_OPENED";

        private var var_2935:int = 0;
        private var var_2934:String = "";
        private var var_2611:String;

        public function RoomSessionPresentEvent(param1:String, param2:IRoomSession, param3:int, param4:String, param5:String, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param2, param6, param7);
            this.var_2935 = param3;
            this.var_2934 = param4;
            this.var_2611 = param5;
        }

        public function get classId():int
        {
            return (this.var_2935);
        }

        public function get itemType():String
        {
            return (this.var_2934);
        }

        public function get productCode():String
        {
            return (this.var_2611);
        }

    }
}