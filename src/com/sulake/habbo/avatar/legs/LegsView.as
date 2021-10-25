﻿package com.sulake.habbo.avatar.legs
{

    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.common.AvatarEditorGridView;
    import com.sulake.core.window.IWindowContainer;

    import flash.utils.Dictionary;

    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class LegsView extends CategoryBaseView implements IAvatarEditorCategoryView
    {

        public function LegsView(param1: IAvatarEditorCategoryModel, param2: IHabboWindowManager, param3: IAssetLibrary)
        {
            super(param2, param3, param1);
        }

        override public function init(): void
        {
            var _loc1_: XmlAsset;
            var _loc2_: AvatarEditorGridView;
            if (!_window)
            {
                _loc1_ = (_assetLibrary.getAssetByName("avatareditor_legs_base") as XmlAsset);
                if (_loc1_)
                {
                    _window = IWindowContainer(_windowManager.buildFromXML(_loc1_.content as XML));
                    _window.visible = false;
                    _window.procedure = this.windowEventProc;
                }

            }

            if (!var_2467)
            {
                var_2467 = new Dictionary();
                var_2467[FigureData.TROUSERS] = new AvatarEditorGridView(var_2446, FigureData.TROUSERS, _windowManager, _assetLibrary);
                var_2467[FigureData.var_1635] = new AvatarEditorGridView(var_2446, FigureData.var_1635, _windowManager, _assetLibrary);
                var_2467[FigureData.var_1636] = new AvatarEditorGridView(var_2446, FigureData.var_1636, _windowManager, _assetLibrary);
            }
            else
            {
                for each (_loc2_ in var_2467)
                {
                    _loc2_.initFromList();
                }

            }

            var_2067 = true;
            attachImages();
            if (var_2446 && var_2468 == "")
            {
                var_2446.switchCategory(FigureData.TROUSERS);
            }

        }

        public function switchCategory(param1: String): void
        {
            if (_window == null)
            {
                return;
            }

            if (_window.disposed)
            {
                return;
            }

            if (var_2468 == param1)
            {
                return;
            }

            inactivateTab(var_2469);
            switch (param1)
            {
                case FigureData.TROUSERS:
                    var_2469 = "tab_pants";
                    break;
                case FigureData.var_1635:
                    var_2469 = "tab_shoes";
                    break;
                case FigureData.var_1636:
                    var_2469 = "tab_belts";
                    break;
                default:
                    throw new Error("[LegsView] Unknown item category: \"" + param1 + "\"");
            }

            var_2468 = param1;
            activateTab(var_2469);
            if (!var_2067)
            {
                this.init();
            }

            updateGridView();
        }

        private function windowEventProc(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "tab_pants":
                        this.switchCategory(FigureData.TROUSERS);
                        break;
                    case "tab_shoes":
                        this.switchCategory(FigureData.var_1635);
                        break;
                    case "tab_belts":
                        this.switchCategory(FigureData.var_1636);
                        break;
                }

            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    switch (param2.name)
                    {
                        case "tab_pants":
                        case "tab_shoes":
                        case "tab_belts":
                            activateTab(param2.name);
                            break;
                    }

                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_626)
                    {
                        switch (param2.name)
                        {
                            case "tab_pants":
                            case "tab_shoes":
                            case "tab_belts":
                                if (var_2469 != param2.name)
                                {
                                    inactivateTab(param2.name);
                                }

                                return;
                        }

                    }

                }

            }

        }

    }
}
