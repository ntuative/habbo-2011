package com.sulake.habbo.help.tutorial
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.display.BitmapData;

    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class TutorialClothesChangeView implements ITutorialUIView
    {

        private var var_3486: TutorialUI;
        private var var_3502: IWindowContainer;

        public function TutorialClothesChangeView(param1: IItemListWindow, param2: TutorialUI): void
        {
            this.var_3486 = param2;
            var _loc3_: IWindowContainer = param2.buildXmlWindow("tutorial_change_clothes") as IWindowContainer;
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.procedure = this.windowProcedure;
            param1.addListItem(_loc3_ as IWindow);
            this.setToolbarIconHighlight(true);
            this.var_3486.help.toolbar.events.addEventListener(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN, this.onShowMenuEvent);
            this.var_3486.prepareForTutorial();
        }

        public function get view(): IWindowContainer
        {
            return null;
        }

        public function get id(): String
        {
            return TutorialUI.TUTORIAL_UI_CLOTHES_VIEW;
        }

        public function dispose(): void
        {
            this.setToolbarIconHighlight(false);
            this.var_3486.help.toolbar.events.removeEventListener(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN, this.onShowMenuEvent);
        }

        private function onShowMenuEvent(param1: HabboToolbarShowMenuEvent): void
        {
            if (param1.menuId == HabboToolbarIconEnum.MEMENU && param1.type == HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN)
            {
                this.setToolbarIconHighlight(false);
                this.hideToolbarIconHighlightArrow();
                this.var_3486.help.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.var_1855));
            }

        }

        public function setToolbarIconHighlight(param1: Boolean): void
        {
            var _loc2_: HabboToolbarSetIconEvent = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_176, HabboToolbarIconEnum.MEMENU);
            if (param1)
            {
                _loc2_.iconState = "highlight_blue";
                this.showToolbarIconHighlightArrow();
            }
            else
            {
                _loc2_.iconState = "0";
                this.hideToolbarIconHighlightArrow();
            }

            this.var_3486.help.toolbar.events.dispatchEvent(_loc2_);
        }

        private function showToolbarIconHighlightArrow(): void
        {
            var _loc2_: BitmapDataAsset;
            if (this.var_3502 != null)
            {
                return;
            }

            this.var_3502 = (this.var_3486.buildXmlWindow("tutorial_arrow") as IWindowContainer);
            var _loc1_: IBitmapWrapperWindow = this.var_3502.findChildByName("arrow") as IBitmapWrapperWindow;
            if (_loc1_ != null)
            {
                _loc2_ = BitmapDataAsset(this.var_3486.assets.getAssetByName("tutorial_highlight_blue_arrow"));
                _loc1_.bitmap = (_loc2_.content as BitmapData).clone();
            }

            this.var_3486.help.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN, HabboToolbarIconEnum.MEMENU_ARROW, this.var_3502));
        }

        private function hideToolbarIconHighlightArrow(): void
        {
            if (this.var_3502 != null)
            {
                this.var_3502.dispose();
                this.var_3502 = null;
            }

        }

        private function windowProcedure(param1: WindowEvent, param2: IWindow): void
        {
            switch (param2.name)
            {
                case "button_cancel":
                    if (param1.type == WindowMouseEvent.var_628)
                    {
                        this.var_3486.showView(TutorialUI.TUTORIAL_UI_MAIN_VIEW);
                    }

                    return;
            }

        }

    }
}
