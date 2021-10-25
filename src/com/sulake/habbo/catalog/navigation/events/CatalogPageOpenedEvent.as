package com.sulake.habbo.catalog.navigation.events
{

    import flash.events.Event;

    public class CatalogPageOpenedEvent extends Event
    {

        public static const CATALOG_PAGE_OPENED: String = "CATALOG_PAGE_OPENED";

        private var _pageId: int;
        private var _pageLocalization: String;

        public function CatalogPageOpenedEvent(pageId: int, pageLocalization: String, param3: Boolean = false, param4: Boolean = false)
        {
            super(CATALOG_PAGE_OPENED, param3, param4);

            this._pageId = pageId;
            this._pageLocalization = pageLocalization;
        }

        public function get pageId(): int
        {
            return this._pageId;
        }

        public function get pageLocalization(): String
        {
            return this._pageLocalization;
        }

    }
}
