package com.sulake.room.renderer.cache
{
    public class RoomObjectCacheItem 
    {

        private var var_2494:RoomObjectLocationCacheItem = null;
        private var var_2570:RoomObjectSortableSpriteCacheItem = null;

        public function RoomObjectCacheItem(param1:String)
        {
            this.var_2494 = new RoomObjectLocationCacheItem(param1);
            this.var_2570 = new RoomObjectSortableSpriteCacheItem();
        }

        public function get location():RoomObjectLocationCacheItem
        {
            return (this.var_2494);
        }

        public function get sprites():RoomObjectSortableSpriteCacheItem
        {
            return (this.var_2570);
        }

        public function dispose():void
        {
            if (this.var_2494 != null)
            {
                this.var_2494.dispose();
                this.var_2494 = null;
            };
            if (this.var_2570 != null)
            {
                this.var_2570.dispose();
                this.var_2570 = null;
            };
        }

    }
}