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

        public static const ASSET_LIBRARY_READY: String = "AssetLibraryReady";
        public static const ASSET_LIBRARY_LOADED: String = "AssetLibraryLoaded";
        public static const ASSET_LIBRARY_UNLOADED: String = "AssetLibraryUnloaded";
        public static const ASSET_LIBRARY_LOAD_ERROR: String = "AssetLibraryLoadError";

        private static const NAME: String = "name";
        private static const ASSET: String = "asset";
        private static const PARAM: String = "param";
        private static const TYPE: String = "mimeType";
        private static const LIBRARY: String = "library";

        private static var AssetTypes: Dictionary;
        private static var AssetProcessor: LazyAssetProcessor = new LazyAssetProcessor();
        private static var NumAssetLibraryInstances: uint = 0;
        private static var AssetLibraryRefArray: Array = [];

        private var _name: String;
        private var _url: String;
        private var _manifest: XML;
        private var _isReady: Boolean;
        private var _numAssets: uint;
        private var _loader: LibraryLoader;
        private var _resource: Class;
        private var _classes: Dictionary;
        private var _assets: Dictionary;
        private var _loaded: Boolean = true;
        private var _assetLoaders: Dictionary;
        private var _nameArray: Array;
        private var _assetTypes: Dictionary;

        public function AssetLibrary(name: String)
        {
            this._name = name;
            this._manifest = new XML();
            this._numAssets = 0;
            this._nameArray = [];

            if (AssetTypes == null)
            {
                AssetTypes = new Dictionary(false);

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
            }


            NumAssetLibraryInstances++;

            this._assetTypes = new Dictionary(false);
            this._assetLoaders = new Dictionary(false);
            this._classes = new Dictionary(false);
            this._assets = new Dictionary(false);

            AssetLibraryRefArray.push(this);
        }

        public static function get numAssetLibraryInstances(): uint
        {
            return NumAssetLibraryInstances;
        }

        public static function get assetLibraryRefArray(): Array
        {
            return AssetLibraryRefArray;
        }

        private static function fetchLibraryContents(library: AssetLibrary, param2: XML, resource: Class): Boolean
        {
            var asset: IAsset;
            var startedAt: int = getTimer();

            if (resource == null)
            {
                throw new Error("Library " + library._url + " doesn't contain valid resource class!");
            }


            var items: XMLList = param2.child(LIBRARY);

            if (items == null)
            {
                throw Error("Provided manifest doesn't contain library node!");
            }


            items = items[0].assets;

            if (items != null)
            {
                items = items.child(ASSET);
                var assetCount: int = items.length();

                for (var i: int = 0; i < assetCount; i++)
                {
                    var item: XML = items[i];
                    var name: String = item.attribute(NAME);
                    var type: String = item.attribute(TYPE);
                    var assetType: AssetTypeDeclaration = null;

                    if (type != null)
                    {
                        assetType = library.getAssetTypeDeclarationByMimeType(type);
                    }

                    if (assetType != null)
                    {
                        asset = new assetType.assetClass(assetType) as IAsset;
                        asset.setUnknownContent(resource[name]);
                        var params: XMLList = item.child(PARAM);

                        if (params.length())
                        {
                            asset.setParamsDesc(params);
                        }


                        library.setAsset(name, asset);
                    }
                    else
                    {
                        Logger.log("Failed to extract asset " + name + " from Library " + library._url + "!");
                    }

                }

            }


            startedAt = getTimer() - startedAt;

            return true;
        }

        public function get url(): String
        {
            return this._url;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get isReady(): Boolean
        {
            return this._isReady;
        }

        public function get manifest(): XML
        {
            return this._manifest;
        }

        public function get numAssets(): uint
        {
            return this._numAssets;
        }

        public function get nameArray(): Array
        {
            return this._nameArray;
        }

        override public function dispose(): void
        {
            if (!disposed)
            {
                this.unload();
                super.dispose();

                AssetLibraryRefArray.splice(AssetLibraryRefArray.indexOf(this), 1);
                NumAssetLibraryInstances--;
                this._assetLoaders = null;
                this._classes = null;
                this._assets = null;
                this._nameArray = null;
                this._manifest = null;
                this._numAssets = 0;
                this._isReady = false;
                this._name = null;
            }

        }

        public function loadFromFile(loader: LibraryLoader, fetchContents: Boolean = true): void
        {
            if (this._url == loader.url && this._isReady)
            {
                if (!this._loaded && fetchContents)
                {
                    AssetLibrary.fetchLibraryContents(this, this._manifest, this._resource);
                }


                this._loaded = fetchContents;

                dispatchEvent(new Event(AssetLibrary.ASSET_LIBRARY_READY));
            }
            else
            {
                if (this._loader == null || this._loader.disposed)
                {
                    this._loader = loader;
                    this._loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                    this._loader.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                }


                this._loaded = fetchContents;
                this._url = this._loader.url;
            }

        }

        public function loadFromResource(param1: XML, param2: Class): Boolean
        {
            return AssetLibrary.fetchLibraryContents(this, param1, param2);
        }

        public function unload(): void
        {
            var item: String;
            var asset: AssetLoaderStruct;

            for (item in this._assetLoaders)
            {
                asset = this._assetLoaders[item];
                asset.assetLoader.dispose();
                this._assetLoaders[item] = null;
            }


            for (item in this._assets)
            {
                this._assets[item] = null;
            }


            for (item in this._classes)
            {
                this._classes[item] = null;
            }


            if (this._loader != null)
            {
                this._loader.dispose();
                this._loader = null;
            }


            this._numAssets = 0;
            this._isReady = false;
            this._url = null;

            dispatchEvent(new Event(AssetLibrary.ASSET_LIBRARY_UNLOADED));
        }

        public function getClass(id: String): Class
        {
            var cls: Class = this._classes[id];

            if (cls != null)
            {
                return cls;
            }


            if (this._loader != null)
            {
                if (this._loader.hasDefinition(id))
                {
                    cls = this._loader.getDefinition(id) as Class;

                    if (cls != null)
                    {
                        this._classes[id] = cls;
                        return cls;
                    }

                }

            }


            return null;
        }

        public function loadAssetFromFile(name: String, location: URLRequest, mimeType: String = null): AssetLoaderStruct
        {
            var assetType: AssetTypeDeclaration;

            if (this.getAssetByName(name) != null)
            {
                throw new Error("Asset with name " + name + " already exists!");
            }


            var asset: AssetLoaderStruct = this._assetLoaders[location.url];

            if (asset != null)
            {
                if (asset.assetName == name)
                {
                    return asset;
                }

            }


            if (mimeType == null)
            {
                assetType = this.solveAssetTypeDeclarationFromUrl(location.url);

                if (assetType == null)
                {
                    throw new Error("Couldn't solve asset type for file " + location.url + "!");
                }

            }
            else
            {
                assetType = this.getAssetTypeDeclarationByMimeType(mimeType, true);

                if (assetType == null)
                {
                    throw new Error("Asset type declaration for mime type " + mimeType + "not found!");
                }

            }


            var loader: IAssetLoader = new assetType.loaderClass(assetType.mimeType, location);

            if (loader == null)
            {
                throw new Error("Invalid file loader class defined for mime type " + mimeType + "!");
            }


            loader.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.assetLoadEventHandler);
            loader.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.assetLoadEventHandler);
            loader.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_UNLOAD, this.assetLoadEventHandler);
            loader.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_PROGRESS, this.assetLoadEventHandler);
            loader.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_STATUS, this.assetLoadEventHandler);
            loader.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_OPEN, this.assetLoadEventHandler);

            asset = new AssetLoaderStruct(name, loader);

            this._assetLoaders[location.url] = asset;

            return asset;
        }

        private function assetLoadEventHandler(e: AssetLoaderEvent): void
        {
            var loader: IAssetLoader;
            var type: String;
            var decl: AssetTypeDeclaration;
            var asset: IAsset;
            var remove: Boolean;
            loader = (e.target as IAssetLoader);
            if (loader == null)
            {
                throw new Error("Failed to downcast object to asset loader!");
            }

            var struct: AssetLoaderStruct = this._assetLoaders[loader.url];

            if (struct == null)
            {
                throw new Error("Asset loader structure was lost! " + (loader ? loader.url : ""));
            }


            switch (e.type)
            {
                case AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE:
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
                        catch (error: Error)
                        {
                            asset.dispose();
                            Logger.log("Failed to build asset from loaded file \"" + loader.url + "\" type: " + type + " error: " + error.name + " / " + error.message);
                            e = new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, e.status);
                            break;
                        }


                        if (this._assets[struct.assetName] == null)
                        {
                            this._numAssets++;
                            this._nameArray.push(struct.assetName);
                        }


                        this._assets[struct.assetName] = asset;
                    }
                    else
                    {
                        Logger.log("Failed to resolve asset type declaration: \"" + loader.url + "\" type: " + type);
                        e = new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, e.status);
                    }


                    break;

                case AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR:
                    remove = true;
                    Logger.log("Failed to download file \"" + loader.url + "\" error: " + loader.errorCode);
                    break;
            }


            struct.dispatchEvent(new AssetLoaderEvent(e.type, e.status));

            if (remove)
            {
                if (!_disposed && loader != null)
                {
                    this._assetLoaders[loader.url] = null;
                }


                if (struct)
                {
                    struct.dispose();
                }

            }

        }

        public function getAssetByName(name: String): IAsset
        {
            var asset: IAsset = this._assets[name];

            if (asset != null)
            {
                return asset;
            }


            if (this._loaded)
            {
                return null;
            }


            return this.fetchAssetFromResource(name);
        }

        public function getAssetByIndex(index: uint): IAsset
        {
            if (index < this._nameArray.length)
            {
                return this.getAssetByName(this._nameArray[index]);
            }

            return null;
        }

        public function getAssetByContent(content: Object): IAsset
        {
            var key: String;
            var asset: IAsset;

            for (key in this._assets)
            {
                asset = this._assets[key];

                if (asset.content === content)
                {
                    return asset;
                }

            }


            return null;
        }

        public function getAssetIndex(asset: IAsset): int
        {
            var key: String;
            for (key in this._assets)
            {
                if (this._assets[key] == asset)
                {
                    return this._nameArray.indexOf(key);
                }

            }


            return -1;
        }

        public function hasAsset(name: String): Boolean
        {
            if (this._assets[name] != null)
            {
                return true;
            }

            return this._resource != null && this._resource[name] != null;


        }

        public function setAsset(param1: String, param2: IAsset, param3: Boolean = true): Boolean
        {
            var _loc4_: * = this._assets[param1] == null;
            if ((param3 || _loc4_) && param2)
            {
                if (_loc4_)
                {
                    this._numAssets++;
                    this._nameArray.push(param1);
                }

                this._assets[param1] = param2;
                if (param2 is ILazyAsset)
                {
                    AssetProcessor.push(param2 as ILazyAsset);
                }

                return true;
            }

            return false;
        }

        public function createAsset(param1: String, param2: AssetTypeDeclaration): IAsset
        {
            if (this.hasAsset(param1) || !param2)
            {
                return null;
            }

            var _loc3_: IAsset = new (param2.assetClass)(param2);
            if (!this.setAsset(param1, _loc3_))
            {
                _loc3_.dispose();
                _loc3_ = null;
            }

            return _loc3_;
        }

        public function removeAsset(param1: IAsset): IAsset
        {
            var _loc2_: String;
            if (param1)
            {
                for (_loc2_ in this._assets)
                {
                    if (this._assets[_loc2_] == param1)
                    {
                        this._nameArray.splice(this._nameArray.indexOf(_loc2_), 1);
                        this._assets[_loc2_] = null;
                        this._numAssets--;
                        return param1;
                    }

                }

            }

            return null;
        }

        public function registerAssetTypeDeclaration(assetType: AssetTypeDeclaration, global: Boolean = true): Boolean
        {
            if (global)
            {
                if (AssetTypes.hasOwnProperty(assetType.mimeType))
                {
                    throw new Error("Asset type " + assetType.mimeType + " already registered!");
                }


                AssetTypes[assetType.mimeType] = assetType;
            }
            else
            {
                if (this._assetTypes.hasOwnProperty(assetType.mimeType))
                {
                    throw new Error("Asset type " + assetType.mimeType + " already registered!");
                }


                this._assetTypes[assetType.mimeType] = assetType;
            }


            return true;
        }

        public function getAssetTypeDeclarationByMimeType(type: String, global: Boolean = true): AssetTypeDeclaration
        {
            if (global)
            {
                var assetType: AssetTypeDeclaration = AssetTypeDeclaration(AssetTypes[type]);

                if (assetType != null)
                {
                    return assetType;
                }

            }


            return AssetTypeDeclaration(this._assetTypes[type]);
        }

        public function getAssetTypeDeclarationByClass(assetClass: Class, global: Boolean = true): AssetTypeDeclaration
        {
            var assetType: AssetTypeDeclaration;
            var type: String;
            if (global)
            {
                for (type in AssetTypes)
                {
                    assetType = AssetTypeDeclaration(AssetTypes[type]);
                    if (assetType != null)
                    {
                        if (assetType.assetClass == assetClass)
                        {
                            return assetType;
                        }

                    }

                }

            }


            for (type in this._assetTypes)
            {
                assetType = AssetTypeDeclaration(this._assetTypes[type]);
                if (assetType != null)
                {
                    if (assetType.assetClass == assetClass)
                    {
                        return assetType;
                    }

                }

            }


            return null;
        }

        public function getAssetTypeDeclarationByFileName(url: String, global: Boolean = true): AssetTypeDeclaration
        {
            var assetType: AssetTypeDeclaration;
            var type: String;

            var filename: String = url.substr(url.lastIndexOf(".") + 1, url.length);

            if (filename.indexOf("?"))
            {
                filename = filename.substr(0, filename.indexOf("?") - 1);
            }


            if (global)
            {
                for (type in AssetTypes)
                {
                    assetType = AssetTypeDeclaration(AssetTypes[type]);
                    if (assetType != null)
                    {
                        if (assetType.fileTypes.indexOf(filename))
                        {
                            return assetType;
                        }

                    }

                }

            }


            for (type in this._assetTypes)
            {
                assetType = AssetTypeDeclaration(this._assetTypes[type]);
                if (assetType != null)
                {
                    if (assetType.fileTypes.indexOf(filename))
                    {
                        return assetType;
                    }

                }

            }


            return null;
        }

        private function libraryLoadedHandler(loaderEvent: LibraryLoaderEvent): void
        {
            var loader: LibraryLoader = loaderEvent.target as LibraryLoader;

            if (loader.manifest == null)
            {
                throw new Error("loader.manifest was null, which would have caused error 1009 anyway. See HL-22347.");
            }


            this._manifest = loader.manifest.copy();
            this._resource = loader.resource;
            this._url = loader.url;

            if (this._loaded)
            {
                AssetLibrary.fetchLibraryContents(this, this._manifest, this._resource);
            }


            this._isReady = true;
            dispatchEvent(new Event(AssetLibrary.ASSET_LIBRARY_LOADED));
            dispatchEvent(new Event(AssetLibrary.ASSET_LIBRARY_READY));

            if (this._loaded)
            {
                this._loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.libraryLoadedHandler);
                this._loader.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.loadErrorHandler);
                this._loader.addEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                this._loader = null;
                this._resource = null;
            }

        }

        private function finalizeLoaderEventHandler(event: Event): void
        {
            var loader: LibraryLoader = event.target as LibraryLoader;

            if (loader && !loader.disposed)
            {
                if (!loader.hasEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE))
                {
                    loader.removeEventListener(LibraryLoader.LIBRARY_LOADER_FINALIZE, this.finalizeLoaderEventHandler);
                    loader.dispose();
                }

            }

        }

        private function onLoadProgress(progressEvent: ProgressEvent): void
        {
            dispatchEvent(progressEvent.clone());
        }

        private function loadErrorHandler(loaderEvent: LibraryLoaderEvent): void
        {
            this._isReady = false;

            var loader: LibraryLoader = loaderEvent.target as LibraryLoader;
            var name: String = loader ? loader.name : "unknown";

            Logger.log("Cannot load the specified file: " + name + " " + loaderEvent.status);
            dispatchEvent(new Event(AssetLibrary.ASSET_LIBRARY_LOAD_ERROR));

            this._loader = null;
        }

        private function solveAssetTypeDeclarationFromUrl(url: String): AssetTypeDeclaration
        {
            var index: int;
            var item: AssetTypeDeclaration;
            var fileTypes: Array;
            var key: String;

            // Remove queryParams
            index = url.indexOf("?", 0);
            if (index > 0)
            {
                url = url.slice(0, index);
            }


            // Retrieve file type seperator index
            index = url.lastIndexOf(".");
            if (index == -1)
            {
                return null;
            }


            // Slice the url to just the file extension
            url = url.slice(index + 1, url.length);

            for (key in this._assetTypes)
            {
                item = this._assetTypes[key];
                fileTypes = item.fileTypes;

                if (fileTypes != null)
                {
                    if (fileTypes.indexOf(url, 0) > -1)
                    {
                        return item;
                    }

                }

            }


            for (key in AssetTypes)
            {
                item = AssetTypes[key];
                fileTypes = item.fileTypes;

                if (fileTypes != null)
                {
                    if (fileTypes.indexOf(url, 0) > -1)
                    {
                        return item;
                    }

                }

            }


            return null;
        }

        private function fetchAssetFromResource(assetName: String): IAsset
        {
            var item: XML;

            if (!this._resource)
            {
                return null;
            }


            var items: XMLList = this._manifest.child(LIBRARY);

            if (items == null)
            {
                throw new Error("Provided manifest doesn't contain library node!");
            }


            if (items.length() == 0)
            {
                return null;
            }


            items = items[0].assets;

            if (items != null)
            {
                items = items.child(ASSET);

                for (var i: int = 0; i < items.length(); i++)
                {
                    item = items[i];

                    if (item.attribute(NAME).toString() == assetName)
                    {
                        var assetType: AssetTypeDeclaration = this.getAssetTypeDeclarationByMimeType(item.attribute(TYPE));

                        if (assetType == null)
                        {
                            throw new Error("Failed to extract asset " + assetName + " from Library " + this._url + "!");
                        }


                        var asset: IAsset = new assetType.assetClass(assetType) as IAsset;
                        asset.setUnknownContent(this._resource[assetName]);

                        var params: XMLList = item.child(PARAM);

                        if (params.length())
                        {
                            asset.setParamsDesc(params);
                        }


                        this.setAsset(assetName, asset);

                        return asset;
                    }

                }

            }


            return null;
        }

        public function toString(): String
        {
            return getQualifiedClassName(this) + ": " + this._name;
        }

    }
}
