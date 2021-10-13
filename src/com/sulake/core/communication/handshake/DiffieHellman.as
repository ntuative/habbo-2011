package com.sulake.core.communication.handshake
{
    import com.hurlant.math.BigInteger;
    import com.sulake.core.utils.ErrorReportStorage;

    public class DiffieHellman implements IKeyExchange 
    {

        private var var_2143:BigInteger;
        private var var_2144:BigInteger;
        private var var_2145:BigInteger;
        private var var_2146:BigInteger;
        private var var_2147:BigInteger;
        private var var_2148:BigInteger;

        public function DiffieHellman(param1:BigInteger, param2:BigInteger)
        {
            this.var_2147 = param1;
            this.var_2148 = param2;
        }

        public function init(param1:String, param2:uint=16):Boolean
        {
            ErrorReportStorage.addDebugData("DiffieHellman", ((((("Prime: " + this.var_2147.toString()) + ",generator: ") + this.var_2148.toString()) + ",secret: ") + param1));
            this.var_2143 = new BigInteger();
            this.var_2143.fromRadix(param1, param2);
            this.var_2144 = this.var_2148.modPow(this.var_2143, this.var_2147);
            return (true);
        }

        public function generateSharedKey(param1:String, param2:uint=16):String
        {
            this.var_2145 = new BigInteger();
            this.var_2145.fromRadix(param1, param2);
            this.var_2146 = this.var_2145.modPow(this.var_2143, this.var_2147);
            return (this.getSharedKey(param2));
        }

        public function getPublicKey(param1:uint=16):String
        {
            return (this.var_2144.toRadix(param1));
        }

        public function getSharedKey(param1:uint=16):String
        {
            return (this.var_2146.toRadix(param1));
        }

    }
}