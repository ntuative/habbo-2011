package com.sulake.habbo.sound.trax
{
    import __AS3__.vec.Vector;

    public class TraxChannelSample 
    {

        private var var_4490:TraxSample = null;
        private var _offset:int = 0;

        public function TraxChannelSample(param1:TraxSample, param2:int)
        {
            this.var_4490 = param1;
            this._offset = param2;
        }

        public function setSample(param1:Vector.<Number>, param2:int, param3:int):void
        {
            var _loc4_:Vector.<Number> = this.var_4490.data;
            if (((param1 == null) || (_loc4_ == null)))
            {
                return;
            };
            if (param2 < 0)
            {
                param3 = (param3 + param2);
                param2 = 0;
            };
            if (param3 > (param1.length - param2))
            {
                param3 = (param1.length - param2);
            };
            var _loc5_:int = param3;
            var _loc6_:int;
            if (_loc5_ > (_loc4_.length - this._offset))
            {
                _loc6_ = (_loc5_ - (_loc4_.length - this._offset));
                _loc5_ = (_loc4_.length - this._offset);
                if (_loc6_ > (param1.length - param2))
                {
                    _loc6_ = (param1.length - param2);
                };
            };
            while (_loc5_-- > 0)
            {
                var _loc7_:* = param2++;
                param1[_loc7_] = _loc4_[this._offset++];
            };
            while (_loc6_-- > 0)
            {
                _loc7_ = param2++;
                param1[_loc7_] = 0;
            };
        }

        public function addSample(param1:Vector.<Number>, param2:int, param3:int):void
        {
            var _loc4_:Vector.<Number> = this.var_4490.data;
            if (((param1 == null) || (_loc4_ == null)))
            {
                return;
            };
            if (param2 < 0)
            {
                param3 = (param3 + param2);
                param2 = 0;
            };
            if (param3 > (param1.length - param2))
            {
                param3 = (param1.length - param2);
            };
            var _loc5_:int = param3;
            if (_loc5_ > (_loc4_.length - this._offset))
            {
                _loc5_ = (_loc4_.length - this._offset);
            };
            while (_loc5_-- > 0)
            {
                var _loc6_:* = param2++;
                param1[_loc6_] = (param1[_loc6_] + _loc4_[this._offset++]);
            };
        }

    }
}