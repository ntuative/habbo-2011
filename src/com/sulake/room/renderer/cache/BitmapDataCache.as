package com.sulake.room.renderer.cache
{

    import com.sulake.core.utils.Map;
    import com.sulake.room.renderer.utils.ExtendedBitmapData;

    import flash.display.BitmapData;

    public class BitmapDataCache
    {

        private var _dataMap: Map;
        private var _cachedItems: Array;
        private var _memUsage: int = 0;
        private var _memLimit: int = 0;

        public function BitmapDataCache(param1: uint)
        {
            this._dataMap = new Map();
            this._cachedItems = [];
            this._memLimit = param1;
        }

        public function get memUsage(): int
        {
            return this._memUsage;
        }

        public function get memLimit(): int
        {
            return this._memLimit;
        }

        public function dispose(): void
        {
            var _loc1_: int;
            var _loc2_: BitmapDataCacheItem;
            if (this._dataMap != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this._dataMap.length)
                {
                    _loc2_ = (this._dataMap.getWithIndex(_loc1_) as BitmapDataCacheItem);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    }

                    _loc1_++;
                }

                this._dataMap.dispose();
                this._dataMap = null;
            }

            this._cachedItems = null;
        }

        public function compress(): void
        {
            var _loc1_: BitmapDataCacheItem;
            var _loc2_: int;
            if (this.memUsage > this.memLimit)
            {
                this._cachedItems.sortOn("useCount", Array.DESCENDING | Array.NUMERIC);
                _loc2_ = this._cachedItems.length - 1;
                while (_loc2_ >= 0)
                {
                    _loc1_ = (this._cachedItems[_loc2_] as BitmapDataCacheItem);
                    if (_loc1_.useCount <= 1)
                    {
                        this.removeItem(_loc1_);
                    }
                    else
                    {
                        _loc2_++;
                        break;
                    }

                    _loc2_--;
                }

                this._cachedItems.splice(_loc2_, this._cachedItems.length - _loc2_);
                if (this.memUsage > this.memLimit)
                {
                    this._cachedItems.sortOn("memUsage", Array.NUMERIC);
                    while (this.memUsage > this.memLimit)
                    {
                        _loc1_ = (this._cachedItems.pop() as BitmapDataCacheItem);
                        if (_loc1_ != null)
                        {
                            this.removeItem(_loc1_);
                        }
                        else
                        {
                            return;
                        }

                    }

                }

            }

        }

        private function removeItem(param1: BitmapDataCacheItem): void
        {
            if (param1 == null)
            {
                return;
            }

            param1 = (this._dataMap.remove(param1.name) as BitmapDataCacheItem);
            if (param1 != null)
            {
                this._memUsage = this._memUsage - param1.memUsage;
                param1.dispose();
            }

        }

        public function getBitmapData(param1: String): ExtendedBitmapData
        {
            var _loc2_: BitmapDataCacheItem = this._dataMap.getValue(param1) as BitmapDataCacheItem;
            if (_loc2_ == null)
            {
                return null;
            }

            return _loc2_.bitmapData;
        }

        public function addBitmapData(param1: String, param2: ExtendedBitmapData): void
        {
            var _loc4_: BitmapData;
            if (param2 == null)
            {
                return;
            }

            var _loc3_: BitmapDataCacheItem = this._dataMap.getValue(param1) as BitmapDataCacheItem;
            if (_loc3_ != null)
            {
                _loc4_ = _loc3_.bitmapData;
                if (_loc4_ != null)
                {
                    this._memUsage = this._memUsage - _loc4_.width * _loc4_.height * 4;
                }

                _loc3_.bitmapData = param2;
            }
            else
            {
                _loc3_ = new BitmapDataCacheItem(param2, param1);
                this._dataMap.add(param1, _loc3_);
                this._cachedItems.push(_loc3_);
            }

            this._memUsage = this._memUsage + param2.width * param2.height * 4;
        }

    }
}
