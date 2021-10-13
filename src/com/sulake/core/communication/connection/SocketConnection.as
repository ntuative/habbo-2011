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

        public static const var_1562:int = 10000;

        private var _disposed:Boolean = false;
        private var var_2134:Socket;
        private var var_2135:ByteArray;
        private var var_2136:IEncryption;
        private var var_2137:IProtocol;
        private var _id:String;
        private var var_2138:IMessageClassManager;
        private var var_2077:ICoreCommunicationManager;
        private var var_2139:IConnectionStateListener;
        private var var_2133:Timer;
        private var var_2140:int;
        private var var_2141:Boolean = false;

        public function SocketConnection(param1:String, param2:ICoreCommunicationManager, param3:IConnectionStateListener)
        {
            this._id = param1;
            this.var_2077 = param2;
            this.var_2135 = new ByteArray();
            this.var_2138 = new MessageClassManager();
            this.var_2134 = new Socket();
            this.var_2133 = new Timer(var_1562, 1);
            this.var_2133.addEventListener(TimerEvent.TIMER, this.onTimeOutTimer);
            this.var_2134.addEventListener(Event.CONNECT, this.onConnect);
            this.var_2134.addEventListener(Event.COMPLETE, this.onComplete);
            this.var_2134.addEventListener(Event.CLOSE, this.onClose);
            this.var_2134.addEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
            this.var_2134.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this.var_2134.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.var_2139 = param3;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function set protocol(param1:IProtocol):void
        {
            this.var_2137 = param1;
        }

        public function get protocol():IProtocol
        {
            return (this.var_2137);
        }

        public function dispose():void
        {
            this._disposed = true;
            if (this.var_2134)
            {
                this.var_2134.removeEventListener(Event.CONNECT, this.onConnect);
                this.var_2134.removeEventListener(Event.COMPLETE, this.onComplete);
                this.var_2134.removeEventListener(Event.CLOSE, this.onClose);
                this.var_2134.removeEventListener(ProgressEvent.SOCKET_DATA, this.onRead);
                this.var_2134.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
                this.var_2134.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                if (this.var_2141)
                {
                    this.var_2134.close();
                };
            };
            this.var_2134 = null;
            this.var_2135 = null;
            this.var_2139 = null;
            this.var_2136 = null;
            this.var_2137 = null;
            this._id = null;
            this.var_2138 = null;
            this.var_2077 = null;
            this.var_2139 = null;
        }

        public function init(param1:String, param2:uint=0):Boolean
        {
            if (this.var_2139)
            {
                this.var_2139.connectionInit(param1, param2);
            };
            Security.loadPolicyFile(((("xmlsocket://" + param1) + ":") + param2));
            this.var_2133.start();
            this.var_2140 = getTimer();
            this.var_2134.connect(param1, param2);
            return (true);
        }

        public function set timeout(param1:int):void
        {
            this.var_2133.delay = param1;
        }

        public function addMessageEvent(param1:IMessageEvent):void
        {
            this.var_2077.addConnectionMessageEvent(this._id, param1);
        }

        public function removeMessageEvent(param1:IMessageEvent):void
        {
            this.var_2077.removeConnectionMessageEvent(this._id, param1);
        }

        public function send(param1:IMessageComposer, param2:int=-1):Boolean
        {
            if (this.disposed)
            {
                return (false);
            };
            var _loc3_:ByteArray = new ByteArray();
            var _loc4_:int = this.var_2138.getMessageComposerID(param1);
            if (_loc4_ < 0)
            {
                this.logConnection(("Could not find registered message composer for " + param1));
                return (false);
            };
            var _loc5_:ByteArray = this.var_2137.encoder.encode(_loc4_, param1.getMessageArray(), param2);
            if (this.var_2139)
            {
                this.var_2139.messageSent(String(_loc4_), _loc5_.toString());
            };
            if (this.var_2136 != null)
            {
                _loc3_ = this.var_2136.encipher(_loc5_);
            }
            else
            {
                _loc3_ = _loc5_;
            };
            this.logConnection(("<<[SOCKET OUT]: " + [_loc4_, param1.getMessageArray(), "->", _loc3_]));
            if (this.var_2134.connected)
            {
                this.var_2134.writeBytes(_loc3_);
                this.var_2134.flush();
            }
            else
            {
                this.logConnection("[SOCKET] Not connected.");
                return (false);
            };
            return (true);
        }

        public function setEncryption(param1:IEncryption):void
        {
            this.var_2136 = param1;
        }

        public function registerMessageClasses(param1:IMessageConfiguration):void
        {
            this.var_2138.registerMessages(param1);
        }

        override public function toString():String
        {
            var _loc1_:String = "";
            _loc1_ = (_loc1_ + "Socket Connection: \n");
            _loc1_ = (_loc1_ + (("Protocol Encoder: " + this.var_2137.encoder) + "\n"));
            _loc1_ = (_loc1_ + (("Protocol Decoder: " + this.var_2137.decoder) + "\n"));
            return (_loc1_ + (("Encryption: " + this.var_2136) + "\n"));
        }

        public function processReceivedData():void
        {
            var id:int;
            var parserTypeData:XML;
            var parserClassName:String;
            var parseDebugData:String;
            var accessorData:XML;
            var accessor:String;
            var message:Array;
            var data:ByteArray;
            var eventClasses:Array;
            var events:Array;
            var eventClass:Class;
            var eventsForClass:Array;
            var parserInstance:IMessageParser;
            var parserClassCurrent:Class;
            var dataClone:ByteArray;
            var messageEventInstance:IMessageEvent;
            var parserClass:Class;
            var dataWrapper:IMessageDataWrapper;
            var wasParsed:Boolean;
            var temp:ByteArray;
            if (this.disposed)
            {
                return;
            };
            var receivedMessages:Array = new Array();
            var offset:uint = this.var_2137.getMessages(this.var_2135, receivedMessages);
            try
            {
                for each (message in receivedMessages)
                {
                    id = (message[0] as int);
                    data = (message[1] as ByteArray);
                    if (this.var_2139)
                    {
                        this.var_2139.messageReceived(String(id), data.toString());
                    };
                    eventClasses = this.var_2138.getMessageEventClasses(id);
                    events = new Array();
                    for each (eventClass in eventClasses)
                    {
                        eventsForClass = this.var_2077.getMessageEvents(this, eventClass);
                        events = events.concat(eventsForClass);
                    };
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
                                parserInstance = this.var_2077.getMessageParser(parserClass);
                                if (!parserInstance.flush())
                                {
                                    this.logConnection((">>[SocketConnection] Message Event Parser wasn't flushed: " + [id, parserClass, parserInstance]));
                                }
                                else
                                {
                                    if (parserInstance.parse(dataWrapper))
                                    {
                                        parserClassCurrent = parserClass;
                                        wasParsed = true;
                                    };
                                };
                            }
                            else
                            {
                                wasParsed = true;
                            };
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
                            };
                        };
                    };
                };
                if (offset == this.var_2135.length)
                {
                    this.var_2135 = new ByteArray();
                }
                else
                {
                    if (offset > 0)
                    {
                        temp = new ByteArray();
                        temp.writeBytes(this.var_2135, offset);
                        this.var_2135 = temp;
                        this.logConnection(((("[SOCKET REST] offset: " + offset) + " rest: ") + this.var_2135.toString()));
                    };
                };
            }
            catch(e:Error)
            {
                if (!disposed)
                {
                    ErrorReportStorage.addDebugData("SocketConnection", (('Crashed while processing incoming message with id="' + id) + '"!'));
                    throw (e);
                };
            };
        }

        public function get connected():Boolean
        {
            return (this.var_2134.connected);
        }

        private function onRead(param1:ProgressEvent):void
        {
            if (!this.var_2134)
            {
                return;
            };
            while (this.var_2134.bytesAvailable > 0)
            {
                this.var_2135.writeByte(this.var_2134.readUnsignedByte());
            };
        }

        private function onConnect(param1:Event):void
        {
            this.logConnection("[SocketConnection] Connected");
            this.var_2133.stop();
            this.var_2141 = true;
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Connected in " + (getTimer() - this.var_2140)));
            dispatchEvent(param1);
        }

        private function onClose(param1:Event):void
        {
            this.var_2133.stop();
            this.logConnection("[SocketConnection] Closed");
            this.var_2141 = false;
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Closed in " + (getTimer() - this.var_2140)));
            dispatchEvent(param1);
        }

        private function onComplete(param1:Event):void
        {
            this.var_2133.stop();
            this.logConnection("[SocketConnection] Complete");
            ErrorReportStorage.addDebugData("ConnectionTimer", ("Completed in " + (getTimer() - this.var_2140)));
            dispatchEvent(param1);
        }

        private function onSecurityError(param1:SecurityErrorEvent):void
        {
            this.var_2133.stop();
            this.logConnection(("[SocketConnection] Security Error: " + param1.text));
            ErrorReportStorage.addDebugData("ConnectionTimer", ("SecurityError in " + (getTimer() - this.var_2140)));
            dispatchEvent(param1);
        }

        private function onIOError(param1:IOErrorEvent):void
        {
            this.var_2133.stop();
            this.logConnection(("[SocketConnection] IO Error: " + param1.text));
            ErrorReportStorage.addDebugData("ConnectionTimer", ("IOError in " + (getTimer() - this.var_2140)));
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
            dispatchEvent(param1);
        }

        private function onTimeOutTimer(param1:TimerEvent):void
        {
            this.var_2133.stop();
            this.logConnection("[SocketConnection] TimeOut Error");
            ErrorReportStorage.addDebugData("ConnectionTimer", ("TimeOut in " + (getTimer() - this.var_2140)));
            var _loc2_:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            _loc2_.text = (("Socket Timeout (" + this.var_2133.delay) + " ms). Possible Firewall.");
            dispatchEvent(_loc2_);
        }

        private function logConnection(param1:String):void
        {
        }

    }
}