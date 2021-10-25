package com.sulake.habbo.moderation
{

    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;

    import iid.IIDHabboWindowManager;

    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;

    public class ModerationManager extends Component implements IHabboModeration
    {

        private var _windowManager: IHabboWindowManager;
        private var _communication: IHabboCommunicationManager;
        private var _connection: IConnection;
        private var _sessionDataManager: ISessionDataManager;
        private var _configuration: IHabboConfigurationManager;
        private var _navigator: IHabboNavigator;
        private var _soundManager: IHabboSoundManager;
        private var _messageHandler: ModerationMessageHandler;
        private var _issueManager: IssueManager;
        private var _startPanel: StartPanelCtrl;
        private var _windowTracker: WindowTracker;
        private var _initMsg: ModeratorInitData;
        private var _currentFlatId: int;

        public function ModerationManager(ctx: IContext, flags: uint = 0, assets: IAssetLibrary = null)
        {
            super(ctx, flags, assets);

            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            
            this._startPanel = new StartPanelCtrl(this);
            this._windowTracker = new WindowTracker();
        }

        override public function dispose(): void
        {
            if (this._startPanel)
            {
                this._startPanel.dispose();
                this._startPanel = null;
            }

            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            }

            if (this._communication)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            }

            if (this._sessionDataManager)
            {
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            }

            if (this._configuration)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            }

            if (this._navigator)
            {
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            }

            if (this._soundManager)
            {
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            }

            this._connection = null;
            super.dispose();
        }

        public function userSelected(id: int, userName: String): void
        {
            Logger.log("USER SELECTED: " + id + ", " + userName);
            this._startPanel.userSelected(id, userName);
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get sessionDataManager(): ISessionDataManager
        {
            return this._sessionDataManager;
        }

        public function get issueManager(): IssueManager
        {
            return this._issueManager;
        }

        public function get connection(): IConnection
        {
            return this._connection;
        }

        public function get startPanel(): StartPanelCtrl
        {
            return this._startPanel;
        }

        public function get initMsg(): ModeratorInitData
        {
            return this._initMsg;
        }

        public function get messageHandler(): ModerationMessageHandler
        {
            return this._messageHandler;
        }

        public function get configuration(): IHabboConfigurationManager
        {
            return this._configuration;
        }

        public function get windowTracker(): WindowTracker
        {
            return this._windowTracker;
        }

        public function get currentFlatId(): int
        {
            return this._currentFlatId;
        }

        public function get soundManager(): IHabboSoundManager
        {
            return this._soundManager;
        }

        public function set initMsg(value: ModeratorInitData): void
        {
            this._initMsg = value;
        }

        public function set currentFlatId(value: int): void
        {
            this._currentFlatId = value;
        }

        private function onWindowManagerReady(iid: IID = null, windowManager: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._windowManager = (windowManager as IHabboWindowManager);
            this._issueManager = new IssueManager(this);
        }

        private function onCommunicationReady(iid: IID = null, communication: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._communication = (communication as IHabboCommunicationManager);
            
            if (this._communication != null)
            {
                this._connection = this._communication.getHabboMainConnection(this.onConnectionReady);
                
                if (this._connection != null)
                {
                    this.onConnectionReady(this._connection);
                }

            }

        }

        private function onConnectionReady(connection: IConnection): void
        {
            if (disposed)
            {
                return;
            }

            if (connection != null)
            {
                this._connection = connection;
                this._messageHandler = new ModerationMessageHandler(this);
            }

        }

        private function onSessionDataReady(iid: IID = null, sessionDataManager: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._sessionDataManager = (sessionDataManager as ISessionDataManager);
        }

        private function onConfigurationReady(iid: IID = null, configuration: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._configuration = (configuration as IHabboConfigurationManager);
        }

        private function onNavigatorReady(iid: IID = null, navigator: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._navigator = IHabboNavigator(navigator);
        }

        private function onSoundManagerReady(iid: IID = null, param2: IUnknown = null): void
        {
            this._soundManager = (param2 as IHabboSoundManager);
        }

        public function getXmlWindow(param1: String): IWindow
        {
            var asset: IAsset = assets.getAssetByName(param1 + "_xml");
            var assetXml: XmlAsset = XmlAsset(asset);

            return this._windowManager.buildFromXML(XML(assetXml.content));
        }

        public function openHkPage(key: String, path: String): void
        {
            var base: String = this.configuration.getKey(key);
            var url: String = base + path;
            var title: String = "housekeeping";

            HabboWebTools.navigateToURL(url, title);
        }

        public function disableButton(authorized: Boolean, container: IWindowContainer, name: String): void
        {
            var button: IButtonWindow = IButtonWindow(container.findChildByName(name));
            
            if (!authorized)
            {
                button.disable();
                button.toolTipCaption = "No permission";
            }

        }

        public function goToRoom(id: int): void
        {
            Logger.log("MOD: GO TO ROOM: " + id);

            this._navigator.goToRoom(id, false);
        }

    }
}
