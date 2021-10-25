package com.sulake.core.communication.messages
{

    import flash.utils.ByteArray;

    import com.sulake.core.communication.protocol.IProtocolDecoder;
    import com.sulake.core.communication.util.Short;

    public class MessageDataWrapper implements IMessageDataWrapper
    {

        private var _data: ByteArray;
        private var _protocolDeccoder: IProtocolDecoder;

        public function MessageDataWrapper(data: ByteArray, protocolDecoder: IProtocolDecoder)
        {
            this._data = data;
            this._protocolDeccoder = protocolDecoder;
        }

        public function readString(): String
        {
            return this._protocolDeccoder.readString(this._data);
        }

        public function readInteger(): int
        {
            return this._protocolDeccoder.readInteger(this._data);
        }

        public function readBoolean(): Boolean
        {
            return this._protocolDeccoder.readBoolean(this._data);
        }

        public function readShort(): Short
        {
            return this._protocolDeccoder.readShort(this._data);
        }

        public function get bytesAvailable(): uint
        {
            return this._data.bytesAvailable;
        }

    }
}
