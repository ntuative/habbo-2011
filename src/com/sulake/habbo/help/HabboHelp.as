package com.sulake.habbo.help
{

    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.help.tutorial.TutorialUI;
    import com.sulake.habbo.help.hotelmerge.HotelMergeUI;
    import com.sulake.habbo.help.cfh.data.CallForHelpData;
    import com.sulake.habbo.help.cfh.data.UserRegistry;

    import iid.IIDHabboWindowManager;

    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.communication.messages.IMessageComposer;

    import flash.utils.Dictionary;

    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;

    public class HabboHelp extends Component implements IHabboHelp
    {

        private var _toolbar: IHabboToolbar;
        private var _assetLibrary: IAssetLibrary;
        private var _windowManager: IHabboWindowManager;
        private var _communication: IHabboCommunicationManager;
        private var _localization: IHabboLocalizationManager;
        private var _configuration: IHabboConfigurationManager;
        private var _sessionDataManager: ISessionDataManager;
        private var _faqUI: FaqIndex;
        private var _incomingMessages: IncomingMessages;
        private var _helpUI: HelpUI;
        private var _tutorialUI: TutorialUI;
        private var _hotelMergeUI: HotelMergeUI;
        private var _callForHelpData: CallForHelpData = new CallForHelpData();
        private var _userRegistry: UserRegistry = new UserRegistry();
        private var _ownUserName: String = "";
        private var _welcomeController: WelcomeScreenController;

        public function HabboHelp(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null)
        {
            super(param1, param2, param3);
            this._assetLibrary = param3;
            this._faqUI = new FaqIndex();
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
        }

        public function set ownUserName(param1: String): void
        {
            this._ownUserName = param1;
        }

        public function get ownUserName(): String
        {
            return this._ownUserName;
        }

        public function get callForHelpData(): CallForHelpData
        {
            return this._callForHelpData;
        }

        public function get userRegistry(): UserRegistry
        {
            return this._userRegistry;
        }

        public function get localization(): IHabboLocalizationManager
        {
            return this._localization;
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get toolbar(): IHabboToolbar
        {
            return this._toolbar;
        }

        public function get sessionDataManager(): ISessionDataManager
        {
            return this._sessionDataManager;
        }

        public function get tutorialUI(): TutorialUI
        {
            return this._tutorialUI;
        }

        public function get hotelMergeUI(): HotelMergeUI
        {
            return this._hotelMergeUI;
        }

        public function hasChangedName(): Boolean
        {
            if (this._tutorialUI)
            {
                return this._tutorialUI.hasChangedName;
            }

            return true;
        }

        override public function dispose(): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.dispose();
                this._helpUI = null;
            }

            if (this._tutorialUI != null)
            {
                this._tutorialUI.dispose();
                this._tutorialUI = null;
            }

            if (this._hotelMergeUI)
            {
                this._hotelMergeUI.dispose();
                this._hotelMergeUI = null;
            }

            if (this._faqUI != null)
            {
                this._faqUI.dispose();
                this._faqUI = null;
            }

            this._incomingMessages = null;

            if (this._toolbar)
            {
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            }

            if (this._localization)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            }

            if (this._communication)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            }

            if (this._configuration)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            }

            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            }

            if (this._sessionDataManager != null)
            {
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            }

            if (this._welcomeController != null)
            {
                this._welcomeController.dispose();
                this._welcomeController = null;
            }

            super.dispose();
        }

        public function showUI(param1: String = null): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.showUI(param1);
            }

        }

        public function hideUI(): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.hideUI();
            }

        }

        public function tellUI(param1: String, param2: * = null): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.tellUI(param1, param2);
            }

        }

        public function enableCallForGuideBotUI(): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.updateCallForGuideBotUI(true);
            }

        }

        public function disableCallForGuideBotUI(): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.updateCallForGuideBotUI(false);
            }

        }

        public function getFaq(): FaqIndex
        {
            return this._faqUI;
        }

        public function sendMessage(param1: IMessageComposer): void
        {
            if (this._communication != null && param1 != null)
            {
                this._communication.getHabboMainConnection(null).send(param1);
            }

        }

        public function getConfigurationKey(param1: String, param2: String = null, param3: Dictionary = null): String
        {
            if (this._configuration == null)
            {
                return param1;
            }

            return this._configuration.getKey(param1, param2, param3);
        }

        public function showCallForHelpReply(param1: String): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.showCallForHelpReply(param1);
            }

        }

        public function showCallForHelpResult(param1: String): void
        {
            if (this._helpUI != null)
            {
                this._helpUI.showCallForHelpResult(param1);
            }

        }

        public function reportUser(param1: int, param2: String): void
        {
            this._callForHelpData.reportedUserId = param1;
            this._callForHelpData.reportedUserName = param2;
            this._helpUI.showUI(HabboHelpViewEnum.HHVE_CFG_TOPIC_SELECT);
        }

        private function toggleHelpUI(): void
        {
            if (this._helpUI == null)
            {
                if (!this.createHelpUI())
                {
                    return;
                }

            }

            this._helpUI.toggleUI();
        }

        private function createHelpUI(): Boolean
        {
            if (this._helpUI == null && this._assetLibrary != null && this._windowManager != null)
            {
                this._helpUI = new HelpUI(this, this._assetLibrary, this._windowManager, this._localization, this._toolbar);
            }

            return this._helpUI != null;
        }

        private function createTutorialUI(): Boolean
        {
            var _loc1_: Boolean;
            if (this._tutorialUI == null && this._assetLibrary != null && this._windowManager != null)
            {
                _loc1_ = this.getConfigurationKey("avatar.widget.enabled", "0") == "0";
                this._tutorialUI = new TutorialUI(this, _loc1_);
            }

            return this._tutorialUI != null;
        }

        public function removeTutorialUI(): void
        {
            if (this._tutorialUI != null)
            {
                this._tutorialUI.dispose();
                this._tutorialUI = null;
            }

        }

        public function initHotelMergeUI(): void
        {
            if (!this._hotelMergeUI)
            {
                this._hotelMergeUI = new HotelMergeUI(this);
            }

            this._hotelMergeUI.startNameChange();
        }

        public function updateTutorial(param1: Boolean, param2: Boolean, param3: Boolean): void
        {
            if (param1 && param2 && param3)
            {
                this.removeTutorialUI();
                return;
            }

            if (this._tutorialUI == null)
            {
                if (!this.createTutorialUI())
                {
                    return;
                }

            }

            this._tutorialUI.update(param1, param2, param3);
        }

        public function startNameChange(): void
        {
            if (this._tutorialUI)
            {
                this._tutorialUI.showView(TutorialUI.TUTORIAL_UI_NAME_VIEW);
            }

        }

        private function onWindowManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            this._windowManager = IHabboWindowManager(param2);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
        }

        private function onCommunicationManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            this._communication = IHabboCommunicationManager(param2);
            this._incomingMessages = new IncomingMessages(this, this._communication);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
        }

        private function onToolbarReady(param1: IID = null, param2: IUnknown = null): void
        {
            this._toolbar = IHabboToolbar(param2);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
        }

        private function onLocalizationManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            this._localization = IHabboLocalizationManager(param2);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
        }

        private function onConfigurationManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            this._configuration = IHabboConfigurationManager(param2);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
        }

        private function onRoomSessionManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            var _loc3_: IRoomSessionManager = IRoomSessionManager(param2);
            _loc3_.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.onRoomSessionEvent);
            _loc3_.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.onRoomSessionEvent);
            this._toolbar.events.addEventListener(HabboToolbarEvent.var_100, this.onHabboToolbarEvent);
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
            this.createHelpUI();
            this.setHabboToolbarIcon();
        }

        private function onSessionDataManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._sessionDataManager = (param2 as ISessionDataManager);
        }

        private function onRoomSessionEvent(param1: RoomSessionEvent): void
        {
            switch (param1.type)
            {
                case RoomSessionEvent.RSE_STARTED:
                    if (this._helpUI != null)
                    {
                        this._helpUI.setRoomSessionStatus(true);
                    }

                    if (this._tutorialUI != null)
                    {
                        this._tutorialUI.setRoomSessionStatus(true);
                    }

                    this.showWelcomeScreen(true);
                    return;
                case RoomSessionEvent.RSE_ENDED:
                    if (this._helpUI != null)
                    {
                        this._helpUI.setRoomSessionStatus(false);
                    }

                    if (this._tutorialUI != null)
                    {
                        this._tutorialUI.setRoomSessionStatus(false);
                    }

                    this.userRegistry.unregisterRoom();
                    this.showWelcomeScreen(false);
                    return;
            }

        }

        private function showWelcomeScreen(param1: Boolean): void
        {
            if (!this._welcomeController)
            {
                this._welcomeController = new WelcomeScreenController(this, this._windowManager, this._configuration);
            }

            this._welcomeController.showWelcomeScreen(param1);
        }

        private function setHabboToolbarIcon(): void
        {
            if (this._toolbar != null)
            {
                this._toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_145, HabboToolbarIconEnum.HELP));
            }

        }

        private function onHabboToolbarEvent(param1: HabboToolbarEvent): void
        {
            if (param1.type == HabboToolbarEvent.var_100)
            {
                this.setHabboToolbarIcon();
                return;
            }

            if (param1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK)
            {
                if (param1.iconId == HabboToolbarIconEnum.HELP)
                {
                    this.toggleHelpUI();

                }

            }

        }

        public function setWelcomeNotifications(param1: Array): void
        {
            if (!this._welcomeController)
            {
                this.showWelcomeScreen(true);
            }

            this._welcomeController.notifications = param1;
        }

    }
}
