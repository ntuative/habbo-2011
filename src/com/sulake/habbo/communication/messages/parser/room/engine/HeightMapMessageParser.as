package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HeightMapMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _heightMap: Array = [];
        private var var_3297: Array = [];
        private var var_3298: Array = [];
        private var _width: int = 0;
        private var _height: int = 0;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get width(): int
        {
            return this._width;
        }

        public function get height(): int
        {
            return this._height;
        }

        public function getTileHeight(x: int, y: int): Number
        {
            if (x < 0 || x >= this.width || y < 0 || y >= this.height)
            {
                return -1;
            }

            var tiles: Array = this._heightMap[y] as Array;

            return Number(tiles[x]);
        }

        public function getTileBlocking(x: int, y: int): Boolean
        {
            if (x < 0 || x >= this.width || y < 0 || y >= this.height)
            {
                return true;
            }

            var tiles: Array = this.var_3297[y] as Array;
            
            return Boolean(tiles[x]);
        }

        public function isRoomTile(x: int, y: int): Boolean
        {
            if (x < 0 || x >= this.width || y < 0 || y >= this.height)
            {
                return false;
            }

            var tiles: Array = this.var_3298[y] as Array;
            
            return Boolean(tiles[x]);
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this.var_3297 = [];
            this.var_3298 = [];
            this._width = 0;
            this._height = 0;

            return true;
        }

        // TODO: Do this when I can be bothered
        public function parse(data: IMessageDataWrapper): Boolean
        {
            var _loc16_: String;
            var _loc17_: String;
            var _loc18_: Number;
            var _loc19_: Boolean;
            var _loc20_: Boolean;

            if (data == null)
            {
                return false;
            }

            var _loc2_: int;
            var _loc3_: int;
            var _loc4_: String = data.readString();
            var _loc5_: Array = _loc4_.split("\r");
            var _loc6_: int;
            var i: int;
            var _loc8_: Array = [];
            var _loc9_: Array;
            var _loc10_: Array = [];
            var _loc11_: Array;
            var _loc12_: Array = [];
            var _loc13_: Array;
            var _loc14_: Array;
            var _loc15_: int;

            this._width = 0;
            this._height = 0;
            
            i = 0;
            
            while (i < _loc5_.length)
            {
                _loc16_ = (_loc5_[i] as String);
                if (_loc16_.length > 0)
                {
                    if (_loc16_.length > this._width)
                    {
                        this._width = _loc16_.length;
                    }

                    _loc9_ = [];
                    _loc8_[i] = _loc9_;
                    _loc11_ = [];
                    _loc10_[i] = _loc11_;
                    _loc13_ = [];
                    _loc12_[i] = _loc13_;
                    _loc6_ = 0;
                    while (_loc6_ < _loc16_.length)
                    {
                        _loc17_ = _loc16_.charAt(_loc6_);
                        if (_loc17_ != "x" && _loc17_ != "X")
                        {
                            _loc15_ = this.getHeightValue(_loc17_);
                            _loc9_.push(_loc15_);
                            if (this.getBlocking(_loc17_))
                            {
                                _loc11_.push(true);
                            }
                            else
                            {
                                _loc11_.push(false);
                            }

                            _loc13_.push(true);
                        }
                        else
                        {
                            _loc9_.push(-1);
                            _loc11_.push(true);
                            _loc13_.push(false);
                        }

                        _loc6_++;
                    }

                }

                i++;
            }

            i = 0;

            while (i < _loc8_.length)
            {
                _loc9_ = (_loc8_[i] as Array);
                while (_loc9_.length < this._width)
                {
                    _loc9_.push(-1);
                }

                i++;
            }

            this._heightMap = [];
            i = 0;

            while (i < _loc8_.length)
            {
                _loc14_ = [];
                this._heightMap.push(_loc14_);
                _loc9_ = (_loc8_[i] as Array);
                _loc6_ = 0;
                while (_loc6_ < this._width)
                {
                    _loc18_ = Number(_loc9_[_loc6_]);
                    _loc14_.push(_loc18_);
                    _loc6_++;
                }

                i++;
            }

            i = 0;

            while (i < _loc10_.length)
            {
                _loc11_ = (_loc10_[i] as Array);

                while (_loc11_.length < this._width)
                {
                    _loc11_.push(true);
                }

                i++;
            }

            this.var_3297 = [];
            i = 0;

            while (i < _loc10_.length)
            {
                _loc14_ = [];
                this.var_3297.push(_loc14_);
                _loc11_ = (_loc10_[i] as Array);
                _loc6_ = 0;

                while (_loc6_ < this._width)
                {
                    _loc19_ = Boolean(_loc11_[_loc6_]);
                    _loc14_.push(_loc19_);
                    _loc6_++;
                }

                i++;
            }

            i = 0;

            while (i < _loc12_.length)
            {
                _loc13_ = (_loc12_[i] as Array);

                while (_loc13_.length < this._width)
                {
                    _loc13_.push(false);
                }

                i++;
            }

            this.var_3298 = [];
            i = 0;

            while (i < _loc12_.length)
            {
                _loc14_ = [];
                this.var_3298.push(_loc14_);
                _loc13_ = (_loc12_[i] as Array);
                _loc6_ = 0;

                while (_loc6_ < this._width)
                {
                    _loc20_ = Boolean(_loc13_[_loc6_]);
                    _loc14_.push(_loc20_);
                    _loc6_++;
                }

                i++;
            }

            this._height = this._heightMap.length;

            return true;
        }

        private function getHeightValue(tileChar: String): int
        {
            var tile: int = parseInt(tileChar, 16);

            return tile % 10;
        }

        private function getBlocking(param1: String): Boolean
        {
            var _loc2_: int = parseInt(param1, 16);
            return _loc2_ >= 10;
        }

    }
}
