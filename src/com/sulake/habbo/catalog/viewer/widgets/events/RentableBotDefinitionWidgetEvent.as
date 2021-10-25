package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    import com.sulake.core.utils.Map;

    public class RentableBotDefinitionWidgetEvent extends Event
    {

        private var _botFigureData: Map;

        public function RentableBotDefinitionWidgetEvent(botFigureData: Map, param2: Boolean = false, param3: Boolean = false)
        {
            super(WidgetEvent.CWE_RENTABLE_BOT_DEFINITIONS, param2, param3);

            this._botFigureData = botFigureData;
        }

        public function get botFigureData(): Map
        {
            return this._botFigureData;
        }

    }
}
