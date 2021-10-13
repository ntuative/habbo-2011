package com.sulake.habbo.widget.events
{
    public class RoomWidgetSongUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1344:String = "RWSUE_PLAYING_CHANGED";
        public static const var_1345:String = "RWSUE_DATA_RECEIVED";

        private var var_2941:int;
        private var _songName:String;
        private var var_4716:String;

        public function RoomWidgetSongUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean=false, param6:Boolean=false)
        {
            super(param1, param5, param6);
            this.var_2941 = param2;
            this._songName = param3;
            this.var_4716 = param4;
        }

        public function get songId():int
        {
            return (this.var_2941);
        }

        public function get songName():String
        {
            return (this._songName);
        }

        public function get songAuthor():String
        {
            return (this.var_4716);
        }

    }
}