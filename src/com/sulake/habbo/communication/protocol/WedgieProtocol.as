package com.sulake.habbo.communication.protocol
{

    import com.sulake.core.communication.protocol.IProtocol;
    import com.sulake.core.communication.protocol.IProtocolEncoder;
    import com.sulake.core.communication.protocol.IProtocolDecoder;

    import flash.utils.ByteArray;

    public class WedgieProtocol implements IProtocol
    {

        public static const WEDGIE_MESSAGE_TERMINATOR: uint = 1;
        public static const WEDGIE_STRING_TERMINATOR: uint = 2;

        private var _encoder: IProtocolEncoder;
        private var _decoder: IProtocolDecoder;

        public function WedgieProtocol()
        {
            this._encoder = new WedgieEncoder();
            this._decoder = new WedgieDecoder();
        }

        public function dispose(): void
        {
            this._encoder.dispose();
            this._decoder.dispose();
            this._encoder = null;
            this._decoder = null;
        }

        public function get encoder(): IProtocolEncoder
        {
            return this._encoder;
        }

        public function get decoder(): IProtocolDecoder
        {
            return this._decoder;
        }

        public function getMessages(data: ByteArray, messages: Array): uint
        {
            data.position = 0;
            var buffer: ByteArray = new ByteArray();
            var terminator: uint;
            var messageId: int;
            var position: uint = data.position;

            while (data.bytesAvailable)
            {
                terminator = data.readUnsignedByte();

                if (terminator == WEDGIE_MESSAGE_TERMINATOR)
                {
                    buffer.position = 0;

                    messageId = this._decoder.getID(buffer);
                    messages.push([messageId, buffer]);
                    
                    buffer = new ByteArray();
                    
                    position = data.position;
                }
                else
                {
                    buffer.writeByte(terminator);
                }

            }

            return position;
        }

    }
}
