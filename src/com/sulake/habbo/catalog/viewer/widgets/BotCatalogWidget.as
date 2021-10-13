package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.RentableBotDefinitionWidgetEvent;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import flash.geom.Point;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;

    public class BotCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid, IAvatarImageListener 
    {

        private var var_2725:Map;
        private var var_2726:Offer;
        protected var var_2727:IItemGridWindow;
        protected var var_2728:XML;
        private var var_2729:Map;
        private var var_2730:IGridItem;

        public function BotCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
            this.var_2727 = (_window.findChildByName("botGrid") as IItemGridWindow);
            this.var_2729 = new Map();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            (page.viewer.catalog as HabboCatalog).getRentableBotDefinitions();
            events.addEventListener(WidgetEvent.CWE_RENTABLE_BOT_DEFINITIONS, this.onBotDefinitions);
            var _loc1_:IWindow = window.findChildByName("ctlg_buy_button");
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBuyButtonEvent);
            return (true);
        }

        private function onBuyButtonEvent(param1:WindowEvent):void
        {
            (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this.var_2726, page.pageId);
        }

        private function onBotDefinitions(param1:RentableBotDefinitionWidgetEvent):void
        {
            this.var_2725 = param1.botFigureData;
            this.populateGridItems();
        }

        private function populateGridItems():void
        {
            var _loc3_:Offer;
            var _loc1_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("BotgridItem") as XmlAsset);
            this.var_2728 = (_loc1_.content as XML);
            var _loc2_:int;
            while (_loc2_ < page.offers.length)
            {
                _loc3_ = page.offers[_loc2_];
                this.createGridItem(_loc3_);
                _loc3_.productContainer.grid = this;
                if (_loc2_ == 0)
                {
                    this.select((_loc3_.productContainer as IGridItem));
                };
                _loc2_++;
            };
        }

        protected function createGridItem(param1:Offer):void
        {
            var _loc6_:BitmapData;
            var _loc2_:IWindowContainer = (page.viewer.catalog.windowManager.buildFromXML(this.var_2728) as IWindowContainer);
            this.var_2727.addGridItem(_loc2_);
            param1.productContainer.view = _loc2_;
            var _loc3_:String = this.var_2725.getValue(param1.productContainer.firstProduct.extraParam.toLowerCase());
            var _loc4_:IBitmapWrapperWindow = (_loc2_.findChildByName("image") as IBitmapWrapperWindow);
            _loc4_.bitmap = new BitmapData(_loc4_.width, _loc4_.height, true, 0xFFFFFF);
            var _loc5_:IAvatarImage = (page.viewer.catalog as HabboCatalog).avatarRenderManager.createAvatarImage(_loc3_, AvatarScaleType.var_305, null, this);
            if (_loc5_)
            {
                _loc5_.setDirection(AvatarSetType.var_136, 4);
                _loc6_ = _loc5_.getImage(AvatarSetType.var_136, true);
                _loc4_.bitmap.copyPixels(_loc6_, _loc6_.rect, new Point(((_loc4_.width - _loc6_.width) / 2), (_loc4_.height - _loc6_.height)));
                _loc4_.invalidate();
                this.var_2729.add(_loc3_, param1.offerId);
                _loc5_.dispose();
            };
        }

        private function updatePreviewImage():void
        {
            var _loc1_:String = this.var_2725.getValue(this.var_2726.productContainer.firstProduct.extraParam.toLowerCase());
            var _loc2_:IAvatarImage = (page.viewer.catalog as HabboCatalog).avatarRenderManager.createAvatarImage(_loc1_, AvatarScaleType.var_106);
            if (_loc2_)
            {
                _loc2_.setDirection(AvatarSetType.var_136, 4);
                this.setPreviewImage(_loc2_.getImage(AvatarSetType.var_136, true));
                _loc2_.dispose();
            };
        }

        private function setProductData():void
        {
            var _loc5_:String;
            var _loc1_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _loc2_:ITextWindow = (_window.findChildByName("ctlg_price") as ITextWindow);
            if (_loc2_ != null)
            {
                _loc5_ = "catalog.purchase.price.credits+activitypoints.0";
                _loc1_.registerParameter(_loc5_, "credits", String(this.var_2726.priceInCredits));
                _loc1_.registerParameter(_loc5_, "pixels", String(this.var_2726.priceInActivityPoints));
                _loc2_.text = _loc1_.getKey(_loc5_);
            };
            var _loc3_:IProductData = page.viewer.catalog.getProductData(this.var_2726.localizationId);
            var _loc4_:ITextWindow = (_window.findChildByName("ctlg_product_name") as ITextWindow);
            if (_loc4_ != null)
            {
                if (_loc3_ != null)
                {
                    _loc4_.text = _loc3_.name;
                }
                else
                {
                    _loc4_.text = "";
                };
            };
            _loc4_ = (_window.findChildByName("ctlg_description") as ITextWindow);
            if (_loc4_ != null)
            {
                if (_loc3_ != null)
                {
                    _loc4_.text = _loc3_.description;
                }
                else
                {
                    _loc4_.text = "";
                };
            };
        }

        private function setPreviewImage(param1:BitmapData):void
        {
            var _loc2_:IBitmapWrapperWindow = (window.findChildByName("big_bot_image") as IBitmapWrapperWindow);
            if (((_loc2_ == null) || (_loc2_.bitmap == null)))
            {
                _loc2_.bitmap = new BitmapData(_loc2_.width, _loc2_.height, true, 0xFFFFFF);
            };
            _loc2_.bitmap.copyPixels(param1, param1.rect, new Point((((_loc2_.width - param1.width) / 2) - 25), (_loc2_.height - param1.height)));
            _loc2_.invalidate();
        }

        public function select(param1:IGridItem):void
        {
            if (param1 == null)
            {
                return;
            };
            if (this.var_2730 != null)
            {
                this.var_2730.deActivate();
            };
            this.var_2730 = param1;
            param1.activate();
            var _loc2_:Offer = (param1 as ProductContainer).offer;
            if (_loc2_ != null)
            {
                this.var_2726 = _loc2_;
                this.updatePreviewImage();
                this.setProductData();
                events.dispatchEvent(new SelectProductEvent(_loc2_));
            };
        }

        public function startDragAndDrop(param1:IGridItem):Boolean
        {
            return (false);
        }

        public function avatarImageReady(param1:String):void
        {
            var _loc3_:Offer;
            var _loc4_:String;
            var _loc5_:IWindowContainer;
            var _loc6_:IBitmapWrapperWindow;
            var _loc7_:IAvatarImage;
            var _loc8_:BitmapData;
            var _loc2_:int = this.var_2729.getValue(param1);
            if (!page.offers)
            {
                return;
            };
            for each (_loc3_ in page.offers)
            {
                if (((((_loc3_.offerId == _loc2_) && (_loc3_.productContainer)) && (_loc3_.productContainer.view)) && (!(_loc3_.productContainer.view.disposed))))
                {
                    _loc4_ = this.var_2725.getValue(_loc3_.productContainer.firstProduct.extraParam.toLowerCase());
                    _loc5_ = _loc3_.productContainer.view;
                    _loc6_ = (_loc5_.findChildByName("image") as IBitmapWrapperWindow);
                    _loc7_ = (page.viewer.catalog as HabboCatalog).avatarRenderManager.createAvatarImage(_loc4_, AvatarScaleType.var_305, null);
                    if (_loc7_)
                    {
                        _loc7_.setDirection(AvatarSetType.var_136, 4);
                        _loc8_ = _loc7_.getImage(AvatarSetType.var_136, true);
                        _loc6_.bitmap.copyPixels(_loc8_, _loc8_.rect, new Point(((_loc6_.width - _loc8_.width) / 2), (_loc6_.height - _loc8_.height)));
                        _loc6_.invalidate();
                        _loc7_.dispose();
                        if (this.var_2726.offerId == _loc2_)
                        {
                            this.updatePreviewImage();
                        };
                    };
                };
            };
        }

    }
}