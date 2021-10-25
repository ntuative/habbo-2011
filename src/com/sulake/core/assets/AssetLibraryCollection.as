package com.sulake.core.assets
{

    import com.sulake.core.runtime.events.EventDispatcher;

    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;

    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.utils.LibraryLoader;

    import flash.events.Event;
    import flash.net.URLRequest;

    public class AssetLibraryCollection extends EventDispatcher implements IAssetLibrary
    {

        protected var var_2117: Array;
        protected var var_2119: Array;
        protected var _loaderContext: LoaderContext;
        protected var var_2118: AssetLibrary;
        protected var _manifest: XML;
        protected var _name: String;
        private var var_1045: uint = 0;

        public function AssetLibraryCollection(param1: String)
        {
            this._name = param1;
            this._manifest = new XML();
            this.var_2117 = [];
            this.var_2119 = [];
            this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            this.var_2118 = new AssetLibrary("lib-" + this.var_1045++);
            this.var_2117.push(this.var_2118);
        }

        public function get url(): String
        {
            return "";
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get isReady(): Boolean
        {
            return this.var_2119.length == 0;
        }

        public function get numAssets(): uint
        {
            return this.getNumAssets();
        }

        public function get nameArray(): Array
        {
            return this.getAssetNameArray();
        }

        public function get manifest(): XML
        {
            return this._manifest;
        }

        public function get loaderContext(): LoaderContext
        {
            return this._loaderContext;
        }

        public function set loaderContext(loaderContext: LoaderContext): void
        {
            this._loaderContext = loaderContext;
        }

        public function loadFromFile(loader: LibraryLoader, param2: Boolean = false): void
        {
            if (this.loaderContext == null)
            {
                this.loaderContext = this._loaderContext;
            }


            var _loc3_: IAssetLibrary = new AssetLibrary("lib-" + this.var_1045++);
            this.var_2119.push(_loc3_);
            _loc3_.loadFromFile(loader, param2);
            loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadEventHandler);
            loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadEventHandler);
            loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadEventHandler);
        }

        public function loadFromResource(param1: XML, param2: Class): Boolean
        {
            return this.var_2118.loadFromResource(param1, param2);
        }

        public function unload(): void
        {
            while (this.var_2119.length > 0)
            {
                (this.var_2119.pop() as IAssetLibrary).dispose();
            }

            while (this.var_2117.length > 0)
            {
                (this.var_2117.pop() as IAssetLibrary).dispose();
            }

        }

        override public function dispose(): void
        {
            var _loc1_: uint;
            var _loc2_: IAssetLibrary;
            var _loc3_: uint;
            if (!disposed)
            {
                super.dispose();
                _loc1_ = this.var_2117.length;
                _loc3_ = 0;
                while (_loc3_ < _loc1_)
                {
                    _loc2_ = this.var_2117.pop();
                    _loc2_.dispose();
                    _loc3_++;
                }

            }

        }

        private function loadEventHandler(param1: LibraryLoaderEvent): void
        {
            var _loc2_: LibraryLoader;
            var _loc3_: IAssetLibrary;
            var _loc4_: uint;
            if (param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE)
            {
                _loc2_ = (param1.target as LibraryLoader);
                _loc4_ = 0;
                while (_loc4_ < this.var_2119.length)
                {
                    _loc3_ = (this.var_2119[_loc4_] as IAssetLibrary);
                    if (_loc3_.url == _loc2_.url)
                    {
                        this.var_2119.splice(_loc4_, 1);
                        break;
                    }

                    _loc4_++;
                }

                this.var_2117.push(_loc3_);
                _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.loadEventHandler);
                _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadEventHandler);
                _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS, this.loadEventHandler);
                if (this.var_2119.length == 0)
                {
                    dispatchEvent(new Event(AssetLibrary.ASSET_LIBRARY_LOADED));
                }

            }

        }

        public function hasAssetLibrary(param1: String): Boolean
        {
            var _loc3_: IAssetLibrary;
            var _loc2_: uint = this.var_2117.length;
            var _loc4_: uint;
            while (_loc4_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc4_];
                if (_loc3_.name == param1)
                {
                    return true;
                }

                _loc4_++;
            }

            return false;
        }

        public function getAssetLibraryByName(param1: String): IAssetLibrary
        {
            var _loc3_: IAssetLibrary;
            var _loc2_: uint = this.var_2117.length;
            var _loc4_: uint;
            while (_loc4_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc4_];
                if (_loc3_.name == param1)
                {
                    return _loc3_;
                }

                _loc4_++;
            }

            return null;
        }

        public function getAssetLibraryByUrl(param1: String): IAssetLibrary
        {
            var _loc3_: IAssetLibrary;
            var _loc2_: uint = this.var_2117.length;
            var _loc4_: uint;
            while (_loc4_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc4_];
                if (_loc3_.url == param1)
                {
                    return _loc3_;
                }

                _loc4_++;
            }

            return null;
        }

        public function addAssetLibrary(param1: IAssetLibrary): void
        {
            if (this.var_2117.indexOf(param1) == -1)
            {
                this.var_2117.push(param1);
            }

        }

        public function loadAssetFromFile(param1: String, param2: URLRequest, param3: String = null): AssetLoaderStruct
        {
            return this.var_2118.loadAssetFromFile(param1, param2, param3);
        }

        public function getAssetByName(param1: String): IAsset
        {
            var _loc3_: IAssetLibrary;
            var _loc4_: IAsset;
            var _loc2_: uint = this.var_2117.length;
            var _loc5_: uint;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc5_];
                _loc4_ = _loc3_.getAssetByName(param1);
                if (_loc4_ != null)
                {
                    return _loc4_;
                }

                _loc5_++;
            }

            return null;
        }

        public function getAssetsByName(param1: String): Array
        {
            var _loc3_: IAsset;
            var _loc4_: IAssetLibrary;
            var _loc2_: Array = [];
            for each (_loc4_ in this.var_2117)
            {
                _loc3_ = _loc4_.getAssetByName(param1);
                if (_loc3_ != null)
                {
                    _loc2_.push(_loc3_);
                }

            }

            return _loc2_;
        }

        public function getAssetByContent(param1: Object): IAsset
        {
            var _loc3_: IAssetLibrary;
            var _loc4_: IAsset;
            var _loc2_: uint = this.var_2117.length;
            var _loc5_: uint;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc5_];
                _loc4_ = _loc3_.getAssetByContent(param1);
                if (_loc4_ != null)
                {
                    return _loc4_;
                }

                _loc5_++;
            }

            return null;
        }

        public function getAssetByIndex(param1: uint): IAsset
        {
            var _loc2_: uint;
            var _loc3_: uint;
            var _loc4_: uint = this.var_2117.length;
            var _loc5_: uint;
            while (_loc5_ < _loc4_)
            {
                _loc2_ = _loc2_ + IAssetLibrary(this.var_2117[_loc5_]).numAssets;
                if (_loc2_ <= param1)
                {
                    return IAssetLibrary(this.var_2117[_loc5_]).getAssetByIndex(param1 - _loc3_);
                }

                _loc3_ = _loc2_;
                _loc5_++;
            }

            return null;
        }

        public function getAssetIndex(param1: IAsset): int
        {
            var _loc3_: IAssetLibrary;
            var _loc2_: uint = this.var_2117.length;
            var _loc4_: int;
            var _loc5_: int;
            var _loc6_: uint;
            while (_loc6_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc6_];
                _loc5_ = _loc3_.getAssetIndex(param1);
                if (_loc5_ != -1)
                {
                    return _loc4_ + _loc5_;
                }

                _loc4_ = _loc4_ + _loc3_.numAssets;
                _loc6_++;
            }

            return -1;
        }

        public function hasAsset(param1: String): Boolean
        {
            var _loc3_: IAssetLibrary;
            var _loc2_: uint = this.var_2117.length;
            var _loc4_: uint;
            while (_loc4_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc4_];
                if (_loc3_.hasAsset(param1))
                {
                    return true;
                }

                _loc4_++;
            }

            return false;
        }

        public function setAsset(param1: String, param2: IAsset, param3: Boolean = true): Boolean
        {
            return this.var_2118.setAsset(param1, param2, param3);
        }

        public function createAsset(param1: String, param2: AssetTypeDeclaration): IAsset
        {
            return this.var_2118.createAsset(param1, param2);
        }

        public function removeAsset(param1: IAsset): IAsset
        {
            var _loc3_: IAssetLibrary;
            var _loc2_: uint = this.var_2117.length;
            var _loc4_: uint;
            while (_loc4_ < _loc2_)
            {
                _loc3_ = this.var_2117[_loc4_];
                if (_loc3_.removeAsset(param1) == param1)
                {
                    return param1;
                }

                _loc4_++;
            }

            return null;
        }

        public function registerAssetTypeDeclaration(param1: AssetTypeDeclaration, param2: Boolean = true): Boolean
        {
            return this.var_2118.registerAssetTypeDeclaration(param1, param2);
        }

        public function getAssetTypeDeclarationByMimeType(param1: String, param2: Boolean = true): AssetTypeDeclaration
        {
            var _loc3_: uint;
            var _loc4_: IAssetLibrary;
            var _loc5_: AssetTypeDeclaration;
            var _loc6_: uint;
            if (param2)
            {
                return this.var_2118.getAssetTypeDeclarationByMimeType(param1, true);
            }

            _loc3_ = this.var_2117.length;
            _loc6_ = 0;
            while (_loc6_ < _loc3_)
            {
                _loc4_ = this.var_2117[_loc6_];
                _loc5_ = _loc4_.getAssetTypeDeclarationByMimeType(param1, false);
                if (_loc5_ != null)
                {
                    return _loc5_;
                }

                _loc6_++;
            }

            return null;
        }

        public function getAssetTypeDeclarationByClass(param1: Class, param2: Boolean = true): AssetTypeDeclaration
        {
            var _loc3_: uint;
            var _loc4_: IAssetLibrary;
            var _loc5_: AssetTypeDeclaration;
            var _loc6_: uint;
            if (param2)
            {
                return this.var_2118.getAssetTypeDeclarationByClass(param1, true);
            }

            _loc3_ = this.var_2117.length;
            _loc6_ = 0;
            while (_loc6_ < _loc3_)
            {
                _loc4_ = this.var_2117[_loc6_];
                _loc5_ = _loc4_.getAssetTypeDeclarationByClass(param1, false);
                if (_loc5_ != null)
                {
                    return _loc5_;
                }

                _loc6_++;
            }

            return null;
        }

        public function getAssetTypeDeclarationByFileName(param1: String, param2: Boolean = true): AssetTypeDeclaration
        {
            var _loc3_: uint;
            var _loc4_: IAssetLibrary;
            var _loc5_: AssetTypeDeclaration;
            var _loc6_: uint;
            if (param2)
            {
                return this.var_2118.getAssetTypeDeclarationByFileName(param1, true);
            }

            _loc3_ = this.var_2117.length;
            _loc6_ = 0;
            while (_loc6_ < _loc3_)
            {
                _loc4_ = this.var_2117[_loc6_];
                _loc5_ = _loc4_.getAssetTypeDeclarationByFileName(param1, false);
                if (_loc5_ != null)
                {
                    return _loc5_;
                }

                _loc6_++;
            }

            return null;
        }

        private function getNumAssets(): uint
        {
            var _loc1_: uint;
            var _loc2_: uint = this.var_2117.length;
            var _loc3_: uint;
            while (_loc3_ < _loc2_)
            {
                _loc1_ = _loc1_ + IAssetLibrary(this.var_2117[_loc3_]).numAssets;
                _loc3_++;
            }

            return _loc1_;
        }

        private function getAssetNameArray(): Array
        {
            var _loc1_: Array = [];
            var _loc2_: uint = this.var_2117.length;
            var _loc3_: uint;
            while (_loc3_ < _loc2_)
            {
                _loc1_ = _loc1_.concat(IAssetLibrary(this.var_2117[_loc3_]).nameArray);
                _loc3_++;
            }

            return _loc1_;
        }

        public function getManifests(): Array
        {
            var _loc1_: Array = [];
            var _loc2_: int = this.var_2117.length;
            var _loc3_: int;
            while (_loc3_ < _loc2_)
            {
                _loc1_.push(IAssetLibrary(this.var_2117[_loc3_]).manifest);
                _loc3_++;
            }

            return _loc1_;
        }

    }
}
