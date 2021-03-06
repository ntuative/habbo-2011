package com.hurlant.util.der
{

    import com.hurlant.math.BigInteger;

    import flash.utils.ByteArray;

    public class Integer extends BigInteger implements IAsn1Type
    {
        private var type: uint;
        private var len: uint;

        public function Integer(type: uint, length: uint, b: ByteArray)
        {
            this.type = type;
            this.len = length;
            super(b);
        }

        public function getLength(): uint
        {
            return len;
        }

        public function getType(): uint
        {
            return type;
        }

        override public function toString(radix: Number = 0): String
        {
            return DER.indent + "Integer[" + type + "][" + len + "][" + super.toString(16) + "]";
        }

    }
}
