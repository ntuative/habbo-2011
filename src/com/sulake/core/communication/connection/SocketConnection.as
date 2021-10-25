package com.sulake.core.communication.connection
{

    import flash.events.EventDispatcher;

    import com.sulake.core.runtime.IDisposable;

    import flash.net.Socket;
    import flash.utils.ByteArray;

    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.messages.IMessageClassManager;
    import com.sulake.core.communication.ICoreCommunicationManager;

    import flash.utils.Timer;

    import com.sulake.core.communication.messages.MessageClassManager;

    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.system.Security;
    import flash.utils.getTimer;

    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.MessageDataWrapper;
    import com.sulake.core.utils.ErrorReportStorage;

    import flash.events.*;

    public class SocketConnection extends EventDispatcher implements IConnection, IDisposable
    {

        public static const CONNECTION_TIMEOUT_MS: int = 10000;

        private var _disposed: Boolean = false;
        private var _socket: Socket;
        private var _buffer: ByteArray;
        private var _encryption: IEncryption;
        private var _protocol: IProtocol;
        private var _id: String;
        private var _messageClassManager: IMessageClassManager;
        private var _coreCommunicationManager: ICoreCommunicationManager;
        private var _connectionStateListener: IConnectionStateListener;
        private var _timeoutTimer: Timer;
        private var _connectedAt: int;
        private var _connected: Boolean = false;

        public function SocketConnection(id: String, coreCommunicationManager: ICoreCommunicationManager, connectionStateListener: IConnectionStateListener)
        {
            this._id = id;
            this._coreCommunicationManager = coreCommunicationManager;
            this._buffer = new ByteArray();
            this._messageClassManager = new MessageClassManager();
            this._socket = new Socket();
            this._timeoutTimer = new Timer(CONNECTION_TIMEOUT_MS, 1);
            this._timeoutTimer.addEventListener(TimerEvent.TIMER, this.onTimeOutTimer);
            this._socket.addEventListener(Event.CONNECT, this.onConnect);
            this._socket.addEventListener(Event.COMPLETE, this.onComplete);
            this._socket.addEventListener(Event.CLOSE, this.onClose);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._connectionStateListener = connectionStateListener;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function set protocol(protocol: IProtocol): void
        {
            this._protocol = protocol;
        }

        public function get protocol(): IProtocol
        {
            return this._protocol;
        }

        public function dispose(): void
        {
            this._disposed = true;

            if (this._socket != null)
            {
                this._socket.removeEventListener(Event.CONNECT, this.onConnect);
                this._socket.removeEventListener(Event.COMPLETE, this.onComplete);
                this._socket.removeEventListener(Event.CLOSE, this.onClose);
                this._socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
                this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
                this._socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);

                if (this._connected)
                {
                    this._socket.close();
                }

            }


            this._socket = null;
            this._buffer = null;
            this._connectionStateListener = null;
            this._encryption = null;
            this._protocol = null;
            this._id = null;
            this._messageClassManager = null;
            this._coreCommunicationManager = null;
            this._connectionStateListener = null;
        }

        public function init(host: String, port: uint = 0): Boolean
        {
            if (this._connectionStateListener != null)
            {
                this._connectionStateListener.connectionInit(host, port);
            }


            Security.loadPolicyFile("xmlsocket://" + host + ":" + port);

            this._timeoutTimer.start();
            this._connectedAt = getTimer();
            this._socket.connect(host, port);

            return true;
        }

        public function set timeout(delay: int): void
        {
            this._timeoutTimer.delay = delay;
        }

        public function addMessageEvent(messageEvent: IMessageEvent): void
        {
            this._coreCommunicationManager.addConnectionMessageEvent(this._id, messageEvent);
        }

        public function removeMessageEvent(messageEvent: IMessageEvent): void
        {
            this._coreCommunicationManager.removeConnectionMessageEvent(this._id, messageEvent);
        }

        public function send(composer: IMessageComposer, param2: int = -1): Boolean
        {
            if (this.disposed)
            {
                return false;
            }


            var buffer: ByteArray = new ByteArray();
            var messageId: int = this._messageClassManager.getMessageComposerID(composer);

            if (messageId < 0)
            {
                this.logConnection("Could not find registered message composer for " + composer);
                return false;
            }


            var messageData: ByteArray = this._protocol.encoder.encode(messageId, composer.getMessageArray(), param2);

            if (this._connectionStateListener != null)
            {
                this._connectionStateListener.messageSent(String(messageId), messageData.toString());
            }


            if (this._encryption != null)
            {
                buffer = this._encryption.encipher(messageData);
            }
            else
            {
                buffer = messageData;
            }


            this.logConnection("<<[SOCKET OUT]: " + [messageId, composer.getMessageArray(), "->", buffer]);

            if (this._socket.connected)
            {
                this._socket.writeBytes(buffer);
                this._socket.flush();
            }
            else
            {
                this.logConnection("[SOCKET] Not connected.");
                return false;
            }


            return true;
        }

        public function setEncryption(encryption: IEncryption): void
        {
            this._encryption = encryption;
        }

        public function registerMessageClasses(messageConfiguration: IMessageConfiguration): void
        {
            this._messageClassManager.registerMessages(messageConfiguration);
        }

        override public function toString(): String
        {
            var str: String = "";

            str = str + "Socket Connection: \n";
            str = str + "Protocol Encoder: " + this._protocol.encoder + "\n";
            str = str + "Protocol Decoder: " + this._protocol.decoder + "\n";
            str = str + "Encryption: " + this._encryption + "\n";

            return str;
        }

        public function processReceivedData(): void
        {
            var id: int;
            var parserTypeData: XML;
            var parserClassName: String;
            var parseDebugData: String;
            var accessorData: XML;
            var accessor: String;
            var message: Array;
            var data: ByteArray;
            var eventClasses: Array;
            var events: Array;
            var eventClass: Class;
            var eventsForClass: Array;
            var parserInstance: IMessageParser;
            var parserClassCurrent: Class;
            var dataClone: ByteArray;
            var messageEventInstance: IMessageEvent;
            var parserClass: Class;
            var dataWrapper: IMessageDataWrapper;
            var wasParsed: Boolean;
            var temp: ByteArray;

            if (this.disposed)
            {
                return;
            }


            var receivedMessages: Array = [];
            var offset: uint = this._protocol.getMessages(this._buffer, receivedMessages);

            try
            {
                for each (message in receivedMessages)
                {
                    id = message[0] as int;
                    data = message[1] as ByteArray;

                    if (this._connectionStateListener)
                    {
                        this._connectionStateListener.messageReceived(String(id), data.toString());
                    }


                    eventClasses = this._messageClassManager.getMessageEventClasses(id);

                    events = [];

                    for each (eventClass in eventClasses)
                    {
                        eventsForClass = this._coreCommunicationManager.getMessageEvents(this, eventClass);
                        events = events.concat(eventsForClass);
                    }


                    parserInstance = null;
                    parserClassCurrent = null;

                    for each (messageEventInstance in events)
                    {
                        parserClass = messageEventInstance.parserClass;

                        if (parserClass != null)
                        {
                            wasParsed = false;

                            if (parserClass != parserClassCurrent)
                            {
                                dataClone = new ByteArray();
                                dataClone.writeBytes(data);
                                dataClone.position = data.position;
                                dataWrapper = new MessageDataWrapper(dataClone, this.protocol.decoder);
                                parserInstance = this._coreCommunicationManager.getMessageParser(parserClass);

                                if (!parserInstance.flush())
                                {
                                    this.logConnection(">>[SocketConnection] Message Event Parser wasn't flushed: " + [
                                        id,
                                        parserClass,
                                        parserInstance
                                    ]);
                                }
                                else
                                {
                                    if (parserInstance.parse(dataWrapper))
                                    {
                                        parserClassCurrent = parserClass;
                                        wasParsed = true;
                                    }

                                }

                            }
                            else
                            {
                                wasParsed = true;
                            }


                            if (wasParsed)
                            {
                                messageEventInstance.connection = this;
                                messageEventInstance.parser = parserInstance;
                                messageEventInstance.callback.call(null, messageEventInstance);
                            }
                            else
                            {
                                parserClassCurrent = null;
                                parserInstance = null;
                            }

                        }

                    }

                }


                if (offset == this._buffer.length)
                {
                    this._buffer = new ByteArray();
                }
                else
                {
                    if (offset > 0)
                    {
                        temp = new ByteArray();
                        temp.writeBytes(this._buffer, offset);
                        this._buffer = temp;
                        this.logConnection("[SOCKET REST] offset: " + offset + " rest: " + this._buffer.toString());
                    }

                }

            }
            catch (e: Error)
            {
                if (!disposed)
                {
                    ErrorReportStorage.addDebugData("SocketConnection", "Crashed while processing incoming message with id=\"" + id + "\"!");
                    throw e;
                }

            }

        }

        public function get connected(): Boolean
        {
            return this._socket.connected;
        }

        private function onRead(event: ProgressEvent): void
        {
            if (this._socket == null)
            {
                return;
            }


            while (this._socket.bytesAvailable > 0)
            {
                this._buffer.writeByte(this._socket.readUnsignedByte());
            }

        }

        private function onConnect(event: Event): void
        {
            this.logConnection("[SocketConnection] Connected");
            this._timeoutTimer.stop();
            this._connected = true;

            ErrorReportStorage.addDebugData("ConnectionTimer", "Connected in " + (getTimer() - this._connectedAt));

            dispatchEvent(event);
        }

        private function onClose(event: Event): void
        {
            this.logConnection("[SocketConnection] Closed");
            this._timeoutTimer.stop();
            this._connected = false;

            ErrorReportStorage.addDebugData("ConnectionTimer", "Closed in " + (getTimer() - this._connectedAt));

            dispatchEvent(event);
        }

        private function onComplete(event: Event): void
        {
            this.logConnection("[SocketConnection] Complete");
            this._timeoutTimer.stop();

            ErrorReportStorage.addDebugData("ConnectionTimer", "Completed in " + (getTimer() - this._connectedAt));

            dispatchEvent(event);
        }

        private function onSecurityError(securityErrorEvent: SecurityErrorEvent): void
        {
            this.logConnection("[SocketConnection] Security Error: " + securityErrorEvent.text);
            this._timeoutTimer.stop();

            ErrorReportStorage.addDebugData("ConnectionTimer", "SecurityError in " + (getTimer() - this._connectedAt));

            dispatchEvent(securityErrorEvent);
        }

        private function onIOError(ioErrorEvent: IOErrorEvent): void
        {
            this.logConnection("[SocketConnection] IO Error: " + ioErrorEvent.text);
            this._timeoutTimer.stop();

            ErrorReportStorage.addDebugData("ConnectionTimer", "IOError in " + (getTimer() - this._connectedAt));

            // Currently a no-op, potentially specific handling planned for the future
            switch (ioErrorEvent.type)
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


            dispatchEvent(ioErrorEvent);
        }

        private function onTimeOutTimer(timerEvent: TimerEvent): void
        {
            this.logConnection("[SocketConnection] TimeOut Error");
            this._timeoutTimer.stop();

            ErrorReportStorage.addDebugData("ConnectionTimer", "TimeOut in " + (getTimer() - this._connectedAt));

            var ioErrorEvent: IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            ioErrorEvent.text = "Socket Timeout (" + this._timeoutTimer.delay + " ms). Possible Firewall.";

            dispatchEvent(ioErrorEvent);
        }

        private function logConnection(param1: String): void
        {
        }

    }
}
