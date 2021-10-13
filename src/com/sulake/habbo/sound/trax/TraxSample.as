package com.sulake.habbo.sound.trax
{
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import __AS3__.vec.*;

    public class TraxSample 
    {

        private static const var_928:int = 32;

        private var var_4492:Vector.<Number> = null;
        private var _id:int;

        public function TraxSample(param1:ByteArray, param2:int)
        {
            var _loc5_:Number;
            super();
            this._id = param2;
            var _loc3_:int = int((param1.length / 8));
            this.var_4492 = new Vector.<Number>(_loc3_, true);
            param1.position = 0;
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                _loc5_ = param1.readFloat();
                param1.readFloat();
                if (_loc4_ >= ((_loc3_ - 1) - var_928))
                {
                    _loc5_ = (_loc5_ * (((_loc3_ - _loc4_) - 1) / Number(var_928)));
                };
                this.var_4492[_loc4_] = _loc5_;
                _loc4_++;
            };
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get length():uint
        {
            return (this.var_4492.length);
        }

        public function get data():Vector.<Number>
        {
            return (this.var_4492);
        }

    }
}