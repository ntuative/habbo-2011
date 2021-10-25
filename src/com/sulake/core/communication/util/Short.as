package com.sulake.core.communication.util
{

    import flash.utils.ByteArray;

    public class Short
    {

        private var _buffer: ByteArray;

        public function Short(value: int)
        {
            this._buffer = new ByteArray();
            this._buffer.writeShort(value);
            this._buffer.position = 0;
        }

        public function get value(): int
        {
            var val: int;

            this._buffer.position = 0;

            if (this._buffer.bytesAvailable)
            {
                val = this._buffer.readShort();
                this._buffer.position = 0;
            }


            return val;
        }

    }
}
