package com.sulake.habbo.sound.trax
{

    public class TraxData
    {

        private var var_4491: Array;

        public function TraxData(param1: String)
        {
            var _loc4_: int;
            var _loc5_: Array;
            var _loc6_: TraxChannel;
            var _loc7_: int;
            var _loc8_: Array;
            var _loc9_: int;
            var _loc10_: int;
            super();
            this.var_4491 = [];
            var _loc2_: Array = param1.split(":");
            var _loc3_: int;
            while (_loc3_ < _loc2_.length / 2)
            {
                if (_loc2_[(_loc3_ * 2)].toString().length > 0)
                {
                    _loc4_ = int(_loc2_[(_loc3_ * 2)]);
                    _loc5_ = _loc2_[(_loc3_ * 2 + 1)].toString().split(";");
                    _loc6_ = new TraxChannel(_loc4_);
                    _loc7_ = 0;
                    while (_loc7_ < _loc5_.length)
                    {
                        _loc8_ = _loc5_[_loc7_].toString().split(",");
                        if (_loc8_.length != 2)
                        {
                            Logger.log("Trax load error: invalid song data string");
                            return;
                        }

                        _loc9_ = int(_loc8_[0]);
                        _loc10_ = int(_loc8_[1]);
                        _loc6_.addChannelItem(new TraxChannelItem(_loc9_, _loc10_));
                        _loc7_++;
                    }

                    this.var_4491.push(_loc6_);
                }

                _loc3_++;
            }

        }

        public function get channels(): Array
        {
            return this.var_4491;
        }

        public function getSampleIds(): Array
        {
            var _loc3_: TraxChannel;
            var _loc4_: int;
            var _loc5_: TraxChannelItem;
            var _loc1_: Array = [];
            var _loc2_: int;
            while (_loc2_ < this.var_4491.length)
            {
                _loc3_ = (this.var_4491[_loc2_] as TraxChannel);
                _loc4_ = 0;
                while (_loc4_ < _loc3_.itemCount)
                {
                    _loc5_ = _loc3_.getItem(_loc4_);
                    if (_loc1_.indexOf(_loc5_.id) == -1)
                    {
                        _loc1_.push(_loc5_.id);
                    }

                    _loc4_++;
                }

                _loc2_++;
            }

            return _loc1_;
        }

    }
}
