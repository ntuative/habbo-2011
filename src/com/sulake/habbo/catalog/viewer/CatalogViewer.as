package com.sulake.habbo.catalog.viewer
{

    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.HabboCatalog;

    import flash.events.Event;

    public class CatalogViewer implements ICatalogViewer
    {

        private var _catalog: IHabboCatalog;
        private var _container: IWindowContainer;
        private var _roomEngine: IRoomEngine;
        private var _habboCatalog: HabboCatalog;
        private var _page: ICatalogPage;

        public function CatalogViewer(catalog: IHabboCatalog, container: IWindowContainer, roomEngine: IRoomEngine)
        {
            this._catalog = catalog;
            this._container = container;
            this._roomEngine = roomEngine;
        }

        public function get roomEngine(): IRoomEngine
        {
            return this._roomEngine;
        }

        public function set habboCatalog(catalog: HabboCatalog): void
        {
            this._habboCatalog = catalog;
        }

        public function get habboCatalog(): HabboCatalog
        {
            return this._habboCatalog;
        }

        public function dispose(): void
        {
        }

        public function get catalog(): IHabboCatalog
        {
            return this._catalog;
        }

        public function showCatalogPage(pageId: int, param2: String, param3: IPageLocalization, param4: Array, offerId: int): void
        {
            Logger.log("[Catalog Viewer] Show Catalog Page: " + [pageId, param2, param4.length, offerId]);

            if (this._page != null)
            {
                if (this._page.pageId == pageId)
                {
                    if (offerId > -1)
                    {
                        this._page.selectOffer(offerId);
                    }


                    return;
                }


                this._container.removeChild(this._page.window);
                this._page.dispose();
            }


            var page: ICatalogPage = new CatalogPage(this, pageId, param2, param3, param4, this._habboCatalog);
            this._page = page;

            if (page.window != null)
            {
                this._container.addChild(page.window);
            }
            else
            {
                Logger.log("[CatalogViewer] No window for page: " + param2);
            }


            this._container.visible = true;

            if (offerId > -1)
            {
                page.selectOffer(offerId);
            }

        }

        public function catalogWindowClosed(): void
        {
            if (this._page != null)
            {
                this._page.closed();
            }

        }

        public function dispatchWidgetEvent(param1: Event): Boolean
        {
            return this._page.dispatchWidgetEvent(param1);
        }

        public function getCurrentLayoutCode(): String
        {
            if (this._page == null)
            {
                return "";
            }

            return this._page.layoutCode;
        }

    }
}
