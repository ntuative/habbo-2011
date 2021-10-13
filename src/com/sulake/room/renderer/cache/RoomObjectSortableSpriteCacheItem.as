package com.sulake.room.renderer.cache
{
    import com.sulake.room.renderer.utils.SortableSprite;

    public class RoomObjectSortableSpriteCacheItem 
    {

        private var var_2570:Array = [];
        private var var_5012:int = -1;
        private var var_5013:int = -1;
        private var var_5014:Boolean = false;

        public function get spriteCount():int
        {
            return (this.var_2570.length);
        }

        public function get isEmpty():Boolean
        {
            return (this.var_5014);
        }

        public function dispose():void
        {
            this.setSpriteCount(0);
        }

        public function addSprite(param1:SortableSprite):void
        {
            this.var_2570.push(param1);
        }

        public function getSprite(param1:int):SortableSprite
        {
            return (this.var_2570[param1]);
        }

        public function needsUpdate(param1:int, param2:int):Boolean
        {
            if (((!(param1 == this.var_5012)) || (!(param2 == this.var_5013))))
            {
                this.var_5012 = param1;
                this.var_5013 = param2;
                return (true);
            };
            return (false);
        }

        public function setSpriteCount(param1:int):void
        {
            var _loc2_:int;
            var _loc3_:SortableSprite;
            if (param1 < this.var_2570.length)
            {
                _loc2_ = param1;
                while (_loc2_ < this.var_2570.length)
                {
                    _loc3_ = this.getSprite(_loc2_);
                    if (_loc3_)
                    {
                        _loc3_.dispose();
                    };
                    _loc2_++;
                };
                this.var_2570.splice(param1, (this.var_2570.length - param1));
            };
            if (this.var_2570.length == 0)
            {
                this.var_5014 = true;
            }
            else
            {
                this.var_5014 = false;
            };
        }

    }
}