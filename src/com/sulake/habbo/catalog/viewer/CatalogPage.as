package com.sulake.habbo.catalog.viewer
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.viewer.widgets.ICatalogWidget;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.CatalogWidgetEnum;
    import com.sulake.habbo.catalog.viewer.widgets.ItemGroupCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SongDiskProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PurseCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpacesCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpacesNewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RoomPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.NewPetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RecyclerCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RecyclerPrizesCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.BotCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ActivityPointDisplayCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MadMoneyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;

    import flash.events.Event;

    public class CatalogPage implements ICatalogPage
    {

        protected static const ASSET_PREFIX: String = "ctlg_";

        protected var _layout: XML;
        protected var _window: IWindowContainer;
        private var _viewer: ICatalogViewer;
        private var _pageId: int;
        private var _layoutCode: String;
        private var _offers: Array;
        private var _localization: IPageLocalization;
        private var _widgets: Array = [];
        private var _eventDispatcher: EventDispatcher;
        private var _catalog: HabboCatalog;
        private var _widget: ItemGridCatalogWidget;

        public function CatalogPage(param1: ICatalogViewer, param2: int, param3: String, param4: IPageLocalization, param5: Array, param6: HabboCatalog)
        {
            var _loc7_: CatalogPageMessageOfferData;
            var _loc8_: Array;
            var _loc9_: IProductData;
            var _loc10_: CatalogPageMessageProductData;
            var _loc11_: Offer;
            var _loc12_: IFurnitureData;
            var _loc13_: Product;
            super();
            this._viewer = param1;
            this._pageId = param2;
            this._layoutCode = param3;
            this._localization = param4;
            this._offers = [];
            this._catalog = param6;
            for each (_loc7_ in param5)
            {
                _loc8_ = [];
                _loc9_ = this._viewer.catalog.getProductData(_loc7_.localizationId);
                for each (_loc10_ in _loc7_.products)
                {
                    _loc12_ = this._viewer.catalog.getFurnitureData(_loc10_.furniClassId, _loc10_.productType);
                    _loc13_ = new Product(_loc10_.productType, _loc10_.furniClassId, _loc10_.extraParam, _loc10_.productCount, _loc10_.expiration, _loc9_, _loc12_);
                    _loc8_.push(_loc13_);
                }

                _loc11_ = new Offer(_loc7_.offerId, _loc7_.localizationId, _loc7_.priceInCredits, _loc7_.priceInActivityPoints, _loc7_.activityPointType, _loc8_, this);
                if (_loc11_.productContainer != null)
                {
                    this._offers.push(_loc11_);
                }
                else
                {
                    _loc11_.dispose();
                }

            }

            this._eventDispatcher = new EventDispatcher();
            this._widgets = [];
            this.init();
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        public function get viewer(): ICatalogViewer
        {
            return this._viewer;
        }

        public function get pageId(): int
        {
            return this._pageId;
        }

        public function get layoutCode(): String
        {
            return this._layoutCode;
        }

        public function get offers(): Array
        {
            return this._offers;
        }

        public function get localization(): IPageLocalization
        {
            return this._localization;
        }

        public function get links(): Array
        {
            return this._localization.getLinks(this._layoutCode);
        }

        public function get hasLinks(): Boolean
        {
            return this._localization.hasLinks(this._layoutCode);
        }

        public function selectOffer(offerId: int): void
        {
            var offer: Offer;
            var gridItem: IGridItem;

            if (this._widget != null)
            {
                Logger.log("selecting offer " + offerId);

                for each (offer in this._offers)
                {
                    if (offer.offerId == offerId)
                    {
                        gridItem = (offer.productContainer as IGridItem);

                        this._widget.select(gridItem);
                    }

                }

            }

        }

        public function dispose(): void
        {
            var widget: ICatalogWidget;
            var offer: Offer;

            for each (widget in this._widgets)
            {
                widget.dispose();
            }


            this._widgets = null;
            this._localization.dispose();

            for each (offer in this._offers)
            {
                offer.dispose();
            }


            this._offers = [];

            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            }


            if (this._eventDispatcher != null)
            {
                this._eventDispatcher.dispose();
                this._eventDispatcher = null;
            }


            this._viewer = null;
            this._layout = null;
            this._pageId = 0;
            this._layoutCode = "";
        }

        public function init(): void
        {
            if (this.createWindow(this.layoutCode))
            {
                this.createWidgets();
            }

        }

        public function closed(): void
        {
            var widget: ICatalogWidget;

            if (this._widgets != null)
            {
                for each (widget in this._widgets)
                {
                    widget.closed();
                }

            }

        }

        protected function createWindow(layoutId: String): Boolean
        {
            var layoutName: String = ASSET_PREFIX + layoutId;
            var layout: XmlAsset = this.viewer.catalog.assets.getAssetByName(layoutName) as XmlAsset;

            if (layout == null)
            {
                Logger.log("Could not find asset for layout " + layoutName);
                return false;
            }


            this._layout = (layout.content as XML);
            this._window = (this.viewer.catalog.windowManager.buildFromXML(this._layout) as IWindowContainer);

            if (this._window == null)
            {
                Logger.log("Could not create layout " + layoutId);
                return false;
            }


            return true;
        }

        private function localize(): void
        {
        }

        private function createWidgets(): void
        {
            this.createWidgetsRecursion(this._window);
            this.initializeWidgets();
        }

        private function createWidgetsRecursion(window: IWindowContainer): void
        {
            var i: int = 0;
            var child: IWindowContainer;

            if (window != null)
            {
                while (i < window.numChildren)
                {
                    child = (window.getChildAt(i) as IWindowContainer);

                    if (child != null)
                    {
                        this.createWidget(child);
                        this.createWidgetsRecursion(child);
                    }


                    i++;
                }

            }

        }

        private function createWidget(container: IWindowContainer): void
        {
            if (container == null)
            {
                return;
            }

            switch (container.name)
            {
                case CatalogWidgetEnum.var_1658:
                    if (this._widget == null)
                    {
                        this._widget = new ItemGridCatalogWidget(container);
                        this._widgets.push(this._widget);
                    }

                    return;
                case CatalogWidgetEnum.var_1659:
                    this._widgets.push(new ItemGroupCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1660:
                    this._widgets.push(new ProductViewCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1661:
                    this._widgets.push(new SongDiskProductViewCatalogWidget(container, this._catalog.soundManager));
                    return;
                case CatalogWidgetEnum.var_1662:
                    this._widgets.push(new SingleViewCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1663:
                    this._widgets.push(new PurchaseCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1664:
                    this._widgets.push(new PurseCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1665:
                    this._widgets.push(new ColourGridCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1666:
                    this._widgets.push(new TraxPreviewCatalogWidget(container, this._catalog.soundManager));
                    return;
                case CatalogWidgetEnum.var_1667:
                    this._widgets.push(new RedeemItemCodeCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1668:
                    this._widgets.push(new SpacesCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1669:
                    this._widgets.push(new SpacesNewCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1670:
                    this._widgets.push(new RoomPreviewCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1671:
                    this._widgets.push(new TrophyCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1672:
                    this._widgets.push(new PetsCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1673:
                    this._widgets.push(new NewPetsCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1674:
                    this._widgets.push(new TextInputCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1675:
                    this._widgets.push(new SpecialInfoWidget(container));
                    return;
                case CatalogWidgetEnum.var_1676:
                    this._widgets.push(new RecyclerCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1677:
                    this._widgets.push(new RecyclerPrizesCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1678:
                    this._widgets.push(new BotCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1679:
                    this._widgets.push(new MarketPlaceCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1680:
                    this._widgets.push(new MarketPlaceOwnItemsCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1681:
                    this._widgets.push(new ClubGiftWidget(container, this._catalog.getClubGiftController()));
                    return;
                case CatalogWidgetEnum.var_1682:
                    this._widgets.push(new ClubBuyCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1683:
                    this._widgets.push(new ActivityPointDisplayCatalogWidget(container));
                    return;
                case CatalogWidgetEnum.var_1684:
                    this._widgets.push(new MadMoneyCatalogWidget(container));
                    return;
            }

        }

        private function initializeWidgets(): void
        {
            var widget: ICatalogWidget;
            var widgets: Array = [];

            for each (widget in this._widgets)
            {
                widget.page = this;
                widget.events = this._eventDispatcher;

                if (!widget.init())
                {
                    widgets.push(widget);
                }

            }


            this.removeWidgets(widgets);
            this.initializeLocalizations();
            this._eventDispatcher.dispatchEvent(new CatalogWidgetsInitializedEvent());
        }

        private function initializeLocalizations(): void
        {
            var widget: ICatalogWidget = new LocalizationCatalogWidget(this._window);

            this._widgets.push(widget);

            widget.page = this;
            widget.events = this._eventDispatcher;

            widget.init();
        }

        private function removeWidgets(param1: Array): void
        {
            var _loc2_: ICatalogWidget;
            var _loc3_: ICatalogWidget;
            var _loc4_: int;
            if (param1 == null || param1.length == 0)
            {
                return;
            }

            for each (_loc2_ in this._widgets)
            {
                if (_loc2_.window != null)
                {
                    for each (_loc3_ in param1)
                    {
                        if (_loc3_.window != null)
                        {
                            if (_loc3_.window.getChildIndex(_loc2_.window) >= 0)
                            {
                                if (param1.indexOf(_loc2_) < 0)
                                {
                                    param1.push(_loc2_);
                                }

                                break;
                            }

                        }

                    }

                }

            }

            for each (_loc3_ in param1)
            {
                if (_loc3_.window != null)
                {
                    this._window.removeChild(_loc3_.window);
                    _loc3_.window.dispose();
                }

                _loc4_ = this._widgets.indexOf(_loc3_);
                if (_loc4_ >= 0)
                {
                    this._widgets.splice(_loc4_, 1);
                }

                _loc3_.dispose();
            }

        }

        public function dispatchWidgetEvent(param1: Event): Boolean
        {
            if (this._eventDispatcher != null)
            {
                return this._eventDispatcher.dispatchEvent(param1);
            }

            return false;
        }

        public function replaceOffers(param1: Array, param2: Boolean = false): void
        {
            var _loc3_: Offer;
            if (param2)
            {
                for each (_loc3_ in this._offers)
                {
                    _loc3_.dispose();
                }

            }

            this._offers = param1;
        }

    }
}
