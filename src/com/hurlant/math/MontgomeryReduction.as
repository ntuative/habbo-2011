package com.hurlant.math
{

    import com.hurlant.math.BigInteger;
    import com.hurlant.math.bi_internal;
    import com.hurlant.math.*;

    use namespace bi_internal;

    internal class MontgomeryReduction implements IReduction
    {

        private var m: BigInteger;
        private var var_2096: int;
        private var var_2097: int;
        private var var_2098: int;
        private var var_2099: int;
        private var var_2100: int;

        public function MontgomeryReduction(param1: BigInteger)
        {
            this.m = param1;
            this.var_2096 = param1.invDigit();
            this.var_2097 = this.var_2096 & 0x7FFF;
            this.var_2098 = this.var_2096 >> 15;
            this.var_2099 = (1 << BigInteger.var_1563 - 15) - 1;
            this.var_2100 = 2 * param1.t;
        }

        public function convert(param1: BigInteger): BigInteger
        {
            var _loc2_: BigInteger = new BigInteger();
            param1.abs().dlShiftTo(this.m.t, _loc2_);
            _loc2_.divRemTo(this.m, null, _loc2_);
            if (param1.s < 0 && _loc2_.compareTo(BigInteger.var_1568) > 0)
            {
                this.m.subTo(_loc2_, _loc2_);
            }

            return _loc2_;
        }

        public function revert(param1: BigInteger): BigInteger
        {
            var _loc2_: BigInteger = new BigInteger();
            param1.copyTo(_loc2_);
            this.reduce(_loc2_);
            return _loc2_;
        }

        public function reduce(param1: BigInteger): void
        {
            var _loc3_: int;
            var _loc4_: int;
            while (param1.t <= this.var_2100)
            {
                var _loc5_: * = param1.t++;
                param1.a[_loc5_] = 0;
            }

            var _loc2_: int;
            while (_loc2_ < this.m.t)
            {
                _loc3_ = param1.a[_loc2_] & 0x7FFF;
                _loc4_ = _loc3_ * this.var_2097 + ((_loc3_ * this.var_2098 + (param1.a[_loc2_] >> 15) * this.var_2097 & this.var_2099) << 15) & BigInteger.var_1565;
                _loc3_ = _loc2_ + this.m.t;
                param1.a[_loc3_] = param1.a[_loc3_] + this.m.am(0, _loc4_, param1, _loc2_, 0, this.m.t);
                while (param1.a[_loc3_] >= BigInteger.var_1564)
                {
                    param1.a[_loc3_] = param1.a[_loc3_] - BigInteger.var_1564;
                    param1.a[++_loc3_]++;
                }

                _loc2_++;
            }

            param1.clamp();
            param1.drShiftTo(this.m.t, param1);
            if (param1.compareTo(this.m) >= 0)
            {
                param1.subTo(this.m, param1);
            }

        }

        public function sqrTo(param1: BigInteger, param2: BigInteger): void
        {
            param1.squareTo(param2);
            this.reduce(param2);
        }

        public function mulTo(param1: BigInteger, param2: BigInteger, param3: BigInteger): void
        {
            param1.multiplyTo(param2, param3);
            this.reduce(param3);
        }

    }
}
