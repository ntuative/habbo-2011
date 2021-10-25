package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    public class CatalogWidgetApproveNameResultEvent extends Event
    {

        private var _result: int;
        private var _nameValidationInfo: String;

        public function CatalogWidgetApproveNameResultEvent(result: int, nameValidationInfo: String, param3: Boolean = false, param4: Boolean = false)
        {
            super(WidgetEvent.var_662, param3, param4);
            this._result = result;
            this._nameValidationInfo = nameValidationInfo;
        }

        public function get result(): int
        {
            return this._result;
        }

        public function get nameValidationInfo(): String
        {
            return this._nameValidationInfo;
        }

    }
}
