﻿package com.sulake.core.utils.debug
{

    import com.sulake.core.runtime.IDisposable;

    import flash.utils.Dictionary;

    public class GarbageMonitor implements IDisposable
    {

        private var _disposed: Boolean = false;
        private var var_2194: Dictionary;

        public function GarbageMonitor()
        {
            this.var_2194 = new Dictionary(true);
        }

        public function dispose(): void
        {
            var _loc1_: *;
            if (!this._disposed)
            {
                for each (_loc1_ in this.var_2194)
                {
                    this.var_2194[_loc1_] = null;
                }

                this.var_2194 = null;
                this._disposed = true;
            }

        }

        public function insert(param1: Object, param2: String = null): void
        {
            this.var_2194[param1] = param2 == null ? param1.toString() : param2;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get list(): Array
        {
            var _loc2_: *;
            var _loc1_: Array = [];
            for each (_loc2_ in this.var_2194)
            {
                _loc1_.push(_loc2_);
            }

            return _loc1_;
        }

    }
}
