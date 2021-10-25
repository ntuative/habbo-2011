package com.sulake.habbo.catalog.purse
{

    import flash.events.Event;

    public class PurseEvent extends Event
    {

        public static const CATALOG_PURSE_CREDIT_BALANCE: String = "catalog_purse_credit_balance";
        public static const CATALOG_PURSE_PIXEL_BALANCE: String = "catalog_purse_pixel_balance";

        private var _balance: int;

        public function PurseEvent(param1: String, param2: int, param3: Boolean = false, param4: Boolean = false)
        {
            super(param1, param3, param4);
            this._balance = param2;
        }

        public function get balance(): int
        {
            return this._balance;
        }

    }
}
