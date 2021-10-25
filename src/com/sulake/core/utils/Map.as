package com.sulake.core.utils
{

    import flash.utils.Proxy;

    import com.sulake.core.runtime.IDisposable;

    import flash.utils.Dictionary;

    import com.sulake.core.Core;

    import flash.utils.flash_proxy;

    use namespace flash.utils.flash_proxy;

    public class Map extends Proxy implements IDisposable
    {

        private var _length: uint;
        private var _items: Dictionary;
        private var _values: Array;
        private var _keys: Array;
        private var _singleWrite: Boolean = false;

        public function Map(singleWrite: Boolean = false)
        {
            this._singleWrite = singleWrite;
            this._length = 0;
            this._items = new Dictionary();
            this._values = [];
            this._keys = [];
        }

        public function get length(): uint
        {
            return this._length;
        }

        public function get disposed(): Boolean
        {
            return this._items == null;
        }

        public function dispose(): void
        {
            var _loc1_: Object;

            if (this._items != null)
            {
                for (_loc1_ in this._items)
                {
                    this._items[_loc1_] = null;
                }

                this._items = null;
            }


            this._length = 0;
            this._values = null;
            this._keys = null;
        }

        public function reset(): void
        {
            var item: Object;

            for (item in this._items)
            {
                this._items[item] = null;
            }


            this._length = 0;
            this._values = [];
            this._keys = [];
        }

        public function unshift(param1: *, param2: *): Boolean
        {
            if (this._items[param1] != null)
            {
                return false;
            }


            this._items[param1] = param2;
            this._values.unshift(param2);
            this._keys.unshift(param1);
            this._length++;
            return true;
        }

        public function add(param1: *, param2: *): Boolean
        {
            if (this._items[param1] != null)
            {
                return false;
            }

            this._items[param1] = param2;
            this._values[this._length] = param2;
            this._keys[this._length] = param1;
            this._length++;
            return true;
        }

        public function getValue(param1: *): *
        {
            return this._items[param1];
        }

        public function remove(param1: *): *
        {
            var _loc2_: Object = this._items[param1];
            if (_loc2_ == null)
            {
                return null;
            }

            var _loc3_: int = this._values.indexOf(_loc2_);
            if (_loc3_ >= 0)
            {
                this._values.splice(_loc3_, 1);
                this._keys.splice(_loc3_, 1);
                this._length--;
            }

            this._items[param1] = null;
            return _loc2_;
        }

        public function getWithIndex(param1: int): *
        {
            if (param1 < 0 || param1 >= this._length)
            {
                return null;
            }

            return this._values[param1];
        }

        public function getKey(param1: int): *
        {
            if (param1 < 0 || param1 >= this._length)
            {
                return null;
            }

            return this._keys[param1];
        }

        public function getKeys(): Array
        {
            return this._keys.slice();
        }

        public function getValues(): Array
        {
            return this._values.slice();
        }

        override flash_proxy function getProperty(param1: *): *
        {
            if (param1 is QName)
            {
                param1 = QName(param1).localName;
            }

            return this._items[param1];
        }

        override flash_proxy function setProperty(param1: *, param2: *): void
        {
            if (param1 is QName)
            {
                param1 = QName(param1).localName;
            }

            if (this._singleWrite)
            {
                if (this._items[param1] != null)
                {
                    Core.error("Trying to write to a single write Map. Key: " + param1 + ", value: " + param2, true, Core.ERROR_CATEGORY_INTENTIONAL_CRASH);
                }

            }

            this._items[param1] = param2;
            var _loc3_: int = this._keys.indexOf(param1);
            if (_loc3_ == -1)
            {
                this._values[this._length] = param2;
                this._keys[this._length] = param1;
                this._length++;
            }
            else
            {
                this._values.splice(_loc3_, 1, param2);
            }

        }

        override flash_proxy function nextNameIndex(param1: int): int
        {
            if (param1 < this._keys.length)
            {
                return param1 + 1;
            }

            return 0;
        }

        override flash_proxy function nextName(param1: int): String
        {
            return this._keys[(param1 - 1)];
        }

        override flash_proxy function nextValue(param1: int): *
        {
            return this._values[(param1 - 1)];
        }

        override flash_proxy function callProperty(param1: *, ..._args): *
        {
            var _loc3_: String;
            if (param1.localName == "toString")
            {
                return "Map";
            }

            return null;
        }

    }
}
