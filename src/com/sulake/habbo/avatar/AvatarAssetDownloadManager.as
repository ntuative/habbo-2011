package com.sulake.habbo.avatar
{

    import com.sulake.core.runtime.events.EventDispatcher;

    import flash.utils.Dictionary;

    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLoaderStruct;

    import flash.utils.Timer;

    import com.sulake.core.assets.XmlAsset;

    import flash.net.URLRequest;

    import com.sulake.core.assets.IAsset;

    import flash.events.TimerEvent;

    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    import flash.events.Event;

    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.figure.FigurePart;
    import com.sulake.habbo.avatar.structure.IFigureData;

    public class AvatarAssetDownloadManager extends EventDispatcher
    {

        private const var_2545: int = 100;
        private const var_298: int = 2;

        private var var_2547: Dictionary;
        private var _assets: IAssetLibrary;
        private var var_2548: Dictionary;
        private var var_2164: Dictionary;
        private var _structure: AvatarStructure;
        private var var_2549: String;
        private var var_2550: String;
        private var var_2551: Boolean;
        private var var_2552: int = 3;
        private var var_2553: AssetLoaderStruct;
        private var var_2546: Timer;
        private var var_2554: Array;
        private var var_2555: Array;
        private var var_2556: Array;

        public function AvatarAssetDownloadManager(param1: IAssetLibrary, param2: String, param3: String, param4: AvatarStructure)
        {
            var _loc7_: XmlAsset;
            var _loc8_: XML;
            super();
            this.var_2547 = new Dictionary();
            this._assets = param1;
            this._structure = param4;
            this.var_2548 = new Dictionary();
            this.var_2549 = param3;
            this.var_2550 = param2;
            this.var_2164 = new Dictionary();
            this.var_2554 = [];
            this.var_2555 = [];
            this.var_2556 = [];
            var _loc5_: URLRequest = new URLRequest(param2);
            var _loc6_: IAsset = this._assets.getAssetByName("figuremap");
            if (_loc6_ == null)
            {
                this.var_2553 = this._assets.loadAssetFromFile("figuremap", _loc5_, "text/xml");
                this.addMapLoaderEventListeners();
            }
            else
            {
                _loc7_ = (this._assets.getAssetByName("figuremap") as XmlAsset);
                _loc8_ = (_loc7_.content as XML).copy();
                this.loadFigureMapData(_loc8_);
            }

            this.var_2546 = new Timer(this.var_2545, 1);
            this.var_2546.addEventListener(TimerEvent.TIMER_COMPLETE, this.onNextDownloadTimeout);
        }

        override public function dispose(): void
        {
            super.dispose();
            this.var_2547 = null;
            this._assets = null;
            this.var_2548 = null;
            this.var_2164 = null;
            this._structure = null;
            this.var_2555 = null;
            this.var_2554 = null;
            if (this.var_2546)
            {
                this.var_2546.stop();
                this.var_2546 = null;
            }

            if (this.var_2553)
            {
                this.removeMapLoaderEventListeners();
                this.var_2553 = null;
            }

        }

        private function addMapLoaderEventListeners(): void
        {
            if (this.var_2553)
            {
                this.var_2553.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onConfigurationComplete);
                this.var_2553.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.onConfigurationError);
            }

        }

        private function removeMapLoaderEventListeners(): void
        {
            if (this.var_2553)
            {
                this.var_2553.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onConfigurationComplete);
                this.var_2553.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.onConfigurationError);
            }

        }

        private function onConfigurationError(param1: Event): void
        {
            var _loc2_: String;
            var _loc3_: URLRequest;
            this.var_2552--;
            if (this.var_2552 <= 0)
            {
                Logger.log("AVATAR ASSET ERROR: Could not download figuremap.xml.");
            }
            else
            {
                Logger.log("Could not download figuremap.xml. Retries left: " + this.var_2552);
                if (this.var_2550.indexOf("?") > 0)
                {
                    _loc2_ = this.var_2550 + "&retry=" + this.var_2552;
                }
                else
                {
                    _loc2_ = this.var_2550 + "?retry=" + this.var_2552;
                }

                this.removeMapLoaderEventListeners();
                _loc3_ = new URLRequest(_loc2_);
                this.var_2553 = this._assets.loadAssetFromFile("figuremap", _loc3_, "text/xml");
                this.addMapLoaderEventListeners();
            }

        }

        private function onConfigurationComplete(event: Event): void
        {
            var data: XML;
            var loaderStruct: AssetLoaderStruct = event.target as AssetLoaderStruct;
            if (loaderStruct == null)
            {
                return;
            }

            try
            {
                data = new XML(loaderStruct.assetLoader.content as String);
            }
            catch (e: Error)
            {
                Logger.log("[AvatarAssetDownloadManager] Error: " + e.message);
                return;
            }

            this.loadFigureMapData(data);
        }

        private function loadFigureMapData(param1: XML): void
        {
            var _loc2_: Array;
            if (param1 == null)
            {
                Logger.log("[AvatarAssetDownloadManager] XML error: " + param1 + " not valid XML");
                return;
            }

            if (param1.toString() == "")
            {
                Logger.log("[AvatarAssetDownloadManager] XML error: " + param1 + " is EMPTY!");
                return;
            }

            this.generateMap(param1);
            this.var_2551 = true;
            for each (_loc2_ in this.var_2554)
            {
                this.loadFigureSetData(_loc2_[0], _loc2_[1]);
            }

            this.var_2554 = [];
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function generateMap(param1: XML): void
        {
            var _loc2_: XML;
            var _loc3_: AvatarAssetDownloadLibrary;
            var _loc4_: XML;
            var _loc5_: String;
            var _loc6_: Array;
            for each (_loc2_ in param1.lib)
            {
                _loc3_ = new AvatarAssetDownloadLibrary(_loc2_.@id, _loc2_.@revision, this.var_2549, this._assets);
                _loc3_.addEventListener(Event.COMPLETE, this.libraryComplete);
                for each (_loc4_ in _loc2_.part)
                {
                    _loc5_ = _loc4_.@type + ":" + _loc4_.@id;
                    _loc6_ = this.var_2547[_loc5_];
                    if (_loc6_ == null)
                    {
                        _loc6_ = [];
                    }

                    _loc6_.push(_loc3_);
                    this.var_2547[_loc5_] = _loc6_;
                }

            }

        }

        public function isReady(param1: IAvatarFigureContainer): Boolean
        {
            if (!this.var_2551)
            {
                return false;
            }

            var _loc2_: Array = this.getLibsToDownload(param1);
            return _loc2_.length == 0;
        }

        public function loadFigureSetData(param1: IAvatarFigureContainer, param2: IAvatarImageListener): void
        {
            var _loc5_: AvatarAssetDownloadLibrary;
            var _loc6_: Array;
            if (!this.var_2551)
            {
                this.var_2554.push([param1, param2]);
                return;
            }

            var _loc3_: String = param1.getFigureString();
            var _loc4_: Array = this.getLibsToDownload(param1);
            if (_loc4_.length > 0)
            {
                if (param2 && !param2.disposed)
                {
                    _loc6_ = this.var_2164[_loc3_];
                    if (_loc6_ == null)
                    {
                        _loc6_ = [];
                    }

                    _loc6_.push(param2);
                    this.var_2164[_loc3_] = _loc6_;
                }

                this.var_2548[_loc3_] = _loc4_;
                for each (_loc5_ in _loc4_)
                {
                    this.addToQueue(_loc5_);
                }

            }
            else
            {
                if (param2 != null && !param2.disposed)
                {
                    param2.avatarImageReady(_loc3_);
                }

            }

        }

        private function libraryComplete(param1: Event): void
        {
            var _loc3_: String;
            var _loc4_: Array;
            var _loc5_: AvatarAssetDownloadLibrary;
            var _loc6_: int;
            var _loc7_: Boolean;
            var _loc8_: AvatarAssetDownloadLibrary;
            var _loc9_: Array;
            var _loc10_: IAvatarImageListener;
            var _loc2_: Array = [];
            for (_loc3_ in this.var_2548)
            {
                _loc7_ = true;
                _loc4_ = this.var_2548[_loc3_];
                for each (_loc8_ in _loc4_)
                {
                    if (!_loc8_.isReady)
                    {
                        _loc7_ = false;
                        break;
                    }

                }

                if (_loc7_)
                {
                    _loc2_.push(_loc3_);
                    _loc9_ = this.var_2164[_loc3_];
                    for each (_loc10_ in _loc9_)
                    {
                        if (_loc10_ != null && !_loc10_.disposed)
                        {
                            _loc10_.avatarImageReady(_loc3_);
                        }

                    }

                    this.var_2164[_loc3_] = null;
                }

            }

            for each (_loc3_ in _loc2_)
            {
                this.var_2548[_loc3_] = null;
            }

            while (_loc6_ < this.var_2556.length)
            {
                _loc5_ = this.var_2556[_loc6_];
                if (_loc5_.libraryName == (param1.target as AvatarAssetDownloadLibrary).libraryName)
                {
                    this.var_2556.splice(_loc6_, 1);
                }

                _loc6_++;
            }

            this.var_2546.start();
        }

        private function getLibsToDownload(param1: IAvatarFigureContainer): Array
        {
            var _loc5_: String;
            var _loc6_: ISetType;
            var _loc7_: int;
            var _loc8_: IFigurePartSet;
            var _loc9_: FigurePart;
            var _loc10_: String;
            var _loc11_: Array;
            var _loc12_: AvatarAssetDownloadLibrary;
            var _loc2_: Array = [];
            if (!this._structure)
            {
                return _loc2_;
            }

            if (!param1)
            {
                return _loc2_;
            }

            var _loc3_: IFigureData = this._structure.figureData;
            if (!_loc3_)
            {
                return _loc2_;
            }

            var _loc4_: Array = param1.getPartTypeIds();
            for each (_loc5_ in _loc4_)
            {
                _loc6_ = _loc3_.getSetType(_loc5_);
                if (_loc6_)
                {
                    _loc7_ = param1.getPartSetId(_loc5_);
                    _loc8_ = _loc6_.getPartSet(_loc7_);
                    if (_loc8_)
                    {
                        for each (_loc9_ in _loc8_.parts)
                        {
                            _loc10_ = _loc9_.type + ":" + _loc9_.id;
                            _loc11_ = this.var_2547[_loc10_];
                            if (_loc11_ != null)
                            {
                                for each (_loc12_ in _loc11_)
                                {
                                    if (_loc12_ != null)
                                    {
                                        if (!_loc12_.isReady)
                                        {
                                            if (_loc2_.indexOf(_loc12_) == -1)
                                            {
                                                _loc2_.push(_loc12_);
                                            }

                                        }

                                    }

                                }

                            }

                        }

                    }

                }

            }

            return _loc2_;
        }

        private function processPending(): void
        {
            var _loc1_: AvatarAssetDownloadLibrary;
            while (this.var_2555.length > 0 && this.var_2556.length < this.var_298)
            {
                _loc1_ = this.var_2555[0];
                _loc1_.startDownloading();
                this.var_2556.push(this.var_2555.shift());
            }

        }

        private function addToQueue(param1: AvatarAssetDownloadLibrary): void
        {
            if (!param1.isReady && this.var_2555.indexOf(param1) == -1 && this.var_2556.indexOf(param1) == -1)
            {
                this.var_2555.push(param1);
                this.processPending();
            }

        }

        private function onNextDownloadTimeout(param1: Event = null): void
        {
            this.processPending();
        }

    }
}
