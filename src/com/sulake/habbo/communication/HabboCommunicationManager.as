package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.communication.connection.IConnectionStateListener;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import flash.utils.Timer;
    import com.sulake.iid.IIDCoreCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import flash.events.Event;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.habbo.communication.enum.HabboProtocolType;
    import com.sulake.habbo.communication.protocol.WedgieProtocol;
    import com.sulake.habbo.communication.enum.HabboConnectionType;
    import com.sulake.core.communication.enum.ConnectionType;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.core.Core;
    import flash.events.TimerEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.tracking.HabboErrorVariableEnum;
    import com.sulake.iid.*;

    public class HabboCommunicationManager extends Component implements IHabboCommunicationManager, IConnectionStateListener 
    {

        private const var_3364:int = 2;

        private var var_2077:ICoreCommunicationManager;
        private var var_2868:IHabboConfigurationManager;
        private var _connection:IConnection;
        private var var_2590:int = 0;
        private var var_3269:IMessageConfiguration = new HabboMessages();
        private var var_2295:String = "";
        private var var_3365:Array = [];
        private var var_3366:int = -1;
        private var var_3367:Timer = new Timer(100, 1);
        private var var_3368:int = 1;
        private var var_3369:String = "";
        private var var_3370:Boolean = false;
        private var var_3371:Boolean = false;
        private var var_3372:Boolean = false;

        public function HabboCommunicationManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.queueInterface(new IIDCoreCommunicationManager(), this.onCoreCommunicationManagerInit);
            this.queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
            param1.events.addEventListener(Event.UNLOAD, this.unloading);
        }

        public function get mode():int
        {
            return (this.var_2590);
        }

        public function set mode(param1:int):void
        {
            this.var_2590 = param1;
        }

        public function get port():int
        {
            if ((((this.var_3365.length == 0) || (this.var_3366 < 0)) || (this.var_3366 >= this.var_3365.length)))
            {
                return (0);
            };
            return (this.var_3365[this.var_3366]);
        }

        private function unloading(param1:Event):void
        {
            if (this._connection)
            {
                this._connection.send(new DisconnectMessageComposer());
                this._connection.dispose();
                this._connection = null;
            };
        }

        override public function dispose():void
        {
            if (this._connection)
            {
                this._connection.dispose();
                this._connection = null;
            };
            if (this.var_2077)
            {
                this.var_2077.release(new IIDCoreCommunicationManager());
                this.var_2077 = null;
            };
            if (this.var_2868)
            {
                this.var_2868.release(new IIDHabboConfigurationManager());
                this.var_2868 = null;
            };
            super.dispose();
        }

        private function onCoreCommunicationManagerInit(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc3_:IProtocol;
            Logger.log(("Habbo Communication Manager: Core Communication Manager found:: " + [param1, param2]));
            if (param2 != null)
            {
                this.var_2077 = (param2 as ICoreCommunicationManager);
                this.var_2077.connectionStateListener = this;
                this.var_2077.registerProtocolType(HabboProtocolType.var_310, WedgieProtocol);
                this._connection = this.var_2077.createConnection(HabboConnectionType.var_311, ConnectionType.var_312);
                _loc3_ = this.var_2077.getProtocolInstanceOfType(HabboProtocolType.var_310);
                this._connection.registerMessageClasses(this.var_3269);
                this._connection.protocol = _loc3_;
                this._connection.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
                this._connection.addEventListener(Event.CONNECT, this.onConnect);
            };
        }

        private function onHabboConfigurationInit(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc3_:String;
            var _loc4_:Boolean;
            var _loc5_:Array;
            var _loc6_:String;
            if (param2 != null)
            {
                Logger.log(("Habbo Communication Manager: init based on configuration: " + this.var_2868));
                ErrorReportStorage.addDebugData("CommunicationConfigInit", "Config Received");
                this.var_2868 = (param2 as IHabboConfigurationManager);
                ErrorReportStorage.addDebugData("CommunicationConfigInit", "Config Ready");
                this.var_3365 = [];
                this.var_2295 = this.var_2868.getKey("connection.info.host", null);
                if (this.var_2295 == null)
                {
                    Core.crash("connection.info.host was not defined", Core.var_86);
                    return;
                };
                _loc3_ = this.var_2868.getKey("connection.info.port", null);
                if (_loc3_ == null)
                {
                    Core.crash("connection.info.port was not defined", Core.var_86);
                    return;
                };
                if (((this.var_2868.keyExists("local.environment")) && (this.var_2868.getKey("local.environment") == "true")))
                {
                    this.var_2295 = this.var_2868.getKey("connection.info.host.local");
                    _loc3_ = this.var_2868.getKey("connection.info.port.local");
                };
                _loc4_ = this.validateHost();
                if (!_loc4_)
                {
                    Core.crash(("Tried to connect to an invalid host: " + this.var_2295), Core.var_86);
                    return;
                };
                _loc5_ = _loc3_.split(",");
                for each (_loc6_ in _loc5_)
                {
                    this.var_3365.push(parseInt(_loc6_.replace(" ", "")));
                };
                ErrorReportStorage.addDebugData("CommunicationConfigInit", ("Config Host: " + this.var_2295));
                Logger.log(("Connection Host: " + this.var_2295));
                Logger.log(("Connection Ports: " + this.var_3365));
                Logger.log(("Habbo Connection Info:" + this._connection));
                this.var_3371 = true;
                if (this.var_3372)
                {
                    this.nextPort();
                };
            }
            else
            {
                ErrorReportStorage.addDebugData("CommunicationConfigInit", "Config NOT received");
            };
        }

        private function validateHost():Boolean
        {
            var _loc2_:int;
            var _loc1_:Array = this.var_2295.split(".");
            if (_loc1_.length >= 2)
            {
                _loc2_ = (_loc1_.length - 1);
                if (((_loc1_[_loc2_] == "com") && ((_loc1_[(_loc2_ - 1)] == "habbo") || (_loc1_[(_loc2_ - 1)] == "sulake"))))
                {
                    return (true);
                };
                if (((_loc1_[_loc2_] == "net") && (_loc1_[(_loc2_ - 1)] == "varoke")))
                {
                    return (true);
                };
            };
            return (true);
        }

        public function initConnection(param1:String):void
        {
            switch (param1)
            {
                case HabboConnectionType.var_311:
                    if (this.var_2868 == null)
                    {
                        Core.crash("Tried to connect to proxy but configuration was null", Core.var_86);
                        return;
                    };
                    if (this._connection == null)
                    {
                        Core.crash("Tried to connect to proxy but connection was null", Core.var_86);
                        return;
                    };
                    this.var_3372 = true;
                    if (this.var_3371)
                    {
                        this.nextPort();
                    };
                    return;
                default:
                    Logger.log(("Unknown Habbo Connection Type: " + param1));
            };
        }

        private function nextPort():void
        {
            var _loc1_:int;
            if (this._connection.connected)
            {
                Logger.log("Warning: Already connected so will not try to connect again!");
                return;
            };
            this.var_3366++;
            if (this.var_3366 >= this.var_3365.length)
            {
                ErrorReportStorage.addDebugData("ConnectionRetry", ("Connection attempt " + this.var_3368));
                this.var_3368++;
                _loc1_ = this.var_3364;
                if (this.var_3365.length == 1)
                {
                    _loc1_++;
                };
                if (this.var_3368 <= _loc1_)
                {
                    this.var_3366 = 0;
                }
                else
                {
                    if (this.var_3370)
                    {
                        return;
                    };
                    this.var_3370 = true;
                    Core.error(((("Connection failed to host " + this.var_2295) + " ports ") + this.var_3365), true, Core.var_86);
                    return;
                };
            };
            this._connection.timeout = (this.var_3368 * 10000);
            this._connection.init(this.var_2295, this.var_3365[this.var_3366]);
        }

        private function onIOError(param1:IOErrorEvent):void
        {
            Logger.log(("[HabboCommunicationManager] IO Error: " + param1.text));
            switch (param1.type)
            {
                case IOErrorEvent.IO_ERROR:
                    break;
                case IOErrorEvent.DISK_ERROR:
                    break;
                case IOErrorEvent.NETWORK_ERROR:
                    break;
                case IOErrorEvent.VERIFY_ERROR:
                    break;
            };
            ErrorReportStorage.addDebugData("Communication IO Error", ((((("IOError " + param1.type) + " on connect: ") + param1.text) + ". Port was ") + this.var_3365[this.var_3366]));
            this.tryNextPort();
        }

        private function onConnect(param1:Event):void
        {
            ErrorReportStorage.addDebugData("Connection", (("Connected with " + this.var_3368) + " attempts"));
        }

        private function tryNextPort():void
        {
            this.var_3367.addEventListener(TimerEvent.TIMER, this.onTryNextPort);
            this.var_3367.start();
        }

        private function onTryNextPort(param1:TimerEvent):void
        {
            this.var_3367.stop();
            this.nextPort();
        }

        private function onSecurityError(param1:SecurityErrorEvent):void
        {
            Logger.log(("[HabboCommunicationManager] Security Error: " + param1.text));
            ErrorReportStorage.addDebugData("Communication Security Error", ((("SecurityError on connect: " + param1.text) + ". Port was ") + this.var_3365[this.var_3366]));
            this.tryNextPort();
        }

        public function getHabboMainConnection(param1:Function):IConnection
        {
            return ((this.var_2077) ? this.var_2077.queueConnection(HabboConnectionType.var_311, param1) : null);
        }

        public function addHabboConnectionMessageEvent(param1:IMessageEvent):void
        {
            if (this.var_2077)
            {
                this.var_2077.addConnectionMessageEvent(HabboConnectionType.var_311, param1);
            };
        }

        public function habboWebLogin(param1:String, param2:String):IHabboWebLogin
        {
            var _loc3_:String = "";
            _loc3_ = this.var_2868.getKey("url.prefix", _loc3_);
            _loc3_ = _loc3_.replace("http://", "");
            _loc3_ = _loc3_.replace("https://", "");
            return (new HabboWebLogin(param1, param2, _loc3_));
        }

        public function connectionInit(param1:String, param2:int):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_313, param1);
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_314, String(param2));
        }

        public function messageReceived(param1:String, param2:String):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_315, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_316, ((param1 + " ") + param2));
            if (this.var_3369.length > 0)
            {
                this.var_3369 = (this.var_3369 + (",R:" + param1));
            }
            else
            {
                this.var_3369 = ("R:" + param1);
            };
            if (this.var_3369.length > 150)
            {
                this.var_3369 = this.var_3369.substring((this.var_3369.length - 150));
            };
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this.var_3369);
        }

        public function messageSent(param1:String, param2:String):void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_317, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_318, ((param1 + " ") + param2));
            if (this.var_3369.length > 0)
            {
                this.var_3369 = (this.var_3369 + (",S:" + param1));
            }
            else
            {
                this.var_3369 = ("S:" + param1);
            };
            if (this.var_3369.length > 150)
            {
                this.var_3369 = this.var_3369.substring((this.var_3369.length - 150));
            };
            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this.var_3369);
        }

    }
}