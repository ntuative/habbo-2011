package com.sulake.habbo.catalog.viewer.widgets
{

    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.catalog.viewer.IGridItem;

    import flash.utils.Timer;

    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;

    import flash.events.TimerEvent;

    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.BundleProductContainer;

    public class ItemGridCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid, IDragAndDropDoneReceiver
    {

        protected var var_2727: IItemGridWindow;
        protected var var_2728: XML;
        protected var var_2730: IGridItem;
        private var var_2735: int = 0;
        protected var var_2270: Timer;
        protected var var_2736: Boolean = true;
        private var var_2737: int = 0;
        private var _scrollBar: IScrollbarWindow;

        public function ItemGridCatalogWidget(param1: IWindowContainer)
        {
            super(param1);
            this._scrollBar = (_window.findChildByName("itemGridScrollbar") as IScrollbarWindow);
            if (this._scrollBar != null)
            {
                this._scrollBar.visible = false;
                this._scrollBar.addEventListener(WindowEvent.var_567, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.var_568, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.var_569, this.deActivateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.var_570, this.deActivateScrollbar);
            }

        }

        override public function dispose(): void
        {
            if (this.var_2270 != null)
            {
                this.var_2270.stop();
                this.var_2270.removeEventListener(TimerEvent.TIMER, this.populateItemGrid);
                this.var_2270 = null;
            }

            if (this.var_2727 != null)
            {
                this.var_2727.destroyGridItems();
                this.var_2727 = null;
            }

            this.var_2728 = null;
            this.var_2730 = null;
            super.dispose();
        }

        override public function init(): Boolean
        {
            if (!super.init())
            {
                return false;
            }

            this.var_2727 = (_window.findChildByName("itemGrid") as IItemGridWindow);
            var _loc1_: XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
            this.var_2728 = (_loc1_.content as XML);
            this.populateItemGrid();
            this.loadItemGridGraphics();
            if (this.var_2736)
            {
                this.var_2270 = new Timer(25);
                this.var_2270.addEventListener(TimerEvent.TIMER, this.loadItemGridGraphics);
                this.var_2270.start();
            }

            return true;
        }

        public function select(param1: IGridItem): void
        {
            if (this.var_2730 != null)
            {
                this.var_2730.deActivate();
            }

            this.var_2730 = param1;
            param1.activate();
            var _loc2_: Offer = (param1 as ProductContainer).offer;
            if (_loc2_ != null)
            {
                events.dispatchEvent(new SelectProductEvent(_loc2_));
            }

        }

        public function startDragAndDrop(param1: IGridItem): Boolean
        {
            var _loc2_: Offer = (param1 as ProductContainer).offer;
            if (_loc2_ != null)
            {
                (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this, _loc2_);
            }

            return true;
        }

        public function onDragAndDropDone(param1: Boolean): void
        {
            if (disposed)
            {
                return;
            }

            if (param1)
            {
                events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false));
            }

        }

        public function stopDragAndDrop(): void
        {
        }

        protected function populateItemGrid(): void
        {
            var _loc1_: Offer;
            for each (_loc1_ in page.offers)
            {
                this.createGridItem(_loc1_);
                _loc1_.productContainer.grid = this;
            }

        }

        protected function resetTimer(): void
        {
            if (this.var_2270)
            {
                this.var_2270.removeEventListener(TimerEvent.TIMER, this.populateItemGrid);
                this.var_2270.reset();
            }

            this.var_2737 = 0;
        }

        protected function loadItemGridGraphics(param1: TimerEvent = null): void
        {
            var _loc3_: Offer;
            if (param1 != null)
            {
            }

            var _loc2_: int;
            while (_loc2_ < 3)
            {
                if (this.var_2737 >= 0 && this.var_2737 < page.offers.length)
                {
                    _loc3_ = page.offers[this.var_2737];
                    this.loadGraphics(_loc3_);
                    _loc3_.productContainer.grid = this;
                }

                this.var_2737++;
                if (this.var_2737 >= page.offers.length)
                {
                    this.resetTimer();
                    return;
                }

                _loc2_++;
            }

        }

        private function activateScrollbar(param1: WindowEvent): void
        {
            (param1.target as IWindow).visible = true;
        }

        private function deActivateScrollbar(param1: WindowEvent): void
        {
            (param1.target as IWindow).visible = false;
        }

        protected function createGridItem(param1: Offer): void
        {
            var _loc2_: IWindowContainer = page.viewer.catalog.windowManager.buildFromXML(this.var_2728) as IWindowContainer;
            this.var_2727.addGridItem(_loc2_);
            param1.productContainer.view = _loc2_;
            if (param1.pricingModel == Offer.PRICING_MODEL_BUNDLE)
            {
                this.var_2735++;
                (param1.productContainer as BundleProductContainer).setBundleCounter(this.var_2735);
            }

        }

        protected function loadGraphics(param1: Offer): void
        {
            param1.productContainer.initProductIcon(page.viewer.roomEngine);
        }

    }
}
