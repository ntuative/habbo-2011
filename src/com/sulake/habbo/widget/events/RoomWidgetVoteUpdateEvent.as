package com.sulake.habbo.widget.events
{
    public class RoomWidgetVoteUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_394:String = "RWPUE_VOTE_QUESTION";
        public static const var_395:String = "RWPUE_VOTE_RESULT";

        private var var_3275:String;
        private var var_3276:Array;
        private var var_3277:Array;
        private var var_3278:int;

        public function RoomWidgetVoteUpdateEvent(param1:String, param2:String, param3:Array, param4:Array=null, param5:int=0, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_3275 = param2;
            this.var_3276 = param3;
            this.var_3277 = param4;
            if (this.var_3277 == null)
            {
                this.var_3277 = [];
            };
            this.var_3278 = param5;
        }

        public function get question():String
        {
            return (this.var_3275);
        }

        public function get choices():Array
        {
            return (this.var_3276.slice());
        }

        public function get votes():Array
        {
            return (this.var_3277.slice());
        }

        public function get totalVotes():int
        {
            return (this.var_3278);
        }

    }
}