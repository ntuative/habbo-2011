package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    public class CatalogWidgetInitPurchaseEvent extends Event
    {

        private var _enableBuyAsGift: Boolean = true;

        public function CatalogWidgetInitPurchaseEvent(enableBuyAsGift: Boolean = true, param2: Boolean = false, param3: Boolean = false)
        {
            super(WidgetEvent.CWE_INIT_PURCHASE, param2, param3);

            this._enableBuyAsGift = enableBuyAsGift;
        }

        public function get enableBuyAsGift(): Boolean
        {
            return this._enableBuyAsGift;
        }

    }
}
