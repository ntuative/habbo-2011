package com.sulake.habbo.widget.messages
{
    public class RoomWidgetGetUserLocationMessage extends RoomWidgetMessage 
    {

        public static const var_1813:String = "RWGOI_MESSAGE_GET_USER_LOCATION";

        private var _userId:int;
        private var var_3043:int;

        public function RoomWidgetGetUserLocationMessage(param1:int, param2:int)
        {
            super(var_1813);
            this._userId = param1;
            this.var_3043 = param2;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get userType():int
        {
            return (this.var_3043);
        }

    }
}