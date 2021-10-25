package com.sulake.habbo.inventory
{

    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.inventory.purse.Purse;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.iid.IIDHabboCommunicationManager;

    import iid.IIDHabboWindowManager;

    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.events.RoomSessionPropertyUpdateEvent;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.inventory.effects.EffectsModel;
    import com.sulake.habbo.inventory.badges.BadgesModel;
    import com.sulake.habbo.inventory.achievements.AchievementsModel;
    import com.sulake.habbo.inventory.recycler.RecyclerModel;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.GetCreditsInfoComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer;
    import com.sulake.core.window.IWindowContainer;

    import flash.events.Event;

    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.iid.*;

    public class HabboInventory extends Component implements IHabboInventory
    {

        private const INIT_TIMEOUT: int = 500;

        private var _communication: IHabboCommunicationManager;
        private var _incomingMessages: IncomingMessages;
        private var _windowManager: IHabboWindowManager;
        private var _sessionData: ISessionDataManager;
        private var _roomSessionManager: IRoomSessionManager;
        private var _localization: IHabboLocalizationManager;
        private var _config: IHabboConfigurationManager;
        private var _soundManager: IHabboSoundManager;
        private var _assetLibrary: IAssetLibrary;
        private var _view: InventoryMainView;
        private var _inventoryCategories: Map;
        private var _roomEngine: IRoomEngine;
        private var _roomSession: IRoomSession;
        private var _initializedInventoryCategories: Array;
        private var _purse: Purse;
        private var _avatarRenderer: IAvatarRenderManager;
        private var _catalog: IHabboCatalog;
        private var _toolbar: IHabboToolbar;
        private var _initialized: Boolean;
        private var _unknown1: Boolean;

        public function HabboInventory(ctx: IContext, flags: uint = 0, assets: IAssetLibrary = null)
        {
            super(ctx, flags, assets);

            this._assetLibrary = assets;
            this._purse = new Purse();
            this._initializedInventoryCategories = [];

            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationComponentInit);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
        }

        public function get isVisible(): Boolean
        {
            return this._view.isVisible;
        }

        override public function dispose(): void
        {
            var categoryKeys: Array;
            var i: int;
            var categoryName: String;
            var inventoryModel: IInventoryModel;

            super.dispose();

            if (this._inventoryCategories)
            {
                categoryKeys = this._inventoryCategories.getKeys();
                i = 0;

                while (i < categoryKeys.length)
                {
                    categoryName = categoryKeys[i];
                    inventoryModel = (this._inventoryCategories.getValue(categoryName) as IInventoryModel);

                    if (inventoryModel != null)
                    {
                        inventoryModel.dispose();
                    }

                    i++;
                }

                this._inventoryCategories.dispose();
                this._inventoryCategories = null;
            }

            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            }

            this._roomSession = null;
            this._incomingMessages = null;

            if (this._communication != null)
            {
                release(new IIDHabboCommunicationManager());
                this._communication = null;
            }

            if (this._incomingMessages != null)
            {
                this._incomingMessages.dispose();
            }

            if (this._windowManager != null)
            {
                release(new IIDHabboWindowManager());
                this._windowManager = null;
            }

            if (this._localization != null)
            {
                release(new IIDHabboLocalizationManager());
                this._localization = null;
            }

            if (this._roomEngine != null)
            {
                release(new IIDRoomEngine());
                this._roomEngine = null;
            }

            if (this._config)
            {
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            }

            if (this._sessionData)
            {
                this._sessionData.release(new IIDSessionDataManager());
                this._sessionData = null;
            }

            if (this._avatarRenderer)
            {
                this._avatarRenderer.release(new IIDAvatarRenderManager());
                this._avatarRenderer = null;
            }

            if (this._catalog)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            }

            if (this._roomSessionManager != null)
            {
                this._roomSessionManager.events.removeEventListener(RoomSessionEvent.RSE_STARTED, this.roomSessionEventHandler);
                this._roomSessionManager.events.removeEventListener(RoomSessionEvent.RSE_ENDED, this.roomSessionEventHandler);
                this._roomSessionManager.events.removeEventListener(RoomSessionPropertyUpdateEvent.var_250, this.roomSessionEventHandler);
                this._roomSessionManager.release(new IIDHabboRoomSessionManager());
                this._roomSessionManager = null;
            }

            if (this._soundManager != null)
            {
                this._soundManager = null;
            }

            if (this._toolbar)
            {
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            }

        }

        public function get communication(): IHabboCommunicationManager
        {
            return this._communication;
        }

        public function get furniModel(): FurniModel
        {
            if (disposed)
            {
                return null;
            }

            return FurniModel(this._inventoryCategories.getValue(InventoryCategory.FURNI));
        }

        public function get tradingModel(): TradingModel
        {
            if (disposed)
            {
                return null;
            }

            return TradingModel(this._inventoryCategories.getValue(InventorySubCategory.TRADING));
        }

        public function get effectsModel(): EffectsModel
        {
            if (disposed)
            {
                return null;
            }

            return EffectsModel(this._inventoryCategories.getValue(InventoryCategory.EFFECTS));
        }

        public function get badgesModel(): BadgesModel
        {
            if (disposed)
            {
                return null;
            }

            return BadgesModel(this._inventoryCategories.getValue(InventoryCategory.BADGES));
        }

        public function get achievementsModel(): AchievementsModel
        {
            if (disposed)
            {
                return null;
            }

            return AchievementsModel(this._inventoryCategories.getValue(InventoryCategory.ACHIEVEMENTS));
        }

        public function get recyclerModel(): RecyclerModel
        {
            if (disposed)
            {
                return null;
            }

            return RecyclerModel(this._inventoryCategories.getValue(InventorySubCategory.RECYCLER));
        }

        public function get petsModel(): PetsModel
        {
            if (disposed)
            {
                return null;
            }

            return PetsModel(this._inventoryCategories.getValue(InventoryCategory.PETS));
        }

        public function get marketplaceModel(): MarketplaceModel
        {
            if (disposed)
            {
                return null;
            }

            return this._inventoryCategories.getValue(InventoryCategory.MARKETPLACE) as MarketplaceModel;
        }

        public function get sessionData(): ISessionDataManager
        {
            return this._sessionData;
        }

        public function get roomSession(): IRoomSession
        {
            return this._roomSession;
        }

        public function get clubDays(): int
        {
            return this._purse.clubDays;
        }

        public function get clubPeriods(): int
        {
            return this._purse.clubPeriods;
        }

        public function get clubPastPeriods(): int
        {
            return this._purse.clubPastPeriods;
        }

        public function get clubHasEverBeenMember(): Boolean
        {
            return this._purse.clubHasEverBeenMember;
        }

        public function get clubLevel(): int
        {
            if (this.clubDays == 0 && this.clubPeriods == 0)
            {
                return HabboClubLevelEnum.HC_LEVEL_NONE;
            }

            if (this._purse.isVIP)
            {
                return HabboClubLevelEnum.HC_LEVEL_VIP;
            }

            return HabboClubLevelEnum.HC_LEVEL_HABBO_CLUB;
        }

        public function get hasRoomSession(): Boolean
        {
            return this._roomSession != null;
        }

        public function getCategoryViewId(): String
        {
            return this._view.getCategoryViewId();
        }

        public function getSubCategoryViewId(): String
        {
            return this._view.getSubCategoryViewId();
        }

        public function setClubStatus(clubPeriods: int, clubDays: int, clubHasEverBeenMember: Boolean, isVip: Boolean): void
        {
            this._purse.clubPeriods = clubPeriods;
            this._purse.clubDays = clubDays;
            this._purse.clubHasEverBeenMember = clubHasEverBeenMember;
            this._purse.isVIP = isVip;

            this._view.setClubStatus(this.clubPeriods, this.clubDays);
        }

        private function onCommunicationComponentInit(iid: IID = null, communicationManager: IUnknown = null): void
        {
            this._communication = IHabboCommunicationManager(communicationManager);
            this._incomingMessages = new IncomingMessages(this);
            this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));

            this.initInventory();
        }

        private function onWindowManagerReady(iid: IID = null, windowManager: IUnknown = null): void
        {
            this._windowManager = IHabboWindowManager(windowManager);

            this.initInventory();
        }

        private function onLocalizationManagerReady(iid: IID, localizationManager: IUnknown): void
        {
            this._localization = (localizationManager as IHabboLocalizationManager);

            this.initInventory();
        }

        private function onRoomEngineReady(iid: IID = null, roomEngine: IUnknown = null): void
        {
            this._roomEngine = IRoomEngine(roomEngine);

            this.initInventory();
        }

        private function onSessionDataManagerReady(iid: IID = null, sessionDataManager: IUnknown = null): void
        {
            this._sessionData = ISessionDataManager(sessionDataManager);

            this.initInventory();
        }

        private function onConfigurationManagerReady(iid: IID = null, configurationManager: IUnknown = null): void
        {
            this._config = (configurationManager as IHabboConfigurationManager);

            this.initInventory();
        }

        private function onCatalogReady(iid: IID = null, habboCatalog: IUnknown = null): void
        {
            this._catalog = (habboCatalog as IHabboCatalog);

            this.initInventory();
        }

        private function onAvatarRenderManagerReady(iid: IID = null, avatarRenderManager: IUnknown = null): void
        {
            this._avatarRenderer = (avatarRenderManager as IAvatarRenderManager);

            this.initInventory();
        }

        private function onRoomSessionManagerReady(iid: IID = null, roomSessionManager: IUnknown = null): void
        {
            this._roomSessionManager = IRoomSessionManager(roomSessionManager);

            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.roomSessionEventHandler);
            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.roomSessionEventHandler);
            this._roomSessionManager.events.addEventListener(RoomSessionPropertyUpdateEvent.var_250, this.roomSessionEventHandler);

            this.initInventory();
        }

        private function onSoundManagerReady(iid: IID = null, soundManager: IUnknown = null): void
        {
            this._soundManager = IHabboSoundManager(soundManager);

            this.initInventory();
        }

        private function onToolbarReady(iid: IID = null, toolbar: IUnknown = null): void
        {
            this._toolbar = IHabboToolbar(toolbar);
            this.initInventory();
        }

        private function onAuthenticationOK(event: IMessageEvent): void
        {
            if (!this._initialized)
            {
                this._unknown1 = true;
                return;
            }

            this.requestData();
        }

        private function requestData(): void
        {
            this._communication.getHabboMainConnection(null).send(new GetCreditsInfoComposer());
            this._communication.getHabboMainConnection(null).send(new ScrGetUserInfoMessageComposer("habbo_club"));
            this._communication.getHabboMainConnection(null).send(new GetBadgePointLimitsComposer());
        }

        private function roomSessionEventHandler(event: RoomSessionEvent): void
        {
            if (!this._initialized)
            {
                return;
            }

            switch (event.type)
            {
                case RoomSessionEvent.RSE_STARTED:
                    this._roomSession = event.session;
                    this._view.setHabboToolbarIcon();

                    if (this.petsModel != null)
                    {
                        this.petsModel.updatePetsAllowed();
                    }

                    if (this.furniModel != null)
                    {
                        this.furniModel.updateView();
                    }

                    return;

                case RoomSessionEvent.RSE_ENDED:
                    this._roomSession = null;
                    return;

                case RoomSessionPropertyUpdateEvent.var_250:
                    if (this.petsModel != null)
                    {
                        this.petsModel.updatePetsAllowed();
                    }

                    return;
            }

        }

        private function initInventory(): void
        {
            if (!this._communication || !this._windowManager || !this._localization || !this._roomEngine || !this._sessionData || !this._config || !this._catalog || !this._avatarRenderer || !this._roomSessionManager || !this._toolbar || !this._soundManager)
            {
                return;
            }

            this._view = new InventoryMainView(this, this._windowManager, this._assetLibrary);
            this._view.setToolbar(this._toolbar);
            this._inventoryCategories = new Map();

            var marketplaceModel: MarketplaceModel = new MarketplaceModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization, this._config);
            this._inventoryCategories.add(InventoryCategory.MARKETPLACE, marketplaceModel);

            var furniModel: FurniModel = new FurniModel(this, marketplaceModel, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._catalog, this._soundManager);
            this._inventoryCategories.add(InventoryCategory.FURNI, furniModel);

            var badgesModel: BadgesModel = new BadgesModel(this, this._windowManager, this._communication, this._assetLibrary, this._sessionData);
            this._inventoryCategories.add(InventoryCategory.BADGES, badgesModel);

            var effectsModel: EffectsModel = new EffectsModel(this, this._windowManager, this._communication, this._assetLibrary, this._localization);
            this._inventoryCategories.add(InventoryCategory.EFFECTS, effectsModel);

            var achievementsModel: AchievementsModel = new AchievementsModel(this, this._windowManager, this._communication, this._assetLibrary, this._localization, this._sessionData);
            this._inventoryCategories.add(InventoryCategory.ACHIEVEMENTS, achievementsModel);

            var tradingModel: TradingModel = new TradingModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization, this._soundManager);
            this._inventoryCategories.add(InventorySubCategory.TRADING, tradingModel);

            var recyclerModel: RecyclerModel = new RecyclerModel(this, this._windowManager, this._communication, this._assetLibrary, this._roomEngine, this._localization);
            this._inventoryCategories.add(InventorySubCategory.RECYCLER, recyclerModel);

            var petsModel: PetsModel = new PetsModel(this, this._windowManager, this._communication, this._assetLibrary, this._localization, this._roomEngine, this._avatarRenderer, this._catalog);
            this._inventoryCategories.add(InventoryCategory.PETS, petsModel);

            this._initialized = true;

            if (this._unknown1)
            {
                this.requestData();
            }

        }

        public function getCategoryWindowContainer(categoryName: String): IWindowContainer
        {
            var inventoryModel: IInventoryModel = IInventoryModel(this._inventoryCategories.getValue(categoryName));

            if (inventoryModel == null)
            {
                return null;
            }

            return inventoryModel.getWindowContainer();
        }

        public function getCategorySubWindowContainer(categoryName: String): IWindowContainer
        {
            var inventoryModel: IInventoryModel = IInventoryModel(this._inventoryCategories.getValue(categoryName));

            if (inventoryModel == null)
            {
                return null;
            }

            return inventoryModel.getWindowContainer();
        }

        public function getActivatedAvatarEffects(): Array
        {
            var effectsModel: EffectsModel = this.effectsModel;

            if (effectsModel == null)
            {
                return [];
            }

            return effectsModel.getEffects(1);
        }

        public function getAvatarEffects(): Array
        {
            var effectsModel: EffectsModel = this.effectsModel;

            if (effectsModel == null)
            {
                return [];
            }

            return effectsModel.getEffects();
        }

        public function setEffectSelected(id: int): void
        {
            var effectsModel: EffectsModel = this.effectsModel;

            if (effectsModel == null)
            {
                return;
            }

            effectsModel.useEffect(id);

            this.notifyChangedEffects();
        }

        public function setEffectDeselected(id: int): void
        {
            var effectsModel: EffectsModel = this.effectsModel;

            if (effectsModel == null)
            {
                return;
            }

            effectsModel.stopUsingEffect(id, true);

            this.notifyChangedEffects();
        }

        public function deselectAllEffects(): void
        {
            var effectsModel: EffectsModel = this.effectsModel;

            if (effectsModel == null)
            {
                return;
            }

            effectsModel.stopUsingAllEffects();

            this.notifyChangedEffects();
        }

        public function closeView(): void
        {
            this._view.hideInventory();
        }

        public function showView(): void
        {
            this._view.showInventory();
        }

        public function toggleInventoryPage(pageName: String): void
        {
            this._view.toggleCategoryView(pageName, false);

            this.inventoryViewOpened(pageName);

            if (!this.isVisible)
            {
                events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED));
            }

        }

        public function toggleInventorySubPage(pageName: String): void
        {
            this._view.toggleSubCategoryView(pageName, false);

            var inventoryModel: IInventoryModel;
            var i: int;

            while (i < this._inventoryCategories.length)
            {
                inventoryModel = (this._inventoryCategories.getWithIndex(i) as IInventoryModel);
                inventoryModel.subCategorySwitch(pageName);
                i++;
            }

            switch (pageName)
            {
                case InventorySubCategory.TRADING:
                    this._view.toggleCategoryView(InventoryCategory.FURNI, false);
                    return;
            }

        }

        public function updateSubView(): void
        {
            this._view.updateSubCategoryView();
        }

        public function closingInventoryView(): void
        {
            var inventoryModel: IInventoryModel;
            var i: int;

            while (i < this._inventoryCategories.length)
            {
                inventoryModel = (this._inventoryCategories.getWithIndex(i) as IInventoryModel);
                inventoryModel.closingInventoryView();
                i++;
            }

            events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED));
        }

        public function inventoryViewOpened(param1: String): void
        {
            var inventoryModel: IInventoryModel;
            var i: int;

            while (i < this._inventoryCategories.length)
            {
                inventoryModel = (this._inventoryCategories.getWithIndex(i) as IInventoryModel);
                inventoryModel.categorySwitch(param1);
                i++;
            }

        }

        public function setupTrading(param1: int, param2: String): void
        {
            var tradingModel: TradingModel = this.tradingModel;

            if (tradingModel == null)
            {
                return;
            }

            tradingModel.requestOpenTrading(param1);
        }

        public function get tradingActive(): Boolean
        {
            var tradingModel: TradingModel = this.tradingModel;

            if (tradingModel == null)
            {
                return false;
            }

            return tradingModel.running;
        }

        public function setupRecycler(start: Boolean): void
        {
            if (this.recyclerModel != null)
            {
                if (start)
                {
                    this.recyclerModel.startRecycler();
                }
                else
                {
                    this.recyclerModel.stopRecycler();
                }

            }

        }

        public function requestSelectedFurniToRecycler(): int
        {
            if (this.recyclerModel != null)
            {
                return this.recyclerModel.lockSelectedFurni();
            }

            return 0;
        }

        public function returnInventoryFurniFromRecycler(id: int): Boolean
        {
            if (this.recyclerModel != null)
            {
                return this.recyclerModel.releaseFurni(id);
            }

            return false;
        }

        public function canUserOfferToTrade(): Boolean
        {
            var tradingModel: TradingModel = this.tradingModel;

            return tradingModel != null ? tradingModel.ownUserCanTrade : false;
        }

        public function setInventoryCategoryInit(categoryName: String, shouldAdd: Boolean = true): void
        {
            var index: int;

            if (shouldAdd)
            {
                if (this._initializedInventoryCategories.indexOf(categoryName) == -1)
                {
                    this._initializedInventoryCategories.push(categoryName);
                }

            }
            else
            {
                index = this._initializedInventoryCategories.indexOf(categoryName);

                if (index >= 0)
                {
                    this._initializedInventoryCategories.splice(index, 1);
                }

            }

        }

        public function isInventoryCategoryInit(categoryName: String): Boolean
        {
            return this._initializedInventoryCategories.indexOf(categoryName) >= 0;


        }

        public function checkCategoryInitilization(categoryName: String): Boolean
        {
            if (this.isInventoryCategoryInit(categoryName))
            {
                return true;
            }

            this.requestInventoryCategoryInit(categoryName);
            return false;
        }

        public function requestInventoryCategoryInit(categoryName: String): void
        {
            var inventoryModel: IInventoryModel = this._inventoryCategories.getValue(categoryName) as IInventoryModel;

            if (inventoryModel != null)
            {
                inventoryModel.requestInitialization(this.INIT_TIMEOUT);
            }

        }

        public function notifyChangedEffects(): void
        {
            events.dispatchEvent(new HabboInventoryEffectsEvent(HabboInventoryEffectsEvent.var_257));
        }

        public function get localization(): IHabboLocalizationManager
        {
            return this._localization;
        }

    }
}
