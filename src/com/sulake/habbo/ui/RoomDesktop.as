package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.IRoomWidgetMessageListener;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.widget.IRoomWidgetFactory;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.moderation.IHabboModeration;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IToolTipWindow;

    import flash.utils.Timer;
    import flash.geom.Rectangle;
    import flash.events.IEventDispatcher;

    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.widget.IRoomWidget;

    import flash.events.TimerEvent;

    import com.sulake.habbo.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;

    import flash.events.Event;

    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.room.utils.RoomGeometry;

    import flash.display.DisplayObject;

    import com.sulake.habbo.room.RoomVariableEnum;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    import flash.display.Sprite;
    import flash.display.BlendMode;
    import flash.utils.getTimer;

    import com.sulake.room.utils.ColorConverter;

    import flash.geom.Point;
    import flash.events.MouseEvent;

    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;

    import flash.filters.BlurFilter;
    import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
    import flash.filters.DisplacementMapFilterMode;
    import flash.filters.DisplacementMapFilter;
    import flash.filters.BitmapFilter;

    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;

    public class RoomDesktop implements IRoomDesktop, IRoomWidgetMessageListener, IRoomWidgetHandlerContainer
    {

        public static const var_365: int = -1;
        private static const var_1546: int = 1000;

        private var _events: EventDispatcher;
        private var _windowManager: IHabboWindowManager = null;
        private var _roomEngine: IRoomEngine = null;
        private var var_4637: IRoomWidgetFactory = null;
        private var var_2847: ISessionDataManager = null;
        private var var_2845: IRoomSessionManager = null;
        private var var_2062: IAvatarRenderManager = null;
        private var _friendList: IHabboFriendList = null;
        private var _inventory: IHabboInventory = null;
        private var var_2844: IHabboToolbar = null;
        private var _navigator: IHabboNavigator = null;
        private var var_4638: IHabboAvatarEditor = null;
        private var _catalog: IHabboCatalog = null;
        private var var_4345: IAdManager = null;
        private var _localization: IHabboLocalizationManager = null;
        private var var_3921: IHabboHelp = null;
        private var _connection: IConnection = null;
        private var var_4639: IHabboModeration;
        private var _config: IHabboConfigurationManager;
        private var _soundManager: IHabboSoundManager;
        private var _habboTracking: IHabboTracking;
        private var var_4640: IHabboUserDefinedRoomEvents;
        private var _assets: IAssetLibrary = null;
        private var var_4405: IRoomSession = null;
        private var var_4641: Array = [];
        private var var_2822: Map;
        private var var_4642: Map;
        private var var_4643: Map;
        private var var_4644: Map;
        private var _updateListeners: Array;
        private var var_4645: DesktopLayoutManager;
        private var var_4646: Boolean = true;
        private var var_4647: Boolean = true;
        private var var_4648: Array;
        private var var_4649: IToolTipWindow;
        private var var_4650: uint = 0xFFFFFF;
        private var var_4651: Boolean = false;
        private var var_4652: int = 0;
        private var var_3635: Timer;
        private var var_4653: Rectangle;

        public function RoomDesktop(param1: IRoomSession, param2: IAssetLibrary, param3: IConnection)
        {
            this._events = new EventDispatcher();
            this.var_4405 = param1;
            this._assets = param2;
            this._connection = param3;
            this.var_2822 = new Map();
            this.var_4642 = new Map();
            this.var_4643 = new Map();
            this.var_4644 = new Map();
            this.var_4645 = new DesktopLayoutManager();
        }

        public function get roomSession(): IRoomSession
        {
            return this.var_4405;
        }

        public function get sessionDataManager(): ISessionDataManager
        {
            return this.var_2847;
        }

        public function get events(): IEventDispatcher
        {
            return this._events;
        }

        public function get roomEngine(): IRoomEngine
        {
            return this._roomEngine;
        }

        public function get roomSessionManager(): IRoomSessionManager
        {
            return this.var_2845;
        }

        public function get friendList(): IHabboFriendList
        {
            return this._friendList;
        }

        public function get avatarRenderManager(): IAvatarRenderManager
        {
            return this.var_2062;
        }

        public function get inventory(): IHabboInventory
        {
            return this._inventory;
        }

        public function get toolbar(): IHabboToolbar
        {
            return this.var_2844;
        }

        public function get roomWidgetFactory(): IRoomWidgetFactory
        {
            return this.var_4637;
        }

        public function get navigator(): IHabboNavigator
        {
            return this._navigator;
        }

        public function get avatarEditor(): IHabboAvatarEditor
        {
            return this.var_4638;
        }

        public function get catalog(): IHabboCatalog
        {
            return this._catalog;
        }

        public function get localization(): IHabboLocalizationManager
        {
            return this._localization;
        }

        public function get habboHelp(): IHabboHelp
        {
            return this.var_3921;
        }

        public function get config(): IHabboConfigurationManager
        {
            return this._config;
        }

        public function get soundManager(): IHabboSoundManager
        {
            return this._soundManager;
        }

        public function get moderation(): IHabboModeration
        {
            return this.var_4639;
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get habboTracking(): IHabboTracking
        {
            return this._habboTracking;
        }

        public function get session(): IRoomSession
        {
            return this.var_4405;
        }

        public function set catalog(param1: IHabboCatalog): void
        {
            this._catalog = param1;
        }

        public function set avatarEditor(param1: IHabboAvatarEditor): void
        {
            this.var_4638 = param1;
        }

        public function set roomWidgetFactory(param1: IRoomWidgetFactory): void
        {
            this.var_4637 = param1;
        }

        public function set sessionDataManager(param1: ISessionDataManager): void
        {
            this.var_2847 = param1;
        }

        public function set roomSessionManager(param1: IRoomSessionManager): void
        {
            this.var_2845 = param1;
        }

        public function get userDefinedRoomEvents(): IHabboUserDefinedRoomEvents
        {
            return this.var_4640;
        }

        public function get connection(): IConnection
        {
            return this._connection;
        }

        public function set friendList(param1: IHabboFriendList): void
        {
            this._friendList = param1;
            if (this._friendList)
            {
                this._friendList.events.addEventListener(FriendRequestEvent.FRIEND_REQUEST_ACCEPTED, this.processEvent);
                this._friendList.events.addEventListener(FriendRequestEvent.FRIEND_REQUEST_DECLINED, this.processEvent);
            }

        }

        public function set avatarRenderManager(param1: IAvatarRenderManager): void
        {
            this.var_2062 = param1;
        }

        public function set windowManager(param1: IHabboWindowManager): void
        {
            this._windowManager = param1;
        }

        public function set inventory(param1: IHabboInventory): void
        {
            this._inventory = param1;
        }

        public function set navigator(param1: IHabboNavigator): void
        {
            this._navigator = param1;
        }

        public function set adManager(param1: IAdManager): void
        {
            this.var_4345 = param1;
        }

        public function set localization(param1: IHabboLocalizationManager): void
        {
            this._localization = param1;
        }

        public function set habboHelp(param1: IHabboHelp): void
        {
            this.var_3921 = param1;
        }

        public function set moderation(param1: IHabboModeration): void
        {
            this.var_4639 = param1;
        }

        public function set config(param1: IHabboConfigurationManager): void
        {
            this._config = param1;
        }

        public function set soundManager(param1: IHabboSoundManager): void
        {
            this._soundManager = param1;
        }

        public function set habboTracking(param1: IHabboTracking): void
        {
            this._habboTracking = param1;
        }

        public function set userDefinedRoomEvents(param1: IHabboUserDefinedRoomEvents): void
        {
            this.var_4640 = param1;
        }

        public function set roomEngine(param1: IRoomEngine): void
        {
            this._roomEngine = param1;
            if (this._roomEngine != null && this._roomEngine.events != null)
            {
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.ROOM_CONTENT_SUCCESS, this.onRoomContentLoaded);
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.ROOM_CONTENT_FAILURE, this.onRoomContentLoaded);
                this._roomEngine.events.addEventListener(RoomContentLoadedEvent.ROOM_CONTENT_CANCEL, this.onRoomContentLoaded);
            }

        }

        public function set toolbar(param1: IHabboToolbar): void
        {
            this.var_2844 = param1;
            this.var_2844.events.addEventListener(HabboToolbarEvent.var_102, this.onToolbarRepositionEvent);
            this.var_2844.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
        }

        public function set layout(param1: XML): void
        {
            this.var_4645.setLayout(param1, this._windowManager, this._config);
            if (this.var_2844 != null)
            {
                this.var_4645.toolbarSize = this.var_2844.size;
                this.var_4645.toolbarOrientation = this.var_2844.orientation;
            }

        }

        public function dispose(): void
        {
            var _loc2_: IRoomGeometry;
            var _loc3_: int;
            var _loc4_: String;
            var _loc5_: IRoomWidget;
            var _loc6_: IRoomWidgetHandler;
            if (this._roomEngine != null && this.var_4405 != null)
            {
                _loc2_ = this._roomEngine.getRoomCanvasGeometry(this.var_4405.roomId, this.var_4405.roomCategory, this.getFirstCanvasId());
                if (_loc2_ != null)
                {
                    this.trackZoomTime(_loc2_.isZoomedIn());
                }

            }

            var _loc1_: int;
            if (this.var_4641 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4641.length)
                {
                    _loc3_ = this.var_4641[_loc1_];
                    _loc4_ = this.getWindowName(_loc3_);
                    if (this._windowManager)
                    {
                        this._windowManager.removeWindow(_loc4_);
                    }

                    _loc1_++;
                }

            }

            this._updateListeners = null;
            if (this.var_2822 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_2822.length)
                {
                    _loc5_ = (this.var_2822.getWithIndex(_loc1_) as IRoomWidget);
                    if (_loc5_ != null)
                    {
                        _loc5_.dispose();
                    }

                    _loc1_++;
                }

                this.var_2822.dispose();
                this.var_2822 = null;
            }

            if (this.var_4642 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4642.length)
                {
                    _loc6_ = (this.var_4642.getWithIndex(_loc1_) as IRoomWidgetHandler);
                    if (_loc6_ != null)
                    {
                        _loc6_.dispose();
                    }

                    _loc1_++;
                }

                this.var_4642.dispose();
                this.var_4642 = null;
            }

            if (this.var_4643 != null)
            {
                this.var_4643.dispose();
                this.var_4643 = null;
            }

            if (this.var_4644 != null)
            {
                this.var_4644.dispose();
                this.var_4644 = null;
            }

            this._assets = null;
            this.var_2062 = null;
            this.var_4641 = null;
            this._events = null;
            if (this._friendList && this._friendList.events)
            {
                this._friendList.events.removeEventListener(FriendRequestEvent.FRIEND_REQUEST_ACCEPTED, this.processEvent);
                this._friendList.events.removeEventListener(FriendRequestEvent.FRIEND_REQUEST_DECLINED, this.processEvent);
            }

            this._friendList = null;
            this.var_4645.dispose();
            this.var_4645 = null;
            if (this._roomEngine != null && this._roomEngine.events != null)
            {
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.ROOM_CONTENT_SUCCESS, this.onRoomContentLoaded);
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.ROOM_CONTENT_FAILURE, this.onRoomContentLoaded);
                this._roomEngine.events.removeEventListener(RoomContentLoadedEvent.ROOM_CONTENT_CANCEL, this.onRoomContentLoaded);
            }

            this._roomEngine = null;
            this.var_2845 = null;
            this.var_4637 = null;
            this.var_4405 = null;
            this.var_2847 = null;
            this._windowManager = null;
            this._inventory = null;
            if (this.var_2844 && this.var_2844.events)
            {
                this.var_2844.events.removeEventListener(HabboToolbarEvent.var_102, this.onToolbarRepositionEvent);
                this.var_2844.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
            }

            this.var_2844 = null;
            this._localization = null;
            this._config = null;
            this._soundManager = null;
            if (this.var_4649 != null)
            {
                this.var_4649.dispose();
                this.var_4649 = null;
            }

            if (this.var_3635 != null)
            {
                this.var_3635.reset();
                this.var_3635.removeEventListener(TimerEvent.TIMER, this.onResizeTimerEvent);
                this.var_3635 = null;
            }

            this.var_4653 = null;
        }

        public function init(): void
        {
            if (this._roomEngine != null && this.var_4405 != null)
            {
                this.var_4648 = this._roomEngine.loadRoomResources(this.var_4405.roomResources);
                if (this.var_4648.length > 0)
                {
                    this.var_4647 = false;
                    this.processEvent(new RoomWidgetLoadingBarUpdateEvent(RoomWidgetLoadingBarUpdateEvent.var_1382));
                }

            }

            if (this.var_4345 != null && this.var_4405.state == RoomSessionEvent.RSE_CREATED)
            {
                this.var_4646 = !this.var_4345.showInterstitial();
            }

            this.checkInterrupts();
        }

        private function onRoomContentLoaded(param1: RoomContentLoadedEvent): void
        {
            if (this.var_4648 == null || this.var_4648.length == 0)
            {
                return;
            }

            var _loc2_: int = this.var_4648.indexOf(param1.contentType);
            if (_loc2_ != -1)
            {
                this.var_4648.splice(_loc2_, 1);
            }

            if (this.var_4648.length == 0)
            {
                this.var_4647 = true;
                this.checkInterrupts();
            }

        }

        public function createWidget(param1: String): void
        {
            var _loc2_: IRoomWidget;
            var _loc3_: Boolean;
            var _loc4_: IRoomWidgetHandler;
            var _loc5_: ChatWidgetHandler;
            var _loc6_: PlayListEditorWidgetHandler;
            var _loc7_: Array;
            var _loc8_: Array;
            var _loc9_: Array;
            var _loc10_: String;
            var _loc11_: String;
            var _loc12_: RoomWidgetRoomViewUpdateEvent;
            if (this.var_4637 == null)
            {
                return;
            }

            _loc2_ = this.var_4637.createWidget(param1);
            if (_loc2_ == null)
            {
                return;
            }

            _loc2_.messageListener = this;
            _loc2_.registerUpdateEvents(this._events);
            this.var_4645.addWidgetWindow(param1, _loc2_.mainWindow);
            if (!this.var_2822.add(param1, _loc2_))
            {
                _loc2_.dispose();
            }

            switch (param1)
            {
                case RoomWidgetEnum.var_258:
                    _loc5_ = new ChatWidgetHandler();
                    _loc5_.connection = this._connection;
                    _loc4_ = (_loc5_ as IRoomWidgetHandler);
                    break;
                case RoomWidgetEnum.var_259:
                    _loc4_ = new InfoStandWidgetHandler(this._soundManager.musicController);
                    break;
                case RoomWidgetEnum.CHAT_INPUT_WIDGET:
                    _loc3_ = true;
                    _loc4_ = new ChatInputWidgetHandler();
                    break;
                case RoomWidgetEnum.var_260:
                    _loc4_ = new MeMenuWidgetHandler();
                    break;
                case RoomWidgetEnum.var_261:
                    _loc4_ = new PlaceholderWidgetHandler();
                    break;
                case RoomWidgetEnum.var_262:
                    _loc4_ = new FurnitureCreditWidgetHandler();
                    break;
                case RoomWidgetEnum.var_263:
                    _loc4_ = new FurnitureStickieWidgetHandler();
                    break;
                case RoomWidgetEnum.var_264:
                    _loc4_ = new FurniturePresentWidgetHandler();
                    break;
                case RoomWidgetEnum.var_265:
                    _loc4_ = new FurnitureTrophyWidgetHandler();
                    break;
                case RoomWidgetEnum.var_266:
                    _loc4_ = new FurnitureTeaserWidgetHandler();
                    break;
                case RoomWidgetEnum.var_267:
                    _loc4_ = new FurnitureEcotronBoxWidgetHandler();
                    break;
                case RoomWidgetEnum.var_268:
                    _loc4_ = new PetPackageFurniWidgetHandler();
                    break;
                case RoomWidgetEnum.var_269:
                    _loc4_ = new DoorbellWidgetHandler();
                    break;
                case RoomWidgetEnum.var_271:
                    _loc4_ = new RoomQueueWidgetHandler();
                    break;
                case RoomWidgetEnum.var_270:
                    _loc4_ = new LoadingBarWidgetHandler();
                    break;
                case RoomWidgetEnum.var_272:
                    _loc4_ = new VoteWidgetHandler();
                    break;
                case RoomWidgetEnum.var_273:
                    _loc4_ = new PollWidgetHandler();
                    break;
                case RoomWidgetEnum.var_275:
                    _loc4_ = new FurniChooserWidgetHandler();
                    break;
                case RoomWidgetEnum.var_274:
                    _loc4_ = new UserChooserWidgetHandler();
                    break;
                case RoomWidgetEnum.var_276:
                    _loc4_ = new FurnitureDimmerWidgetHandler();
                    break;
                case RoomWidgetEnum.var_277:
                    _loc4_ = new FriendRequestWidgetHandler();
                    break;
                case RoomWidgetEnum.var_278:
                    _loc4_ = new FurnitureClothingChangeWidgetHandler();
                    break;
                case RoomWidgetEnum.var_279:
                    _loc4_ = new ConversionPointWidgetHandler();
                    break;
                case RoomWidgetEnum.var_280:
                    _loc4_ = new UserNotificationWidgetHandler();
                    break;
                case RoomWidgetEnum.var_281:
                    _loc4_ = new PurseWidgetHandler();
                    break;
                case RoomWidgetEnum.var_282:
                    _loc4_ = new AvatarInfoWidgetHandler();
                    break;
                case RoomWidgetEnum.var_283:
                    _loc4_ = new WelcomeGiftWidgetHandler();
                    break;
                case RoomWidgetEnum.var_284:
                    _loc6_ = new PlayListEditorWidgetHandler();
                    _loc6_.connection = this._connection;
                    _loc4_ = (_loc6_ as IRoomWidgetHandler);
                    break;
                case RoomWidgetEnum.var_285:
                    _loc4_ = new RoomInfoWidgetHandler();
                    break;
            }

            if (_loc4_ != null)
            {
                _loc4_.container = this;
                if (!this.var_4642.add(param1, _loc4_))
                {
                    _loc4_.dispose();
                }

                _loc7_ = null;
                _loc8_ = _loc4_.getWidgetMessages();
                if (_loc8_ != null)
                {
                    for each (_loc10_ in _loc8_)
                    {
                        _loc7_ = this.var_4643.getValue(_loc10_);
                        if (_loc7_ == null)
                        {
                            _loc7_ = [];
                            this.var_4643.add(_loc10_, _loc7_);
                        }
                        else
                        {
                            Logger.log("Room widget message '" + _loc10_ + "' handled by more than one widget message handler, could cause problems. Be careful!");
                        }

                        _loc7_.push(_loc4_);
                    }

                }

                _loc9_ = _loc4_.getProcessedEvents();
                if (_loc9_ != null)
                {
                    for each (_loc11_ in _loc9_)
                    {
                        _loc7_ = this.var_4644.getValue(_loc11_);
                        if (_loc7_ == null)
                        {
                            _loc7_ = [];
                            this.var_4644.add(_loc11_, _loc7_);
                        }

                        _loc7_.push(_loc4_);
                    }

                }

            }

            if (_loc3_)
            {
                param1 = RoomWidgetRoomViewUpdateEvent.var_1327;
                _loc12_ = new RoomWidgetRoomViewUpdateEvent(param1, this.var_4645.roomViewRect);
                this.events.dispatchEvent(_loc12_);
            }

        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc3_: IRoomWidgetHandler;
            var _loc4_: RoomWidgetUpdateEvent;
            if (param1 == null)
            {
                return null;
            }

            var _loc2_: Array = this.var_4643.getValue(param1.type);
            if (_loc2_ != null)
            {
                for each (_loc3_ in _loc2_)
                {
                    _loc4_ = _loc3_.processWidgetMessage(param1);
                    if (_loc4_ != null)
                    {
                        return _loc4_;
                    }

                }

            }

            return null;
        }

        public function processEvent(param1: Event): void
        {
            var _loc3_: IRoomWidgetHandler;
            if (!param1)
            {
                return;
            }

            var _loc2_: Array = this.var_4644.getValue(param1.type);
            if (_loc2_ != null)
            {
                for each (_loc3_ in _loc2_)
                {
                    _loc3_.processEvent(param1);
                }

            }

        }

        public function roomObjectEventHandler(param1: RoomEngineObjectEvent): void
        {
            var _loc6_: String;
            var _loc7_: IUserData;
            if (param1 == null)
            {
                return;
            }

            var _loc2_: int = int(param1.objectId);
            var _loc3_: int = int(param1.category);
            var _loc4_: RoomWidgetRoomObjectUpdateEvent;
            var _loc5_: RoomWidgetFurniToWidgetMessage;
            switch (param1.type)
            {
                case RoomEngineObjectEvent.REOE_OBJECT_SELECTED:
                    _loc4_ = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    if (this.var_4639 != null && _loc3_ == RoomObjectCategoryEnum.var_71)
                    {
                        _loc7_ = this.var_4405.userDataManager.getUserDataByIndex(_loc2_);
                        if (_loc7_ != null && _loc7_.type == RoomObjectTypeEnum.var_1262)
                        {
                            this.var_4639.userSelected(_loc7_.webID, _loc7_.name);
                        }

                    }

                    break;
                case RoomEngineObjectEvent.REOB_OBJECT_ADDED:
                    switch (_loc3_)
                    {
                        case RoomObjectCategoryEnum.var_72:
                        case RoomObjectCategoryEnum.var_73:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1318;
                            break;
                        case RoomObjectCategoryEnum.var_71:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1267;
                            break;
                    }

                    if (_loc6_ != null)
                    {
                        _loc4_ = new RoomWidgetRoomObjectUpdateEvent(_loc6_, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    }

                    break;
                case RoomEngineObjectEvent.REOE_OBJECT_REMOVED:
                    switch (_loc3_)
                    {
                        case RoomObjectCategoryEnum.var_72:
                        case RoomObjectCategoryEnum.var_73:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1280;
                            break;
                        case RoomObjectCategoryEnum.var_71:
                            _loc6_ = RoomWidgetRoomObjectUpdateEvent.var_1260;
                            break;
                    }

                    if (_loc6_ != null)
                    {
                        _loc4_ = new RoomWidgetRoomObjectUpdateEvent(_loc6_, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    }

                    break;
                case RoomEngineObjectEvent.REOE_OBJECT_DESELECTED:
                    _loc4_ = new RoomWidgetRoomObjectUpdateEvent(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    break;
                case RoomEngineObjectEvent.REOB_OBJECT_REQUEST_MOVE:
                    if (!this.var_4405.isRoomController && !this.var_2847.isAnyRoomController)
                    {
                        return;
                    }

                    this._roomEngine.modifyRoomObject(param1.objectId, param1.category, RoomObjectOperationEnum.OBJECT_MOVE);
                    break;
                case RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1535, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_STICKIE:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1536, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PRESENT:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1537, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_TROPHY:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1538, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_TEASER:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1539, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_ECOTRONBOX:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1540, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_DIMMER:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1541, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOE_WIDGET_REQUEST_PLACEHOLDER:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1542, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_CLICK:
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_DOUBLE_CLICK:
                    this.handleRoomAdClick(param1);
                    break;
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_SHOW:
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_HIDE:
                    this.handleRoomAdTooltip(param1);
                    break;
                case RoomEngineObjectEvent.REOR_REMOVE_DIMMER:
                    this.processEvent(param1);
                    break;
                case RoomEngineObjectEvent.REOR_REQUEST_CLOTHING_CHANGE:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1543, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineObjectEvent.REOR_WIDGET_REQUEST_PLAYLIST_EDITOR:
                    _loc5_ = new RoomWidgetFurniToWidgetMessage(RoomWidgetFurniToWidgetMessage.var_1544, _loc2_, _loc3_, param1.roomId, param1.roomCategory);
                    this.processWidgetMessage(_loc5_);
                    break;
                case RoomEngineSoundMachineEvent.var_420:
                    this.processEvent(param1);
                    break;
            }

            if (_loc4_ != null)
            {
                this.events.dispatchEvent(_loc4_);
            }

        }

        public function roomEngineEventHandler(param1: RoomEngineEvent): void
        {
            var _loc2_: RoomWidgetUpdateEvent;
            switch (param1.type)
            {
                case RoomEngineEvent.REE_NORMAL_MODE:
                    _loc2_ = new RoomWidgetRoomEngineUpdateEvent(RoomWidgetRoomEngineUpdateEvent.var_440, param1.roomId, param1.roomCategory);
                    break;
                case RoomEngineEvent.REE_GAME_MODE:
                    _loc2_ = new RoomWidgetRoomEngineUpdateEvent(RoomWidgetRoomEngineUpdateEvent.var_1261, param1.roomId, param1.roomCategory);
                    break;
            }

            if (_loc2_ != null)
            {
                this.events.dispatchEvent(_loc2_);
            }

        }

        public function createRoomView(param1: int): void
        {
            var _loc13_: Number;
            var _loc14_: Number;
            var _loc15_: Number;
            var _loc16_: Number;
            var _loc17_: Number;
            var _loc18_: Number;
            var _loc19_: Number;
            var _loc20_: Number;
            var _loc21_: IWindow;
            var _loc2_: Rectangle = this.var_4645.roomViewRect;
            var _loc3_: int = _loc2_.width;
            var _loc4_: int = _loc2_.height;
            var _loc5_: int = RoomGeometry.var_1545;
            if (this.var_4641.indexOf(param1) >= 0)
            {
                return;
            }

            if (this.var_4405 == null || this._windowManager == null || this._roomEngine == null)
            {
                return;
            }

            var _loc6_: DisplayObject = this._roomEngine.createRoomCanvas(this.var_4405.roomId, this.var_4405.roomCategory, param1, _loc3_, _loc4_, _loc5_);
            if (_loc6_ == null)
            {
                return;
            }

            var _loc7_: RoomGeometry = this._roomEngine.getRoomCanvasGeometry(this.var_4405.roomId, this.var_4405.roomCategory, param1) as RoomGeometry;
            if (_loc7_ != null)
            {
                _loc13_ = this._roomEngine.getRoomNumberValue(this.var_4405.roomId, this.var_4405.roomCategory, RoomVariableEnum.var_447);
                _loc14_ = this._roomEngine.getRoomNumberValue(this.var_4405.roomId, this.var_4405.roomCategory, RoomVariableEnum.var_449);
                _loc15_ = this._roomEngine.getRoomNumberValue(this.var_4405.roomId, this.var_4405.roomCategory, RoomVariableEnum.var_448);
                _loc16_ = this._roomEngine.getRoomNumberValue(this.var_4405.roomId, this.var_4405.roomCategory, RoomVariableEnum.var_450);
                _loc17_ = (_loc13_ + _loc14_) / 2;
                _loc18_ = (_loc15_ + _loc16_) / 2;
                _loc19_ = 20;
                _loc17_ = _loc17_ + (_loc19_ - 1);
                _loc18_ = _loc18_ + (_loc19_ - 1);
                _loc20_ = Math.sqrt(_loc19_ * _loc19_ + _loc19_ * _loc19_) * Math.tan((30 / 180) * Math.PI);
                _loc7_.location = new Vector3d(_loc17_, _loc18_, _loc20_);
            }

            var _loc8_: XmlAsset = this._assets.getAssetByName("room_view_container_xml") as XmlAsset;
            if (_loc8_ == null)
            {
                return;
            }

            var _loc9_: IWindowContainer = this._windowManager.buildFromXML(_loc8_.content as XML) as IWindowContainer;
            if (_loc9_ == null)
            {
                return;
            }

            _loc9_.width = _loc3_;
            _loc9_.height = _loc4_;
            var _loc10_: IDisplayObjectWrapper = _loc9_.findChildByName("room_canvas_wrapper") as IDisplayObjectWrapper;
            if (_loc10_ == null)
            {
                return;
            }

            _loc10_.setDisplayObject(_loc6_);
            _loc10_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_627, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_632, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_628, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_633, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowMouseEvent.var_634, this.canvasMouseHandler);
            _loc10_.addEventListener(WindowEvent.var_573, this.onRoomViewResized);
            var _loc11_: Sprite = new Sprite();
            _loc11_.mouseEnabled = false;
            _loc11_.blendMode = BlendMode.MULTIPLY;
            _loc10_ = (_loc9_.findChildByName("colorizer_wrapper") as IDisplayObjectWrapper);
            if (_loc10_ == null)
            {
                return;
            }

            _loc10_.setDisplayObject(_loc11_);
            _loc10_.addEventListener(WindowEvent.var_573, this.resizeColorizer);
            if (this.var_4405.isSpectatorMode)
            {
                _loc21_ = this.getSpectatorModeVisualization();
                if (_loc21_ != null)
                {
                    _loc21_.width = _loc9_.width;
                    _loc21_.height = _loc9_.height;
                    _loc9_.addChild(_loc21_);
                }

            }

            this.var_4645.addRoomView(_loc9_);
            this.var_4641.push(param1);
            var _loc12_: String = this._roomEngine.getWorldType(this.var_4405.roomId, this.var_4405.roomCategory);
            if (!this._roomEngine.isPublicRoomWorldType(_loc12_))
            {
                this.var_4651 = true;
                this.var_4652 = getTimer();
            }

        }

        private function resizeColorizer(param1: WindowEvent): void
        {
            var _loc2_: IDisplayObjectWrapper = param1.target as IDisplayObjectWrapper;
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: Sprite = _loc2_.getDisplayObject() as Sprite;
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.graphics.clear();
            _loc3_.graphics.beginFill(this.var_4650);
            _loc3_.graphics.drawRect(0, 0, _loc2_.width, _loc2_.height);
            _loc3_.graphics.endFill();
        }

        public function setRoomViewColor(param1: uint, param2: int): void
        {
            var _loc3_: IWindowContainer = this.var_4645.getRoomView() as IWindowContainer;
            if (_loc3_ == null)
            {
                return;
            }

            var _loc4_: IDisplayObjectWrapper = _loc3_.getChildByName("colorizer_wrapper") as IDisplayObjectWrapper;
            if (_loc4_ == null)
            {
                return;
            }

            var _loc5_: Sprite = _loc4_.getDisplayObject() as Sprite;
            if (_loc5_ == null)
            {
                return;
            }

            var _loc6_: int = ColorConverter.rgbToHSL(param1);
            _loc6_ = (_loc6_ & 0xFFFF00) + param2;
            param1 = ColorConverter.hslToRGB(_loc6_);
            this.var_4650 = param1;
            _loc5_.graphics.clear();
            _loc5_.graphics.beginFill(param1);
            _loc5_.graphics.drawRect(0, 0, _loc4_.width, _loc4_.height);
            _loc5_.graphics.endFill();
        }

        public function getFirstCanvasId(): int
        {
            if (this.var_4641 != null)
            {
                if (this.var_4641.length > 0)
                {
                    return this.var_4641[0];
                }

            }

            return 0;
        }

        public function getRoomViewRect(): Rectangle
        {
            if (!this.var_4645)
            {
                return null;
            }

            return this.var_4645.roomViewRect;
        }

        public function canvasMouseHandler(param1: WindowEvent): void
        {
            var _loc5_: Point;
            var _loc6_: int;
            var _loc7_: int;
            var _loc8_: Point;
            if (this._roomEngine == null || this.var_4405 == null)
            {
                return;
            }

            var _loc2_: WindowMouseEvent = param1 as WindowMouseEvent;
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: String = "";
            switch (_loc2_.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    _loc3_ = MouseEvent.CLICK;
                    break;
                case WindowMouseEvent.var_627:
                    _loc3_ = MouseEvent.DOUBLE_CLICK;
                    break;
                case WindowMouseEvent.var_628:
                    _loc3_ = MouseEvent.MOUSE_DOWN;
                    break;
                case WindowMouseEvent.var_633:
                case WindowMouseEvent.var_634:
                    _loc3_ = MouseEvent.MOUSE_UP;
                    break;
                case WindowMouseEvent.var_632:
                    _loc3_ = MouseEvent.MOUSE_MOVE;
                    break;
                default:
                    return;
            }

            var _loc4_: IDisplayObjectWrapper = _loc2_.target as IDisplayObjectWrapper;
            if (_loc4_ == _loc2_.target)
            {
                _loc5_ = new Point();
                _loc4_.getGlobalPosition(_loc5_);
                _loc6_ = _loc2_.stageX - _loc5_.x;
                _loc7_ = _loc2_.stageY - _loc5_.y;
                this._roomEngine.setActiveRoom(this.var_4405.roomId, this.var_4405.roomCategory);
                this._roomEngine.handleRoomCanvasMouseEvent(this.var_4641[0], _loc6_, _loc7_, _loc3_, _loc2_.altKey, _loc2_.ctrlKey, _loc2_.shiftKey, _loc2_.buttonDown);
            }

            if (_loc3_ == MouseEvent.MOUSE_MOVE && this.var_4649 != null)
            {
                _loc8_ = new Point(_loc2_.stageX, _loc2_.stageY);
                _loc8_.offset(-this.var_4649.width / 2, 15);
                this.var_4649.setGlobalPosition(_loc8_);
            }

        }

        private function onRoomViewResized(param1: WindowEvent): void
        {
            var _loc2_: IWindow = param1.window;
            this.var_4653 = _loc2_.rectangle;
            this._roomEngine.modifyRoomCanvas(this.var_4405.roomId, this.var_4405.roomCategory, this.var_4641[0], _loc2_.width, _loc2_.height);
            if (this.var_3635 == null)
            {
                this.var_3635 = new Timer(var_1546, 1);
                this.var_3635.addEventListener(TimerEvent.TIMER, this.onResizeTimerEvent);
            }
            else
            {
                this.var_3635.reset();
            }

            this.var_3635.start();
        }

        private function onResizeTimerEvent(param1: TimerEvent): void
        {
            var _loc2_: String = RoomWidgetRoomViewUpdateEvent.var_1327;
            this.events.dispatchEvent(new RoomWidgetRoomViewUpdateEvent(_loc2_, this.var_4653));
        }

        private function onToolbarRepositionEvent(param1: HabboToolbarEvent): void
        {
            if (this.var_4645 != null)
            {
                this.var_4645.toolbarOrientation = param1.orientation;
            }

        }

        private function trackZoomTime(param1: Boolean): void
        {
            var _loc2_: int;
            var _loc3_: int;
            if (this.var_4651)
            {
                _loc2_ = getTimer();
                _loc3_ = int(Math.round((_loc2_ - this.var_4652) / 1000));
                if (this._habboTracking != null)
                {
                    if (param1)
                    {
                        this._habboTracking.track("zoomEnded", "FurnitureQuestVendingWallItemLogic", _loc3_);
                    }
                    else
                    {
                        this._habboTracking.track("zoomEnded", "out", _loc3_);
                    }

                }

                this.var_4652 = _loc2_;
            }

        }

        private function onHabboToolbarEvent(param1: HabboToolbarEvent): void
        {
            var _loc2_: IRoomGeometry;
            var _loc3_: HabboToolbarSetIconEvent;
            if (param1.iconId == HabboToolbarIconEnum.ZOOM)
            {
                if (this.var_4405 != null)
                {
                    _loc2_ = this._roomEngine.getRoomCanvasGeometry(this.var_4405.roomId, this.var_4405.roomCategory, this.getFirstCanvasId());
                    if (_loc2_ != null)
                    {
                        this.trackZoomTime(_loc2_.isZoomedIn());
                        _loc2_.performZoom();
                        _loc3_ = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_176, HabboToolbarIconEnum.ZOOM);
                        if (_loc2_.isZoomedIn())
                        {
                            _loc3_.iconState = "2";
                            this.var_2844.events.dispatchEvent(_loc3_);
                        }
                        else
                        {
                            _loc3_.iconState = "0";
                            this.var_2844.events.dispatchEvent(_loc3_);
                        }

                    }

                }

            }

        }

        public function update(): void
        {
            var _loc3_: IRoomWidgetHandler;
            if (this._updateListeners == null)
            {
                return;
            }

            var _loc1_: int = this._updateListeners.length;
            var _loc2_: int;
            while (_loc2_ < _loc1_)
            {
                _loc3_ = (this._updateListeners.getWithIndex(_loc2_) as IRoomWidgetHandler);
                if (_loc3_ != null)
                {
                    _loc3_.update();
                }

                _loc2_++;
            }

        }

        private function getWindowName(param1: int): String
        {
            return "Room_Engine_Window_" + param1;
        }

        private function createFilter(param1: int, param2: int): Array
        {
            var _loc3_: BlurFilter = new BlurFilter(2, 2);
            return [];
        }

        private function getBitmapFilter(param1: int, param2: int): BitmapFilter
        {
            var _loc3_: BitmapData = new BitmapData(param1, param2);
            _loc3_.perlinNoise(param1, param2, 5, Math.random() * 0x77359400, true, false);
            var _loc4_: Point = new Point(0, 0);
            var _loc5_: uint = BitmapDataChannel.RED;
            var _loc6_: uint = _loc5_;
            var _loc7_: uint = _loc5_;
            var _loc8_: Number = param1 / 20;
            var _loc9_: Number = -param1 / 25;
            var _loc10_: String = DisplacementMapFilterMode.COLOR;
            var _loc11_: uint;
            var _loc12_: Number = 0;
            return new DisplacementMapFilter(_loc3_, _loc4_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_);
        }

        public function checkInterrupts(): void
        {
            if (this.var_2845 != null && this.var_4405 != null && this.var_4646 && this.var_4647)
            {
                this.var_2845.startSession(this.var_4405);
                this.processEvent(new RoomWidgetLoadingBarUpdateEvent(RoomWidgetLoadingBarUpdateEvent.var_1383));
            }

        }

        public function setInterstitialCompleted(): void
        {
            this.var_4646 = true;
            this.checkInterrupts();
        }

        private function handleRoomAdClick(param1: RoomEngineObjectEvent): void
        {
            if (param1 == null)
            {
                return;
            }

            var _loc2_: IRoomObject = this._roomEngine.getRoomObject(param1.roomId, param1.roomCategory, param1.objectId, param1.category);
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: IRoomObjectModel = _loc2_.getModel() as IRoomObjectModel;
            var _loc4_: String = _loc3_.getString(RoomObjectVariableEnum.var_488);
            if (_loc4_ == null || _loc4_.indexOf("http") != 0)
            {
                return;
            }

            switch (param1.type)
            {
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_CLICK:
                    if (this.var_4405.isRoomController || this.var_2847.isAnyRoomController)
                    {
                        return;
                    }

                    HabboWebTools.openWebPage(_loc4_);
                    return;
                case RoomEngineObjectEvent.REOE_ROOM_AD_FURNI_DOUBLE_CLICK:
                    if (!this.var_4405.isRoomController && !this.var_2847.isAnyRoomController)
                    {
                        return;
                    }

                    HabboWebTools.openWebPage(_loc4_);
                    return;
            }

        }

        private function handleRoomAdTooltip(param1: RoomEngineObjectEvent): void
        {
            var _loc2_: IRoomObject;
            var _loc3_: String;
            if (param1 == null)
            {
                return;
            }

            switch (param1.type)
            {
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_SHOW:
                    if (this.var_4649 != null)
                    {
                        return;
                    }

                    _loc2_ = this._roomEngine.getRoomObject(param1.roomId, param1.roomCategory, param1.objectId, param1.category);
                    if (_loc2_ == null)
                    {
                        return;
                    }

                    _loc3_ = this._localization.getKey(_loc2_.getType() + ".tooltip", "${ads.roomad.tooltip}");
                    this.var_4649 = (this._windowManager.createWindow("room_ad_tooltip", _loc3_, WindowType.var_203, WindowStyle.var_1114, WindowParam.var_691) as IToolTipWindow);
                    this.var_4649.setParamFlag(WindowParam.var_593, false);
                    this.var_4649.visible = true;
                    this.var_4649.center();
                    return;
                case RoomEngineObjectEvent.REOE_ROOM_AD_TOOLTIP_HIDE:
                    if (this.var_4649 == null)
                    {
                        return;
                    }

                    this.var_4649.dispose();
                    this.var_4649 = null;
                    return;
            }

        }

        private function getSpectatorModeVisualization(): IWindow
        {
            var _loc1_: XmlAsset = this._assets.getAssetByName("spectator_mode_xml") as XmlAsset;
            if (_loc1_ == null)
            {
                return null;
            }

            var _loc2_: IWindowContainer = this._windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer;
            if (_loc2_ == null)
            {
                return null;
            }

            this.setBitmap(_loc2_.findChildByName("top_left"), "spec_top_left_png");
            this.setBitmap(_loc2_.findChildByName("top_middle"), "spec_top_middle_png");
            this.setBitmap(_loc2_.findChildByName("top_right"), "spec_top_right_png");
            this.setBitmap(_loc2_.findChildByName("middle_left"), "spec_middle_left_png");
            this.setBitmap(_loc2_.findChildByName("middle_right"), "spec_middle_right_png");
            this.setBitmap(_loc2_.findChildByName("bottom_left"), "spec_bottom_left_png");
            this.setBitmap(_loc2_.findChildByName("bottom_middle"), "spec_bottom_middle_png");
            this.setBitmap(_loc2_.findChildByName("bottom_right"), "spec_bottom_right_png");
            return _loc2_;
        }

        private function setBitmap(param1: IWindow, param2: String): void
        {
            var _loc3_: IBitmapWrapperWindow = param1 as IBitmapWrapperWindow;
            if (_loc3_ == null || this._assets == null)
            {
                return;
            }

            var _loc4_: BitmapDataAsset = this._assets.getAssetByName(param2) as BitmapDataAsset;
            if (_loc4_ == null)
            {
                return;
            }

            var _loc5_: BitmapData = _loc4_.content as BitmapData;
            if (_loc5_ == null)
            {
                return;
            }

            _loc3_.bitmap = _loc5_.clone();
        }

        public function initializeWidget(param1: String, param2: int = 0): void
        {
            var _loc3_: IRoomWidget = this.var_2822[param1];
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.initialize(param2);
        }

        public function getWidgetState(param1: String): int
        {
            var _loc2_: IRoomWidget = this.var_2822[param1];
            if (_loc2_ == null)
            {
                return var_365;
            }

            return _loc2_.state;
        }

        public function addUpdateListener(param1: IRoomWidgetHandler): void
        {
            if (this._updateListeners == null)
            {
                this._updateListeners = [];
            }

            if (this._updateListeners.indexOf(param1) == -1)
            {
                this._updateListeners.push(param1);
            }

        }

        public function removeUpdateListener(param1: IRoomWidgetHandler): void
        {
            if (this._updateListeners == null)
            {
                return;
            }

            var _loc2_: int = this._updateListeners.indexOf(param1);
            if (_loc2_ != -1)
            {
                this._updateListeners.splice(_loc2_, 1);
            }

        }

    }
}
