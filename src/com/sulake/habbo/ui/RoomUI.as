package com.sulake.habbo.ui
{

    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.widget.IRoomWidgetFactory;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;

    import iid.IIDHabboWindowManager;

    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboRoomWidget;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboAvatarEditor;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboModeration;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
    import com.sulake.habbo.session.events.RoomSessionViralFurniStatusEvent;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.session.events.RoomSessionVoteEvent;
    import com.sulake.habbo.session.events.RoomSessionPollEvent;
    import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;
    import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.core.assets.XmlAsset;

    public class RoomUI extends Component implements IRoomUI, IUpdateReceiver
    {

        private var _windowManager: IHabboWindowManager;
        private var _roomEngine: IRoomEngine;
        private var var_2845: IRoomSessionManager;
        private var var_4637: IRoomWidgetFactory;
        private var var_2847: ISessionDataManager;
        private var _friendList: IHabboFriendList;
        private var var_2062: IAvatarRenderManager;
        private var _inventory: IHabboInventory;
        private var var_2844: IHabboToolbar;
        private var _navigator: IHabboNavigator;
        private var var_4638: IHabboAvatarEditor = null;
        private var _catalog: IHabboCatalog;
        private var var_4345: IAdManager;
        private var _localization: IHabboLocalizationManager;
        private var var_3921: IHabboHelp;
        private var var_4639: IHabboModeration;
        private var _config: IHabboConfigurationManager;
        private var _soundManager: IHabboSoundManager;
        private var var_4654: Map;
        private var var_4655: int = RoomDesktop.var_365;
        private var _connection: IConnection;
        private var _habboTracking: IHabboTracking;
        private var var_4640: IHabboUserDefinedRoomEvents;

        public function RoomUI(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null)
        {
            super(param1, param2, param3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboRoomWidget(), this.onRoomWidgetFactoryReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboAvatarEditor(), this.onAvatarEditorReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboAdManager(), this.onAdManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
            queueInterface(new IIDHabboHelp(), this.onHabboHelpReady);
            queueInterface(new IIDHabboModeration(), this.onHabboModerationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboUserDefinedRoomEvents(), this.onUserDefinedRoomEventsReady);
            this._habboTracking = IHabboTracking(queueInterface(new IIDHabboTracking()));
            this.var_4654 = new Map();
            registerUpdateReceiver(this, 0);
        }

        override public function dispose(): void
        {
            var _loc1_: String;
            var _loc2_: RoomDesktop;
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

            if (this.var_2845 != null)
            {
                this.var_2845.release(new IIDHabboRoomSessionManager());
                this.var_2845 = null;
            }

            if (this.var_4637 != null)
            {
                this.var_4637.release(new IIDHabboRoomWidget());
                this.var_4637 = null;
            }

            if (this._inventory != null)
            {
                this._inventory.release(new IIDHabboInventory());
                this._inventory = null;
            }

            if (this.var_2844 != null)
            {
                this.var_2844.release(new IIDHabboToolbar());
                this.var_2844 = null;
            }

            if (this._config != null)
            {
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            }

            if (this._soundManager != null)
            {
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            }

            if (this.var_4345 != null)
            {
                this.var_4345.release(new IIDHabboAdManager());
                this.var_4345 = null;
            }

            if (this.var_2062 != null)
            {
                this.var_2062.release(new IIDAvatarRenderManager());
                this.var_2062 = null;
            }

            if (this._catalog != null)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            }

            if (this._friendList != null)
            {
                this._friendList.release(new IIDHabboFriendList());
                this._friendList = null;
            }

            if (this.var_3921 != null)
            {
                this.var_3921.release(new IIDHabboHelp());
                this.var_3921 = null;
            }

            if (this._localization != null)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            }

            if (this.var_4639 != null)
            {
                this.var_4639.release(new IIDHabboModeration());
                this.var_4639 = null;
            }

            if (this._navigator != null)
            {
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            }

            if (this.var_2847 != null)
            {
                this.var_2847.release(new IIDSessionDataManager());
                this.var_2847 = null;
            }

            if (this._habboTracking)
            {
                this._habboTracking.release(new IIDHabboTracking());
                this._habboTracking = null;
            }

            if (this.var_4640)
            {
                this.var_4640.release(new IIDHabboUserDefinedRoomEvents());
                this.var_4640 = null;
            }

            this.var_4638 = null;
            this._connection = null;
            if (this.var_4654)
            {
                while (this.var_4654.length > 0)
                {
                    _loc1_ = (this.var_4654.getKey(0) as String);
                    _loc2_ = (this.var_4654.remove(_loc1_) as RoomDesktop);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    }

                }

                this.var_4654.dispose();
                this.var_4654 = null;
            }

            removeUpdateReceiver(this);
            super.dispose();
        }

        private function onWindowManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._windowManager = (param2 as IHabboWindowManager);
        }

        private function onRoomWidgetFactoryReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_4637 = (param2 as IRoomWidgetFactory);
        }

        private function onRoomSessionManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_2845 = (param2 as IRoomSessionManager);
            this.registerSessionEvents();
            if (this.var_2845 != null && this._roomEngine != null && this._roomEngine.isInitialized)
            {
                this.var_2845.roomEngineReady = true;
            }

        }

        private function onSessionDataManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_2847 = (param2 as ISessionDataManager);
        }

        private function onFriendListReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._friendList = (param2 as IHabboFriendList);
        }

        private function onAvatarRenderManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_2062 = (param2 as IAvatarRenderManager);
        }

        private function onInventoryReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._inventory = (param2 as IHabboInventory);
        }

        private function onToolbarReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_2844 = (param2 as IHabboToolbar);
        }

        private function onNavigatorReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._navigator = (param2 as IHabboNavigator);
        }

        private function onAvatarEditorReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_4638 = (param2 as IHabboAvatarEditor);
        }

        private function onCatalogReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._catalog = (param2 as IHabboCatalog);
        }

        private function onAdManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_4345 = (param2 as IAdManager);
            if (this.var_4345 != null && this.var_4345.events != null)
            {
                this.var_4345.events.addEventListener(AdEvent.INTERSTITIAL_COMPLETE, this.adEventHandler);
                this.var_4345.events.addEventListener(AdEvent.INTERSTITIAL_SHOW, this.adEventHandler);
                this.var_4345.events.addEventListener(AdEvent.ROOM_AD_SHOW, this.adEventHandler);
            }

        }

        private function onLocalizationManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._localization = (param2 as IHabboLocalizationManager);
        }

        private function onHabboHelpReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_3921 = (param2 as IHabboHelp);
        }

        private function onHabboModerationReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_4639 = (param2 as IHabboModeration);
            Logger.log("XXXX GOT HABBO MODERATION: " + this.var_4639);
        }

        private function onConfigurationManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._config = (param2 as IHabboConfigurationManager);
        }

        private function onSoundManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._soundManager = (param2 as IHabboSoundManager);
        }

        private function registerSessionEvents(): void
        {
            if (this.var_2845)
            {
                this.var_2845.events.addEventListener(RoomSessionEvent.RSE_CREATED, this.roomSessionStateEventHandler);
                this.var_2845.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.roomSessionStateEventHandler);
                this.var_2845.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.roomSessionStateEventHandler);
                this.var_2845.events.addEventListener(RoomSessionChatEvent.RSCE_CHAT_EVENT, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionChatEvent.RSCE_FLOOD_EVENT, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionUserBadgesEvent.var_368, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionDoorbellEvent.var_269, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionDoorbellEvent.var_369, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionDoorbellEvent.var_370, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionPresentEvent.var_371, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionPetPackageEvent.var_372, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionPetPackageEvent.var_373, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionViralFurniStatusEvent.var_374, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionViralFurniStatusEvent.var_375, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_376, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_377, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_378, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_379, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_380, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_381, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_382, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_383, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_384, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_385, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_386, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_387, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_388, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_389, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_390, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_391, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionErrorMessageEvent.var_392, this.roomSessionDialogEventHandler);
                this.var_2845.events.addEventListener(RoomSessionQueueEvent.var_393, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionVoteEvent.var_394, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionVoteEvent.var_395, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionPollEvent.var_396, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionPollEvent.var_61, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionPollEvent.var_397, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionDimmerPresetsEvent.var_398, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionFriendRequestEvent.var_277, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionUserNotificationEvent.var_280, this.roomSessionEventHandler);
                this.var_2845.events.addEventListener(RoomSessionUserDataUpdateEvent.var_399, this.roomSessionEventHandler);
            }

        }

        private function roomSessionStateEventHandler(param1: RoomSessionEvent): void
        {
            var _loc2_: IRoomDesktop;
            if (this._roomEngine == null)
            {
                return;
            }

            switch (param1.type)
            {
                case RoomSessionEvent.RSE_CREATED:
                    _loc2_ = this.createDesktop(param1.session);
                    return;
                case RoomSessionEvent.RSE_STARTED:
                    return;
                case RoomSessionEvent.RSE_ENDED:
                    if (param1.session != null)
                    {
                        this.disposeDesktop(this.getRoomIdentifier(param1.session.roomId, param1.session.roomCategory));
                        this.var_2844.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_306, HabboToolbarIconEnum.ZOOM));
                        this.var_2844.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_306, HabboToolbarIconEnum.MEMENU));
                        this.var_2844.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_306, HabboToolbarIconEnum.INVENTORY));
                    }

                    return;
            }

        }

        private function roomSessionEventHandler(param1: RoomSessionEvent): void
        {
            var _loc2_: String;
            var _loc3_: IRoomDesktop;
            if (this._roomEngine == null)
            {
                return;
            }

            if (param1.session != null)
            {
                _loc2_ = this.getRoomIdentifier(param1.session.roomId, param1.session.roomCategory);
                _loc3_ = this.getDesktop(_loc2_);
                if (_loc3_ != null)
                {
                    _loc3_.processEvent(param1);
                }

            }

        }

        private function roomSessionDialogEventHandler(event: RoomSessionEvent): void
        {
            var errorMessage: String;
            var errorTitle: String = "${error.title}";
            switch (event.type)
            {
                case RoomSessionErrorMessageEvent.var_376:
                    errorMessage = "${room.error.cant_trade_stuff}";
                    break;
                case RoomSessionErrorMessageEvent.var_377:
                    errorMessage = "${room.error.cant_set_item}";
                    break;
                case RoomSessionErrorMessageEvent.var_378:
                    errorMessage = "${room.error.cant_set_not_owner}";
                    break;
                case RoomSessionErrorMessageEvent.var_381:
                    errorMessage = "${room.error.max_furniture}";
                    break;
                case RoomSessionErrorMessageEvent.var_390:
                    errorMessage = "${room.error.max_pets}";
                    break;
                case RoomSessionErrorMessageEvent.var_382:
                    errorMessage = "${room.error.max_queuetiles}";
                    break;
                case RoomSessionErrorMessageEvent.var_383:
                    errorMessage = "${room.error.max_soundfurni}";
                    break;
                case RoomSessionErrorMessageEvent.var_384:
                    errorMessage = "${room.error.max_stickies}";
                    break;
                case RoomSessionErrorMessageEvent.var_385:
                    errorMessage = "${room.error.kicked}";
                    errorTitle = "${generic.alert.title}";
                    break;
                case RoomSessionErrorMessageEvent.var_387:
                    errorMessage = "${room.error.guide.not.available}";
                    break;
                case RoomSessionErrorMessageEvent.var_386:
                    errorMessage = "${room.error.guide.already.exists}";
                    break;
                case RoomSessionErrorMessageEvent.var_388:
                    errorMessage = "${room.error.pets.forbidden_in_hotel}";
                    break;
                case RoomSessionErrorMessageEvent.var_389:
                    errorMessage = "${room.error.pets.forbidden_in_flat}";
                    break;
                case RoomSessionErrorMessageEvent.var_391:
                    errorMessage = "${room.error.pets.no_free_tiles}";
                    break;
                case RoomSessionErrorMessageEvent.var_392:
                    errorMessage = "${room.error.pets.selected_tile_not_free}";
                    break;
                default:
                    return;
            }

            this._windowManager.alert(errorTitle, errorMessage, 0, function (param1: IAlertDialog, param2: WindowEvent): void
            {
                param1.dispose();
            });
        }

        private function adEventHandler(param1: AdEvent): void
        {
            if (param1 == null)
            {
                return;
            }

            var _loc2_: String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_: RoomDesktop = this.getDesktop(_loc2_) as RoomDesktop;
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.processEvent(param1);
        }

        private function onRoomEngineReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._roomEngine = (param2 as IRoomEngine);
            this.initializeRoomEngineEvents();
            if (this.var_2845 != null && this._roomEngine != null && this._roomEngine.isInitialized)
            {
                this.var_2845.roomEngineReady = true;
            }

        }

        private function onCommunicationReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            var _loc3_: IHabboCommunicationManager = param2 as IHabboCommunicationManager;
            if (_loc3_ != null)
            {
                this._connection = _loc3_.getHabboMainConnection(this.onConnectionReady);
                if (this._connection != null)
                {
                    this.onConnectionReady(this._connection);
                }

            }

        }

        private function onUserDefinedRoomEventsReady(param1: IID = null, param2: IUnknown = null): void
        {
            this.var_4640 = (param2 as IHabboUserDefinedRoomEvents);
        }

        private function onConnectionReady(param1: IConnection): void
        {
            if (disposed)
            {
                return;
            }

            if (param1 != null)
            {
                this._connection = param1;
            }

        }

        private function initializeRoomEngineEvents(): void
        {
            if (this._roomEngine != null && this._roomEngine.events != null)
            {
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_ENGINE_INITIALIZED, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_INITIALIZED, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_DISPOSED, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_NORMAL_MODE, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineEvent.REE_GAME_MODE, this.roomEngineEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineDimmerStateEvent.REDSE_ROOM_COLOR, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineRoomColorEvent.REE_ROOM_COLOR, this.roomEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_OBJECT_SELECTED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_OBJECT_DESELECTED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_ADDED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_OBJECT_REMOVED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_REQUEST_MOVE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_STICKIE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PRESENT, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_TROPHY, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TEASER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_ECOTRONBOX, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PLACEHOLDER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_WIDGET_REQUEST_DIMMER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_CLICK, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_DOUBLE_CLICK, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_SHOW, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_HIDE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOR_REMOVE_DIMMER, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOR_REQUEST_CLOTHING_CHANGE, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR, this.roomObjectEventHandler);
                this._roomEngine.events.addEventListener(RoomEngineSoundMachineEvent.var_420, this.roomObjectEventHandler);
            }

        }

        private function roomEngineEventHandler(param1: RoomEngineEvent): void
        {
            var _loc2_: String;
            var _loc3_: RoomDesktop;
            if (param1 == null)
            {
                return;
            }

            if (param1.type == RoomEngineEvent.REE_ENGINE_INITIALIZED)
            {
                if (this.var_2845 != null)
                {
                    this.var_2845.roomEngineReady = true;
                }

            }
            else
            {
                if (param1.type == RoomEngineEvent.REE_GAME_MODE || param1.type == RoomEngineEvent.REE_NORMAL_MODE)
                {
                    _loc2_ = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
                    _loc3_ = (this.getDesktop(_loc2_) as RoomDesktop);
                    if (_loc3_ == null)
                    {
                        return;
                    }

                    _loc3_.roomEngineEventHandler(param1);
                }

            }

        }

        private function roomEventHandler(param1: RoomEngineEvent): void
        {
            var _loc4_: IRoomSession;
            var _loc5_: Boolean;
            var _loc6_: RoomEngineRoomColorEvent;
            var _loc7_: HabboToolbarSetIconEvent;
            if (param1 == null)
            {
                return;
            }

            if (this._roomEngine == null)
            {
                return;
            }

            var _loc2_: String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_: RoomDesktop = this.getDesktop(_loc2_) as RoomDesktop;
            if (_loc3_ == null)
            {
                if (this.var_2845 == null)
                {
                    return;
                }

                _loc4_ = this.var_2845.getSession(param1.roomId, param1.roomCategory);
                if (_loc4_ != null)
                {
                    _loc3_ = (this.createDesktop(_loc4_) as RoomDesktop);
                }

            }

            if (_loc3_ == null)
            {
                return;
            }

            switch (param1.type)
            {
                case RoomEngineEvent.REE_INITIALIZED:
                    _loc5_ = false;
                    _loc3_.createRoomView(this.getActiveCanvasId(param1.roomId, param1.roomCategory));
                    if (this._roomEngine != null)
                    {
                        this._roomEngine.setActiveRoom(param1.roomId, param1.roomCategory);
                        if (!this._roomEngine.isPublicRoomWorldType(this._roomEngine.getWorldType(param1.roomId, param1.roomCategory)))
                        {
                            _loc7_ = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_176, HabboToolbarIconEnum.ZOOM);
                            _loc7_.iconState = "2";
                            this.var_2844.events.dispatchEvent(_loc7_);
                        }
                        else
                        {
                            _loc5_ = true;
                        }

                    }

                    _loc3_.createWidget(RoomWidgetEnum.var_258);
                    _loc3_.createWidget(RoomWidgetEnum.var_259);
                    if (!_loc3_.session.isSpectatorMode)
                    {
                        _loc3_.createWidget(RoomWidgetEnum.var_260);
                        _loc3_.createWidget(RoomWidgetEnum.CHAT_INPUT_WIDGET);
                        _loc3_.createWidget(RoomWidgetEnum.var_277);
                    }

                    _loc3_.createWidget(RoomWidgetEnum.var_261);
                    _loc3_.createWidget(RoomWidgetEnum.var_262);
                    _loc3_.createWidget(RoomWidgetEnum.var_263);
                    _loc3_.createWidget(RoomWidgetEnum.var_264);
                    _loc3_.createWidget(RoomWidgetEnum.var_265);
                    _loc3_.createWidget(RoomWidgetEnum.var_266);
                    _loc3_.createWidget(RoomWidgetEnum.var_267);
                    _loc3_.createWidget(RoomWidgetEnum.var_268);
                    _loc3_.createWidget(RoomWidgetEnum.var_269);
                    _loc3_.createWidget(RoomWidgetEnum.var_273);
                    _loc3_.createWidget(RoomWidgetEnum.var_272);
                    _loc3_.createWidget(RoomWidgetEnum.var_276);
                    _loc3_.createWidget(RoomWidgetEnum.var_278);
                    _loc3_.createWidget(RoomWidgetEnum.var_279);
                    _loc3_.createWidget(RoomWidgetEnum.var_280);
                    _loc3_.createWidget(RoomWidgetEnum.var_283);
                    if (this._config.getKey("avatar.widget.enabled", "0") == "1")
                    {
                        _loc3_.createWidget(RoomWidgetEnum.var_282);
                    }

                    if (this._config.getKey("purse.widget.enabled", "0") == "1")
                    {
                        _loc3_.createWidget(RoomWidgetEnum.var_281);
                        _loc3_.initializeWidget(RoomWidgetEnum.var_281);
                    }

                    if (!_loc5_)
                    {
                        _loc3_.createWidget(RoomWidgetEnum.var_275);
                    }

                    _loc3_.createWidget(RoomWidgetEnum.var_274);
                    if (this.var_4655 != RoomDesktop.var_365)
                    {
                        _loc3_.initializeWidget(RoomWidgetEnum.var_274, this.var_4655);
                    }

                    if (this.var_4345 != null)
                    {
                        this.var_4345.showRoomAd();
                    }

                    _loc3_.createWidget(RoomWidgetEnum.var_284);
                    if (this._config.getKey("roominfo.widget.enabled") == "1")
                    {
                        _loc3_.createWidget(RoomWidgetEnum.var_285);
                    }

                    return;
                case RoomEngineEvent.REE_DISPOSED:
                    this.disposeDesktop(_loc2_);
                    return;
                case RoomEngineRoomColorEvent.REE_ROOM_COLOR:
                    _loc6_ = (param1 as RoomEngineRoomColorEvent);
                    if (_loc6_ == null)
                    {
                        break;
                    }
                    if (_loc6_.bgOnly)
                    {
                        _loc3_.setRoomViewColor(0xFFFFFF, 0xFF);
                    }
                    else
                    {
                        _loc3_.setRoomViewColor(_loc6_.color, _loc6_.brightness);
                    }

                    return;
                case RoomEngineDimmerStateEvent.REDSE_ROOM_COLOR:
                    _loc3_.processEvent(param1);
                    return;
            }

        }

        private function roomObjectEventHandler(param1: RoomEngineObjectEvent): void
        {
            if (param1 == null)
            {
                return;
            }

            if (this._roomEngine == null)
            {
                return;
            }

            var _loc2_: String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_: RoomDesktop = this.getDesktop(_loc2_) as RoomDesktop;
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.roomObjectEventHandler(param1);
        }

        public function processWidgetMessage(param1: int, param2: int, param3: RoomWidgetMessage): void
        {
            if (param3 == null)
            {
                return;
            }

            if (this._roomEngine == null)
            {
                return;
            }

            var _loc4_: String = this.getRoomIdentifier(param1, param2);
            var _loc5_: RoomDesktop = this.getDesktop(_loc4_) as RoomDesktop;
            if (_loc5_ == null)
            {
                return;
            }

            _loc5_.processWidgetMessage(param3);
        }

        public function createDesktop(param1: IRoomSession): IRoomDesktop
        {
            if (param1 == null)
            {
                return null;
            }

            if (this._roomEngine == null)
            {
                return null;
            }

            var _loc2_: String = this.getRoomIdentifier(param1.roomId, param1.roomCategory);
            var _loc3_: RoomDesktop = this.getDesktop(_loc2_) as RoomDesktop;
            if (_loc3_ != null)
            {
                return _loc3_;
            }

            _loc3_ = new RoomDesktop(param1, assets, this._connection);
            _loc3_.roomEngine = this._roomEngine;
            _loc3_.windowManager = this._windowManager;
            _loc3_.roomWidgetFactory = this.var_4637;
            _loc3_.sessionDataManager = this.var_2847;
            _loc3_.roomSessionManager = this.var_2845;
            _loc3_.friendList = this._friendList;
            _loc3_.avatarRenderManager = this.var_2062;
            _loc3_.inventory = this._inventory;
            _loc3_.toolbar = this.var_2844;
            _loc3_.navigator = this._navigator;
            _loc3_.avatarEditor = this.var_4638;
            _loc3_.catalog = this._catalog;
            _loc3_.adManager = this.var_4345;
            _loc3_.localization = this._localization;
            _loc3_.habboHelp = this.var_3921;
            _loc3_.moderation = this.var_4639;
            _loc3_.config = this._config;
            _loc3_.soundManager = this._soundManager;
            _loc3_.habboTracking = this._habboTracking;
            _loc3_.userDefinedRoomEvents = this.var_4640;
            var _loc4_: XmlAsset = assets.getAssetByName("room_desktop_layout_xml") as XmlAsset;
            if (_loc4_ != null)
            {
                _loc3_.layout = (_loc4_.content as XML);
            }

            _loc3_.createWidget(RoomWidgetEnum.var_270);
            _loc3_.createWidget(RoomWidgetEnum.var_271);
            _loc3_.init();
            this.var_4654.add(_loc2_, _loc3_);
            return _loc3_;
        }

        public function disposeDesktop(param1: String): void
        {
            var _loc3_: int;
            var _loc2_: RoomDesktop = this.var_4654.remove(param1) as RoomDesktop;
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.getWidgetState(RoomWidgetEnum.var_274);
                if (_loc3_ != RoomDesktop.var_365)
                {
                    this.var_4655 = _loc3_;
                }

                _loc2_.dispose();
            }

        }

        public function getDesktop(param1: String): IRoomDesktop
        {
            return this.var_4654.getValue(param1) as RoomDesktop;
        }

        public function getActiveCanvasId(param1: int, param2: int): int
        {
            return 1;
        }

        public function update(param1: uint): void
        {
            var _loc3_: RoomDesktop;
            var _loc2_: int;
            while (_loc2_ < this.var_4654.length)
            {
                _loc3_ = (this.var_4654.getWithIndex(_loc2_) as RoomDesktop);
                if (_loc3_ != null)
                {
                    _loc3_.update();
                }

                _loc2_++;
            }

        }

        private function getRoomIdentifier(param1: int, param2: int): String
        {
            return "hard_coded_room_id";
        }

    }
}
