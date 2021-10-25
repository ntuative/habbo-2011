package com.sulake.core.utils
{

    public class ErrorReportStorage
    {

        private static var var_363: Map = new Map();
        private static var var_362: Map = new Map();

        public static function getDebugData(): String
        {
            var _loc1_: String = "";
            var _loc2_: int;
            while (_loc2_ < var_362.length)
            {
                if (_loc2_ == 0)
                {
                    _loc1_ = var_362.getWithIndex(_loc2_);
                }
                else
                {
                    _loc1_ = _loc1_ + " ** " + var_362.getWithIndex(_loc2_);
                }

                _loc2_++;
            }

            if (_loc1_.length > 500)
            {
                _loc1_ = _loc1_.substr(_loc1_.length - 500);
            }

            return _loc1_;
        }

        public static function addDebugData(param1: String, param2: String): void
        {
            var_362.remove(param1);
            var_362.add(param1, param2);
        }

        public static function setParameter(param1: String, param2: String): void
        {
            var_363[param1] = param2;
        }

        public static function getParameter(param1: String): String
        {
            return var_363[param1];
        }

        public static function getParameterNames(): Array
        {
            return var_363.getKeys();
        }

    }
}
