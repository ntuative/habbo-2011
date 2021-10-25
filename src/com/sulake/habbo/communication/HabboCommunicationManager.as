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

        private const MAX_RETRY_ATTEMPTS: int = 2;

        private var _coreCommunicationManager: ICoreCommunicationManager;
        private var _habboConfigurationManager: IHabboConfigurationManager;
        private var _connection: IConnection;
        private var _mode: int = 0;
        private var _habboMessages: IMessageConfiguration = new HabboMessages();
        private var _host: String = "";
        private var _ports: Array = []; // @type: Array<String>
        private var _portIndex: int = -1;
        private var _nextPortTimer: Timer = new Timer(100, 1);
        private var _connectionAttempt: int = 1;
        private var _messageQueueLog: String = "";
        private var _connectionFailed: Boolean = false;
        private var var_3371: Boolean = false;
        private var var_3372: Boolean = false;

        public function HabboCommunicationManager(ctx: IContext, flags: uint = 0, assets: IAssetLibrary = null)
        {
            super(ctx, flags, assets);

            this.queueInterface(new IIDCoreCommunicationManager(), this.onCoreCommunicationManagerInit);
            this.queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);

            ctx.events.addEventListener(Event.UNLOAD, this.unloading);
        }

        public function get mode(): int
        {
            return this._mode;
        }

        public function set mode(mode: int): void
        {
            this._mode = mode;
        }

        public function get port(): int
        {
            if (this._ports.length == 0 || this._portIndex < 0 || this._portIndex >= this._ports.length)
            {
                return 0;
            }


            return this._ports[this._portIndex];
        }

        private function unloading(param1: Event): void
        {
            if (this._connection)
            {
                this._connection.send(new DisconnectMessageComposer());
                this._connection.dispose();
                this._connection = null;
            }

        }

        override public function dispose(): void
        {
            if (this._connection)
            {
                this._connection.dispose();
                this._connection = null;
            }

            if (this._coreCommunicationManager)
            {
                this._coreCommunicationManager.release(new IIDCoreCommunicationManager());
                this._coreCommunicationManager = null;
            }

            if (this._habboConfigurationManager)
            {
                this._habboConfigurationManager.release(new IIDHabboConfigurationManager());
                this._habboConfigurationManager = null;
            }

            super.dispose();
        }

        private function onCoreCommunicationManagerInit(iid: IID = null, coreCommunicationManager: IUnknown = null): void
        {
            Logger.log("Habbo Communication Manager: Core Communication Manager found:: " + [
                iid,
                coreCommunicationManager
            ]);

            if (coreCommunicationManager != null)
            {
                this._coreCommunicationManager = (coreCommunicationManager as ICoreCommunicationManager);

                this._coreCommunicationManager.connectionStateListener = this;
                this._coreCommunicationManager.registerProtocolType(HabboProtocolType.PROTOCOL_TYPE_WEDGIE, WedgieProtocol);

                this._connection = this._coreCommunicationManager.createConnection(HabboConnectionType.CONNECTION_TYPE_HABBO, ConnectionType.TCP_CONNECTION);

                this._connection.registerMessageClasses(this._habboMessages);
                this._connection.protocol = this._coreCommunicationManager.getProtocolInstanceOfType(HabboProtocolType.PROTOCOL_TYPE_WEDGIE);
                this._connection.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
                this._connection.addEventListener(Event.CONNECT, this.onConnect);
            }

        }

        private function onHabboConfigurationInit(iid: IID = null, habboConfigurationManager: IUnknown = null): void
        {
            if (habboConfigurationManager != null)
            {
                Logger.log("Habbo Communication Manager: init based on configuration: " + this._habboConfigurationManager);

                ErrorReportStorage.addDebugData("CommunicationConfigInit", "Config Received");

                this._habboConfigurationManager = (habboConfigurationManager as IHabboConfigurationManager);

                ErrorReportStorage.addDebugData("CommunicationConfigInit", "Config Ready");

                this._ports = [];
                this._host = this._habboConfigurationManager.getKey("connection.info.host", null);

                if (this._host == null)
                {
                    Core.crash("connection.info.host was not defined", Core.ERROR_CATEGORY_CONNECTION_INIT);
                    return;
                }


                var port: String = this._habboConfigurationManager.getKey("connection.info.port", null);

                if (port == null)
                {
                    Core.crash("connection.info.port was not defined", Core.ERROR_CATEGORY_CONNECTION_INIT);
                    return;
                }


                if (this._habboConfigurationManager.keyExists("local.environment") && this._habboConfigurationManager.getKey("local.environment") == "true")
                {
                    this._host = this._habboConfigurationManager.getKey("connection.info.host.local");
                    port = this._habboConfigurationManager.getKey("connection.info.port.local");
                }


                if (!this.validateHost())
                {
                    Core.crash("Tried to connect to an invalid host: " + this._host, Core.ERROR_CATEGORY_CONNECTION_INIT);
                    return;
                }


                // @type Array<String>
                var ports: Array = port.split(",");

                for each (var p: String in ports)
                {
                    this._ports.push(parseInt(p.replace(" ", "")));
                }


                ErrorReportStorage.addDebugData("CommunicationConfigInit", "Config Host: " + this._host);

                Logger.log("Connection Host: " + this._host);

                Logger.log("Connection Ports: " + this._ports);

                Logger.log("Habbo Connection Info:" + this._connection);

                this.var_3371 = true;

                if (this.var_3372)
                {
                    this.nextPort();
                }

            }
            else
            {
                ErrorReportStorage.addDebugData("CommunicationConfigInit", "Config NOT received");
            }

        }

        private function validateHost(): Boolean
        {
            // @type: Array<String>
            var hostParts: Array = this._host.split(".");

            if (hostParts.length >= 2)
            {
                var tail: int = hostParts.length - 1;

                if (hostParts[tail] == "com" && (hostParts[tail - 1] == "habbo" || hostParts[tail - 1] == "sulake"))
                {
                    return true;
                }


                if (hostParts[tail] == "net" && hostParts[tail - 1] == "varoke")
                {
                    return true;
                }

            }


            return true;
        }

        public function initConnection(param1: String): void
        {
            switch (param1)
            {
                case HabboConnectionType.CONNECTION_TYPE_HABBO:
                    if (this._habboConfigurationManager == null)
                    {
                        Core.crash("Tried to connect to proxy but configuration was null", Core.ERROR_CATEGORY_CONNECTION_INIT);
                        return;
                    }


                    if (this._connection == null)
                    {
                        Core.crash("Tried to connect to proxy but connection was null", Core.ERROR_CATEGORY_CONNECTION_INIT);
                        return;
                    }


                    this.var_3372 = true;

                    if (this.var_3371)
                    {
                        this.nextPort();
                    }

                    return;
                default:
                    Logger.log("Unknown Habbo Connection Type: " + param1);
            }

        }

        private function nextPort(): void
        {
            var retryAttempts: int;

            if (this._connection.connected)
            {
                Logger.log("Warning: Already connected so will not try to connect again!");
                return;
            }


            this._portIndex++;

            if (this._portIndex >= this._ports.length)
            {
                ErrorReportStorage.addDebugData("ConnectionRetry", "Connection attempt " + this._connectionAttempt);

                this._connectionAttempt++;

                retryAttempts = this.MAX_RETRY_ATTEMPTS;

                if (this._ports.length == 1)
                {
                    retryAttempts++;
                }


                if (this._connectionAttempt <= retryAttempts)
                {
                    this._portIndex = 0;
                }
                else
                {
                    if (this._connectionFailed)
                    {
                        return;
                    }


                    this._connectionFailed = true;

                    Core.error("Connection failed to host " + this._host + " ports " + this._ports, true, Core.ERROR_CATEGORY_CONNECTION_INIT);

                    return;
                }

            }


            this._connection.timeout = this._connectionAttempt * 10000;

            this._connection.init(this._host, this._ports[this._portIndex]);
        }

        private function onIOError(param1: IOErrorEvent): void
        {
            Logger.log("[HabboCommunicationManager] IO Error: " + param1.text);

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
            }


            ErrorReportStorage.addDebugData("Communication IO Error", "IOError " + param1.type + " on connect: " + param1.text + ". Port was " + this._ports[this._portIndex]);

            this.tryNextPort();
        }

        private function onConnect(param1: Event): void
        {
            ErrorReportStorage.addDebugData("Connection", "Connected with " + this._connectionAttempt + " attempts");
        }

        private function tryNextPort(): void
        {
            this._nextPortTimer.addEventListener(TimerEvent.TIMER, this.onTryNextPort);
            this._nextPortTimer.start();
        }

        private function onTryNextPort(param1: TimerEvent): void
        {
            this._nextPortTimer.stop();
            this.nextPort();
        }

        private function onSecurityError(param1: SecurityErrorEvent): void
        {
            Logger.log("[HabboCommunicationManager] Security Error: " + param1.text);
            ErrorReportStorage.addDebugData("Communication Security Error", "SecurityError on connect: " + param1.text + ". Port was " + this._ports[this._portIndex]);

            this.tryNextPort();
        }

        public function getHabboMainConnection(callback: Function): IConnection
        {
            if (this._coreCommunicationManager != null)
            {
                return this._coreCommunicationManager.queueConnection(HabboConnectionType.CONNECTION_TYPE_HABBO, callback);
            }

            return null;
        }

        public function addHabboConnectionMessageEvent(messageEvent: IMessageEvent): void
        {
            if (this._coreCommunicationManager != null)
            {
                this._coreCommunicationManager.addConnectionMessageEvent(HabboConnectionType.CONNECTION_TYPE_HABBO, messageEvent);
            }

        }

        public function habboWebLogin(param1: String, param2: String): IHabboWebLogin
        {
            var domain: String = this._habboConfigurationManager.getKey("url.prefix", "")
                    .replace("http://", "")
                    .replace("https://", "");

            return new HabboWebLogin(param1, param2, domain);
        }

        public function connectionInit(param1: String, param2: int): void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_313, param1);
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_314, String(param2));
        }

        public function messageReceived(param1: String, param2: String): void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_315, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_316, param1 + " " + param2);

            if (this._messageQueueLog.length > 0)
            {
                this._messageQueueLog = this._messageQueueLog + (",R:" + param1);
            }
            else
            {
                this._messageQueueLog = "R:" + param1;
            }


            if (this._messageQueueLog.length > 150)
            {
                this._messageQueueLog = this._messageQueueLog.substring(this._messageQueueLog.length - 150);
            }


            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this._messageQueueLog);
        }

        public function messageSent(param1: String, param2: String): void
        {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_317, String(new Date().getTime()));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.var_318, param1 + " " + param2);

            if (this._messageQueueLog.length > 0)
            {
                this._messageQueueLog = this._messageQueueLog + (",S:" + param1);
            }
            else
            {
                this._messageQueueLog = "S:" + param1;
            }


            if (this._messageQueueLog.length > 150)
            {
                this._messageQueueLog = this._messageQueueLog.substring(this._messageQueueLog.length - 150);
            }


            ErrorReportStorage.addDebugData("MESSAGE_QUEUE", this._messageQueueLog);
        }
    }
}
