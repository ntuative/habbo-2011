package com.sulake.habbo.widget.messages
{
    public class RoomWidgetVoteMessage extends RoomWidgetMessage 
    {

        public static const var_272:String = "RWVM_VOTE_MESSAGE";

        private var var_4866:int;

        public function RoomWidgetVoteMessage(param1:int)
        {
            super(var_272);
            this.var_4866 = param1;
        }

        public function get vote():int
        {
            return (this.var_4866);
        }

    }
}