package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetInitPurchaseEvent extends Event 
    {

        private var var_2720:Boolean = true;

        public function CatalogWidgetInitPurchaseEvent(param1:Boolean=true, param2:Boolean=false, param3:Boolean=false)
        {
            super(WidgetEvent.CWE_INIT_PURCHASE, param2, param3);
            this.var_2720 = param1;
        }

        public function get enableBuyAsGift():Boolean
        {
            return (this.var_2720);
        }

    }
}