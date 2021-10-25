package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    public class CatalogWidgetPurchaseOverrideEvent extends Event
    {

        private var _callback: Function;

        public function CatalogWidgetPurchaseOverrideEvent(callback: Function, param2: Boolean = false, param3: Boolean = false)
        {
            super(WidgetEvent.CWE_PURCHASE_OVERRIDE, param2, param3);

            this._callback = callback;
        }

        public function get callback(): Function
        {
            return this._callback;
        }

    }
}
