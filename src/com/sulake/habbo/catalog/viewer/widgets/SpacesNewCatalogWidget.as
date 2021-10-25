package com.sulake.habbo.catalog.viewer.widgets
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements IDisposable, ICatalogWidget, IItemGrid
    {

        private var var_2063: XML;
        private var _groupNames: Array = ["wallpaper", "floor", "landscape"];
        private var var_2738: Array = [];
        private var var_2739: int = 0;
        private var var_2740: Array = [0, 0, 0];
        private var var_2809: ISelectorWindow;
        private var var_511: Array = ["group.walls", "group.floors", "group.views"];

        public function SpacesNewCatalogWidget(param1: IWindowContainer)
        {
            var _loc2_: int;
            var _loc3_: IWindow;
            super(param1);
            this.var_2809 = (_window.findChildByName("groups") as ISelectorWindow);
            if (this.var_2809)
            {
                _loc2_ = 0;
                while (_loc2_ < this.var_2809.numSelectables)
                {
                    _loc3_ = this.var_2809.getSelectableAt(_loc2_);
                    if (_loc3_ is ISelectableWindow)
                    {
                        _loc3_.addEventListener(WindowEvent.var_560, this.onSelectGroup);
                    }

                    _loc2_++;
                }

            }

        }

        override public function dispose(): void
        {
            var _loc1_: Array;
            var _loc2_: Offer;
            super.dispose();
            for each (_loc1_ in this.var_2738)
            {
                for each (_loc2_ in _loc1_)
                {
                    _loc2_.dispose();
                }

            }

            this.var_2738 = null;
        }

        override public function init(): Boolean
        {
            Logger.log("Init Item Group Catalog Widget (Spaces New)");
            this.createOfferGroups();
            if (!super.init())
            {
                return false;
            }

            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            this.switchCategory(this.var_511[this.var_2739]);
            this.updateRoomPreview();
            return true;
        }

        public function onWidgetsInitialized(param1: CatalogWidgetsInitializedEvent): void
        {
            var _loc2_: int = this.var_2740[this.var_2739];
            var _loc3_: Offer = this.var_2738[this.var_2739][_loc2_];
            this.select(_loc3_.productContainer as IGridItem);
        }

        public function selectIndex(param1: int): void
        {
            var _loc2_: Offer;
            if (param1 > -1 && param1 < var_2727.numGridItems)
            {
                _loc2_ = this.var_2738[this.var_2739][param1];
                this.select(_loc2_.productContainer as IGridItem);
            }

        }

        override public function select(param1: IGridItem): void
        {
            if (param1 == null)
            {
                return;
            }

            super.select(param1);
            var _loc2_: Offer = (param1 as ProductContainer).offer;
            if (_loc2_ == null)
            {
                return;
            }

            events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc2_.extraParameter));
            this.var_2740[this.var_2739] = (this.var_2738[this.var_2739] as Array).indexOf(_loc2_);
            this.updateRoomPreview();
        }

        private function updateRoomPreview(): void
        {
            var _loc1_: int = this.var_2740[0];
            var _loc2_: int = this.var_2740[1];
            var _loc3_: int = this.var_2740[2];
            var _loc4_: Offer = this.var_2738[0][_loc1_];
            var _loc5_: Offer = this.var_2738[1][_loc2_];
            var _loc6_: Offer = this.var_2738[2][_loc3_];
            if (!_loc5_ || !_loc4_ || !_loc6_)
            {
                return;
            }

            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_loc5_.extraParameter, _loc4_.extraParameter, _loc6_.extraParameter, 64));
        }

        private function createOfferGroups(): Boolean
        {
            var offer: Offer;
            var product: IProduct;
            var classId: int;
            var groupName: String;
            var index: int;
            var offerCode: String;
            var offerPrefix: String;
            var offerPostfix: String;
            var pattern: XML;
            var itemData: XML;
            var cloneOffer: Offer;
            var configurationAsset: XmlAsset = page.viewer.catalog.assets.getAssetByName("configuration_catalog_spaces") as XmlAsset;
            if (configurationAsset != null)
            {
                this.var_2063 = (configurationAsset.content as XML);
            }
            else
            {
                return false;
            }

            for each (offer in page.offers)
            {
                if (offer.pricingModel == Offer.PRICING_MODEL_SINGLE || offer.pricingModel == Offer.PRICING_MODEL_MULTI)
                {
                    product = offer.productContainer.firstProduct;
                    if (product != null)
                    {
                        classId = product.productClassId;
                        if (product.productType == ProductTypeEnum.var_113 || product.productType == ProductTypeEnum.var_112)
                        {
                            if (product.furnitureData != null)
                            {
                                groupName = product.furnitureData.name;
                                index = this._groupNames.indexOf(groupName);
                                offerCode = offer.localizationId;
                                offerPrefix = offerCode.split(" ")[0];
                                offerPostfix = offerCode.split(" ")[1];
                                if (this._groupNames.indexOf(groupName) == -1)
                                {
                                    this._groupNames.push(groupName);
                                }

                                while (this.var_2738.length < this._groupNames.length)
                                {
                                    this.var_2738.push([]);
                                }

                                switch (groupName)
                                {
                                    case "floor":
                                        for each (pattern in this.var_2063.floors.pattern)
                                        {
                                            for each (itemData in pattern.floor)
                                            {
                                                cloneOffer = offer.clone();
                                                cloneOffer.extraParameter = itemData.@id;
                                                (this.var_2738[index] as Array).push(cloneOffer);
                                            }

                                        }

                                        break;
                                    case "wallpaper":
                                        pattern = (this.var_2063.walls.pattern.(@id == offerPostfix)[0] as XML);
                                        if (pattern)
                                        {
                                            for each (itemData in pattern.wall)
                                            {
                                                cloneOffer = offer.clone();
                                                cloneOffer.extraParameter = itemData.@id;
                                                (this.var_2738[index] as Array).push(cloneOffer);
                                            }

                                        }

                                        break;
                                    case "landscape":
                                        pattern = (this.var_2063.landscapes.pattern.(@id == offerPostfix)[0] as XML);
                                        if (pattern)
                                        {
                                            for each (itemData in pattern.landscape)
                                            {
                                                cloneOffer = offer.clone();
                                                cloneOffer.extraParameter = itemData.@id;
                                                (this.var_2738[index] as Array).push(cloneOffer);
                                            }

                                        }

                                        break;
                                    default:
                                        Logger.log("[SpacesCatalogWidget] : " + groupName);
                                }

                            }

                        }

                    }

                }

            }

            page.replaceOffers([], true);
            return true;
        }

        private function onSelectGroup(param1: WindowEvent): void
        {
            var _loc3_: int;
            var _loc2_: ISelectableWindow = param1.target as ISelectableWindow;
            if (_loc2_)
            {
                _loc3_ = this.var_2809.getSelectableIndex(_loc2_);
                Logger.log("select: " + [_loc2_.name, _loc3_]);
                this.switchCategory(_loc2_.name);
            }

        }

        private function switchCategory(param1: String): void
        {
            var _loc3_: int;
            if (disposed)
            {
                return;
            }

            if (!this.var_2809)
            {
                return;
            }

            this.var_2809.setSelected(this.var_2809.getSelectableByName(param1));
            var _loc2_: int = -1;
            switch (param1)
            {
                case "group.walls":
                    _loc2_ = 0;
                    break;
                case "group.floors":
                    _loc2_ = 1;
                    break;
                case "group.views":
                    _loc2_ = 2;
                    break;
                default:
                    _loc2_ = -1;
            }

            if (_loc2_ > -1)
            {
                if (var_2730 != null)
                {
                    var_2730.deActivate();
                }

                var_2730 = null;
                this.var_2739 = _loc2_;
                if (var_2727)
                {
                    var_2727.destroyGridItems();
                }

                page.replaceOffers(this.var_2738[this.var_2739], false);
                resetTimer();
                populateItemGrid();
                loadItemGridGraphics();
                if (var_2270)
                {
                    var_2270.start();
                }

                _loc3_ = this.var_2740[this.var_2739];
                this.selectIndex(_loc3_);
            }

        }

    }
}
