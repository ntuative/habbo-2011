package com.sulake.habbo.quest
{

    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.iid.IIDHabboCommunicationManager;

    import iid.IIDHabboWindowManager;

    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.assets.BitmapDataAsset;

    import flash.display.BitmapData;

    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.net.URLRequest;

    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.communication.messages.IMessageComposer;

    public class HabboQuestEngine extends Component implements IHabboQuestEngine
    {

        private var _windowManager: IHabboWindowManager;
        private var _communication: IHabboCommunicationManager;
        private var _localization: IHabboLocalizationManager;
        private var _configuration: IHabboConfigurationManager;
        private var _incomingMessages: IncomingMessages;
        private var _controller: QuestController;
        private var _roomEngine: IRoomEngine;
        private var _toolbar: IHabboToolbar;
        private var _catalog: IHabboCatalog;
        private var _sessionDataManager: ISessionDataManager;
        private var _defaultCampaignCode: String;
        private var _help: IHabboHelp;

        public function HabboQuestEngine(ctx: IContext, flags: uint = 0, assets: IAssetLibrary = null)
        {
            super(ctx, flags, assets);

            this._controller = new QuestController(this);

            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationComponentInit);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboHelp(), this.onHabboHelpReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
        }

        override public function dispose(): void
        {
            super.dispose();

            if (this._toolbar)
            {
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            }

            if (this._catalog != null)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            }

            if (this._windowManager != null)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            }

            if (this._roomEngine != null)
            {
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            }

            if (this._configuration != null)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            }

            if (this._localization != null)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            }

            if (this._communication != null)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            }

            if (this._sessionDataManager != null)
            {
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            }

            if (this._incomingMessages)
            {
                this._incomingMessages.dispose();
            }

            if (this._help != null)
            {
                this._help.release(new IIDHabboHelp());
                this._help = null;
            }

        }

        public function getXmlWindow(name: String): IWindow
        {
            var asset: IAsset;
            var xmlAsset: XmlAsset;
            var window: IWindow;

            try
            {
                asset = assets.getAssetByName(name);
                xmlAsset = XmlAsset(asset);
                window = this._windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch (e: Error)
            {
            }

            return window;
        }

        private function onCommunicationComponentInit(iid: IID = null, communication: IUnknown = null): void
        {
            this._communication = IHabboCommunicationManager(communication);
            this._incomingMessages = new IncomingMessages(this);
        }

        private function onWindowManagerReady(iid: IID = null, windowManager: IUnknown = null): void
        {
            this._windowManager = IHabboWindowManager(windowManager);
        }

        private function onRoomEngineReady(iid: IID = null, roomEngine: IUnknown = null): void
        {
            this._roomEngine = (roomEngine as IRoomEngine);
        }

        public function get roomEngine(): IRoomEngine
        {
            return this._roomEngine;
        }

        private function onLocalizationReady(iid: IID = null, localization: IUnknown = null): void
        {
            this._localization = IHabboLocalizationManager(localization);
        }

        private function onConfigurationReady(iid: IID, configuration: IUnknown): void
        {
            if (configuration == null)
            {
                return;
            }

            this._configuration = (configuration as IHabboConfigurationManager);
        }

        private function onCatalogReady(iid: IID = null, catalog: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._catalog = (catalog as IHabboCatalog);
        }

        private function onSessionDataManagerReady(iid: IID = null, sessionDataManager: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._sessionDataManager = (sessionDataManager as ISessionDataManager);
        }

        private function onHabboHelpReady(iid: IID = null, help: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._help = (help as IHabboHelp);
        }

        public function get communication(): IHabboCommunicationManager
        {
            return this._communication;
        }

        public function get habboHelp(): IHabboHelp
        {
            return this._help;
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get localization(): IHabboLocalizationManager
        {
            return this._localization;
        }

        public function get configuration(): IHabboConfigurationManager
        {
            return this._configuration;
        }

        public function get controller(): QuestController
        {
            return this._controller;
        }

        public function get toolbar(): IHabboToolbar
        {
            return this._toolbar;
        }

        public function openCatalog(param1: String): void
        {
            this._catalog.openCatalogPage(param1, true);
        }

        private function onToolbarReady(iid: IID = null, toolbar: IUnknown = null): void
        {
            this._toolbar = (IHabboToolbar(toolbar) as IHabboToolbar);

            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
        }

        private function onHabboToolbarEvent(event: HabboToolbarEvent): void
        {
            if (event.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK)
            {
                if (event.iconId == HabboToolbarIconEnum.QUESTS)
                {
                    this._controller.onToolbarClick();

                }

            }

        }

        public function setImageFromAsset(wrapper: IBitmapWrapperWindow, assetName: String, callback: Function): void
        {
            if (!assetName || !assets)
            {
                return;
            }

            var bitmap: BitmapDataAsset = assets.getAssetByName(assetName) as BitmapDataAsset;

            if (bitmap == null)
            {
                this.retrievePreviewAsset(assetName, callback);
                return;
            }

            if (wrapper)
            {
                QuestUtils.setElementImage(wrapper, bitmap.content as BitmapData);
            }

        }

        private function retrievePreviewAsset(assetName: String, callback: Function): void
        {
            if (!assetName || !assets)
            {
                return;
            }

            var questingUrl: String = this._configuration.getKey("image.library.questing.url");
            var fullAssetName: * = questingUrl + assetName + ".png";

            Logger.log("[HabboQuestEngine] Retrieve Product Preview Asset: " + fullAssetName);

            var request: URLRequest = new URLRequest(fullAssetName);
            var loader: AssetLoaderStruct = assets.loadAssetFromFile(assetName, request, "image/png");

            if (!loader)
            {
                return;
            }

            loader.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, callback);
        }

        public function getActivityPointsForType(id: int): int
        {
            if (!this._catalog)
            {
                return 0;
            }

            return this._catalog.getPurse().getActivityPointsForType(id);
        }

        public function get sessionDataManager(): ISessionDataManager
        {
            return this._sessionDataManager;
        }

        public function get defaultCampaignCode(): String
        {
            return this._defaultCampaignCode;
        }

        public function set defaultCampaignCode(value: String): void
        {
            this._defaultCampaignCode = value;
        }

        public function send(message: IMessageComposer): void
        {
            this.communication.getHabboMainConnection(null).send(message);
        }

    }
}
