package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    import com.sulake.habbo.catalog.viewer.Offer;

    public class SelectProductEvent extends Event
    {

        private var _offer: Offer;

        public function SelectProductEvent(offer: Offer, param2: Boolean = false, param3: Boolean = false)
        {
            super(WidgetEvent.CWE_SELECT_PRODUCT, param2, param3);

            this._offer = offer;
        }

        public function get offer(): Offer
        {
            return this._offer;
        }

    }
}
