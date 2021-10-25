package com.sulake.habbo.communication.demo
{

    import com.sulake.core.runtime.Component;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.core.communication.handshake.IKeyExchange;
    import com.sulake.habbo.communication.encryption.PseudoRandom;

    import iid.IIDHabboWindowManager;

    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    import flash.utils.ByteArray;
    import flash.geom.Point;

    import com.sulake.habbo.communication.enum.HabboConnectionType;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.core.communication.connection.IConnection;

    import flash.events.Event;

    import com.sulake.habbo.communication.messages.incoming.handshake.HelloMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.InitCryptoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.SecretKeyEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.SessionParamsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.error.ErrorReportEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent;

    import flash.external.ExternalInterface;

    import com.sulake.habbo.communication.enum.HabboCommunicationEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InitCryptoMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.handshake.DiffieHellman;
    import com.hurlant.math.BigInteger;
    import com.sulake.habbo.communication.messages.outgoing.handshake.GenerateSecretKeyMessageComposer;
    import com.sulake.habbo.communication.encryption.RC4_R27;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.encryption.CryptoTools;

    import flash.net.SharedObject;

    import com.sulake.habbo.communication.messages.outgoing.handshake.VersionCheckMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.UniqueIDMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.GetSessionParametersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.SSOTicketMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.TryLoginMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.handshake.InfoRetrieveMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.ConversionPointMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer;
    import com.sulake.habbo.communication.messages.parser.error.ErrorReportMessageParser;
    import com.sulake.habbo.utils.HabboWebTools;

    import flash.display.BitmapData;

    import com.sulake.iid.*;
    import com.sulake.habbo.communication.messages.incoming.handshake.*;
    import com.sulake.habbo.communication.messages.outgoing.handshake.*;

    import iid.*;

    public class HabboCommunicationDemo extends Component
    {

        private const var_2879: String = "fuselogin";

        private var _communicationManager: ICoreCommunicationManager;
        private var _habboConfiguration: IHabboConfigurationManager;
        private var _habboCommunication: IHabboCommunicationManager;
        private var _windowManager: IHabboWindowManager;
        private var _roomSessionManager: IRoomSessionManager;
        private var var_2870: IKeyExchange;
        private var var_2143: String;
        private var _view: HabboLoginDemoView;
        private var _seed: PseudoRandom;
        private var _ssoTicket: String;
        private var _flashClientUrl: String;
        private var var_2874: Boolean;
        private var var_2875: Boolean;
        private var _externalVariables: String;
        private var _hotelView: HabboHotelView;
        private var _token: String = "";

        public function HabboCommunicationDemo(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null)
        {
            super(param1, param2, param3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onHabboCommunication);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
        }

        private static function decode(param1: ByteArray, param2: uint, param3: uint, param4: Point, param5: Point): String
        {
            var _loc12_: int;
            var _loc13_: uint;
            var _loc14_: int;
            var _loc15_: uint;
            var _loc16_: uint;
            var _loc6_: String = "";
            var _loc7_: uint;
            var _loc8_: uint;
            var _loc9_: uint;
            var _loc10_: uint;
            if (param3 == 4)
            {
                _loc10_ = 1;
            }

            var _loc11_: int = param4.y;
            while (_loc11_ < param4.y + param5.y)
            {
                _loc12_ = param4.x;
                while (_loc12_ < param4.x + param5.x)
                {
                    _loc13_ = ((_loc11_ + _loc9_) * param2 + _loc12_) * param3;
                    _loc14_ = _loc10_;
                    while (_loc14_ < param3)
                    {
                        param1.position = _loc13_ + _loc14_;
                        _loc15_ = param1.readUnsignedByte();
                        _loc16_ = _loc15_ & 0x01;
                        _loc8_ = _loc8_ | _loc16_ << 7 - _loc7_;
                        if (_loc7_ == 7)
                        {
                            _loc6_ = _loc6_ + String.fromCharCode(_loc8_);
                            _loc8_ = 0;
                            _loc7_ = 0;
                        }
                        else
                        {
                            _loc7_++;
                        }

                        _loc14_++;
                    }

                    if (_loc12_ % 2 == 0)
                    {
                        _loc9_++;
                    }

                    _loc12_++;
                }

                _loc9_ = 0;
                _loc11_++;
            }

            return _loc6_;
        }

        private static function xor(param1: String, param2: String): String
        {
            var _loc6_: uint;
            var _loc3_: String = "";
            var _loc4_: int;
            var _loc5_: int;
            while (_loc5_ < param1.length)
            {
                _loc6_ = param1.charCodeAt(_loc5_);
                _loc3_ = _loc3_ + String.fromCharCode(_loc6_ ^ param2.charCodeAt(_loc4_));
                if (++_loc4_ == param2.length)
                {
                    _loc4_ = 0;
                }

                _loc5_++;
            }

            return _loc3_;
        }

        public function get communicationManager(): ICoreCommunicationManager
        {
            return this._communicationManager;
        }

        public function get habboConfiguration(): IHabboConfigurationManager
        {
            return this._habboConfiguration;
        }

        public function get habboCommunication(): IHabboCommunicationManager
        {
            return this._habboCommunication;
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function set ssoTicket(param1: String): void
        {
            this._ssoTicket = param1;
        }

        public function set flashClientUrl(param1: String): void
        {
            this._flashClientUrl = param1;
        }

        override public function dispose(): void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            }


            if (this._hotelView != null)
            {
                this._hotelView.dispose();
                this._hotelView = null;
            }

        }

        public function setSSOTicket(ticket: String): void
        {
            if (ticket && !this._ssoTicket)
            {
                this._ssoTicket = ticket;
                this._habboCommunication.initConnection(HabboConnectionType.CONNECTION_TYPE_HABBO);
            }

        }

        private function onHabboConfigurationInit(iid: IID = null, configurationManager: IUnknown = null): void
        {
            if (configurationManager != null)
            {
                this._habboConfiguration = (configurationManager as IHabboConfigurationManager);
                this.checkRequirements();
            }

        }

        private function onWindowManagerReady(iid: IID, windowManager: IUnknown): void
        {
            this._windowManager = (windowManager as IHabboWindowManager);
            this.checkRequirements();
        }

        private function onRoomSessionManagerReady(iid: IID, roomSessionManager: IUnknown): void
        {
            this._roomSessionManager = (roomSessionManager as IRoomSessionManager);
            this._roomSessionManager.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.onRoomSessionEnded);
            this.checkRequirements();
        }

        private function onHabboCommunication(iid: IID = null, communicationManager: IUnknown = null): void
        {
            var connection: IConnection;

            if (communicationManager != null)
            {
                this._habboCommunication = (communicationManager as IHabboCommunicationManager);
                connection = this._habboCommunication.getHabboMainConnection(null);

                if (connection != null)
                {
                    connection.addEventListener(Event.CONNECT, this.onConnectionEstablished);
                    connection.addEventListener(Event.CLOSE, this.onConnectionDisconnected);
                }


                this._habboCommunication.addHabboConnectionMessageEvent(new HelloMessageEvent(this.onHelloEvent));
                this._habboCommunication.addHabboConnectionMessageEvent(new InitCryptoMessageEvent(this.onInitCrypto));
                this._habboCommunication.addHabboConnectionMessageEvent(new SecretKeyEvent(this.onSecretKeyEvent));
                this._habboCommunication.addHabboConnectionMessageEvent(new SessionParamsMessageEvent(this.static));
                this._habboCommunication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
                this._habboCommunication.addHabboConnectionMessageEvent(new PingMessageEvent(this.onPing));
                this._habboCommunication.addHabboConnectionMessageEvent(new ErrorReportEvent(this.onErrorReport));
                this._habboCommunication.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
                this._habboCommunication.addHabboConnectionMessageEvent(new GenericErrorEvent(this.onGenericError));
                this._habboCommunication.addHabboConnectionMessageEvent(new DisconnectReasonEvent(this.onDisconnectReason));
                this._habboCommunication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEntryInfoEvent));
                this._habboCommunication.addHabboConnectionMessageEvent(new UniqueMachineIDEvent(this.onUniqueMachineId));
                this._habboCommunication.addHabboConnectionMessageEvent(new IdentityAccountsEvent(this.onIdentityAccounts));

                this.checkRequirements();
            }

        }

        private function checkRequirements(): void
        {
            if (this._habboCommunication && this._habboConfiguration && this._roomSessionManager && this._windowManager)
            {
                this.componentsAreRunning();
            }

        }

        private function componentsAreRunning(): void
        {
            var _loc4_: Boolean;

            this._hotelView = new HabboHotelView(this._windowManager, assets, Component(context).events);
            var hotelViewImage: String = this._habboConfiguration.getKey("client.hotel_view.image");
            var imageLibraryUrl: String = this._habboConfiguration.getKey("image.library.url");

            if (hotelViewImage != null && imageLibraryUrl != null)
            {
                this._hotelView.loadHotelViewImage(imageLibraryUrl + hotelViewImage);
            }


            var useSsoTicket: * = this._habboConfiguration.getKey("use.sso.ticket") == "1";

            this._ssoTicket = this._habboConfiguration.getKey("sso.ticket", null);
            this._flashClientUrl = this._habboConfiguration.getKey("flash.client.url", "");
            this._externalVariables = this._habboConfiguration.getKey("external.variables.txt", "");

            if (this._hotelView == null)
            {
                this._hotelView = new HabboHotelView(this._windowManager, assets, Component(context).events);
            }


            if (useSsoTicket)
            {
                this._habboCommunication.mode = HabboConnectionType.var_440;

                if (this._ssoTicket)
                {
                    this._habboCommunication.initConnection(HabboConnectionType.CONNECTION_TYPE_HABBO);
                }
                else
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.addCallback("setSSOTicket", this.setSSOTicket);
                        ExternalInterface.call("requestSSOTicket");
                    }

                }

            }
            else
            {
                if (this._windowManager != null)
                {
                    return; // dead code below
                    this._view = new HabboLoginDemoView(this);
                    this._view.addEventListener(HabboLoginDemoView.var_441, this.onInitConnection);
                }

            }

        }

        private function onInitConnection(param1: Event = null): void
        {
            this.dispatchLoginStepEvent(HabboCommunicationEvent.INIT);

            if (this._ssoTicket != null)
            {
                this._habboCommunication.mode = HabboConnectionType.var_440;
            }
            else
            {
                this._habboCommunication.mode = HabboConnectionType.var_440;

                if (this._habboConfiguration.keyExists("local.environment"))
                {
                    this._habboCommunication.mode = HabboConnectionType.var_442;
                }

            }


            this._habboCommunication.initConnection(HabboConnectionType.CONNECTION_TYPE_HABBO);
        }

        private function onConnectionEstablished(param1: Event = null): void
        {
            var messageComposer: IMessageComposer;

            var connection: IConnection = this._habboCommunication.getHabboMainConnection(null);

            if (connection != null)
            {
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_55);
                messageComposer = new InitCryptoMessageComposer(this._habboCommunication.mode);
                connection.send(messageComposer);
            }

        }

        private function onHelloEvent(param1: IMessageEvent): void
        {
        }

        private function onInitCrypto(event: IMessageEvent): void
        {
            var urlPrefix: String;
            var hotelViewBannerUrl: String;
            var publicKey: String;
            var connection: IConnection = event.connection;
            var initCryptoEvent: InitCryptoMessageEvent = event as InitCryptoMessageEvent;
            var token: String = initCryptoEvent.token;
            var isServerEncrypted: Boolean = initCryptoEvent.isServerEncrypted;

            this._seed = new PseudoRandom(parseInt(token.substring(token.length - 4), 16), 0x10000);

            switch (this._habboCommunication.mode)
            {
                case HabboConnectionType.var_440:
                    urlPrefix = "";
                    urlPrefix = this._habboConfiguration.getKey("url.prefix", urlPrefix);
                    urlPrefix = urlPrefix.replace("http://", "");
                    urlPrefix = urlPrefix.replace("https://", "");

                    hotelViewBannerUrl = this._habboConfiguration.getKey("hotelview.banner.url", "http:/\nsitename$/gamedata/banner");
                    hotelViewBannerUrl = hotelViewBannerUrl.replace("$sitename$", urlPrefix);

                    this._token = token;

                    this._hotelView.loadBannerImage(hotelViewBannerUrl + "?token=" + this._token, this.onHotelViewBannerLoaded);
                    return;

                case HabboConnectionType.var_442:
                    this.sendConnectionParameters(connection);
                    return;

                case HabboConnectionType.var_443:
                    this.var_2143 = this.generateRandomHexString(30);
                    this.var_2870 = new DiffieHellman(new BigInteger(this._habboConfiguration.getKey("connection.development.prime"), 16), new BigInteger(this._habboConfiguration.getKey("connection.development.generator"), 16));
                    this.var_2870.init(this.var_2143);

                    publicKey = this.var_2870.getPublicKey(10);

                    connection.send(new GenerateSecretKeyMessageComposer(publicKey.toUpperCase()));
                    return;

                default:
                    Logger.log("[HabboCommunicationDemo] Unknown Connection Mode: " + this._habboCommunication.mode);
            }

        }

        private function onSecretKeyEvent(param1: IMessageEvent): void
        {
            var _loc2_: IConnection = param1.connection;
            var _loc3_: SecretKeyEvent = param1 as SecretKeyEvent;
            var _loc4_: String = _loc3_.serverPublicKey;
            this.var_2870.generateSharedKey(_loc4_, 10);
            var _loc5_: String = this.var_2870.getSharedKey(16).toUpperCase();
            var _loc6_: RC4_R27 = new RC4_R27(null, null);
            var _loc7_: IEncryption = new RC4_R27(_loc6_, this._seed);
            var _loc8_: ByteArray = CryptoTools.hexStringToByteArray(_loc5_);
            _loc8_.position = 0;
            _loc6_.init(_loc8_);
            _loc8_.position = 0;
            _loc7_.initFromState(_loc6_);
            _loc2_.setEncryption(_loc7_);
            this.sendConnectionParameters(_loc2_);
        }

        private function sendConnectionParameters(connection: IConnection): void
        {
            var so: SharedObject;

            this.var_2874 = true;
            this.dispatchLoginStepEvent(HabboCommunicationEvent.var_56);
            connection.send(new VersionCheckMessageComposer(401, this._flashClientUrl, this._externalVariables));

            var machineId: String = "";

            try
            {
                so = SharedObject.getLocal(this.var_2879, "/");
                if (so.data.machineid != null)
                {
                    machineId = so.data.machineid;
                }

            }
            catch (e: Error)
            {
            }


            connection.send(new UniqueIDMessageComposer(machineId));
            connection.send(new GetSessionParametersMessageComposer());
        }

        private function static(param1: IMessageEvent): void
        {
            var _loc4_: SSOTicketMessageComposer;
            var _loc5_: String;
            var _loc6_: String;
            this.var_2874 = false;
            var _loc2_: IConnection = param1.connection;
            var _loc3_: SessionParamsMessageEvent = param1 as SessionParamsMessageEvent;
            if (this._ssoTicket != null)
            {
                _loc4_ = new SSOTicketMessageComposer(this._ssoTicket);
                _loc2_.send(_loc4_);
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_57);
            }
            else
            {
                if (this._view != null)
                {
                    _loc5_ = this._view.name;
                    _loc6_ = this._view.password;
                    if (_loc5_.length > 0 && _loc6_.length > 0)
                    {
                        this.sendTryLogin(_loc5_, _loc6_);
                        this.dispatchLoginStepEvent(HabboCommunicationEvent.var_57);
                    }

                }
                else
                {
                    Logger.log("[HabboCommunicationDemo] Error, no login window nor ticket");
                }

            }

        }

        public function sendTryLogin(param1: String, param2: String, param3: int = 0): void
        {
            var _loc4_: IConnection = this._habboCommunication.getHabboMainConnection(null);
            var _loc5_: TryLoginMessageComposer = new TryLoginMessageComposer(param1, param2, param3);
            _loc4_.send(_loc5_);
        }

        private function onAuthenticationOK(param1: IMessageEvent): void
        {
            var _loc2_: IConnection = param1.connection;
            var _loc3_: AuthenticationOKMessageEvent = param1 as AuthenticationOKMessageEvent;
            Logger.log("Authentication success!");
            var _loc4_: InfoRetrieveMessageComposer = new InfoRetrieveMessageComposer();
            _loc2_.send(_loc4_);
            var _loc5_: ConversionPointMessageComposer = new ConversionPointMessageComposer("Login", "socket", "client.auth_ok");
            _loc2_.send(_loc5_);
            if (this._view != null)
            {
                this._view.closeLoginWindow();
            }

            this.dispatchLoginStepEvent(HabboCommunicationEvent.var_59);
        }

        private function onUserObject(param1: IMessageEvent): void
        {
            param1.connection.send(new ScrGetUserInfoMessageComposer("habbo_club"));
        }

        private function onGenericError(event: IMessageEvent): void
        {
            var parser: GenericErrorParser = (event as GenericErrorEvent).getParser();
            switch (parser.errorCode)
            {
                case -3:
                    this._windowManager.alert("${connection.error.id.title}", "${connection.login.error.-3.desc}", 0, function (param1: IAlertDialog, param2: WindowEvent): void
                    {
                        param1.dispose();
                    });
                    return;
                case -400:
                    this._windowManager.alert("${connection.error.id.title}", "${connection.login.error.-400.desc}", 0, function (param1: IAlertDialog, param2: WindowEvent): void
                    {
                        param1.dispose();
                    });
                    return;
            }

        }

        private function onPing(param1: IMessageEvent): void
        {
            var _loc2_: IConnection = param1.connection;
            var _loc3_: PingMessageEvent = param1 as PingMessageEvent;
            var _loc4_: PongMessageComposer = new PongMessageComposer();
            _loc2_.send(_loc4_);
        }

        private function onUniqueMachineId(event: UniqueMachineIDEvent): void
        {
            var so: SharedObject;
            if (event == null)
            {
                return;
            }

            try
            {
                so = SharedObject.getLocal(this.var_2879, "/");
                so.data.machineid = event.machineID;
                so.flush();
            }
            catch (e: Error)
            {
            }

        }

        private function onIdentityAccounts(param1: IdentityAccountsEvent): void
        {
            if (!param1)
            {
                return;
            }

            if (this._view)
            {
                this._view.populateUserList(param1.getParser().accounts);
            }

        }

        private function onErrorReport(event: IMessageEvent): void
        {
            var parser: ErrorReportMessageParser = (event as ErrorReportEvent).getParser();
            var errorCode: int = parser.errorCode;
            var messageId: int = parser.messageId;
            var time: String = parser.timestamp;
            Logger.log("SERVER ERROR! Error code:" + errorCode + "Message id:" + messageId);
            this._windowManager.registerLocalizationParameter("connection.server.error.desc", "errorCode", String(errorCode));
            this._windowManager.alert("${connection.server.error.title}", "${connection.server.error.desc}", 0, function (param1: IAlertDialog, param2: WindowEvent): void
            {
                param1.dispose();
            });
        }

        private function onConnectionDisconnected(param1: Event): void
        {
            var _loc2_: String;
            if (this.var_2874)
            {
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_58);
            }

            if (param1.type == Event.CLOSE && !this.var_2875)
            {
                _loc2_ = this._habboConfiguration.getKey("logout.disconnect.url");
                _loc2_ = this.setOriginProperty(_loc2_);
                HabboWebTools.openWebPage(_loc2_, "_self");
            }

        }

        private function onDisconnectReason(param1: DisconnectReasonEvent): void
        {
            if (this.var_2874)
            {
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_58);
            }

            this.var_2875 = true;
            var _loc2_: String = this._habboConfiguration.getKey("logout.url");
            if (_loc2_.length > 0)
            {
                _loc2_ = this.setReasonProperty(_loc2_, param1.reasonString);
                _loc2_ = this.setOriginProperty(_loc2_);
                _loc2_ = _loc2_ + ("&id=" + param1.reason);
                HabboWebTools.openWebPage(_loc2_, "_self");
            }

        }

        private function setReasonProperty(param1: String, param2: String): String
        {
            if (param1.indexOf("%reason%") != -1)
            {
                return param1.replace("%reason%", param2);
            }

            return param1;
        }

        private function setOriginProperty(param1: String): String
        {
            if (param1.indexOf("%origin%") != -1)
            {
                return param1.replace("%origin%", this._habboConfiguration.getKey("flash.client.origin", "popup"));
            }


            return param1;
        }

        private function onRoomEntryInfoEvent(param1: RoomEntryInfoMessageEvent): void
        {
            if (this._hotelView)
            {
                if (!this._hotelView.disposed)
                {
                    this._hotelView.hide();
                }

            }

        }

        private function onRoomSessionEnded(param1: RoomSessionEvent): void
        {
            if (!this._roomSessionManager.sessionStarting)
            {
                this.showHotelView();
            }

        }

        private function showHotelView(): void
        {
            if (this._hotelView)
            {
                if (!this._hotelView.disposed)
                {
                    this._hotelView.show();
                }

            }

        }

        private function dispatchLoginStepEvent(param1: String): void
        {
            if (Component(context) == null || Component(context).events == null)
            {
                return;
            }

            Component(context).events.dispatchEvent(new Event(param1));
        }

        private function onHotelViewBannerLoaded(param1: BitmapData): void
        {
            var _loc15_: String;
            var _loc2_: ByteArray = param1.getPixels(param1.rect);
            var _loc3_: String = decode(_loc2_, param1.width, 4, new Point(4, 39), new Point(80, 30));
            var _loc4_: String = xor(_loc3_, this._token);
            var _loc5_: uint = _loc4_.charCodeAt(0);
            var _loc6_: uint = _loc4_.charCodeAt(_loc5_ + 1);
            var _loc7_: String = _loc4_.substr(1, _loc5_);
            var _loc8_: String = _loc4_.substr(_loc5_ + 2, _loc6_);
            var _loc9_: IConnection = this._habboCommunication.getHabboMainConnection(null);
            var _loc10_: BigInteger = new BigInteger();
            var _loc11_: BigInteger = new BigInteger();
            var _loc12_: String;
            _loc10_.fromRadix(_loc7_, 10);
            _loc11_.fromRadix(_loc8_, 10);
            this.var_2870 = new DiffieHellman(_loc10_, _loc11_);
            var _loc13_: int = 10;
            var _loc14_: String;
            while (_loc13_ > 0)
            {
                _loc14_ = this.generateRandomHexString(30);
                this.var_2870.init(_loc14_);
                _loc15_ = this.var_2870.getPublicKey(10);
                if (_loc15_.length < 64)
                {
                    if (_loc12_ == null || _loc15_.length > _loc12_.length)
                    {
                        _loc12_ = _loc15_;
                        this.var_2143 = _loc14_;
                    }

                }
                else
                {
                    _loc12_ = _loc15_;
                    this.var_2143 = _loc14_;
                    break;
                }

                _loc13_--;
            }

            if (_loc14_ != this.var_2143)
            {
                this.var_2870.init(this.var_2143);
            }

            _loc9_.send(new GenerateSecretKeyMessageComposer(_loc12_.toUpperCase()));
            this._token = "";
        }

        private function generateRandomHexString(param1: uint = 16): String
        {
            var _loc4_: uint;
            var _loc2_: String = "";
            var _loc3_: int;
            while (_loc3_ < param1)
            {
                _loc4_ = uint(uint(Math.random() * 0xFF));
                _loc2_ = _loc2_ + _loc4_.toString(16);
                _loc3_++;
            }

            return _loc2_;
        }

    }
}
