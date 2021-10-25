package com.sulake.habbo.tracking
{

    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.utils.debug.GarbageMonitor;

    import flash.system.Capabilities;
    import flash.external.ExternalInterface;
    import flash.utils.getTimer;

    import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;

    import flash.system.System;

    public class PerformanceTracker
    {

        private var _connection: IConnection = null;
        private var var_2063: IHabboConfigurationManager = null;
        private var var_1045: int = 0;
        private var var_4576: Number = 0;
        private var var_4604: Array = [];
        private var var_3113: String = "";
        private var var_3114: String = "";
        private var var_3115: String = "";
        private var var_3116: String = "";
        private var var_3117: Boolean = false;
        private var var_4605: GarbageMonitor = null;
        private var var_3120: int = 0;
        private var var_4606: Boolean;
        private var var_4607: int = 1000;
        private var var_3122: int = 0;
        private var _reportInterval: int = 60;
        private var var_4573: int = 0;
        private var var_4608: int = 10;
        private var var_4609: int = 0;
        private var var_4610: Number = 0.15;
        private var var_4611: Boolean = true;
        private var var_4612: Number = 0;

        public function PerformanceTracker()
        {
            this.var_3114 = Capabilities.version;
            this.var_3115 = Capabilities.os;
            this.var_3117 = Capabilities.isDebugger;
            this.var_3113 = ExternalInterface.available
                    ? ExternalInterface.call("window.navigator.userAgent.toString")
                    : "unknown";
            if (this.var_3113 == null)
            {
                this.var_3113 = "unknown";
            }

            this.var_4605 = new GarbageMonitor();
            this.updateGarbageMonitor();
            this.var_4573 = getTimer();
        }

        public function get flashVersion(): String
        {
            return this.var_3114;
        }

        public function get averageUpdateInterval(): int
        {
            return this.var_4576;
        }

        public function set slowUpdateLimit(param1: int): void
        {
            this.var_4607 = param1;
        }

        public function set reportInterval(param1: int): void
        {
            this._reportInterval = param1;
        }

        public function set reportLimit(param1: int): void
        {
            this.var_4608 = param1;
        }

        public function set connection(param1: IConnection): void
        {
            this._connection = param1;
        }

        public function set configuration(param1: IHabboConfigurationManager): void
        {
            this.var_2063 = param1;
            this._reportInterval = int(this.var_2063.getKey("performancetest.interval", "60"));
            this.var_4607 = int(this.var_2063.getKey("performancetest.slowupdatelimit", "1000"));
            this.var_4608 = int(this.var_2063.getKey("performancetest.reportlimit", "10"));
            this.var_4610 = Number(this.var_2063.getKey("performancetest.distribution.deviancelimit.percent", "10"));
            this.var_4611 = Boolean(int(this.var_2063.getKey("performancetest.distribution.enabled", "1")));
            this.var_4606 = Boolean(this.var_2063.getKey("monitor.garbage.collection", "0") == "1");
        }

        public function dispose(): void
        {
        }

        private function updateGarbageMonitor(): Object
        {
            var _loc2_: Object;
            var _loc1_: Array = this.var_4605.list;
            if (_loc1_ == null || _loc1_.length == 0)
            {
                _loc2_ = new GarbageTester("tester");
                this.var_4605.insert(_loc2_, "tester");
                return _loc2_;
            }

            return null;
        }

        public function update(param1: uint, param2: int): void
        {
            var _loc4_: Object;
            var _loc5_: Number;
            var _loc6_: Boolean;
            var _loc7_: Number;
            if (this.var_4606)
            {
                _loc4_ = this.updateGarbageMonitor();
                if (_loc4_ != null)
                {
                    this.var_3120++;
                    Logger.log("Garbage collection");
                }

            }

            var _loc3_: Boolean;
            if (param1 > this.var_4607)
            {
                this.var_3122++;
                _loc3_ = true;
            }
            else
            {
                this.var_1045++;
                if (this.var_1045 <= 1)
                {
                    this.var_4576 = param1;
                }
                else
                {
                    _loc5_ = Number(this.var_1045);
                    this.var_4576 = (this.var_4576 * (_loc5_ - 1)) / _loc5_ + Number(param1) / _loc5_;
                }

            }

            if (param2 - this.var_4573 > this._reportInterval * 1000 && this.var_4609 < this.var_4608)
            {
                Logger.log("*** Performance tracker: average frame rate " + 1000 / this.var_4576);
                _loc6_ = true;
                if (this.var_4611 && this.var_4609 > 0)
                {
                    _loc7_ = this.differenceInPercents(this.var_4612, this.var_4576);
                    if (_loc7_ < this.var_4610)
                    {
                        _loc6_ = false;
                    }

                }

                this.var_4573 = param2;
                if (_loc6_ || _loc3_)
                {
                    this.var_4612 = this.var_4576;
                    if (this.sendReport(param2))
                    {
                        this.var_4609++;
                    }

                }

            }

        }

        private function sendReport(param1: int): Boolean
        {
            var _loc2_: PerformanceLogMessageComposer;
            var _loc3_: int;
            var _loc4_: int;
            var _loc5_: int;
            if (this._connection != null)
            {
                _loc2_ = null;
                _loc3_ = int(param1 / 1000);
                _loc4_ = -1;
                _loc5_ = int(System.totalMemory / 0x0400);
                _loc2_ = new PerformanceLogMessageComposer(_loc3_, this.var_3113, this.var_3114, this.var_3115, this.var_3116, this.var_3117, _loc5_, _loc4_, this.var_3120, this.var_4576, this.var_3122);
                this._connection.send(_loc2_);
                this.var_3120 = 0;
                this.var_4576 = 0;
                this.var_1045 = 0;
                this.var_3122 = 0;
                return true;
            }

            return false;
        }

        private function differenceInPercents(param1: Number, param2: Number): Number
        {
            if (param1 == param2)
            {
                return 0;
            }

            var _loc3_: Number = param1;
            var _loc4_: Number = param2;
            if (param2 > param1)
            {
                _loc3_ = param2;
                _loc4_ = param1;
            }

            return 100 * (1 - _loc4_ / _loc3_);
        }

    }
}
