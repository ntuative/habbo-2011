package com.sulake.habbo.communication.encryption
{

    public class PseudoRandom
    {

        private static const var_2893: int = 19979;
        private static const var_2894: int = 5;

        private var seed: int;
        private var modulus: int;

        public function PseudoRandom(param1: int, param2: int): void
        {
            this.seed = param1;
            this.modulus = param2;
        }

        public function nextInt(): int
        {
            var _loc1_: int = Math.abs(var_2893 * this.seed + var_2894) % this.modulus;
            this.seed = _loc1_;
            return _loc1_;
        }

    }
}
