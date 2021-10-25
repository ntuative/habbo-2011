package com.sulake.room.renderer.cache
{

    import com.sulake.room.renderer.utils.SortableSprite;

    public class RoomObjectSortableSpriteCacheItem
    {

        private var _sprites: Array = [];
        private var _unknown1: int = -1;
        private var _unknown2: int = -1;
        private var _isEmpty: Boolean = false;

        public function get spriteCount(): int
        {
            return this._sprites.length;
        }

        public function get isEmpty(): Boolean
        {
            return this._isEmpty;
        }

        public function dispose(): void
        {
            this.setSpriteCount(0);
        }

        public function addSprite(sprite: SortableSprite): void
        {
            this._sprites.push(sprite);
        }

        public function getSprite(sprite: int): SortableSprite
        {
            return this._sprites[sprite];
        }

        // TODO: Suss this out
        public function needsUpdate(param1: int, param2: int): Boolean
        {
            if (param1 != this._unknown1 || param2 != this._unknown2)
            {
                this._unknown1 = param1;
                this._unknown2 = param2;
                return true;
            }

            return false;
        }

        public function setSpriteCount(param1: int): void
        {
            var _loc2_: int;
            var _loc3_: SortableSprite;
            if (param1 < this._sprites.length)
            {
                _loc2_ = param1;
                while (_loc2_ < this._sprites.length)
                {
                    _loc3_ = this.getSprite(_loc2_);
                    if (_loc3_)
                    {
                        _loc3_.dispose();
                    }

                    _loc2_++;
                }

                this._sprites.splice(param1, this._sprites.length - param1);
            }

            this._isEmpty = this._sprites.length == 0;

        }

    }
}
