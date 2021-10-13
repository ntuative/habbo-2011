package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.Purse;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;

    public class PurchaseCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var var_2770:XML;
        private var var_2771:XML;
        private var var_2772:XML;
        private var var_2773:IWindowContainer;
        private var var_2774:IButtonWindow;
        private var var_2775:IButtonWindow;
        private var var_2776:ITextWindow;
        private var var_2777:ITextWindow;
        private var var_2778:ITextWindow;
        private var var_2779:ITextWindow;
        private var var_2607:Offer;
        private var var_2780:String = "";
        private var var_2781:Function;

        public function PurchaseCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            events.removeEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.removeEventListener(WidgetEvent.var_1653, this.onSetParameter);
            events.removeEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE, this.onPurchaseOverride);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            var _loc1_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsStub") as XmlAsset);
            if (_loc1_ != null)
            {
                this.var_2770 = (_loc1_.content as XML);
            };
            var _loc2_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetPixelsStub") as XmlAsset);
            if (_loc2_ != null)
            {
                this.var_2771 = (_loc2_.content as XML);
            };
            var _loc3_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsPixelsStub") as XmlAsset);
            if (_loc3_ != null)
            {
                this.var_2772 = (_loc3_.content as XML);
            };
            var _loc4_:XmlAsset = (page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsOrCreditsAndPixelsStub") as XmlAsset);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.addEventListener(WidgetEvent.var_1653, this.onSetParameter);
            events.addEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE, this.onPurchaseOverride);
            events.addEventListener(WidgetEvent.CWE_INIT_PURCHASE, this.initPurchase);
            return (true);
        }

        private function onPurchaseOverride(param1:CatalogWidgetPurchaseOverrideEvent):void
        {
            this.var_2781 = param1.callback;
        }

        private function attachStub(param1:String):void
        {
            var _loc2_:IWindowContainer;
            switch (param1)
            {
                case Offer.var_716:
                    _loc2_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_2770) as IWindowContainer);
                    break;
                case Offer.var_787:
                    _loc2_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_2771) as IWindowContainer);
                    break;
                case Offer.var_788:
                    _loc2_ = (page.viewer.catalog.windowManager.buildFromXML(this.var_2772) as IWindowContainer);
                    break;
                default:
                    Logger.log(("Unknown price-type, can't attach..." + this.var_2607.priceType));
            };
            if (_loc2_ != null)
            {
                if (this.var_2773 != null)
                {
                    _window.removeChild(this.var_2773);
                    this.var_2773.dispose();
                };
                this.var_2773 = _loc2_;
                _window.addChild(_loc2_);
                this.var_2773.x = 0;
                this.var_2773.y = 0;
            };
            this.var_2776 = (_window.findChildByName("ctlg_price_credits") as ITextWindow);
            this.var_2777 = (_window.findChildByName("ctlg_price_pixels") as ITextWindow);
            this.var_2778 = (_window.findChildByName("ctlg_price_credits_pixels") as ITextWindow);
            this.var_2779 = (_window.findChildByName("ctlg_special_txt") as ITextWindow);
            this.var_2774 = (window.findChildByName("ctlg_buy_button") as IButtonWindow);
            if (this.var_2774 != null)
            {
                if (this.var_2781 != null)
                {
                    this.var_2774.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.var_2781);
                }
                else
                {
                    this.var_2774.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.var_2781);
                    this.var_2774.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPurchase);
                };
                this.var_2774.disable();
            };
        }

        private function onSelectProduct(param1:SelectProductEvent):void
        {
            var _loc4_:String;
            var _loc2_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            this.var_2607 = param1.offer;
            this.attachStub(this.var_2607.priceType);
            if (this.var_2776 != null)
            {
                _loc2_.registerParameter("catalog.purchase.price.credits", "credits", String(this.var_2607.priceInCredits));
                this.var_2776.caption = "${catalog.purchase.price.credits}";
            };
            var _loc3_:String = ((this.var_2607.activityPointType == Purse.var_142) ? "pixels" : "activitypoints");
            if (this.var_2777 != null)
            {
                _loc4_ = ("catalog.purchase.price.activitypoints." + this.var_2607.activityPointType);
                _loc2_.registerParameter(_loc4_, _loc3_, this.var_2607.priceInActivityPoints.toString());
                this.var_2777.caption = _loc2_.getKey(_loc4_);
            };
            if (this.var_2778 != null)
            {
                _loc4_ = ("catalog.purchase.price.credits+activitypoints." + this.var_2607.activityPointType);
                _loc2_.registerParameter(_loc4_, "credits", String(this.var_2607.priceInCredits));
                _loc2_.registerParameter(_loc4_, _loc3_, String(this.var_2607.priceInActivityPoints));
                this.var_2778.caption = _loc2_.getKey(_loc4_);
            };
            var _loc5_:IWindow = _window.findChildByName("activity_points_bg");
            if (_loc5_ != null)
            {
                _loc5_.color = ((this.var_2607.activityPointType == 0) ? 6737151 : 0xCCCCCC);
            };
            if (this.var_2774 != null)
            {
                this.var_2774.enable();
            };
        }

        private function onSetParameter(param1:SetExtraPurchaseParameterEvent):void
        {
            this.var_2780 = param1.parameter;
        }

        private function onPurchase(param1:WindowMouseEvent):void
        {
            if (this.var_2607 != null)
            {
                (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this.var_2607, page.pageId, this.var_2780);
            };
        }

        private function initPurchase(param1:CatalogWidgetInitPurchaseEvent):void
        {
            if (this.var_2607 != null)
            {
                (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this.var_2607, page.pageId, this.var_2780, param1.enableBuyAsGift);
            };
        }

    }
}