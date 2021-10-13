package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class HabboSessionFigureUpdatedEvent extends Event 
    {

        public static const var_1432:String = "HABBO_SESSION_FIGURE_UPDATE";

        private var _userId:int;
        private var var_2534:String;
        private var var_2071:String;

        public function HabboSessionFigureUpdatedEvent(param1:int, param2:String, param3:String, param4:Boolean=false, param5:Boolean=false)
        {
            super(var_1432, param4, param5);
            this._userId = param1;
            this.var_2534 = param2;
            this.var_2071 = param3;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function get gender():String
        {
            return (this.var_2071);
        }

    }
}