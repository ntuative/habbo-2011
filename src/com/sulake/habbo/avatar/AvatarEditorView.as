package com.sulake.habbo.avatar
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.ITabSelectorWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.components.IFrameWindow;

    import flash.utils.Timer;

    import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
    import com.sulake.core.assets.XmlAsset;

    import flash.events.TimerEvent;
    import flash.events.Event;

    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;

    import flash.display.BitmapData;
    import flash.geom.Point;

    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.avatar.enum.AvatarEditorSideCategory;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.avatar.events.AvatarEditorSavedEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.catalog.enum.CatalogPageName;

    public class AvatarEditorView
    {

        public static var var_528: IWindowContainer;
        public static var var_527: IWindowContainer;
        public static var var_1634: int = 0x666666;

        private var _controller: HabboAvatarEditor;
        private var _window: IWindowContainer;
        private var _windowManager: IHabboWindowManager;
        private var var_2560: String;
        private var var_2561: ITabSelectorWindow;
        private var _catalog: IHabboCatalog;
        private var var_2562: IFrameWindow;
        private var var_2557: Timer;
        private var var_2563: Number = 0;
        private var var_2564: Boolean = true;
        private var var_2565: String;
        private var var_2566: Boolean = true;
        private var var_2559: Array = [];
        private var var_2558: Array = [
            AvatarEditorFigureCategory.var_520,
            AvatarEditorFigureCategory.var_107,
            AvatarEditorFigureCategory.var_521,
            AvatarEditorFigureCategory.var_522,
            AvatarEditorFigureCategory.HOTLOOKS,
            AvatarEditorFigureCategory.var_523
        ];

        public function AvatarEditorView(param1: HabboAvatarEditor, param2: IHabboWindowManager, param3: IHabboCatalog, param4: Array, param5: Boolean)
        {
            var _loc6_: String;
            var _loc7_: XmlAsset;
            var _loc8_: XmlAsset;
            super();
            this._controller = param1;
            this._windowManager = param2;
            this._catalog = param3;
            if (var_528 == null)
            {
                _loc7_ = (this._controller.assets.getAssetByName("AvatarEditorThumb") as XmlAsset);
                var_528 = (this._controller.windowManager.buildFromXML(_loc7_.content as XML) as IWindowContainer);
            }

            if (var_527 == null)
            {
                _loc8_ = (this._controller.assets.getAssetByName("color_chooser_cell") as XmlAsset);
                var_527 = (this._controller.windowManager.buildFromXML(_loc8_.content as XML) as IWindowContainer);
            }

            this.var_2557 = new Timer(1000);
            this.var_2557.addEventListener(TimerEvent.TIMER, this.onUpdate);
            if (param4 == null)
            {
                param4 = this.var_2558;
            }

            for each (_loc6_ in param4)
            {
                this.var_2559.push(_loc6_);
            }

            this.createWindow(param5);
        }

        public function dispose(): void
        {
            var _loc1_: IWindowContainer;
            var _loc2_: IWindowContainer;
            var _loc3_: IWindowContainer;
            if (this.var_2557 != null)
            {
                this.var_2557.stop();
                this.var_2557.removeEventListener(TimerEvent.TIMER, this.onUpdate);
                this.var_2557 = null;
            }

            if (this._window != null)
            {
                _loc1_ = (this._window.findChildByName("figureContainer") as IWindowContainer);
                if (_loc1_ != null)
                {
                    while (_loc1_.numChildren > 0)
                    {
                        _loc1_.removeChildAt(0);
                    }

                }

                _loc2_ = (this._window.findChildByName("contentArea") as IWindowContainer);
                if (_loc2_ != null)
                {
                    while (_loc2_.numChildren > 0)
                    {
                        _loc2_.removeChildAt(0);
                    }

                }

                _loc3_ = (this._window.findChildByName("sideContainer") as IWindowContainer);
                if (_loc3_ != null)
                {
                    while (_loc3_.numChildren > 0)
                    {
                        _loc3_.removeChildAt(0);
                    }

                }

                this._window.dispose();
                this._window = null;
            }

        }

        public function validateAvailableCategories(param1: Array): Boolean
        {
            var _loc2_: String;
            if (param1 == null)
            {
                return this.validateAvailableCategories(this.var_2558);
            }

            if (param1.length != this.var_2559.length)
            {
                return false;
            }

            for each (_loc2_ in param1)
            {
                if (this.var_2559.indexOf(_loc2_) < 0)
                {
                    return false;
                }

            }

            return true;
        }

        private function onUpdate(param1: Event = null): void
        {
            if (this.canChangeOutfit())
            {
                this.var_2564 = this.canChangeOutfit();
                this.var_2557.stop();
                if (this._window)
                {
                    this._window.findChildByName("save").enable();
                }

            }

        }

        public function toggle(): void
        {
            this._window.visible = !this._window.visible;
            if (this._window.visible)
            {
                this.var_2557.start();
            }
            else
            {
                this.var_2557.stop();
            }

        }

        public function show(): void
        {
            this._window.visible = true;
        }

        public function hide(): void
        {
            this._window.visible = false;
        }

        private function createWindow(param1: Boolean): void
        {
            var _loc3_: IWindow;
            var _loc4_: ISelectableWindow;
            var _loc5_: ISelectableWindow;
            var _loc6_: int;
            if (this._window == null)
            {
                if (param1)
                {
                    this._window = (this._windowManager.buildFromXML((this._controller.assets.getAssetByName("AvatarEditor") as XmlAsset).content as XML) as IWindowContainer);
                }
                else
                {
                    this._window = (this._windowManager.buildFromXML((this._controller.assets.getAssetByName("AvatarEditorSimple") as XmlAsset).content as XML) as IWindowContainer);
                }

                _loc3_ = (this._windowManager.buildFromXML((this._controller.assets.getAssetByName("AvatarEditorContent") as XmlAsset).content as XML) as IWindowContainer);
                this._window.addChild(_loc3_);
            }

            this._window.procedure = this.windowEventProc;
            this.var_2561 = (this._window.findChildByName("mainTabs") as ITabSelectorWindow);
            var _loc2_: int = this.var_2561.numSelectables - 1;
            while (_loc2_ >= 0)
            {
                _loc4_ = this.var_2561.getSelectableAt(_loc2_);
                if (_loc4_ != null && this.var_2559.indexOf(_loc4_.name) < 0)
                {
                    _loc5_ = this.var_2561.removeSelectable(_loc4_);
                    _loc6_ = _loc2_ + 1;
                    while (_loc6_ < this.var_2561.numSelectables)
                    {
                        this.var_2561.getSelectableAt(_loc6_).x = this.var_2561.getSelectableAt(_loc6_).x - _loc5_.width;
                        _loc6_++;
                    }

                }

                _loc2_--;
            }

            this.var_2561.setSelected(this.var_2561.getSelectableAt(0));
            this.attachImages();
            this.update();
        }

        private function attachImages(): void
        {
            var _loc3_: String;
            var _loc4_: IWindowContainer;
            var _loc5_: IBitmapWrapperWindow;
            var _loc6_: BitmapDataAsset;
            var _loc7_: BitmapData;
            var _loc1_: Array = this.var_2558;
            var _loc2_: Point = new Point();
            for each (_loc3_ in _loc1_)
            {
                _loc4_ = (this._window.findChildByName(_loc3_) as IWindowContainer);
                if (_loc4_ != null)
                {
                    _loc5_ = (_loc4_.findChildByTag("BITMAP") as IBitmapWrapperWindow);
                    if (_loc5_ != null)
                    {
                        _loc6_ = (this._controller.assets.getAssetByName("ae_tabs_" + _loc3_) as BitmapDataAsset);
                        _loc7_ = (_loc6_.content as BitmapData);
                        _loc5_.bitmap = new BitmapData(_loc5_.width, _loc5_.height, true, 0xFFFFFF);
                        _loc2_.x = (_loc5_.width - _loc7_.width) / 2;
                        _loc2_.y = (_loc5_.height - _loc7_.height) / 2;
                        _loc5_.bitmap.copyPixels(_loc7_, _loc7_.rect, _loc2_);
                    }

                }

            }

        }

        public function update(): void
        {
            var _loc1_: IWindowContainer = this._controller.figureData.view.window;
            var _loc2_: IWindowContainer = this._window.findChildByName("figureContainer") as IWindowContainer;
            if (_loc2_.numChildren > 0)
            {
                _loc2_.removeChildAt(0);
            }

            if (_loc2_ != null)
            {
                _loc2_.addChild(_loc1_);
            }

            var _loc3_: IContainerButtonWindow = this._window.findChildByName("wardrobe") as IContainerButtonWindow;
            if (_loc3_ && this._controller.sessionData)
            {
                _loc3_.visible = this._controller.sessionData.hasUserRight("fuse_use_wardrobe", HabboClubLevelEnum.HC_LEVEL_HABBO_CLUB) && this._controller.isWardrobeAllowed();
            }

            var _loc4_: String = AvatarEditorSideCategory.var_1633;
            if (this._controller.sessionData && this._controller.sessionData.hasUserRight("fuse_use_wardrobe", HabboClubLevelEnum.HC_LEVEL_HABBO_CLUB) && (this.var_2565 == AvatarEditorSideCategory.var_523 || this.var_2566))
            {
                if (this._controller.isWardrobeAllowed())
                {
                    _loc4_ = AvatarEditorSideCategory.var_523;
                }

            }

            if (this._controller.isClubTryoutAllowed() && this._controller.clubMemberLevel <= 0)
            {
                _loc4_ = AvatarEditorSideCategory.var_524;
            }

            this.setSideContent(_loc4_);
            this.setViewToCategory(this.var_2560);
        }

        public function toggleCategoryView(param1: String, param2: Boolean = false): void
        {
            if (param2)
            {
            }

            this.setViewToCategory(param1);
        }

        private function toggleWardrobe(): void
        {
            if (this.var_2565 == AvatarEditorSideCategory.var_523)
            {
                this.var_2566 = false;
                this.setSideContent(AvatarEditorSideCategory.var_1633);
            }
            else
            {
                this.setSideContent(AvatarEditorSideCategory.var_523);
            }

        }

        private function setSideContent(param1: String): void
        {
            var _loc2_: IWindowContainer = this._window.findChildByName("sideContainer") as IWindowContainer;
            if (!_loc2_)
            {
                return;
            }

            var _loc3_: IWindow;
            switch (param1)
            {
                case AvatarEditorSideCategory.var_1633:
                    break;
                case AvatarEditorSideCategory.var_524:
                    _loc3_ = this._controller.getSideContentWindowContainer(AvatarEditorSideCategory.var_524);
                    break;
                case AvatarEditorSideCategory.var_523:
                    _loc3_ = this._controller.getSideContentWindowContainer(AvatarEditorSideCategory.var_523);
                    break;
            }

            _loc2_.removeChildAt(0);
            _loc2_.invalidate();
            if (_loc3_)
            {
                _loc2_.addChild(_loc3_);
                _loc3_.visible = true;
                _loc2_.width = _loc3_.width;
            }
            else
            {
                _loc2_.width = 0;
            }

            this.var_2565 = param1;
        }

        private function setViewToCategory(param1: String): void
        {
            if (param1 == null)
            {
                return;
            }

            if (param1 == "")
            {
                return;
            }

            var _loc2_: IWindowContainer = this._window.findChildByName("contentArea") as IWindowContainer;
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: IWindowContainer = _loc2_.getChildAt(0) as IWindowContainer;
            _loc2_.removeChild(_loc3_);
            _loc2_.invalidate();
            var _loc4_: IWindowContainer = this._controller.getCategoryWindowContainer(param1);
            if (_loc4_ == null)
            {
                return;
            }

            _loc4_.visible = true;
            _loc2_.addChild(_loc4_);
            this.var_2560 = param1;
            this.var_2561.setSelected(this.var_2561.getSelectableByName(param1));
        }

        public function windowEventProc(param1: WindowEvent, param2: IWindow): void
        {
            var _loc3_: String;
            var _loc4_: String;
            if (param1.type == WindowEvent.var_560)
            {
                _loc3_ = param2.name;
                Logger.log("Select tab: " + _loc3_);
                if (_loc3_ != this.var_2560)
                {
                    this._controller.toggleAvatarEditorPage(_loc3_);
                }

            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                {
                    switch (param2.name)
                    {
                        case "save":
                            if (this._controller.hasInvalidClubItems())
                            {
                                this.displayStripClubDialog();
                                return;
                            }

                            _loc4_ = this._controller.figureData.getFigureString();
                            this._controller.saveCurrentSelection();
                            this.var_2563 = new Date().valueOf();
                            this.var_2564 = false;
                            this.var_2557.start();
                            this._window.findChildByName("save").disable();
                            this._controller.events.dispatchEvent(new AvatarEditorSavedEvent(_loc4_));
                            break;
                        case "cancel":
                            this._controller.close();
                            break;
                        case "wardrobe":
                            this.toggleWardrobe();
                            break;
                    }

                    if (param2.name == "header_button_close")
                    {
                        this.hide();
                    }

                }

            }

        }

        private function displayStripClubDialog(): void
        {
            var _loc1_: IAsset;
            var _loc2_: XML;
            if (!this.var_2562)
            {
                _loc1_ = this._controller.assets.getAssetByName("StripClubItemsInfo");
                if (!_loc1_)
                {
                    throw new Error("Failed to initialize strip club info dialog; missing asset!");
                }

                _loc2_ = (_loc1_.content as XML);
                this.var_2562 = (this._windowManager.buildFromXML(_loc2_, 2) as IFrameWindow);
                this.var_2562.procedure = this.stripClubDialogEventProc;
                this.var_2562.center();
            }
            else
            {
                this.var_2562.visible = true;
                this.var_2562.center();
            }

        }

        private function stripClubDialogEventProc(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "header_button_close":
                        this.var_2562.visible = false;
                        return;
                    case "strip_button_ok":
                        if (this._controller)
                        {
                            this._controller.stripClubItems();
                        }

                        this.var_2562.visible = false;
                        return;
                    case "strip_button_club_info":
                        this.openCatalogClubPage();
                        this.var_2562.visible = false;
                }

            }

        }

        private function openCatalogClubPage(): void
        {
            if (this._catalog)
            {
                this._catalog.openCatalogPage(CatalogPageName.var_159, true);
            }

        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        private function canChangeOutfit(): Boolean
        {
            var _loc1_: Number = new Date().valueOf();
            return _loc1_ - this.var_2563 > 5000;
        }

    }
}
