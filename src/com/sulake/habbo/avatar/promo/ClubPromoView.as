package com.sulake.habbo.avatar.promo
{

    import com.sulake.habbo.avatar.common.ISideContentView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ClubPromoView implements ISideContentView
    {

        private var var_2446: ClubPromoModel;
        private var _window: IWindowContainer;

        public function ClubPromoView(param1: ClubPromoModel)
        {
            var _loc2_: XmlAsset;
            super();
            this.var_2446 = param1;
            if (this.var_2446 && this.var_2446.controller && this.var_2446.controller.assets)
            {
                _loc2_ = (this.var_2446.controller.assets.getAssetByName("avatareditor_club_promo_try") as XmlAsset);
                if (_loc2_)
                {
                    this._window = (this.var_2446.controller.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer);
                    this._window.visible = false;
                    this._window.procedure = this.windowEventProc;
                }

            }

        }

        public function dispose(): void
        {
            this.var_2446 = null;
        }

        public function getWindowContainer(): IWindowContainer
        {
            return this._window;
        }

        public function showBuyView(): void
        {
            var _loc1_: XmlAsset;
            if (this.var_2446 && this.var_2446.controller && this.var_2446.controller.assets)
            {
                _loc1_ = (this.var_2446.controller.assets.getAssetByName("avatareditor_club_promo_buy") as XmlAsset);
                if (_loc1_)
                {
                    this._window = (this.var_2446.controller.windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer);
                    this._window.visible = false;
                    this._window.procedure = this.windowEventProc;
                }

            }

        }

        private function windowEventProc(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "try_clothes_btn":
                        if (this.var_2446)
                        {
                            this.var_2446.tryClubClothes();
                        }

                        return;
                    case "club_info_btn":
                        if (this.var_2446 && this.var_2446.controller && this.var_2446.controller.catalog)
                        {
                            this.var_2446.controller.catalog.openCatalogPage(CatalogPageName.var_159, true);
                        }

                        return;
                    default:
                        Logger.log("No event proc for element in Club Promo View");
                }

            }

        }

    }
}
