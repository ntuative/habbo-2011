package com.sulake.room.renderer.cache
{

    public class RoomObjectCacheItem
    {

        private var _location: RoomObjectLocationCacheItem = null;
        private var _sprites: RoomObjectSortableSpriteCacheItem = null;

        public function RoomObjectCacheItem(param1: String)
        {
            this._location = new RoomObjectLocationCacheItem(param1);
            this._sprites = new RoomObjectSortableSpriteCacheItem();
        }

        public function get location(): RoomObjectLocationCacheItem
        {
            return this._location;
        }

        public function get sprites(): RoomObjectSortableSpriteCacheItem
        {
            return this._sprites;
        }

        public function dispose(): void
        {
            if (this._location != null)
            {
                this._location.dispose();
                this._location = null;
            }

            if (this._sprites != null)
            {
                this._sprites.dispose();
                this._sprites = null;
            }

        }

    }
}
