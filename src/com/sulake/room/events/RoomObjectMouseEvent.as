package com.sulake.room.events
{
    public class RoomObjectMouseEvent extends RoomObjectEvent 
    {

        public static const var_483:String = "ROE_MOUSE_CLICK";
        public static const var_1621:String = "ROE_MOUSE_ENTER";
        public static const var_484:String = "ROE_MOUSE_MOVE";
        public static const var_1622:String = "ROE_MOUSE_LEAVE";
        public static const var_1623:String = "ROE_MOUSE_DOUBLE_CLICK";
        public static const ROOM_OBJECT_MOUSE_DOWN:String = "ROE_MOUSE_DOWN";

        private var var_4978:String = "";
        private var var_4979:Boolean;
        private var var_4980:Boolean;
        private var var_4981:Boolean;
        private var var_4982:Boolean;

        public function RoomObjectMouseEvent(param1:String, param2:String, param3:int, param4:String, param5:Boolean=false, param6:Boolean=false, param7:Boolean=false, param8:Boolean=false, param9:Boolean=false, param10:Boolean=false)
        {
            super(param1, param3, param4, param9, param10);
            this.var_4978 = param2;
            this.var_4979 = param5;
            this.var_4980 = param6;
            this.var_4981 = param7;
            this.var_4982 = param8;
        }

        public function get eventId():String
        {
            return (this.var_4978);
        }

        public function get altKey():Boolean
        {
            return (this.var_4979);
        }

        public function get ctrlKey():Boolean
        {
            return (this.var_4980);
        }

        public function get shiftKey():Boolean
        {
            return (this.var_4981);
        }

        public function get buttonDown():Boolean
        {
            return (this.var_4982);
        }

    }
}