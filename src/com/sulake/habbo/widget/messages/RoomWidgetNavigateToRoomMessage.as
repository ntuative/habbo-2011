package com.sulake.habbo.widget.messages
{
    public class RoomWidgetNavigateToRoomMessage extends RoomWidgetMessage 
    {

        public static const var_1896:String = "RWGOI_MESSAGE_NAVIGATE_TO_ROOM";
        public static const var_1897:String = "RWGOI_MESSAGE_NAVIGATE_HOME";

        private var _roomId:int;

        public function RoomWidgetNavigateToRoomMessage(param1:String, param2:int=-1)
        {
            super(param1);
            this._roomId = param2;
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

    }
}