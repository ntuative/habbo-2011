package com.sulake.habbo.widget.messages
{
    public class RoomWidgetPollMessage extends RoomWidgetMessage 
    {

        public static const var_1890:String = "RWPM_START";
        public static const var_1889:String = "RWPM_REJECT";
        public static const ANSWER:String = "RWPM_ANSWER";

        private var _id:int = -1;
        private var var_3086:int = 0;
        private var var_4863:Array = null;

        public function RoomWidgetPollMessage(param1:String, param2:int)
        {
            this._id = param2;
            super(param1);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get questionId():int
        {
            return (this.var_3086);
        }

        public function set questionId(param1:int):void
        {
            this.var_3086 = param1;
        }

        public function get answers():Array
        {
            return (this.var_4863);
        }

        public function set answers(param1:Array):void
        {
            this.var_4863 = param1;
        }

    }
}