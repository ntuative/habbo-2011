package
{

    import flash.display.Sprite;

    import com.sulake.core.runtime.ICore;

    import flash.display.DisplayObjectContainer;

    import com.sulake.habbo.tracking.HabboTracking;

    import flash.events.Event;
    import flash.events.ProgressEvent;

    import com.sulake.core.Core;

    import flash.external.ExternalInterface;

    import com.sulake.core.runtime.Component;

    import flash.net.URLRequest;

    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.runtime.events.LibraryProgressEvent;

    public class HabboMain extends Sprite
    {

        private static const UNKNOWN_MAGIC_NUMBER: Number = 0.71;

        private var _core: ICore;
        private var _container: DisplayObjectContainer;
        private var _loaded: Boolean = false;
        private var _habboTracking: HabboTracking;

        public function HabboMain(container: DisplayObjectContainer)
        {
            this._container = container;

            this._container.addEventListener(Event.COMPLETE, this.onCompleteEvent);
            this._container.addEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);

            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);

            Logger.log("Core version: " + Core.version);
        }

        private function dispose(): void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);

            if (this._container != null)
            {
                this._container.removeEventListener(Event.COMPLETE, this.onCompleteEvent);
                this._container.removeEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);

                this._container = null;
            }


            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }

        }

        private function initializeCore(): void
        {
            try
            {
                this._core.initialize();

                if (ExternalInterface.available)
                {
                    ExternalInterface.addCallback("unloading", this.unloading);
                }

            }
            catch (error: Error)
            {
                Habbo.trackLoginStep(Habbo.CLIENT_INIT_CORE_FAIL);

                Core.crash("Failed to initialize the core: " + error.message, Core.ERROR_CATEGORY_PREPARE_CORE, error);
            }

        }

        public function unloading(): void
        {
            if (this._core != null && !this._core.disposed)
            {
                this._core.events.dispatchEvent(new Event(Event.UNLOAD));
            }

        }

        protected function onAddedToStage(event: Event = null): void
        {
            try
            {
                this.prepareCore();
            }
            catch (error: Error)
            {
                Habbo.trackLoginStep(Habbo.CLIENT_INIT_CORE_FAIL);
                Habbo.reportCrash("Failed to prepare the core: " + error.message, Core.ERROR_CATEGORY_PREPARE_CORE, error);

                Core.dispose();
            }

        }

        private function prepareCore(): void
        {
            Habbo.trackLoginStep(Habbo.CLIENT_INIT_CORE_INIT);

            this._core = Core.instantiate(stage, Core.CORE_SETUP_FRAME_UPDATE_COMPLEX);

            this._core.events.addEventListener(Component.COMPONENT_EVENT_ERROR, this.onCoreError);

            this._core.prepareComponent(CoreCommunicationFrameworkLib);
            this._core.prepareComponent(HabboRoomObjectLogicLib);
            this._core.prepareComponent(HabboRoomObjectVisualizationLib);
            this._core.prepareComponent(RoomManagerLib);
            this._core.prepareComponent(RoomSpriteRendererLib);
            this._core.prepareComponent(HabboRoomSessionManagerLib);
            this._core.prepareComponent(HabboAvatarRenderLib);
            this._core.prepareComponent(HabboRoomWidgetLib);
            this._core.prepareComponent(HabboSessionDataManagerLib);
            this._core.prepareComponent(HabboTrackingLib);
            this._core.prepareComponent(HabboConfigurationCom);
            this._core.prepareComponent(HabboLocalizationCom);
            this._core.prepareComponent(HabboWindowManagerCom);
            this._core.prepareComponent(HabboCommunicationCom);
            this._core.prepareComponent(HabboCommunicationDemoCom);
            this._core.prepareComponent(HabboNavigatorCom);
            this._core.prepareComponent(HabboFriendListCom);
            this._core.prepareComponent(HabboMessengerCom);
            this._core.prepareComponent(HabboInventoryCom);
            this._core.prepareComponent(HabboToolbarCom);
            this._core.prepareComponent(HabboCatalogCom);
            this._core.prepareComponent(HabboRoomEngineCom);
            this._core.prepareComponent(HabboRoomUICom);
            this._core.prepareComponent(HabboAvatarEditorCom);
            this._core.prepareComponent(HabboNotificationsCom);
            this._core.prepareComponent(HabboHelpCom);
            this._core.prepareComponent(HabboAdManagerCom);
            this._core.prepareComponent(HabboModerationCom);
            this._core.prepareComponent(HabboUserDefinedRoomEventsCom);
            this._core.prepareComponent(HabboSoundManagerFlash10Com);
            this._core.prepareComponent(HabboQuestEngineCom);
            this._core.prepareComponent(HabboFriendBarCom);

            this._habboTracking = HabboTracking.getInstance();

            var configXmlAsset: AssetLoaderStruct = this._core.assets.loadAssetFromFile("config.xml", new URLRequest("config_habbo.xml"));

            if (configXmlAsset.assetLoader.ready)
            {
                this.setupCoreConfigFromLoader(configXmlAsset);
            }
            else
            {
                configXmlAsset.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.configLoadedHandler);
                configXmlAsset.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.configLoadedHandler);
            }

        }

        private function configLoadedHandler(assetLoaderEvent: AssetLoaderEvent): void
        {
            var configXmlAsset: AssetLoaderStruct = assetLoaderEvent.target as AssetLoaderStruct;

            configXmlAsset.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.configLoadedHandler);
            configXmlAsset.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.configLoadedHandler);

            if (assetLoaderEvent.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
            {
                this.setupCoreConfigFromLoader(configXmlAsset);
            }
            else
            {
                Habbo.reportCrash("Failed to download external configuration document " + configXmlAsset.assetLoader.url + "!", Core.ERROR_CATEGORY_DOWNLOAD_CONFIG, null);
            }

        }

        private function setupCoreConfigFromLoader(configXmlAsset: AssetLoaderStruct): void
        {
            var asset: XmlAsset = this._core.assets.getAssetByName(configXmlAsset.assetName) as XmlAsset;

            if (asset == null || asset.content == null)
            {
                Habbo.reportCrash("Download external configuration document is null!", Core.ERROR_CATEGORY_DOWNLOAD_CONFIG, null);
            }


            if (this._core != null)
            {
                this._core.readConfigDocument(XML(asset.content), this._container);
            }
            else
            {
                Habbo.reportCrash("Core vanished while downloading config document!", Core.ERROR_CATEGORY_DOWNLOAD_CONFIG, null);
            }

        }

        private function onEnterFrame(event: Event): void
        {
            if (this._container != null)
            {
                var background: Sprite = this._container.getChildByName("background") as Sprite;

                if (background != null)
                {
                    background.alpha = background.alpha - 0.01;
                    if (background.alpha <= 0)
                    {
                        // no-op
                    }

                }


                if (this._loaded)
                {
                    if (this._container.alpha <= 0)
                    {
                        this.dispose();

                        this._loaded = false;
                    }
                    else
                    {
                        this._container.alpha = this._container.alpha - 0.1;
                    }

                }

            }

        }

        private function onCompleteEvent(param1: Event): void
        {
            this.updateLoadingBar(this._container, 1);
            this.initializeCore();
            this._loaded = true;
        }

        private function onProgressEvent(progressEvent: ProgressEvent): void
        {
            if (this._container)
            {
                var percentageComplete: Number = progressEvent.bytesLoaded / progressEvent.bytesTotal;

                this.updateLoadingBar(this._container, percentageComplete);

                var background: Sprite = this._container.getChildByName("background") as Sprite;

                if (background != null)
                {
                    background.alpha = Math.min(1 - percentageComplete, background.alpha);
                }


                if (progressEvent is LibraryProgressEvent)
                {
                    var libraryProgressEvent: LibraryProgressEvent = progressEvent as LibraryProgressEvent;

                    if (libraryProgressEvent.fileName == "hh_human_fx.swf" || libraryProgressEvent.fileName == "hh_human_body.swf")
                    {
                        if (this._habboTracking != null && !this._habboTracking.disposed)
                        {
                            this._habboTracking.track("libraryLoaded", libraryProgressEvent.fileName, libraryProgressEvent.elapsedTime);
                        }

                    }

                }

            }

        }

        private function updateLoadingBar(container: DisplayObjectContainer, percentageComplete: Number): void
        {
            var fileLoadingBar: Sprite = container.getChildByName(Habbo.FILE_LOADING_BAR) as Sprite;
            var fileBarSprite: Sprite = fileLoadingBar.getChildByName(Habbo.FILE_BAR_SPRITE) as Sprite;

            var rectWidth: int;
            var rectHeight: int;
            var maxRectWidth: int = 200;
            var maxRectHeight: int = 20;

            var unknown1: int = 1;
            var unknown2: int = 1;

            var totalFiles: int = this._core.getNumberOfFilesPending() + this._core.getNumberOfFilesLoaded();
            var remainingFiles: Number = ((1 - UNKNOWN_MAGIC_NUMBER) + this._core.getNumberOfFilesLoaded() / totalFiles) * UNKNOWN_MAGIC_NUMBER;

            fileBarSprite.x = unknown1 + unknown2;
            fileBarSprite.y = unknown1 + unknown2;
            fileBarSprite.graphics.clear();

            rectWidth = maxRectHeight - unknown1 * 2 - unknown2 * 2;
            rectHeight = (maxRectWidth - unknown1 * 2 - unknown2 * 2) * remainingFiles;

            fileBarSprite.graphics.beginFill(12241619);
            fileBarSprite.graphics.drawRect(0, 0, rectHeight, rectWidth / 2);
            fileBarSprite.graphics.endFill();
            fileBarSprite.graphics.beginFill(9216429);
            fileBarSprite.graphics.drawRect(0, rectWidth / 2, rectHeight, rectWidth / 2 + 1);
            fileBarSprite.graphics.endFill();
        }

        public function onCoreError(param1: Event): void
        {
            Habbo.trackLoginStep(Habbo.CLIENT_INIT_CORE_FAIL);
        }

    }
}
