package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class SetExtraPurchaseParameterEvent extends Event 
    {

        private var var_2724:String;

        public function SetExtraPurchaseParameterEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(WidgetEvent.var_1653, param2, param3);
            this.var_2724 = param1;
        }

        public function get parameter():String
        {
            return (this.var_2724);
        }

    }
}