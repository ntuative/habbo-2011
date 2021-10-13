package com.sulake.habbo.avatar.pets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.habbo.avatar.AvatarRenderManager;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import flash.net.URLRequest;
    import flash.events.Event;

    public class PetDataManager implements IPetDataManager, IDisposable 
    {

        private var var_2509:Map;
        private var _assets:AssetLibraryCollection;
        private var var_2164:Array;
        private var var_2177:Array;
        private var var_1063:AvatarRenderManager;
        private var var_2510:Map;
        private var var_2511:Array;
        private var _disposed:Boolean = false;

        public function PetDataManager(param1:AvatarRenderManager, param2:AssetLibraryCollection)
        {
            this.var_2509 = new Map();
            this.var_2164 = [];
            this.var_1063 = param1;
            this.var_2177 = [];
            this._assets = param2;
            this.var_2510 = new Map();
            this.var_2511 = [];
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            var _loc1_:LibraryLoader;
            if (this._disposed)
            {
                return;
            };
            this._assets = null;
            this.var_1063 = null;
            this.var_2164 = null;
            this.var_2509.dispose();
            this.var_2509 = null;
            if (this.var_2177 != null)
            {
                for each (_loc1_ in this.var_2177)
                {
                    _loc1_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
                    _loc1_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
                };
            };
            this.var_2177 = null;
            this.var_2510.dispose();
            this.var_2510 = null;
            this.var_2511 = null;
            this._disposed = true;
        }

        public function reset():void
        {
            this.init();
        }

        public function init():void
        {
            var _loc2_:XmlAsset;
            var _loc3_:XML;
            var _loc4_:int;
            var _loc1_:Array = this._assets.getAssetsByName("petData");
            for each (_loc2_ in _loc1_)
            {
                if (_loc2_ != null)
                {
                    _loc3_ = (_loc2_.content as XML);
                    _loc4_ = int(_loc3_.@species);
                    if (this.var_2509.getValue(_loc4_) == null)
                    {
                        this.var_2509.add(_loc4_, new PetData(_loc3_));
                    };
                };
            };
        }

        public function removeListener(param1:IPetDataListener=null):void
        {
            if (((param1 == null) || (this.var_2164 == null)))
            {
                return;
            };
            var _loc2_:int = this.var_2164.indexOf(param1);
            if (_loc2_ != -1)
            {
                this.var_2164.splice(_loc2_, 1);
            };
        }

        private function notifyListeners():void
        {
            var _loc1_:IPetDataListener;
            while (this.var_2164.length > 0)
            {
                _loc1_ = (this.var_2164.pop() as IPetDataListener);
                if (((!(_loc1_ == null)) && (!(_loc1_.disposed))))
                {
                    _loc1_.petDataReady();
                };
            };
        }

        public function getPetData(param1:int, param2:IPetDataListener=null):IPetData
        {
            var _loc3_:IPetData = (this.var_2509.getValue(param1) as IPetData);
            if (_loc3_ == null)
            {
                this.assetsReady(param1, AvatarScaleType.var_106, param2);
            };
            return (_loc3_);
        }

        public function createPetFigureString(param1:int, param2:int, param3:uint):String
        {
            if (this.disposed)
            {
                return ("");
            };
            var _loc4_:PetData = this.var_2509.getValue(param1);
            if (_loc4_ == null)
            {
                Logger.log(("Could not find Pet Data: " + param1));
                return ("");
            };
            var _loc5_:Breed = _loc4_.findBreed(param2);
            if (_loc5_ == null)
            {
                return ("");
            };
            var _loc6_:PetColor = _loc4_.findColor(param3);
            if (_loc6_ == null)
            {
                return (_loc5_.avatarFigureString);
            };
            var _loc7_:Array = _loc5_.avatarFigureString.split(".");
            return (_loc7_.join((_loc6_.figurePartPaletteColorId + ".")));
        }

        public function populateFigureData(figureData:XML):void
        {
            var targetSets:Array;
            var targetPalette:XML;
            var speciesKeys:Array;
            var key:int;
            var petData:PetData;
            var petColorData:PetColor;
            var breed:Breed;
            var colorValue:String;
            var color:XML;
            var colorId:int;
            var avatarFigureString:String;
            var targetSetName:String;
            var figureTargetSet:XML;
            var figurePart:XML;
            var setId:int;
            var figureSet:XML;
            targetSets = ["pbd", "phd", "ptl"];
            targetPalette = figureData.colors.palette.(@id == "1")[0];
            speciesKeys = this.var_2509.getKeys();
            for each (key in speciesKeys)
            {
                petData = this.var_2509.getValue(key);
                if (petData != null)
                {
                    for each (petColorData in petData.colors)
                    {
                        colorValue = petColorData.rgb.toString(16);
                        color = targetPalette.color.(text() == colorValue)[0];
                        if (color == null)
                        {
                            colorId = (targetPalette.children().length() + 1);
                            color = new (XML)((((((('<color id="' + colorId) + '" index="') + colorId) + '" club="0" selectable="1">') + colorValue) + "</color>"));
                            targetPalette.appendChild(color);
                        };
                        petColorData.figurePartPaletteColorId = parseInt(color.@id);
                    };
                    for each (breed in petData.breeds)
                    {
                        avatarFigureString = "";
                        for each (targetSetName in targetSets)
                        {
                            figureTargetSet = figureData.sets.settype.(@type == targetSetName)[0];
                            if (figureTargetSet == null)
                            {
                                Logger.log(("Could not find Figure Target Set for populating Pet Data: " + targetSetName));
                            }
                            else
                            {
                                figurePart = figureTargetSet.set.part.(@id == petData.species).((hasOwnProperty("palettemapid")) && (@palettemapid == breed.patternId))[0];
                                if (figurePart == null)
                                {
                                };
                                setId = (figureTargetSet.children().length() + 1);
                                figureSet = new (XML)((('<set id="' + setId) + '" gender="U" club="0" colorable="1" selectable="1"/>'));
                                figurePart = new (XML)((((((('<part id="' + petData.species) + '" breed="') + breed.id) + '" type="') + targetSetName) + '" colorable="1" colorindex="1" index="1"/>'));
                                if (breed.patternId >= 0)
                                {
                                    figurePart.@palettemapid = breed.patternId;
                                };
                                figureSet.appendChild(figurePart);
                                figureTargetSet.appendChild(figureSet);
                                avatarFigureString = (avatarFigureString + ((((targetSetName + "-") + setId) + "-") + "."));
                            };
                        };
                        breed.avatarFigureString = avatarFigureString;
                    };
                };
            };
        }

        public function get species():Map
        {
            return (this.var_2509);
        }

        public function assetsReady(param1:int, param2:String, param3:IPetDataListener=null):Boolean
        {
            var _loc5_:int;
            var _loc6_:String;
            var _loc8_:LibraryLoader;
            var _loc4_:Array = [];
            switch (param1)
            {
                case 0:
                    _loc4_.push("h_dog.swf");
                    break;
                case 1:
                    _loc4_.push("h_dog.swf");
                    _loc4_.push("h_cat.swf");
                    break;
                case 2:
                    _loc4_.push("h_dog.swf");
                    _loc4_.push("h_croco.swf");
                    break;
                case 3:
                    _loc4_.push("h_terrier.swf");
                    break;
                case 4:
                    _loc4_.push("h_bear.swf");
                    break;
                case 5:
                    _loc4_.push("h_pig.swf");
                    break;
                case 6:
                    _loc4_.push("h_lion.swf");
                    break;
                case 7:
                    _loc4_.push("h_rhino.swf");
                    break;
            };
            if (param2 == AvatarScaleType.var_305)
            {
                _loc5_ = 0;
                while (_loc5_ < _loc4_.length)
                {
                    _loc4_[_loc5_] = ("s" + _loc4_[_loc5_]);
                    _loc5_++;
                };
            };
            _loc4_.push("pets_palettes.swf");
            var _loc7_:Boolean = true;
            for each (_loc6_ in _loc4_)
            {
                if (this.var_2511.indexOf(_loc6_) == -1)
                {
                    _loc7_ = false;
                    if (this.var_2510.getValue(_loc6_) == null)
                    {
                        _loc8_ = new LibraryLoader();
                        this._assets.loadFromFile(_loc8_);
                        _loc8_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
                        _loc8_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
                        _loc8_.load(new URLRequest(_loc6_));
                        this.var_2177.push(_loc8_);
                        this.var_2510.add(_loc6_, _loc8_);
                        if (((!(param3 == null)) && (this.var_2164.indexOf(param3) == -1)))
                        {
                            this.var_2164.push(param3);
                        };
                    };
                };
            };
            return (_loc7_);
        }

        private function unregisterLoadingAssets(param1:LibraryLoader):void
        {
            var _loc3_:String;
            var _loc4_:String;
            var _loc5_:LibraryLoader;
            var _loc2_:Array = new Array();
            for each (_loc3_ in this.var_2510.getKeys())
            {
                _loc5_ = this.var_2510.getValue(_loc3_);
                if (param1 == _loc5_)
                {
                    _loc2_.push(_loc3_);
                };
            };
            for each (_loc4_ in _loc2_)
            {
                this.var_2510.remove(_loc4_);
            };
        }

        private function onContentLoadError(param1:Event):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
            var _loc3_:int = this.var_2177.indexOf(_loc2_);
            if (_loc3_ != -1)
            {
                this.var_2177.splice(_loc3_, 1);
                this.unregisterLoadingAssets(_loc2_);
            };
        }

        private function onLoaderComplete(param1:Event):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
            this.var_2511.push(_loc2_.url);
            var _loc3_:int = this.var_2177.indexOf(_loc2_);
            if (_loc3_ >= 0)
            {
                this.var_2177.splice(_loc3_, 1);
                this.unregisterLoadingAssets(_loc2_);
            };
            if (this.var_2177.length == 0)
            {
                this.var_1063.resetPetData();
                this.notifyListeners();
            };
        }

    }
}