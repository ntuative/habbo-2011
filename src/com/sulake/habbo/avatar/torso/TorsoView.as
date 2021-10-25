package com.sulake.habbo.avatar.torso
{

    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
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

    public class TorsoView extends CategoryBaseView implements IAvatarEditorCategoryView
    {

        public function TorsoView(param1: TorsoModel, param2: IHabboWindowManager, param3: IAssetLibrary)
        {
            super(param2, param3, param1);
        }

        override public function init(): void
        {
            var _loc1_: XmlAsset;
            var _loc2_: AvatarEditorGridView;
            if (!_window)
            {
                _loc1_ = (_assetLibrary.getAssetByName("avatareditor_torso_base") as XmlAsset);
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
                var_2467[FigureData.var_1645] = new AvatarEditorGridView(var_2446, FigureData.var_1645, _windowManager, _assetLibrary);
                var_2467[FigureData.var_1646] = new AvatarEditorGridView(var_2446, FigureData.var_1646, _windowManager, _assetLibrary);
                var_2467[FigureData.CHEST_ACCESSORIES] = new AvatarEditorGridView(var_2446, FigureData.CHEST_ACCESSORIES, _windowManager, _assetLibrary);
                var_2467[FigureData.var_1647] = new AvatarEditorGridView(var_2446, FigureData.var_1647, _windowManager, _assetLibrary);
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
                var_2446.switchCategory(FigureData.var_1646);
            }

        }

        override public function dispose(): void
        {
            super.dispose();
            var_2446 = null;
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
                case FigureData.var_1646:
                    var_2469 = "tab_shirt";
                    break;
                case FigureData.var_1645:
                    var_2469 = "tab_jacket";
                    break;
                case FigureData.var_1647:
                    var_2469 = "tab_prints";
                    break;
                case FigureData.CHEST_ACCESSORIES:
                    var_2469 = "tab_accessories";
                    break;
                default:
                    throw new Error("[TorsoView] Unknown item category: \"" + param1 + "\"");
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
                    case "tab_jacket":
                        this.switchCategory(FigureData.var_1645);
                        break;
                    case "tab_shirt":
                        this.switchCategory(FigureData.var_1646);
                        break;
                    case "tab_accessories":
                        this.switchCategory(FigureData.CHEST_ACCESSORIES);
                        break;
                    case "tab_prints":
                        this.switchCategory(FigureData.var_1647);
                        break;
                }

            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    switch (param2.name)
                    {
                        case "tab_jacket":
                        case "tab_prints":
                        case "tab_shirt":
                        case "tab_accessories":
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
                            case "tab_jacket":
                            case "tab_prints":
                            case "tab_shirt":
                            case "tab_accessories":
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
