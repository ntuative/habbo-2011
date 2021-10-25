package com.sulake.core.communication
{

    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;

    import flash.utils.Dictionary;

    import com.sulake.core.communication.connection.IConnectionStateListener;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.connection.SocketConnection;
    import com.sulake.core.communication.enum.ConnectionType;
    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.iid.*;

    public class CoreCommunicationManager extends Component implements ICoreCommunicationManager, IUpdateReceiver
    {

        private var _connections: Dictionary;
        private var _protocols: Dictionary;
        private var _events: Dictionary;
        private var _parsers: Array;
        private var _connectionStateListener: IConnectionStateListener;

        public function CoreCommunicationManager(context: IContext, flags: uint = 0)
        {
            super(context, flags);

            this._connections = new Dictionary();
            this._protocols = new Dictionary();
            this._events = new Dictionary();
            this._parsers = [];

            registerUpdateReceiver(this, 1);
        }

        public function set connectionStateListener(listener: IConnectionStateListener): void
        {
            this._connectionStateListener = listener;
        }

        override public function dispose(): void
        {
            var collection: Array;
            var parser: IMessageParser;
            var event: IMessageEvent;
            removeUpdateReceiver(this);

            for each (var connection: IConnection in this._connections)
            {
                connection.dispose();
            }


            this._connections = null;
            this._protocols = null;
            this._connectionStateListener = null;

            for each (collection in this._events)
            {
                while (true)
                {
                    event = collection.pop() as IMessageEvent;

                    if (!event)
                    {
                        break;
                    }

                    event.dispose();
                }

            }


            this._events = null;

            for each (parser in this._parsers)
            {
                // no-op
            }


            this._protocols = null;

            super.dispose();
        }

        public function createConnection(id: String, type: uint = 0): IConnection
        {
            var connection: IConnection;

            switch (type)
            {
                case ConnectionType.TCP_CONNECTION:
                    connection = new SocketConnection(id, this, this._connectionStateListener);
                    break;
                default:
                    Logger.log("[CoreCommunicationManager] Unknown connectionType, can not create connection: " + type);
            }


            this._connections[id] = connection;

            return connection;
        }

        public function queueConnection(id: String, callback: Function): IConnection
        {
            if (id == null || this._connections == null)
            {
                return null;
            }


            return this._connections[id] as IConnection;
        }

        public function registerProtocolType(type: String, proto: Class): Boolean
        {
            var protocol: Object = new proto();

            if (protocol is IProtocol)
            {
                this._protocols[type] = proto;

                return true;
            }


            throw new Error("[CoreCommunicationManager] Invalid Protocol class defined for protocol type " + type + "!");
        }

        public function getProtocolInstanceOfType(type: String): IProtocol
        {
            var proto: Class = this._protocols[type];

            if (proto == null)
            {
                throw new Error("[CoreCommunicationManager] Could not instantiate Protocol class defined for protocol type " + type + "!");
            }

            return new proto() as IProtocol;
        }

        public function addConnectionMessageEvent(id: String, event: IMessageEvent): void
        {
            var collection: Array = this._events[id];

            if (collection == null)
            {
                collection = [];

                this._events[id] = collection;
            }


            collection.push(event);
        }

        public function removeConnectionMessageEvent(id: String, event: IMessageEvent): void
        {
            var eventCollection: Array = this._events[id];

            if (eventCollection != null)
            {
                var index: int = eventCollection.indexOf(event);

                if (index >= 0)
                {
                    eventCollection.splice(index, 1);
                }

            }

        }

        public function getMessageEvents(connection: IConnection, messageEventClass: Class): Array
        {
            var id: String;
            var event: IMessageEvent;
            var connectionId: String = "";

            var item: * = null;

            for (item in this._connections)
            {
                id = item;

                if (this._connections[id] == connection)
                {
                    connectionId = id;

                    break;
                }

            }


            if (connectionId == "")
            {
                throw new Error("[CoreCommunicationManager] Could not find registered events for connection " + connection + "!");
            }


            var collection: Array = this._events[connectionId];

            var events: Array = [];

            for each (item in collection)
            {
                event = item;

                if (event is messageEventClass)
                {
                    events.push(event);
                }

            }


            return events;
        }

        public function getMessageParser(messageParserClass: Class): IMessageParser
        {
            var messageParser: IMessageParser;

            for each (var parser: IMessageParser in this._parsers)
            {
                if (parser is messageParserClass)
                {
                    messageParser = parser;
                    break;
                }

            }


            if (messageParser == null)
            {
                messageParser = new messageParserClass() as IMessageParser;

                if (messageParser == null)
                {
                    throw new Error("[CoreCommunicationManager] Could not create parser-instance from class: " + messageParserClass + "!");
                }


                this._parsers.push(messageParser);
            }


            return messageParser;
        }

        public function update(_: uint): void
        {
            for each (var connection: IConnection in this._connections)
            {
                connection.processReceivedData();
            }

        }

    }
}
