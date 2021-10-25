package com.sulake.habbo.catalog.viewer.widgets
{

    import com.sulake.core.window.IWindowContainer;

    import flash.events.IEventDispatcher;

    import com.sulake.habbo.catalog.viewer.ICatalogPage;

    public class CatalogWidget
    {

        protected var _window: IWindowContainer;
        private var _events: IEventDispatcher;
        private var _page: ICatalogPage;
        private var _disposed: Boolean;

        public function CatalogWidget(window: IWindowContainer)
        {
            this._window = window;
        }

        public function set page(value: ICatalogPage): void
        {
            this._page = value;
        }

        public function set events(value: IEventDispatcher): void
        {
            this._events = value;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        public function get events(): IEventDispatcher
        {
            return this._events;
        }

        public function get page(): ICatalogPage
        {
            return this._page;
        }

        public function dispose(): void
        {
            this._events = null;
            this._page = null;
            this._window = null;
            this._disposed = true;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function init(): Boolean
        {
            return true;
        }

        public function closed(): void
        {
        }

    }
}
