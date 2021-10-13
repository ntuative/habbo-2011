package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    public class ItemGroupCatalogWidget extends ItemGridCatalogWidget implements ICatalogWidget, IItemGrid 
    {

        private var _groupNames:Array = new Array();
        private var var_2738:Array = new Array();
        private var var_2739:int = 0;
        private var var_2740:int = 0;

        public function ItemGroupCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function init():Boolean
        {
            Logger.log("Init Item Group Catalog Widget (Plasto)");
            this.createOfferGroups();
            var_2736 = false;
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX, this.onColourIndex);
            return (true);
        }

        public function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent):void
        {
            var _loc2_:Offer = this.var_2738[this.var_2739][this.var_2740];
            this.select((_loc2_.productContainer as IGridItem));
        }

        override public function select(param1:IGridItem):void
        {
            var _loc5_:Offer;
            var _loc6_:IFurnitureData;
            var _loc7_:int;
            if (param1 == null)
            {
                return;
            };
            super.select(param1);
            this.var_2739 = var_2727.getGridItemIndex(param1.view);
            var _loc2_:String = this._groupNames[this.var_2739];
            var _loc3_:Array = (this.var_2738[this.var_2739] as Array);
            var _loc4_:Array = new Array();
            for each (_loc5_ in _loc3_)
            {
                _loc6_ = _loc5_.productContainer.firstProduct.furnitureData;
                _loc7_ = _loc6_.colours[(_loc6_.colours.length - 1)];
                _loc4_.push(_loc7_);
            };
            Logger.log(((("Show the colors for current selection..." + _loc2_) + " ") + _loc4_.length));
            events.dispatchEvent(new CatalogWidgetColoursEvent(_loc4_, "ctlg_clr_40x32_1", "ctlg_clr_40x32_2", "ctlg_clr_40x32_3"));
        }

        override public function startDragAndDrop(param1:IGridItem):Boolean
        {
            return (false);
        }

        override protected function populateItemGrid():void
        {
            var _loc1_:Array;
            var _loc2_:Offer;
            for each (_loc1_ in this.var_2738)
            {
                if (this.var_2740 < _loc1_.length)
                {
                    _loc2_ = (_loc1_[this.var_2740] as Offer);
                    createGridItem(_loc2_);
                    loadGraphics(_loc2_);
                    _loc2_.productContainer.grid = this;
                };
            };
        }

        private function onColourIndex(param1:CatalogWidgetColourIndexEvent):void
        {
            var _loc2_:int = param1.index;
            var _loc3_:Array = (this.var_2738[this.var_2739] as Array);
            var _loc4_:Offer = (_loc3_[_loc2_] as Offer);
            if (_loc4_ != null)
            {
                events.dispatchEvent(new SelectProductEvent(_loc4_));
            };
        }

        private function createOfferGroups():void
        {
            var _loc1_:Offer;
            var _loc2_:Array;
            var _loc3_:IProduct;
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:int;
            for each (_loc1_ in page.offers)
            {
                if (((_loc1_.pricingModel == Offer.var_784) || (_loc1_.pricingModel == Offer.var_785)))
                {
                    _loc3_ = _loc1_.productContainer.firstProduct;
                    if (_loc3_ != null)
                    {
                        _loc4_ = _loc3_.productClassId;
                        if (((_loc3_.productType == ProductTypeEnum.var_113) || (_loc3_.productType == ProductTypeEnum.var_112)))
                        {
                            if (_loc3_.furnitureData != null)
                            {
                                _loc5_ = _loc3_.furnitureData.name;
                                if (this._groupNames.indexOf(_loc5_) == -1)
                                {
                                    this._groupNames.push(_loc5_);
                                    this.var_2738.push(new Array());
                                };
                                _loc6_ = this._groupNames.indexOf(_loc5_);
                                (this.var_2738[_loc6_] as Array).push(_loc1_);
                            };
                        };
                    };
                };
            };
            for each (_loc2_ in this.var_2738)
            {
                _loc2_.sort(this.sortByColor);
            };
        }

        private function sortByColor(param1:Offer, param2:Offer):int
        {
            var _loc3_:Number = param1.productContainer.firstProduct.furnitureData.colourIndex;
            var _loc4_:Number = param2.productContainer.firstProduct.furnitureData.colourIndex;
            if (_loc3_ > _loc4_)
            {
                return (1);
            };
            if (_loc3_ < _loc4_)
            {
                return (-1);
            };
            return (0);
        }

    }
}