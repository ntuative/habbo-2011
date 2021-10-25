package com.sulake.habbo.ui
{

    import com.sulake.habbo.avatar.IHabboAvatarEditorDataSaver;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;

    import flash.display.BitmapData;

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.avatar.events.AvatarEditorClosedEvent;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.widget.events.RoomWidgetToolbarClickedUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetWaveMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetGetEffectsMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetSelectEffectMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetOpenInventoryMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetStopEffectMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetNavigateToRoomMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetToolbarMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetAvatarEditorMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetSelectOutfitMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetShowOwnRoomsMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetGetSettingsMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetStoreSettingsMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetClothingChangeMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetSetToolbarIconMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetAvatarEditorUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    import flash.events.Event;

    import com.sulake.habbo.widget.events.RoomWidgetTutorialEvent;

    public class MeMenuWidgetHandler implements IRoomWidgetHandler, IHabboAvatarEditorDataSaver, IAvatarImageListener
    {

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;
        private var _inventory: IHabboInventory;
        private var var_2844: IHabboToolbar;
        private var _catalog: IHabboCatalog;
        private var var_4632: String;
        private var var_4633: BitmapData;

        public function MeMenuWidgetHandler()
        {
            Logger.log("[MeMenuWidgetHandler]");
        }

        public function dispose(): void
        {
            this.var_978 = true;
            this.container = null;
            this._inventory = null;
            this.var_2844 = null;
            this._catalog = null;
            this.var_4632 = null;
            this.var_4633 = null;
        }

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_260;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            if (this._container != null)
            {
                if (this._container.sessionDataManager && !this._container.sessionDataManager.disposed && this._container.sessionDataManager.events)
                {
                    this._container.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
                }

                if (this._inventory && !this._inventory.disposed && this._inventory.events)
                {
                    this._inventory.events.removeEventListener(HabboInventoryEffectsEvent.var_257, this.onAvatarEffectsChanged);
                    this._inventory.events.removeEventListener(HabboInventoryHabboClubEvent.var_1789, this.onHabboClubSubscriptionChanged);
                }

                if (this.var_2844 && !this.var_2844.disposed && this.var_2844.events)
                {
                    this.var_2844.events.removeEventListener(HabboToolbarEvent.var_100, this.onHabboToolbarEvent);
                    this.var_2844.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
                }

                if (this._container.avatarEditor && !this._container.avatarEditor.disposed && this._container.avatarEditor.events)
                {
                    this._container.avatarEditor.events.removeEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED, this.onAvatarEditorClosed);
                }

                if (this._container.habboHelp && !this._container.habboHelp.disposed && this._container.habboHelp.events)
                {
                    this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.var_1855, this.onHelpTutorialEvent);
                    this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.var_1306, this.onHelpTutorialEvent);
                }

                if (this._container.catalog && !this._container.catalog.disposed && this._container.catalog.events)
                {
                    this._container.catalog.events.removeEventListener(PurseEvent.CATALOG_PURSE_CREDIT_BALANCE, this.onCreditBalance);
                }

            }

            this._container = param1;
            if (this._container == null)
            {
                return;
            }

            if (this._container.sessionDataManager != null)
            {
                this._container.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
            }

            this._inventory = this._container.inventory;
            if (this._inventory != null)
            {
                this._inventory.events.addEventListener(HabboInventoryEffectsEvent.var_257, this.onAvatarEffectsChanged);
                this._inventory.events.addEventListener(HabboInventoryHabboClubEvent.var_1789, this.onHabboClubSubscriptionChanged);
            }

            this.var_2844 = this._container.toolbar;
            if (this.var_2844 != null)
            {
                this.var_2844.events.addEventListener(HabboToolbarEvent.var_100, this.onHabboToolbarEvent);
                this.var_2844.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
                this.setMeMenuToolbarIcon();
            }

            if (this._container.avatarEditor != null)
            {
                this._container.avatarEditor.events.addEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED, this.onAvatarEditorClosed);
            }

            if (this._container.habboHelp != null)
            {
                this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.var_1855, this.onHelpTutorialEvent);
                this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.var_1306, this.onHelpTutorialEvent);
            }

            this._catalog = this._container.catalog;
            if (this._container.catalog != null)
            {
                this._container.catalog.events.addEventListener(PurseEvent.CATALOG_PURSE_CREDIT_BALANCE, this.onCreditBalance);
            }

        }

        private function setMeMenuToolbarIcon(): void
        {
            var _loc1_: BitmapData;
            var _loc2_: String;
            var _loc3_: String;
            var _loc4_: IAvatarImage;
            var _loc5_: HabboToolbarSetIconEvent;
            if (this._container.avatarRenderManager != null)
            {
                _loc2_ = this._container.sessionDataManager.figure;
                if (_loc2_ != this.var_4632)
                {
                    _loc3_ = this._container.sessionDataManager.gender;
                    _loc4_ = this._container.avatarRenderManager.createAvatarImage(_loc2_, AvatarScaleType.var_106, _loc3_, this);
                    if (_loc4_ != null)
                    {
                        _loc4_.setDirection(AvatarSetType.var_107, 3);
                        _loc1_ = _loc4_.getCroppedImage(AvatarSetType.var_107);
                        _loc4_.dispose();
                    }

                    this.var_4632 = _loc2_;
                    this.var_4633 = _loc1_;
                }
                else
                {
                    _loc1_ = this.var_4633;
                }

            }

            if (this.var_2844 != null)
            {
                _loc5_ = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_432, HabboToolbarIconEnum.MEMENU);
                if (_loc1_ != null)
                {
                    _loc5_.bitmapData = _loc1_;
                }

                this.var_2844.events.dispatchEvent(_loc5_);
            }

        }

        private function onHabboToolbarEvent(param1: HabboToolbarEvent): void
        {
            if (param1.type == HabboToolbarEvent.var_100)
            {
                this.setMeMenuToolbarIcon();
            }

            if (this._container == null)
            {
                return;
            }

            if (param1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK)
            {
                switch (param1.iconId)
                {
                    case HabboToolbarIconEnum.MEMENU:
                        this._container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU));
                        return;
                    case HabboToolbarIconEnum.ROOMINFO:
                        this._container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ROOM_INFO));
                        return;
                }

            }

        }

        public function getWidgetMessages(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomWidgetWaveMessage.var_1891);
            _loc1_.push(RoomWidgetDanceMessage.var_1892);
            _loc1_.push(RoomWidgetGetEffectsMessage.var_1893);
            _loc1_.push(RoomWidgetSelectEffectMessage.var_1826);
            _loc1_.push(RoomWidgetSelectEffectMessage.var_1825);
            _loc1_.push(RoomWidgetSelectEffectMessage.var_1828);
            _loc1_.push(RoomWidgetOpenInventoryMessage.var_1894);
            _loc1_.push(RoomWidgetOpenCatalogMessage.var_1815);
            _loc1_.push(RoomWidgetStopEffectMessage.var_1895);
            _loc1_.push(RoomWidgetNavigateToRoomMessage.var_1896);
            _loc1_.push(RoomWidgetNavigateToRoomMessage.var_1897);
            _loc1_.push(RoomWidgetToolbarMessage.var_1309);
            _loc1_.push(RoomWidgetToolbarMessage.var_1308);
            _loc1_.push(RoomWidgetAvatarEditorMessage.var_1822);
            _loc1_.push(RoomWidgetAvatarEditorMessage.var_1898);
            _loc1_.push(RoomWidgetSelectOutfitMessage.var_1823);
            _loc1_.push(RoomWidgetShowOwnRoomsMessage.var_1899);
            _loc1_.push(RoomWidgetRequestWidgetMessage.var_1310);
            _loc1_.push(RoomWidgetGetSettingsMessage.var_1830);
            _loc1_.push(RoomWidgetStoreSettingsMessage.var_1900);
            _loc1_.push(RoomWidgetStoreSettingsMessage.var_1831);
            _loc1_.push(RoomWidgetStoreSettingsMessage.var_1832);
            _loc1_.push(RoomWidgetAvatarEditorMessage.var_1821);
            _loc1_.push(RoomWidgetClothingChangeMessage.var_1376);
            return _loc1_;
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetOpenCatalogMessage;
            var _loc3_: RoomWidgetOpenInventoryMessage;
            var _loc4_: RoomWidgetSetToolbarIconMessage;
            var _loc5_: RoomWidgetToolbarMessage;
            var _loc6_: RoomWidgetToolbarMessage;
            var _loc7_: HabboToolbarEvent;
            var _loc8_: RoomWidgetDanceMessage;
            var _loc9_: Array;
            var _loc10_: RoomWidgetSelectEffectMessage;
            var _loc11_: RoomWidgetSelectEffectMessage;
            var _loc12_: Boolean;
            var _loc13_: int;
            var _loc14_: IUserData;
            var _loc15_: int;
            var _loc16_: int;
            var _loc17_: RoomWidgetAvatarEditorMessage;
            var _loc18_: IWindowContainer;
            var _loc19_: String;
            var _loc20_: String;
            var _loc21_: int;
            if (!param1)
            {
                return null;
            }

            switch (param1.type)
            {
                case RoomWidgetRequestWidgetMessage.var_1310:
                    if (this._container != null && this._container.toolbar != null && this._container.toolbar.events != null)
                    {
                        _loc7_ = new HabboToolbarEvent(HabboToolbarEvent.HTE_TOOLBAR_CLICK);
                        _loc7_.iconId = HabboToolbarIconEnum.MEMENU;
                        this._container.toolbar.events.dispatchEvent(_loc7_);
                    }

                    break;
                case RoomWidgetWaveMessage.var_1891:
                    if (this._container != null && this._container.roomSession != null)
                    {
                        this._container.roomSession.sendWaveMessage();
                    }

                    break;
                case RoomWidgetDanceMessage.var_1892:
                    if (this._container != null && this._container.roomSession != null)
                    {
                        _loc8_ = (param1 as RoomWidgetDanceMessage);
                        if (_loc8_ != null)
                        {
                            this._container.roomSession.sendDanceMessage(_loc8_.style);
                        }

                    }

                    break;
                case RoomWidgetGetEffectsMessage.var_1893:
                    if (this._inventory != null)
                    {
                        _loc9_ = this._inventory.getAvatarEffects();
                        this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc9_));
                    }

                    break;
                case RoomWidgetSelectEffectMessage.var_1826:
                    if (this._inventory != null)
                    {
                        _loc10_ = (param1 as RoomWidgetSelectEffectMessage);
                        this._inventory.setEffectSelected(_loc10_.effectType);
                    }

                    break;
                case RoomWidgetSelectEffectMessage.var_1825:
                    if (this._inventory != null)
                    {
                        _loc11_ = (param1 as RoomWidgetSelectEffectMessage);
                        this._inventory.setEffectDeselected(_loc11_.effectType);
                    }

                    break;
                case RoomWidgetOpenCatalogMessage.var_1815:
                    _loc2_ = (param1 as RoomWidgetOpenCatalogMessage);
                    if (this._catalog != null && _loc2_.pageKey == RoomWidgetOpenCatalogMessage.var_1816)
                    {
                        this._catalog.openCatalogPage(CatalogPageName.var_159, true);
                    }

                    break;
                case RoomWidgetOpenInventoryMessage.var_1894:
                    _loc3_ = (param1 as RoomWidgetOpenInventoryMessage);
                    if (this._inventory != null)
                    {
                        Logger.log("MeMenuWidgetHandler open inventory: " + _loc3_.inventoryType);
                        switch (_loc3_.inventoryType)
                        {
                            case RoomWidgetOpenInventoryMessage.var_1827:
                                this._catalog.openCatalogPage(CatalogPageName.var_917, true);
                                break;
                            case RoomWidgetOpenInventoryMessage.var_1820:
                                this._inventory.toggleInventoryPage(InventoryCategory.BADGES);
                                break;
                            case RoomWidgetOpenInventoryMessage.var_1901:
                                this._inventory.toggleInventoryPage(InventoryCategory.FURNI);
                                break;
                            case RoomWidgetOpenInventoryMessage.var_1902:
                                break;
                            default:
                                Logger.log("MeMenuWidgetHandler: unknown inventory type: " + _loc3_.inventoryType);
                        }

                    }

                    break;
                case RoomWidgetSelectEffectMessage.var_1828:
                case RoomWidgetStopEffectMessage.var_1895:
                    Logger.log("STOP ALL EFFECTS");
                    if (this._inventory != null)
                    {
                        this._inventory.deselectAllEffects();
                    }

                    break;
                case RoomWidgetSetToolbarIconMessage.var_1904:
                    _loc4_ = (param1 as RoomWidgetSetToolbarIconMessage);
                    switch (_loc4_.widgetType)
                    {
                        case RoomWidgetSetToolbarIconMessage.var_1903:
                            break;
                        default:
                            Logger.log("MeMenuWidgetHandler: unknown icon widget type: " + _loc4_.widgetType);
                    }

                    break;
                case RoomWidgetNavigateToRoomMessage.var_1897:
                    Logger.log("MeMenuWidgetHandler: GO HOME");
                    if (this._container != null)
                    {
                        this._container.navigator.goToHomeRoom();
                    }

                    break;
                case RoomWidgetShowOwnRoomsMessage.var_1899:
                    if (this._container != null)
                    {
                        this._container.navigator.showOwnRooms();
                    }

                    break;
                case RoomWidgetToolbarMessage.var_1309:
                    _loc5_ = (param1 as RoomWidgetToolbarMessage);
                    if (!_loc5_ || !this._container || !this._container.events)
                    {
                        return null;
                    }

                    if (this.var_2844)
                    {
                        this.var_2844.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN, HabboToolbarIconEnum.MEMENU, _loc5_.window));
                        if (this._inventory != null)
                        {
                            _loc12_ = false;
                            if (this._container != null && this._container.sessionDataManager != null)
                            {
                                _loc12_ = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance", HabboClubLevelEnum.HC_LEVEL_HABBO_CLUB);
                            }

                            this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this._inventory.clubDays, this._inventory.clubPeriods, this._inventory.clubPastPeriods, _loc12_, this._inventory.clubLevel));
                        }

                        if (this._catalog != null && this._catalog.getPurse() != null)
                        {
                            this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_150, this._catalog.getPurse().credits));
                        }

                    }

                    if (!this._container.roomSession || !this._container.roomSession.userDataManager)
                    {
                        return null;
                    }

                    if (this._container.roomEngine != null)
                    {
                        _loc13_ = this._container.sessionDataManager != null
                                ? this._container.sessionDataManager.userId
                                : -1;
                        _loc14_ = this._container.roomSession.userDataManager.getUserData(_loc13_);
                        if (!_loc14_)
                        {
                            return null;
                        }

                        _loc15_ = 0;
                        _loc16_ = 0;
                        this._container.roomEngine.selectAvatar(_loc15_, _loc16_, _loc14_.id, true);
                    }

                    break;
                case RoomWidgetToolbarMessage.var_1308:
                    _loc6_ = (param1 as RoomWidgetToolbarMessage);
                    if (!_loc6_)
                    {
                        return null;
                    }

                    if (this.var_2844 && this.var_2844.events)
                    {
                        this.var_2844.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_OUT, HabboToolbarIconEnum.MEMENU, _loc6_.window));
                    }

                    break;
                case RoomWidgetAvatarEditorMessage.var_1822:
                    Logger.log("MeMenuWidgetHandler: Open avatar editor...");
                    if (this._container)
                    {
                        _loc17_ = (param1 as RoomWidgetAvatarEditorMessage);
                        _loc18_ = _loc17_.context;
                        this._container.avatarEditor.openEditor(_loc18_, this);
                        _loc19_ = this._container.sessionDataManager.figure;
                        _loc20_ = this._container.sessionDataManager.gender;
                        _loc21_ = HabboClubLevelEnum.HC_LEVEL_NONE;
                        if (this._container.sessionDataManager.hasUserRight("fuse_use_club_outfits", HabboClubLevelEnum.HC_LEVEL_HABBO_CLUB))
                        {
                            _loc21_ = HabboClubLevelEnum.HC_LEVEL_HABBO_CLUB;
                        }

                        if (this._container.sessionDataManager.hasUserRight("fuse_use_vip_outfits", HabboClubLevelEnum.HC_LEVEL_VIP))
                        {
                            _loc21_ = HabboClubLevelEnum.HC_LEVEL_VIP;
                        }

                        this._container.avatarEditor.loadAvatarInEditor(_loc19_, _loc20_, _loc21_);
                        if (this._container.habboHelp && this._container.habboHelp.events)
                        {
                            this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING));
                        }

                    }

                    break;
                case RoomWidgetGetSettingsMessage.var_1830:
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.var_1305, this._container.soundManager.volume));
                    break;
                case RoomWidgetStoreSettingsMessage.var_1831:
                    this._container.soundManager.volume = (param1 as RoomWidgetStoreSettingsMessage).volume;
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.var_1305, this._container.soundManager.volume));
                    break;
                case RoomWidgetStoreSettingsMessage.var_1832:
                    this._container.soundManager.previewVolume = (param1 as RoomWidgetStoreSettingsMessage).volume;
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.var_1305, this._container.soundManager.volume));
                    break;
                case RoomWidgetAvatarEditorMessage.var_1821:
                    if (this._container.habboHelp && this._container.habboHelp.events)
                    {
                        this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING));
                    }

                    break;
                case RoomWidgetClothingChangeMessage.var_1376:
                    this._container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.var_1303));
                    break;
                default:
                    Logger.log("Unhandled message in MeMenuWidgetHandler: " + param1.type);
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            return [];
        }

        public function processEvent(param1: Event): void
        {
        }

        public function update(): void
        {
        }

        private function onAvatarEffectsChanged(param1: Event = null): void
        {
            var _loc2_: Array;
            if (this._container == null)
            {
                return;
            }

            Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
            if (this._inventory != null)
            {
                _loc2_ = this._inventory.getAvatarEffects();
                this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc2_));
            }

        }

        private function onAvatarEditorClosed(param1: Event = null): void
        {
            if (this._container == null)
            {
                return;
            }

            Logger.log("[MeMenuWidgetHandler] Received Avatar Editor Closed Event...");
            this._container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.var_1302));
        }

        private function onHabboClubSubscriptionChanged(param1: Event = null): void
        {
            var _loc2_: Boolean;
            if (this._inventory != null)
            {
                _loc2_ = false;
                if (this._container != null && this._container.sessionDataManager != null)
                {
                    _loc2_ = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance", HabboClubLevelEnum.HC_LEVEL_HABBO_CLUB);
                }

                this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this._inventory.clubDays, this._inventory.clubPeriods, this._inventory.clubPastPeriods, _loc2_, this._inventory.clubLevel));
            }

        }

        private function onFigureUpdate(param1: HabboSessionFigureUpdatedEvent): void
        {
            if (this._container == null)
            {
                return;
            }

            if (param1 == null)
            {
                return;
            }

            var _loc2_: * = param1.userId == this._container.sessionDataManager.userId;
            if (_loc2_)
            {
                this.setMeMenuToolbarIcon();
            }

            if (this._container != null && this._container.events != null)
            {
            }

        }

        private function onCreditBalance(param1: PurseEvent): void
        {
            if (param1 == null || this._container == null || this._container.events == null)
            {
                return;
            }

            this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_150, param1.balance));
        }

        private function onHelpTutorialEvent(param1: HabboHelpTutorialEvent): void
        {
            if (this._container == null)
            {
                return;
            }

            switch (param1.type)
            {
                case HabboHelpTutorialEvent.var_1306:
                    this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.var_1306));
                    return;
                case HabboHelpTutorialEvent.var_1855:
                    this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.var_1307));
                    return;
            }

        }

        public function saveFigure(param1: String, param2: String): void
        {
            if (this._container == null)
            {
                return;
            }

            this._container.roomSession.sendUpdateFigureData(param1, param2);
            this._container.avatarEditor.close();
        }

        public function avatarImageReady(param1: String): void
        {
            this.var_4632 = "";
            this.setMeMenuToolbarIcon();
        }

    }
}
