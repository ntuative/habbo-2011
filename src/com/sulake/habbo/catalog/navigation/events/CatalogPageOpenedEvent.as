package com.sulake.habbo.catalog.navigation.events
{
    import flash.events.Event;

    public class CatalogPageOpenedEvent extends Event 
    {

        public static const CATALOG_PAGE_OPENED:String = "CATALOG_PAGE_OPENED";

        private var var_2608:int;
        private var var_2654:String;

        public function CatalogPageOpenedEvent(param1:int, param2:String, param3:Boolean=false, param4:Boolean=false)
        {
            super(CATALOG_PAGE_OPENED, param3, param4);
            this.var_2608 = param1;
            this.var_2654 = param2;
        }

        public function get pageId():int
        {
            return (this.var_2608);
        }

        public function get pageLocalization():String
        {
            return (this.var_2654);
        }

    }
}