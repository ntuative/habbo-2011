package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.assets.loaders.BinaryFileLoader;
    import com.sulake.core.assets.loaders.BitmapFileLoader;
    import com.sulake.core.assets.loaders.ZipFileLoader;
    import com.sulake.core.assets.loaders.SoundFileLoader;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.assets.loaders.IAssetLoader;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.assets.loaders.*;

    public class AssetLibrary extends EventDispatcher implements IAssetLibrary 
    {

        public static const var_332:String = "AssetLibraryReady";
        public static const var_333:String = "AssetLibraryLoaded";
        public static const var_334:String = "AssetLibraryUnloaded";
        public static const var_335:String = "AssetLibraryLoadError";
        private static const var_341:String = "name";
        private static const var_340:String = "asset";
        private static const var_342:String = "param";
        private static const TYPE:String = "mimeType";
        private static const var_339:String = "library";
        private static var var_336:Dictionary;
        private static var var_343:LazyAssetProcessor = new LazyAssetProcessor();
        private static var var_337:uint = 0;
        private static var var_338:Array = new Array();

        private var _name:String;
        private var var_2107:String;
        private var _manifest:XML;
        private var var_2108:Boolean;
        private var var_2109:uint;
        private var var_2103:LibraryLoader;
        private var var_2111:Class;
        private var var_2112:Dictionary;
        private var var_2113:Dictionary;
        private var var_2114:Boolean = true;
        private var var_2115:Dictionary;
        private var var_2110:Array;
        private var var_2116:Dictionary;

        public function AssetLibrary(param1:String)
        {
            this._name = param1;
            this._manifest = new XML();
            this.var_2109 = 0;
            this.var_2110 = new Array();
            if (var_336 == null)
            {
                var_336 = new Dictionary(false);
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/octet-stream", UnknownAsset, BinaryFileLoader));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-shockwave-flash", DisplayAsset, BitmapFileLoader, "swf"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-font-truetype", FontAsset, BinaryFileLoader, "ttf", "otf"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("application/zip", UnknownAsset, ZipFileLoader, "zip"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("text/xml", XmlAsset, BinaryFileLoader, "xml"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("text/html", XmlAsset, BinaryFileLoader, "htm", "html"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("text/plain", TextAsset, BinaryFileLoader, "txt"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/jpeg", BitmapDataAsset, BitmapFileLoader, "jpg", "jpeg"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/gif", BitmapDataAsset, BitmapFileLoader, "gif"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/png", BitmapDataAsset, BitmapFileLoader, "png"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("image/tiff", BitmapDataAsset, BitmapFileLoader, "tif", "tiff"));
                this.registerAssetTypeDeclaration(new AssetTypeDeclaration("sound/mp3", SoundAsset, SoundFileLoader, "mp3"));
            };
            var_337++;
            this.var_2116 = new Dictionary(false);
            this.var_2115 = new Dictionary(false);
            this.var_2112 = new Dictionary(false);
            this.var_2113 = new Dictionary(false);
            var_338.push(this);
        }

        public static function get numAssetLibraryInstances():uint
        {
            return (var_337);
        }

        public static function get assetLibraryRefArray():Array
        {
            return (var_338);
        }

        private static function fetchLibraryContents(param1:AssetLibrary, param2:XML, param3:Class):Boolean
        {
            var _loc6_:XML;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:AssetTypeDeclaration;
            var _loc10_:IAsset;
            var _loc11_:XMLList;
            var _loc12_:int;
            var _loc13_:AssetTypeDeclaration;
            var _loc14_:String;
            var _loc15_:uint;
            var _loc4_:int = getTimer();
            if (param3 == null)
            {
                throw (new Error((("Library " + param1.var_2107) + " doesn't contain valid resource class!")));
            };
            var _loc5_:XMLList = param2.child(var_339);
            if (_loc5_ == null)
            {
                throw (Error("Provided manifest doesn't contain library node!"));
            };
            _loc5_ = _loc5_[0].assets;
            if (_loc5_ != null)
            {
                _loc5_ = _loc5_.child(var_340);
                _loc12_ = _loc5_.length();
                _loc14_ = null;
                _loc15_ = 0;
                while (_loc15_ < _loc12_)
                {
                    _loc6_ = _loc5_[_loc15_];
                    _loc7_ = _loc6_.attribute(var_341);
                    _loc8_ = _loc6_.attribute(TYPE);
                    if (_loc8_ == _loc14_)
                    {
                        _loc9_ = _loc13_;
                    }
                    else
                    {
                        _loc9_ = param1.getAssetTypeDeclarationByMimeType(_loc8_);
                        _loc14_ = _loc8_;
                        _loc13_ = _loc9_;
                    };
                    if (_loc9_ != null)
                    {
                        _loc10_ = (new (_loc9_.assetClass)(_loc9_) as IAsset);
                        _loc10_.setUnknownContent(param3[_loc7_]);
                        _loc11_ = _loc6_.child(var_342);
                        if (_loc11_.length())
                        {
                            _loc10_.setParamsDesc(_loc11_);
                        };
                        param1.setAsset(_loc7_, _loc10_);
                    }
                    else
                    {
                        Logger.log((((("Failed to extract asset " + _loc7_) + " from Library ") + param1.var_2107) + "!"));
                    };
                    _loc15_++;
                };
            };
            _loc4_ = (getTimer() - _loc4_);
            return (true);
        }

        public function get url():String
        {
            return (this.var_2107);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get isReady():Boolean
        {
            return (this.var_2108);
        }

        public function get manifest():XML
        {
            return (this._manifest);
        }

        public function get numAssets():uint
        {
            return (this.var_2109);
        }

        public function get nameArray():Array
        {
            return (this.var_2110);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                this.unload();
                super.dispose();
                var_338.splice(var_338.indexOf(this), 1);
                var_337--;
                this.var_2115 = null;
                this.var_2112 = null;
                this.var_2113 = null;
                this.var_2110 = null;
                this._manifest = null;
                this.var_2109 = 0;
                this.var_2108 = false;
                this._name = null;
            };
        }

        public function loadFromFile(param1:LibraryLoader, param2:Boolean=true):void
        {
            if (((this.var_2107 == param1.url) && (this.var_2108)))
            {
                if (((!(this.var_2114)) && (param2)))
                {
                    AssetLibrary.fetchLibraryContents(this, this._manifest, this.var_2111);
                };
                this.var_2114 = param2;
                dispatchEvent(new Event(AssetLibrary.var_332));
            }
            else
            {
                if (((this.var_2103 == null) || (this.var_2103.disposed)))
                {
                    this.var_2103 = param1;
                    this.var_2103.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                    this.var_2103.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                };
                this.var_2114 = param2;
                this.var_2107 = this.var_2103.url;
            };
        }

        public function loadFromResource(param1:XML, param2:Class):Boolean
        {
            return (AssetLibrary.fetchLibraryContents(this, param1, param2));
        }

        public function unload():void
        {
            var _loc1_:String;
            var _loc2_:AssetLoaderStruct;
            for (_loc1_ in this.var_2115)
            {
                _loc2_ = this.var_2115[_loc1_];
                _loc2_.assetLoader.dispose();
                delete this.var_2115[_loc1_];
            };
            for (_loc1_ in this.var_2113)
            {
                delete this.var_2113[_loc1_];
            };
            for (_loc1_ in this.var_2112)
            {
                delete this.var_2112[_loc1_];
            };
            if (this.var_2103 != null)
            {
                this.var_2103.dispose();
                this.var_2103 = null;
            };
            this.var_2109 = 0;
            this.var_2108 = false;
            this.var_2107 = null;
            dispatchEvent(new Event(AssetLibrary.var_334));
        }

        public function getClass(param1:String):Class
        {
            var _loc2_:Class = this.var_2112[param1];
            if (_loc2_ != null)
            {
                return (_loc2_);
            };
            if (this.var_2103 != null)
            {
                if (this.var_2103.hasDefinition(param1))
                {
                    _loc2_ = (this.var_2103.getDefinition(param1) as Class);
                    if (_loc2_ != null)
                    {
                        this.var_2112[param1] = _loc2_;
                        return (_loc2_);
                    };
                };
            };
            return (null);
        }

        public function loadAssetFromFile(param1:String, param2:URLRequest, param3:String=null):AssetLoaderStruct
        {
            var _loc5_:AssetTypeDeclaration;
            if (this.getAssetByName(param1) != null)
            {
                throw (new Error((("Asset with name " + param1) + " already exists!")));
            };
            var _loc4_:AssetLoaderStruct = this.var_2115[param2.url];
            if (_loc4_ != null)
            {
                if (_loc4_.assetName == param1)
                {
                    return (_loc4_);
                };
            };
            if (param3 == null)
            {
                _loc5_ = this.solveAssetTypeDeclarationFromUrl(param2.url);
                if (_loc5_ == null)
                {
                    throw (new Error((("Couldn't solve asset type for file " + param2.url) + "!")));
                };
            }
            else
            {
                _loc5_ = this.getAssetTypeDeclarationByMimeType(param3, true);
                if (_loc5_ == null)
                {
                    throw (new Error((("Asset type declaration for mime type " + param3) + "not found!")));
                };
            };
            var _loc6_:IAssetLoader = new (_loc5_.loaderClass)(_loc5_.mimeType, param2);
            if (_loc6_ == null)
            {
                throw (new Error((("Invalid file loader class defined for mime type " + param3) + "!")));
            };
            _loc6_.addEventListener(AssetLoaderEvent.var_35, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_36, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_89, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_88, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_90, this.assetLoadEventHandler);
            _loc6_.addEventListener(AssetLoaderEvent.var_91, this.assetLoadEventHandler);
            _loc4_ = new AssetLoaderStruct(param1, _loc6_);
            this.var_2115[param2.url] = _loc4_;
            return (_loc4_);
        }

        private function assetLoadEventHandler(e:AssetLoaderEvent):void
        {
            var loader:IAssetLoader;
            var type:String;
            var decl:AssetTypeDeclaration;
            var asset:IAsset;
            var remove:Boolean;
            loader = (e.target as IAssetLoader);
            if (loader == null)
            {
                throw (new Error("Failed to downcast object to asset loader!"));
            };
            var struct:AssetLoaderStruct = this.var_2115[loader.url];
            if (struct == null)
            {
                throw (new Error(("Asset loader structure was lost! " + ((loader) ? loader.url : ""))));
            };
            switch (e.type)
            {
                case AssetLoaderEvent.var_35:
                    type = loader.mimeType;
                    decl = this.getAssetTypeDeclarationByMimeType(type);
                    remove = true;
                    if (decl != null)
                    {
                        asset = new (decl.assetClass)(decl, loader.url);
                        try
                        {
                            asset.setUnknownContent(loader.content);
                        }
                        catch(error:Error)
                        {
                            asset.dispose();
                            Logger.log(((((((('Failed to build asset from loaded file "' + loader.url) + '" type: ') + type) + " error: ") + error.name) + " / ") + error.message));
                            e = new AssetLoaderEvent(AssetLoaderEvent.var_36, e.status);
                            break;
                        };
                        if (this.var_2113[struct.assetName] == null)
                        {
                            this.var_2109++;
                            this.var_2110.push(struct.assetName);
                        };
                        this.var_2113[struct.assetName] = asset;
                    }
                    else
                    {
                        Logger.log(((('Failed to resolve asset type declaration: "' + loader.url) + '" type: ') + type));
                        e = new AssetLoaderEvent(AssetLoaderEvent.var_36, e.status);
                    };
                    break;
                case AssetLoaderEvent.var_36:
                    remove = true;
                    Logger.log(((('Failed to download file "' + loader.url) + '" error: ') + loader.errorCode));
                    break;
            };
            struct.dispatchEvent(new AssetLoaderEvent(e.type, e.status));
            if (remove)
            {
                if (((!(_disposed)) && (loader)))
                {
                    delete this.var_2115[loader.url];
                };
                if (struct)
                {
                    struct.dispose();
                };
            };
        }

        public function getAssetByName(param1:String):IAsset
        {
            var _loc2_:IAsset = this.var_2113[param1];
            if (_loc2_ != null)
            {
                return (_loc2_);
            };
            if (this.var_2114)
            {
                return (null);
            };
            return (this.fetchAssetFromResource(param1));
        }

        public function getAssetByIndex(param1:uint):IAsset
        {
            return ((param1 < this.var_2110.length) ? this.getAssetByName(this.var_2110[param1]) : null);
        }

        public function getAssetByContent(param1:Object):IAsset
        {
            var _loc2_:String;
            var _loc3_:IAsset;
            for (_loc2_ in this.var_2113)
            {
                _loc3_ = this.var_2113[_loc2_];
                if (_loc3_.content === param1)
                {
                    return (_loc3_);
                };
            };
            return (null);
        }

        public function getAssetIndex(param1:IAsset):int
        {
            var _loc2_:String;
            for (_loc2_ in this.var_2113)
            {
                if (this.var_2113[_loc2_] == param1)
                {
                    return (this.var_2110.indexOf(_loc2_));
                };
            };
            return (-1);
        }

        public function hasAsset(param1:String):Boolean
        {
            return ((!(this.var_2113[param1] == null)) || ((this.var_2111 != null) ? (!(this.var_2111[param1] == null)) : false));
        }

        public function setAsset(param1:String, param2:IAsset, param3:Boolean=true):Boolean
        {
            var _loc4_:* = (this.var_2113[param1] == null);
            if ((((param3) || (_loc4_)) && (param2)))
            {
                if (_loc4_)
                {
                    this.var_2109++;
                    this.var_2110.push(param1);
                };
                this.var_2113[param1] = param2;
                if ((param2 is ILazyAsset))
                {
                    var_343.push((param2 as ILazyAsset));
                };
                return (true);
            };
            return (false);
        }

        public function createAsset(param1:String, param2:AssetTypeDeclaration):IAsset
        {
            if (((this.hasAsset(param1)) || (!(param2))))
            {
                return (null);
            };
            var _loc3_:IAsset = new (param2.assetClass)(param2);
            if (!this.setAsset(param1, _loc3_))
            {
                _loc3_.dispose();
                _loc3_ = null;
            };
            return (_loc3_);
        }

        public function removeAsset(param1:IAsset):IAsset
        {
            var _loc2_:String;
            if (param1)
            {
                for (_loc2_ in this.var_2113)
                {
                    if (this.var_2113[_loc2_] == param1)
                    {
                        this.var_2110.splice(this.var_2110.indexOf(_loc2_), 1);
                        delete this.var_2113[_loc2_];
                        this.var_2109--;
                        return (param1);
                    };
                };
            };
            return (null);
        }

        public function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean=true):Boolean
        {
            if (param2)
            {
                if (var_336.hasOwnProperty(param1.mimeType))
                {
                    throw (new Error((("Asset type " + param1.mimeType) + " already registered!")));
                };
                var_336[param1.mimeType] = param1;
            }
            else
            {
                if (this.var_2116.hasOwnProperty(param1.mimeType))
                {
                    throw (new Error((("Asset type " + param1.mimeType) + " already registered!")));
                };
                this.var_2116[param1.mimeType] = param1;
            };
            return (true);
        }

        public function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean=true):AssetTypeDeclaration
        {
            var _loc3_:AssetTypeDeclaration;
            if (param2)
            {
                _loc3_ = AssetTypeDeclaration(var_336[param1]);
                if (_loc3_ != null)
                {
                    return (_loc3_);
                };
            };
            return (AssetTypeDeclaration(this.var_2116[param1]));
        }

        public function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean=true):AssetTypeDeclaration
        {
            var _loc3_:AssetTypeDeclaration;
            var _loc4_:String;
            if (param2)
            {
                for (_loc4_ in var_336)
                {
                    _loc3_ = AssetTypeDeclaration(var_336[_loc4_]);
                    if (_loc3_ != null)
                    {
                        if (_loc3_.assetClass == param1)
                        {
                            return (_loc3_);
                        };
                    };
                };
            };
            for (_loc4_ in this.var_2116)
            {
                _loc3_ = AssetTypeDeclaration(this.var_2116[_loc4_]);
                if (_loc3_ != null)
                {
                    if (_loc3_.assetClass == param1)
                    {
                        return (_loc3_);
                    };
                };
            };
            return (null);
        }

        public function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean=true):AssetTypeDeclaration
        {
            var _loc4_:AssetTypeDeclaration;
            var _loc5_:String;
            var _loc3_:String = param1.substr((param1.lastIndexOf(".") + 1), param1.length);
            if (_loc3_.indexOf("?"))
            {
                _loc3_ = _loc3_.substr(0, (_loc3_.indexOf("?") - 1));
            };
            if (param2)
            {
                for (_loc5_ in var_336)
                {
                    _loc4_ = AssetTypeDeclaration(var_336[_loc5_]);
                    if (_loc4_ != null)
                    {
                        if (_loc4_.fileTypes.indexOf(_loc3_))
                        {
                            return (_loc4_);
                        };
                    };
                };
            };
            for (_loc5_ in this.var_2116)
            {
                _loc4_ = AssetTypeDeclaration(this.var_2116[_loc5_]);
                if (_loc4_ != null)
                {
                    if (_loc4_.fileTypes.indexOf(_loc3_))
                    {
                        return (_loc4_);
                    };
                };
            };
            return (null);
        }

        private function libraryLoadedHandler(param1:LibraryLoaderEvent):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            if (_loc2_.manifest == null)
            {
                throw (new Error("loader.manifest was null, which would have caused error 1009 anyway. See HL-22347."));
            };
            this._manifest = _loc2_.manifest.copy();
            this.var_2111 = _loc2_.resource;
            this.var_2107 = _loc2_.url;
            if (this.var_2114)
            {
                AssetLibrary.fetchLibraryContents(this, this._manifest, this.var_2111);
            };
            this.var_2108 = true;
            dispatchEvent(new Event(AssetLibrary.var_333));
            dispatchEvent(new Event(AssetLibrary.var_332));
            if (this.var_2114)
            {
                this.var_2103.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                this.var_2103.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                this.var_2103.addEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                this.var_2103 = null;
                this.var_2111 = null;
            };
        }

        private function finalizeLoaderEventHandler(param1:Event):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            if (((_loc2_) && (!(_loc2_.disposed))))
            {
                if (!_loc2_.hasEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE))
                {
                    _loc2_.removeEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                    _loc2_.dispose();
                };
            };
        }

        private function onLoadProgress(param1:ProgressEvent):void
        {
            dispatchEvent(param1.clone());
        }

        private function loadErrorHandler(param1:LibraryLoaderEvent):void
        {
            this.var_2108 = false;
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            var _loc3_:String = ((_loc2_) ? _loc2_.name : "unknown");
            Logger.log(((("Cannot load the specified file: " + _loc3_) + " ") + param1.status));
            dispatchEvent(new Event(AssetLibrary.var_335));
            this.var_2103 = null;
        }

        private function solveAssetTypeDeclarationFromUrl(param1:String):AssetTypeDeclaration
        {
            var _loc2_:int;
            var _loc3_:AssetTypeDeclaration;
            var _loc4_:Array;
            var _loc5_:String;
            _loc2_ = param1.indexOf("?", 0);
            if (_loc2_ > 0)
            {
                param1 = param1.slice(0, _loc2_);
            };
            _loc2_ = param1.lastIndexOf(".");
            if (_loc2_ == -1)
            {
                return (null);
            };
            param1 = param1.slice((_loc2_ + 1), param1.length);
            for (_loc5_ in this.var_2116)
            {
                _loc3_ = this.var_2116[_loc5_];
                _loc4_ = _loc3_.fileTypes;
                if (_loc4_ != null)
                {
                    if (_loc4_.indexOf(param1, 0) > -1)
                    {
                        return (_loc3_);
                    };
                };
            };
            for (_loc5_ in var_336)
            {
                _loc3_ = var_336[_loc5_];
                _loc4_ = _loc3_.fileTypes;
                if (_loc4_ != null)
                {
                    if (_loc4_.indexOf(param1, 0) > -1)
                    {
                        return (_loc3_);
                    };
                };
            };
            return (null);
        }

        private function fetchAssetFromResource(param1:String):IAsset
        {
            var _loc3_:XML;
            var _loc4_:AssetTypeDeclaration;
            var _loc5_:IAsset;
            var _loc6_:XMLList;
            var _loc7_:int;
            var _loc8_:uint;
            if (!this.var_2111)
            {
                return (null);
            };
            var _loc2_:XMLList = this._manifest.child(var_339);
            if (_loc2_ == null)
            {
                throw (new Error("Provided manifest doesn't contain library node!"));
            };
            if (_loc2_.length() == 0)
            {
                return (null);
            };
            _loc2_ = _loc2_[0].assets;
            if (_loc2_ != null)
            {
                _loc2_ = _loc2_.child(var_340);
                _loc5_ = null;
                _loc7_ = _loc2_.length();
                _loc8_ = 0;
                while (_loc8_ < _loc7_)
                {
                    _loc3_ = _loc2_[_loc8_];
                    if (_loc3_.attribute(var_341).toString() == param1)
                    {
                        _loc4_ = this.getAssetTypeDeclarationByMimeType(_loc3_.attribute(TYPE));
                        if (_loc4_ == null)
                        {
                            throw (new Error((((("Failed to extract asset " + param1) + " from Library ") + this.var_2107) + "!")));
                        };
                        _loc5_ = (new (_loc4_.assetClass)(_loc4_) as IAsset);
                        _loc5_.setUnknownContent(this.var_2111[param1]);
                        _loc6_ = _loc3_.child(var_342);
                        if (_loc6_.length())
                        {
                            _loc5_.setParamsDesc(_loc6_);
                        };
                        this.setAsset(param1, _loc5_);
                        return (_loc5_);
                    };
                    _loc8_++;
                };
            };
            return (null);
        }

        public function toString():String
        {
            return ((getQualifiedClassName(this) + ": ") + this._name);
        }

    }
}