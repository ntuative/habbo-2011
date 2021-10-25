package com.sulake.habbo.tracking
{

    import com.sulake.habbo.configuration.IHabboConfigurationManager;

    public class FramerateTracker
    {

        private var var_4573: int;
        private var var_4574: int;
        private var var_4575: int;
        private var var_4576: Number;
        private var var_4577: Boolean;
        private var var_4578: int;
        private var var_4579: int;

        public function get frameRate(): int
        {
            return Math.round(1000 / this.var_4576);
        }

        public function configure(param1: IHabboConfigurationManager): void
        {
            this.var_4574 = int(param1.getKey("tracking.framerate.reportInterval.seconds", "300")) * 1000;
            this.var_4578 = int(param1.getKey("tracking.framerate.maximumEvents", "5"));
            this.var_4577 = true;
        }

        public function trackUpdate(param1: uint, param2: IHabboTracking, param3: int): void
        {
            var _loc4_: Number;
            this.var_4575++;
            if (this.var_4575 == 1)
            {
                this.var_4576 = param1;
                this.var_4573 = param3;
            }
            else
            {
                _loc4_ = Number(this.var_4575);
                this.var_4576 = (this.var_4576 * (_loc4_ - 1)) / _loc4_ + Number(param1) / _loc4_;
            }

            if (this.var_4577 && param3 - this.var_4573 >= this.var_4574)
            {
                this.var_4575 = 0;
                if (this.var_4579 < this.var_4578)
                {
                    param2.track("performance", "averageFramerate", this.frameRate);
                    this.var_4579++;
                    this.var_4573 = param3;
                }

            }

        }

        public function dispose(): void
        {
        }

    }
}
