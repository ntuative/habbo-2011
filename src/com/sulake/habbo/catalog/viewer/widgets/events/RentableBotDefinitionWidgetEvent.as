package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;
    import com.sulake.core.utils.Map;

    public class RentableBotDefinitionWidgetEvent extends Event 
    {

        private var var_2723:Map;

        public function RentableBotDefinitionWidgetEvent(param1:Map, param2:Boolean=false, param3:Boolean=false)
        {
            super(WidgetEvent.CWE_RENTABLE_BOT_DEFINITIONS, param2, param3);
            this.var_2723 = param1;
        }

        public function get botFigureData():Map
        {
            return (this.var_2723);
        }

    }
}