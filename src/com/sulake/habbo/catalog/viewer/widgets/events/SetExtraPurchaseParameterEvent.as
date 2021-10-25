package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    public class SetExtraPurchaseParameterEvent extends Event
    {

        private var _parameter: String;

        public function SetExtraPurchaseParameterEvent(parameter: String, param2: Boolean = false, param3: Boolean = false)
        {
            super(WidgetEvent.var_1653, param2, param3);

            this._parameter = parameter;
        }

        public function get parameter(): String
        {
            return this._parameter;
        }

    }
}
