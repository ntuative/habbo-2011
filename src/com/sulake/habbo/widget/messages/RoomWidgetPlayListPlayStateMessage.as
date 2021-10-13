package com.sulake.habbo.widget.messages
{
    public class RoomWidgetPlayListPlayStateMessage extends RoomWidgetMessage 
    {

        public static const var_1252:String = "RWPLPS_TOGGLE_PLAY_PAUSE";

        private var _furniId:int;
        private var var_2084:int;

        public function RoomWidgetPlayListPlayStateMessage(param1:String, param2:int, param3:int=-1)
        {
            super(param1);
            this._furniId = param2;
            this.var_2084 = param3;
        }

        public function get furniId():int
        {
            return (this._furniId);
        }

        public function get position():int
        {
            return (this.var_2084);
        }

    }
}