package com.sulake.room.object
{
    import flash.utils.Dictionary;

    public class RoomObjectModel implements IRoomObjectModelController 
    {

        private var var_4999:Dictionary;
        private var var_5000:Dictionary;
        private var var_5001:Dictionary;
        private var var_5002:Dictionary;
        private var var_5003:Array;
        private var var_5004:Array;
        private var _numberArrayReadOnlyList:Array;
        private var _stringArrayReadOnlyList:Array;
        private var _updateID:int;

        public function RoomObjectModel()
        {
            this.var_4999 = new Dictionary();
            this.var_5000 = new Dictionary();
            this.var_5001 = new Dictionary();
            this.var_5002 = new Dictionary();
            this.var_5003 = [];
            this.var_5004 = [];
            this._numberArrayReadOnlyList = [];
            this._stringArrayReadOnlyList = [];
            this._updateID = 0;
        }

        public function dispose():void
        {
            var _loc1_:String;
            if (this.var_4999 != null)
            {
                for (_loc1_ in this.var_4999)
                {
                    delete this.var_4999[_loc1_];
                };
                this.var_4999 = null;
            };
            if (this.var_5000 != null)
            {
                for (_loc1_ in this.var_5000)
                {
                    delete this.var_5000[_loc1_];
                };
                this.var_5000 = null;
            };
            if (this.var_5001 != null)
            {
                for (_loc1_ in this.var_5001)
                {
                    delete this.var_5001[_loc1_];
                };
                this.var_5001 = null;
            };
            if (this.var_5002 != null)
            {
                for (_loc1_ in this.var_5002)
                {
                    delete this.var_5002[_loc1_];
                };
                this.var_5002 = null;
            };
            this.var_5004 = [];
            this.var_5003 = [];
            this._stringArrayReadOnlyList = [];
            this._numberArrayReadOnlyList = [];
        }

        public function getNumber(param1:String):Number
        {
            return (this.var_4999[param1]);
        }

        public function getString(param1:String):String
        {
            return (this.var_5000[param1]);
        }

        public function getNumberArray(param1:String):Array
        {
            var _loc2_:Array = this.var_5001[param1];
            if (_loc2_ != null)
            {
                _loc2_ = _loc2_.slice();
            };
            return (_loc2_);
        }

        public function getStringArray(param1:String):Array
        {
            var _loc2_:Array = this.var_5002[param1];
            if (_loc2_ != null)
            {
                _loc2_ = _loc2_.slice();
            };
            return (_loc2_);
        }

        public function setNumber(param1:String, param2:Number, param3:Boolean=false):void
        {
            if (this.var_5003.indexOf(param1) >= 0)
            {
                return;
            };
            if (param3)
            {
                this.var_5003.push(param1);
            };
            if (this.var_4999[param1] != param2)
            {
                this.var_4999[param1] = param2;
                this._updateID++;
            };
        }

        public function setString(param1:String, param2:String, param3:Boolean=false):void
        {
            if (this.var_5004.indexOf(param1) >= 0)
            {
                return;
            };
            if (param3)
            {
                this.var_5004.push(param1);
            };
            if (this.var_5000[param1] != param2)
            {
                this.var_5000[param1] = param2;
                this._updateID++;
            };
        }

        public function setNumberArray(param1:String, param2:Array, param3:Boolean=false):void
        {
            if (param2 == null)
            {
                return;
            };
            if (this._numberArrayReadOnlyList.indexOf(param1) >= 0)
            {
                return;
            };
            if (param3)
            {
                this._numberArrayReadOnlyList.push(param1);
            };
            var _loc4_:Array = [];
            var _loc5_:int;
            _loc5_ = 0;
            while (_loc5_ < param2.length)
            {
                if ((param2[_loc5_] is Number))
                {
                    _loc4_.push(param2[_loc5_]);
                };
                _loc5_++;
            };
            var _loc6_:Array = this.var_5001[param1];
            var _loc7_:Boolean = true;
            if (((!(_loc6_ == null)) && (_loc6_.length == _loc4_.length)))
            {
                _loc5_ = (_loc4_.length - 1);
                while (_loc5_ >= 0)
                {
                    if ((_loc4_[_loc5_] as Number) != (_loc6_[_loc5_] as Number))
                    {
                        _loc7_ = false;
                        break;
                    };
                    _loc5_--;
                };
            }
            else
            {
                _loc7_ = false;
            };
            if (_loc7_)
            {
                return;
            };
            this.var_5001[param1] = _loc4_;
            this._updateID++;
        }

        public function setStringArray(param1:String, param2:Array, param3:Boolean=false):void
        {
            if (param2 == null)
            {
                return;
            };
            if (this._stringArrayReadOnlyList.indexOf(param1) >= 0)
            {
                return;
            };
            if (param3)
            {
                this._stringArrayReadOnlyList.push(param1);
            };
            var _loc4_:Array = [];
            var _loc5_:int;
            _loc5_ = 0;
            while (_loc5_ < param2.length)
            {
                if ((param2[_loc5_] is String))
                {
                    _loc4_.push(param2[_loc5_]);
                };
                _loc5_++;
            };
            var _loc6_:Array = this.var_5002[param1];
            var _loc7_:Boolean = true;
            if (((!(_loc6_ == null)) && (_loc6_.length == _loc4_.length)))
            {
                _loc5_ = (_loc4_.length - 1);
                while (_loc5_ >= 0)
                {
                    if ((_loc4_[_loc5_] as String) != (_loc6_[_loc5_] as String))
                    {
                        _loc7_ = false;
                        break;
                    };
                    _loc5_--;
                };
            }
            else
            {
                _loc7_ = false;
            };
            if (_loc7_)
            {
                return;
            };
            this.var_5002[param1] = _loc4_;
            this._updateID++;
        }

        public function getUpdateID():int
        {
            return (this._updateID);
        }

    }
}