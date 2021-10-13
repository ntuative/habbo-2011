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

        private const var_2879:String = "fuselogin";

        private var var_2077:ICoreCommunicationManager;
        private var var_2868:IHabboConfigurationManager;
        private var var_2869:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var var_2845:IRoomSessionManager;
        private var var_2870:IKeyExchange;
        private var var_2143:String;
        private var _view:HabboLoginDemoView;
        private var var_2871:PseudoRandom;
        private var var_2872:String;
        private var var_2873:String;
        private var var_2874:Boolean;
        private var var_2875:Boolean;
        private var var_2876:String;
        private var var_2877:HabboHotelView;
        private var var_2878:String = "";

        public function HabboCommunicationDemo(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onHabboCommunication);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
        }

        private static function decode(param1:ByteArray, param2:uint, param3:uint, param4:Point, param5:Point):String
        {
            var _loc12_:int;
            var _loc13_:uint;
            var _loc14_:int;
            var _loc15_:uint;
            var _loc16_:uint;
            var _loc6_:String = "";
            var _loc7_:uint;
            var _loc8_:uint;
            var _loc9_:uint;
            var _loc10_:uint;
            if (param3 == 4)
            {
                _loc10_ = 1;
            };
            var _loc11_:int = param4.y;
            while (_loc11_ < (param4.y + param5.y))
            {
                _loc12_ = param4.x;
                while (_loc12_ < (param4.x + param5.x))
                {
                    _loc13_ = ((((_loc11_ + _loc9_) * param2) + _loc12_) * param3);
                    _loc14_ = _loc10_;
                    while (_loc14_ < param3)
                    {
                        param1.position = (_loc13_ + _loc14_);
                        _loc15_ = param1.readUnsignedByte();
                        _loc16_ = (_loc15_ & 0x01);
                        _loc8_ = (_loc8_ | (_loc16_ << (7 - _loc7_)));
                        if (_loc7_ == 7)
                        {
                            _loc6_ = (_loc6_ + String.fromCharCode(_loc8_));
                            _loc8_ = 0;
                            _loc7_ = 0;
                        }
                        else
                        {
                            _loc7_++;
                        };
                        _loc14_++;
                    };
                    if ((_loc12_ % 2) == 0)
                    {
                        _loc9_++;
                    };
                    _loc12_++;
                };
                _loc9_ = 0;
                _loc11_++;
            };
            return (_loc6_);
        }

        private static function xor(param1:String, param2:String):String
        {
            var _loc6_:uint;
            var _loc3_:String = "";
            var _loc4_:int;
            var _loc5_:int;
            while (_loc5_ < param1.length)
            {
                _loc6_ = param1.charCodeAt(_loc5_);
                _loc3_ = (_loc3_ + String.fromCharCode((_loc6_ ^ param2.charCodeAt(_loc4_))));
                if (++_loc4_ == param2.length)
                {
                    _loc4_ = 0;
                };
                _loc5_++;
            };
            return (_loc3_);
        }

        public function get communicationManager():ICoreCommunicationManager
        {
            return (this.var_2077);
        }

        public function get habboConfiguration():IHabboConfigurationManager
        {
            return (this.var_2868);
        }

        public function get habboCommunication():IHabboCommunicationManager
        {
            return (this.var_2869);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function set ssoTicket(param1:String):void
        {
            this.var_2872 = param1;
        }

        public function set flashClientUrl(param1:String):void
        {
            this.var_2873 = param1;
        }

        override public function dispose():void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
            if (this.var_2877 != null)
            {
                this.var_2877.dispose();
                this.var_2877 = null;
            };
        }

        public function setSSOTicket(param1:String):void
        {
            if (((param1) && (!(this.var_2872))))
            {
                this.var_2872 = param1;
                this.var_2869.initConnection(HabboConnectionType.var_311);
            };
        }

        private function onHabboConfigurationInit(param1:IID=null, param2:IUnknown=null):void
        {
            if (param2 != null)
            {
                this.var_2868 = (param2 as IHabboConfigurationManager);
                this.checkRequirements();
            };
        }

        private function onWindowManagerReady(param1:IID, param2:IUnknown):void
        {
            this._windowManager = (param2 as IHabboWindowManager);
            this.checkRequirements();
        }

        private function onRoomSessionManagerReady(param1:IID, param2:IUnknown):void
        {
            this.var_2845 = (param2 as IRoomSessionManager);
            this.var_2845.events.addEventListener(RoomSessionEvent.var_98, this.onRoomSessionEnded);
            this.checkRequirements();
        }

        private function onHabboCommunication(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc3_:IConnection;
            if (param2 != null)
            {
                this.var_2869 = (param2 as IHabboCommunicationManager);
                _loc3_ = this.var_2869.getHabboMainConnection(null);
                if (_loc3_ != null)
                {
                    _loc3_.addEventListener(Event.CONNECT, this.onConnectionEstablished);
                    _loc3_.addEventListener(Event.CLOSE, this.onConnectionDisconnected);
                };
                this.var_2869.addHabboConnectionMessageEvent(new HelloMessageEvent(this.onHelloEvent));
                this.var_2869.addHabboConnectionMessageEvent(new InitCryptoMessageEvent(this.onInitCrypto));
                this.var_2869.addHabboConnectionMessageEvent(new SecretKeyEvent(this.onSecretKeyEvent));
                this.var_2869.addHabboConnectionMessageEvent(new SessionParamsMessageEvent(this.static));
                this.var_2869.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
                this.var_2869.addHabboConnectionMessageEvent(new PingMessageEvent(this.onPing));
                this.var_2869.addHabboConnectionMessageEvent(new ErrorReportEvent(this.onErrorReport));
                this.var_2869.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
                this.var_2869.addHabboConnectionMessageEvent(new GenericErrorEvent(this.onGenericError));
                this.var_2869.addHabboConnectionMessageEvent(new DisconnectReasonEvent(this.onDisconnectReason));
                this.var_2869.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEntryInfoEvent));
                this.var_2869.addHabboConnectionMessageEvent(new UniqueMachineIDEvent(this.onUniqueMachineId));
                this.var_2869.addHabboConnectionMessageEvent(new IdentityAccountsEvent(this.onIdentityAccounts));
                this.checkRequirements();
            };
        }

        private function checkRequirements():void
        {
            if (((((this.var_2869) && (this.var_2868)) && (this.var_2845)) && (this._windowManager)))
            {
                this.componentsAreRunning();
            };
        }

        private function componentsAreRunning():void
        {
            var _loc4_:Boolean;
            this.var_2877 = new HabboHotelView(this._windowManager, assets, Component(context).events);
            var _loc1_:String = this.var_2868.getKey("client.hotel_view.image");
            var _loc2_:String = this.var_2868.getKey("image.library.url");
            if (((!(_loc1_ == null)) && (!(_loc2_ == null))))
            {
                this.var_2877.loadHotelViewImage((_loc2_ + _loc1_));
            };
            var _loc3_:* = (this.var_2868.getKey("use.sso.ticket") == "1");
            this.var_2872 = this.var_2868.getKey("sso.ticket", null);
            this.var_2873 = this.var_2868.getKey("flash.client.url", "");
            this.var_2876 = this.var_2868.getKey("external.variables.txt", "");
            if (this.var_2877 == null)
            {
                this.var_2877 = new HabboHotelView(this._windowManager, assets, Component(context).events);
            };
            if (_loc3_)
            {
                this.var_2869.mode = HabboConnectionType.var_440;
                if (this.var_2872)
                {
                    this.var_2869.initConnection(HabboConnectionType.var_311);
                }
                else
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.addCallback("setSSOTicket", this.setSSOTicket);
                        ExternalInterface.call("requestSSOTicket");
                    };
                };
            }
            else
            {
                if (this._windowManager != null)
                {
                    return;
                    this._view = new HabboLoginDemoView(this);
                    this._view.addEventListener(HabboLoginDemoView.var_441, this.onInitConnection);
                };
            };
        }

        private function onInitConnection(param1:Event=null):void
        {
            this.dispatchLoginStepEvent(HabboCommunicationEvent.INIT);
            if (this.var_2872 != null)
            {
                this.var_2869.mode = HabboConnectionType.var_440;
            }
            else
            {
                this.var_2869.mode = HabboConnectionType.var_440;
                if (this.var_2868.keyExists("local.environment"))
                {
                    this.var_2869.mode = HabboConnectionType.var_442;
                };
            };
            this.var_2869.initConnection(HabboConnectionType.var_311);
        }

        private function onConnectionEstablished(param1:Event=null):void
        {
            var _loc3_:IMessageComposer;
            var _loc2_:IConnection = this.var_2869.getHabboMainConnection(null);
            if (_loc2_ != null)
            {
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_55);
                _loc3_ = new InitCryptoMessageComposer(this.var_2869.mode);
                _loc2_.send(_loc3_);
            };
        }

        private function onHelloEvent(param1:IMessageEvent):void
        {
        }

        private function onInitCrypto(param1:IMessageEvent):void
        {
            var _loc6_:String;
            var _loc7_:String;
            var _loc8_:String;
            var _loc2_:IConnection = param1.connection;
            var _loc3_:InitCryptoMessageEvent = (param1 as InitCryptoMessageEvent);
            var _loc4_:String = _loc3_.token;
            var _loc5_:Boolean = _loc3_.isServerEncrypted;
            this.var_2871 = new PseudoRandom(parseInt(_loc4_.substring((_loc4_.length - 4)), 16), 0x10000);
            switch (this.var_2869.mode)
            {
                case HabboConnectionType.var_440:
                    _loc6_ = "";
                    _loc6_ = this.var_2868.getKey("url.prefix", _loc6_);
                    _loc6_ = _loc6_.replace("http://", "");
                    _loc6_ = _loc6_.replace("https://", "");
                    _loc7_ = this.var_2868.getKey("hotelview.banner.url", "http:/\nsitename$/gamedata/banner");
                    _loc7_ = _loc7_.replace("$sitename$", _loc6_);
                    this.var_2878 = _loc4_;
                    this.var_2877.loadBannerImage(((_loc7_ + "?token=") + this.var_2878), this.onHotelViewBannerLoaded);
                    return;
                case HabboConnectionType.var_442:
                    this.sendConnectionParameters(_loc2_);
                    return;
                case HabboConnectionType.var_443:
                    this.var_2143 = this.generateRandomHexString(30);
                    this.var_2870 = new DiffieHellman(new BigInteger(this.var_2868.getKey("connection.development.prime"), 16), new BigInteger(this.var_2868.getKey("connection.development.generator"), 16));
                    this.var_2870.init(this.var_2143);
                    _loc8_ = this.var_2870.getPublicKey(10);
                    _loc2_.send(new GenerateSecretKeyMessageComposer(_loc8_.toUpperCase()));
                    return;
                default:
                    Logger.log(("[HabboCommunicationDemo] Unknown Connection Mode: " + this.var_2869.mode));
            };
        }

        private function onSecretKeyEvent(param1:IMessageEvent):void
        {
            var _loc2_:IConnection = param1.connection;
            var _loc3_:SecretKeyEvent = (param1 as SecretKeyEvent);
            var _loc4_:String = _loc3_.serverPublicKey;
            this.var_2870.generateSharedKey(_loc4_, 10);
            var _loc5_:String = this.var_2870.getSharedKey(16).toUpperCase();
            var _loc6_:RC4_R27 = new RC4_R27(null, null);
            var _loc7_:IEncryption = new RC4_R27(_loc6_, this.var_2871);
            var _loc8_:ByteArray = CryptoTools.hexStringToByteArray(_loc5_);
            _loc8_.position = 0;
            _loc6_.init(_loc8_);
            _loc8_.position = 0;
            _loc7_.initFromState(_loc6_);
            _loc2_.setEncryption(_loc7_);
            this.sendConnectionParameters(_loc2_);
        }

        private function sendConnectionParameters(connection:IConnection):void
        {
            var so:SharedObject;
            this.var_2874 = true;
            this.dispatchLoginStepEvent(HabboCommunicationEvent.var_56);
            connection.send(new VersionCheckMessageComposer(401, this.var_2873, this.var_2876));
            var machineId:String = "";
            try
            {
                so = SharedObject.getLocal(this.var_2879, "/");
                if (so.data.machineid != null)
                {
                    machineId = so.data.machineid;
                };
            }
            catch(e:Error)
            {
            };
            connection.send(new UniqueIDMessageComposer(machineId));
            connection.send(new GetSessionParametersMessageComposer());
        }

        private function static(param1:IMessageEvent):void
        {
            var _loc4_:SSOTicketMessageComposer;
            var _loc5_:String;
            var _loc6_:String;
            this.var_2874 = false;
            var _loc2_:IConnection = param1.connection;
            var _loc3_:SessionParamsMessageEvent = (param1 as SessionParamsMessageEvent);
            if (this.var_2872 != null)
            {
                _loc4_ = new SSOTicketMessageComposer(this.var_2872);
                _loc2_.send(_loc4_);
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_57);
            }
            else
            {
                if (this._view != null)
                {
                    _loc5_ = this._view.name;
                    _loc6_ = this._view.password;
                    if (((_loc5_.length > 0) && (_loc6_.length > 0)))
                    {
                        this.sendTryLogin(_loc5_, _loc6_);
                        this.dispatchLoginStepEvent(HabboCommunicationEvent.var_57);
                    };
                }
                else
                {
                    Logger.log("[HabboCommunicationDemo] Error, no login window nor ticket");
                };
            };
        }

        public function sendTryLogin(param1:String, param2:String, param3:int=0):void
        {
            var _loc4_:IConnection = this.var_2869.getHabboMainConnection(null);
            var _loc5_:TryLoginMessageComposer = new TryLoginMessageComposer(param1, param2, param3);
            _loc4_.send(_loc5_);
        }

        private function onAuthenticationOK(param1:IMessageEvent):void
        {
            var _loc2_:IConnection = param1.connection;
            var _loc3_:AuthenticationOKMessageEvent = (param1 as AuthenticationOKMessageEvent);
            Logger.log("Authentication success!");
            var _loc4_:InfoRetrieveMessageComposer = new InfoRetrieveMessageComposer();
            _loc2_.send(_loc4_);
            var _loc5_:ConversionPointMessageComposer = new ConversionPointMessageComposer("Login", "socket", "client.auth_ok");
            _loc2_.send(_loc5_);
            if (this._view != null)
            {
                this._view.closeLoginWindow();
            };
            this.dispatchLoginStepEvent(HabboCommunicationEvent.var_59);
        }

        private function onUserObject(param1:IMessageEvent):void
        {
            param1.connection.send(new ScrGetUserInfoMessageComposer("habbo_club"));
        }

        private function onGenericError(event:IMessageEvent):void
        {
            var parser:GenericErrorParser = (event as GenericErrorEvent).getParser();
            switch (parser.errorCode)
            {
                case -3:
                    this._windowManager.alert("${connection.error.id.title}", "${connection.login.error.-3.desc}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
                case -400:
                    this._windowManager.alert("${connection.error.id.title}", "${connection.login.error.-400.desc}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    return;
            };
        }

        private function onPing(param1:IMessageEvent):void
        {
            var _loc2_:IConnection = param1.connection;
            var _loc3_:PingMessageEvent = (param1 as PingMessageEvent);
            var _loc4_:PongMessageComposer = new PongMessageComposer();
            _loc2_.send(_loc4_);
        }

        private function onUniqueMachineId(event:UniqueMachineIDEvent):void
        {
            var so:SharedObject;
            if (event == null)
            {
                return;
            };
            try
            {
                so = SharedObject.getLocal(this.var_2879, "/");
                so.data.machineid = event.machineID;
                so.flush();
            }
            catch(e:Error)
            {
            };
        }

        private function onIdentityAccounts(param1:IdentityAccountsEvent):void
        {
            if (!param1)
            {
                return;
            };
            if (this._view)
            {
                this._view.populateUserList(param1.getParser().accounts);
            };
        }

        private function onErrorReport(event:IMessageEvent):void
        {
            var parser:ErrorReportMessageParser = (event as ErrorReportEvent).getParser();
            var errorCode:int = parser.errorCode;
            var messageId:int = parser.messageId;
            var time:String = parser.timestamp;
            Logger.log(((("SERVER ERROR! Error code:" + errorCode) + "Message id:") + messageId));
            this._windowManager.registerLocalizationParameter("connection.server.error.desc", "errorCode", String(errorCode));
            this._windowManager.alert("${connection.server.error.title}", "${connection.server.error.desc}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }

        private function onConnectionDisconnected(param1:Event):void
        {
            var _loc2_:String;
            if (this.var_2874)
            {
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_58);
            };
            if (((param1.type == Event.CLOSE) && (!(this.var_2875))))
            {
                _loc2_ = this.var_2868.getKey("logout.disconnect.url");
                _loc2_ = this.setOriginProperty(_loc2_);
                HabboWebTools.openWebPage(_loc2_, "_self");
            };
        }

        private function onDisconnectReason(param1:DisconnectReasonEvent):void
        {
            if (this.var_2874)
            {
                this.dispatchLoginStepEvent(HabboCommunicationEvent.var_58);
            };
            this.var_2875 = true;
            var _loc2_:String = this.var_2868.getKey("logout.url");
            if (_loc2_.length > 0)
            {
                _loc2_ = this.setReasonProperty(_loc2_, param1.reasonString);
                _loc2_ = this.setOriginProperty(_loc2_);
                _loc2_ = (_loc2_ + ("&id=" + param1.reason));
                HabboWebTools.openWebPage(_loc2_, "_self");
            };
        }

        private function setReasonProperty(param1:String, param2:String):String
        {
            if (param1.indexOf("%reason%") != -1)
            {
                return (param1.replace("%reason%", param2));
            };
            return (param1);
        }

        private function setOriginProperty(param1:String):String
        {
            if (param1.indexOf("%origin%") != -1)
            {
                return (param1.replace("%origin%", this.var_2868.getKey("flash.client.origin", "popup")));
            };
            return (param1);
        }

        private function onRoomEntryInfoEvent(param1:RoomEntryInfoMessageEvent):void
        {
            if (this.var_2877)
            {
                if (!this.var_2877.disposed)
                {
                    this.var_2877.hide();
                };
            };
        }

        private function onRoomSessionEnded(param1:RoomSessionEvent):void
        {
            if (!this.var_2845.sessionStarting)
            {
                this.showHotelView();
            };
        }

        private function showHotelView():void
        {
            if (this.var_2877)
            {
                if (!this.var_2877.disposed)
                {
                    this.var_2877.show();
                };
            };
        }

        private function dispatchLoginStepEvent(param1:String):void
        {
            if (((Component(context) == null) || (Component(context).events == null)))
            {
                return;
            };
            Component(context).events.dispatchEvent(new Event(param1));
        }

        private function onHotelViewBannerLoaded(param1:BitmapData):void
        {
            var _loc15_:String;
            var _loc2_:ByteArray = param1.getPixels(param1.rect);
            var _loc3_:String = decode(_loc2_, param1.width, 4, new Point(4, 39), new Point(80, 30));
            var _loc4_:String = xor(_loc3_, this.var_2878);
            var _loc5_:uint = _loc4_.charCodeAt(0);
            var _loc6_:uint = _loc4_.charCodeAt((_loc5_ + 1));
            var _loc7_:String = _loc4_.substr(1, _loc5_);
            var _loc8_:String = _loc4_.substr((_loc5_ + 2), _loc6_);
            var _loc9_:IConnection = this.var_2869.getHabboMainConnection(null);
            var _loc10_:BigInteger = new BigInteger();
            var _loc11_:BigInteger = new BigInteger();
            var _loc12_:String;
            _loc10_.fromRadix(_loc7_, 10);
            _loc11_.fromRadix(_loc8_, 10);
            this.var_2870 = new DiffieHellman(_loc10_, _loc11_);
            var _loc13_:int = 10;
            var _loc14_:String;
            while (_loc13_ > 0)
            {
                _loc14_ = this.generateRandomHexString(30);
                this.var_2870.init(_loc14_);
                _loc15_ = this.var_2870.getPublicKey(10);
                if (_loc15_.length < 64)
                {
                    if (((_loc12_ == null) || (_loc15_.length > _loc12_.length)))
                    {
                        _loc12_ = _loc15_;
                        this.var_2143 = _loc14_;
                    };
                }
                else
                {
                    _loc12_ = _loc15_;
                    this.var_2143 = _loc14_;
                    break;
                };
                _loc13_--;
            };
            if (_loc14_ != this.var_2143)
            {
                this.var_2870.init(this.var_2143);
            };
            _loc9_.send(new GenerateSecretKeyMessageComposer(_loc12_.toUpperCase()));
            this.var_2878 = "";
        }

        private function generateRandomHexString(param1:uint=16):String
        {
            var _loc4_:uint;
            var _loc2_:String = "";
            var _loc3_:int;
            while (_loc3_ < param1)
            {
                _loc4_ = uint(uint((Math.random() * 0xFF)));
                _loc2_ = (_loc2_ + _loc4_.toString(16));
                _loc3_++;
            };
            return (_loc2_);
        }

    }
}