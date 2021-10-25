package com.sulake.habbo.room
{

    import com.sulake.room.IRoomContentLoader;
    import com.sulake.habbo.session.furniture.IFurniDataListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;

    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    import com.sulake.habbo.room.utils.PublicRoomData;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.habbo.session.furniture.IFurnitureData;

    import flash.events.Event;

    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectVisualizationEnum;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.LibraryLoader;

    import flash.net.URLRequest;

    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.Core;
    import com.sulake.core.assets.IAsset;

    import flash.display.BitmapData;

    public class RoomContentLoader implements IRoomContentLoader, IFurniDataListener, IDisposable
    {

        public static const RCL_LOADER_READY: String = "RCL_LOADER_READY";
        private static const RCL_PUBLIC_ROOM: String = "RCL_PUBLICROOM_";
        private static const STATE_DEFAULT: int = 0;
        private static const STATE_INITIALIZING: int = 1;
        private static const STATE_FURNI_INITIALIZED: int = 2;
        private static const PLACE_HOLDER: String = "place_holder";
        private static const WALL_PLACE_HOLDER: String = "wall_place_holder";
        private static const PET_PLACE_HOLDER: String = "pet_place_holder";
        private static const PLACE_HOLDER_DEFAULT: String = PLACE_HOLDER;//"place_holder"
        private static const ROOM: String = "room";
        private static const TILE_CURSOR: String = "tile_cursor";
        private static const SELECTION_ARROW: String = "selection_arrow";

        private var _libraries: Map = null;
        private var _events: Map = null;
        private var _assetLibrary: AssetLibrary = null;
        private var _additionalObjectTypeLibraries: Map = null;
        private var _assetCollections: Map = null;
        private var _visualizationFactory: IRoomObjectVisualizationFactory = null;
        private var _state: int = 0;
        private var _stateEvents: IEventDispatcher = null;
        private var _disposed: Boolean = false;
        private var _furniDataInitialized: Boolean = false;
        private var _activeObjectTypes: Map = null;
        private var _activeObjects: Dictionary = new Dictionary();
        private var _wallItemTypes: Map = null;
        private var _wallItems: Dictionary = new Dictionary();
        private var _petTypes: Map = null;
        private var _pets: Dictionary = new Dictionary();
        private var _petColors: Map = null;
        private var _publicRoomData: PublicRoomData = null;
        private var _publicRooms: Map = null;
        private var _objectRevisions: Map = null;
        private var _objectAliases: Map = null;
        private var _objectOriginalNames: Map = null;
        private var _objectAdUrls: Map = null;
        private var _furniLoadUrl: String;
        private var _furniLoadNameTemplate: String;
        private var _publicRoomLoadUrl: String;
        private var _publicRoomLoadNameTemplate: String;
        private var _legacyContentCollection: Array = ["hh_people_pool", "hh_people_pool_calippo", "hh_paalu", "hh_people_paalu"];
        private var _publicRoomVisualTypeList: Array = ["room_public", "room_public_park", "room_public_pool"];
        private var _sessionDataManagerLoading: Boolean = false;
        private var _sessionDataManager: ISessionDataManager;

        public function RoomContentLoader()
        {
            this._libraries = new Map();
            this._events = new Map();
            this._assetLibrary = new AssetLibrary("room_engine");
            this._activeObjectTypes = new Map();
            this._wallItemTypes = new Map();
            this._petTypes = new Map();
            this.initPetData();
            this._objectAdUrls = new Map();
            this._objectRevisions = new Map();
            this._objectAliases = new Map();
            this._objectOriginalNames = new Map();
            this._assetCollections = new Map();
            this._additionalObjectTypeLibraries = new Map();
            this._publicRooms = new Map();
        }

        public function set sessionDataManager(param1: ISessionDataManager): void
        {
            this._sessionDataManager = param1;

            if (this._sessionDataManagerLoading)
            {
                this._sessionDataManagerLoading = false;
                this.initFurnitureData();
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function set visualizationFactory(param1: IRoomObjectVisualizationFactory): void
        {
            this._visualizationFactory = param1;
        }

        public function initialize(param1: IEventDispatcher, param2: IHabboConfigurationManager): void
        {
            if (this._state >= STATE_INITIALIZING)
            {
                return;
            }

            this._stateEvents = param1;
            this._furniLoadUrl = param2.getKey("flash.dynamic.download.url", "furniture/");
            this._furniLoadNameTemplate = param2.getKey("flash.dynamic.download.name.template", "%typeid%.swf");
            this._publicRoomLoadUrl = param2.getKey("public.room.dynamic.download.url", "");
            this._publicRoomLoadNameTemplate = param2.getKey("public.room.dynamic.download.name.template", "%typeid%.swf");
            this._state = STATE_INITIALIZING;
            this.initFurnitureData();
        }

        private function initPetData(): void
        {
            var _loc3_: String;
            var _loc1_: Array = ["spider", "turtle", "chicken", "frog", "dragon", "monster"];
            var _loc2_: int = 8;
            for each (_loc3_ in _loc1_)
            {
                this._pets[_loc3_] = _loc2_;
                this._petTypes.add(_loc2_, _loc3_);
                _loc2_++;
            }

            this._petColors = new Map();
        }

        private function initFurnitureData(): void
        {
            if (this._sessionDataManager == null)
            {
                this._sessionDataManagerLoading = true;
                return;
            }

            var _loc1_: Array = this._sessionDataManager.getFurniData(this);
            if (_loc1_ == null)
            {
                return;
            }

            this.populateFurniData(_loc1_);
            this._furniDataInitialized = true;
            this.continueInitilization();
        }

        public function dispose(): void
        {
            var _loc1_: String;
            var _loc2_: int;
            var _loc3_: int;
            var _loc4_: AssetLibrary;
            var _loc5_: IGraphicAssetCollection;
            if (this._libraries != null)
            {
                _loc2_ = this._libraries.length;
                _loc3_ = 0;
                while (_loc3_ < _loc2_)
                {
                    _loc4_ = (this._libraries.getWithIndex(_loc3_) as AssetLibrary);
                    if (_loc4_ != null)
                    {
                        _loc4_.dispose();
                    }

                    _loc3_++;
                }

                this._libraries.dispose();
                this._libraries = null;
            }

            if (this._events != null)
            {
                this._events.dispose();
                this._events = null;
            }

            if (this._activeObjectTypes != null)
            {
                this._activeObjectTypes.dispose();
                this._activeObjectTypes = null;
            }

            if (this._wallItemTypes != null)
            {
                this._wallItemTypes.dispose();
                this._wallItemTypes = null;
            }

            if (this._petTypes != null)
            {
                this._petTypes.dispose();
                this._petTypes = null;
            }

            if (this._petColors != null)
            {
                this._petColors.dispose();
                this._petColors = null;
            }

            if (this._assetLibrary != null)
            {
                this._assetLibrary.dispose();
                this._assetLibrary = null;
            }

            if (this._objectRevisions != null)
            {
                this._objectRevisions.dispose();
                this._objectRevisions = null;
            }

            if (this._objectAliases != null)
            {
                this._objectAliases.dispose();
                this._objectAliases = null;
            }

            if (this._objectOriginalNames != null)
            {
                this._objectOriginalNames.dispose();
                this._objectOriginalNames = null;
            }

            if (this._objectAdUrls != null)
            {
                this._objectAdUrls.dispose();
                this._objectAdUrls = null;
            }

            if (this._assetCollections != null)
            {
                _loc2_ = this._assetCollections.length;
                _loc3_ = 0;
                while (_loc3_ < _loc2_)
                {
                    _loc5_ = (this._assetCollections.getWithIndex(_loc3_) as IGraphicAssetCollection);
                    if (_loc5_ != null)
                    {
                        _loc5_.dispose();
                    }

                    _loc3_++;
                }

                this._assetCollections.dispose();
                this._assetCollections = null;
            }

            if (this._additionalObjectTypeLibraries != null)
            {
                this._additionalObjectTypeLibraries.dispose();
                this._additionalObjectTypeLibraries = null;
            }

            if (this._activeObjects != null)
            {
                for (_loc1_ in this._activeObjects)
                {
                    this._activeObjects[_loc1_] = null;
                }

                this._activeObjects = null;
            }

            if (this._wallItems != null)
            {
                for (_loc1_ in this._wallItems)
                {
                    this._wallItems[_loc1_] = null;
                }

                this._wallItems = null;
            }

            if (this._pets != null)
            {
                for (_loc1_ in this._pets)
                {
                    this._pets[_loc1_] = null;
                }

                this._pets = null;
            }

            this._stateEvents = null;
            this._sessionDataManager = null;
            this._disposed = true;
        }

        private function populateFurniData(param1: Array): void
        {
            var _loc2_: IFurnitureData;
            var _loc3_: int;
            var _loc4_: String;
            var _loc5_: int;
            var _loc6_: String;
            var _loc7_: String;
            var _loc8_: int;
            for each (_loc2_ in param1)
            {
                _loc3_ = _loc2_.id;
                _loc4_ = _loc2_.name;
                if (_loc2_.colourIndex > 0)
                {
                    _loc4_ = _loc4_ + "*" + _loc2_.colourIndex;
                }

                _loc5_ = _loc2_.revision;
                _loc6_ = _loc2_.adUrl;
                if (_loc6_.length > 0)
                {
                    this._objectAdUrls.add(_loc4_, _loc6_);
                }

                _loc7_ = _loc2_.name;
                if (_loc2_.type == "s")
                {
                    this._activeObjectTypes.add(_loc3_, _loc4_);
                    if (this._activeObjects[_loc7_] == null)
                    {
                        this._activeObjects[_loc7_] = 1;
                    }

                }
                else
                {
                    if (_loc2_.type == "i")
                    {
                        if (_loc4_ == "post.it")
                        {
                            _loc4_ = "post_it";
                            _loc7_ = "post_it";
                        }

                        if (_loc4_ == "post.it.vd")
                        {
                            _loc4_ = "post_it_vd";
                            _loc7_ = "post_it_vd";
                        }

                        this._wallItemTypes.add(_loc3_, _loc4_);
                        if (this._wallItems[_loc7_] == null)
                        {
                            this._wallItems[_loc7_] = 1;
                        }

                    }

                }

                _loc8_ = this._objectRevisions.getValue(_loc7_);
                if (_loc5_ > _loc8_)
                {
                    this._objectRevisions.remove(_loc7_);
                    this._objectRevisions.add(_loc7_, _loc5_);
                }

            }

        }

        private function continueInitilization(): void
        {
            if (this._furniDataInitialized)
            {
                this._state = STATE_FURNI_INITIALIZED;
                if (this._stateEvents != null)
                {
                    this._stateEvents.dispatchEvent(new Event(RCL_LOADER_READY));
                }

            }

        }

        public function setRoomObjectAlias(param1: String, param2: String): void
        {
            if (this._objectAliases != null)
            {
                this._objectAliases.remove(param1);
                this._objectAliases.add(param1, param2);
            }

            if (this._objectOriginalNames != null)
            {
                this._objectOriginalNames.remove(param2);
                this._objectOriginalNames.add(param2, param1);
            }

        }

        private function getRoomObjectAlias(param1: String): String
        {
            var _loc2_: String;
            if (this._objectAliases != null)
            {
                _loc2_ = (this._objectAliases.getValue(param1) as String);
            }

            if (_loc2_ == null)
            {
                _loc2_ = param1;
            }

            return _loc2_;
        }

        private function getRoomObjectOriginalName(param1: String): String
        {
            var _loc2_: String;
            if (this._objectOriginalNames != null)
            {
                _loc2_ = (this._objectOriginalNames.getValue(param1) as String);
            }

            if (_loc2_ == null)
            {
                _loc2_ = param1;
            }

            return _loc2_;
        }

        public function getObjectCategory(param1: String): int
        {
            if (param1 == null)
            {
                return RoomObjectCategoryEnum.var_352;
            }

            if (this._activeObjects[param1] != null)
            {
                return RoomObjectCategoryEnum.var_72;
            }

            if (this._wallItems[param1] != null)
            {
                return RoomObjectCategoryEnum.var_73;
            }

            if (this._pets[param1] != null)
            {
                return RoomObjectCategoryEnum.var_71;
            }

            if (param1.indexOf("poster") == 0)
            {
                return RoomObjectCategoryEnum.var_73;
            }

            if (this._publicRoomData != null && (this._publicRoomData.type == param1 || this._publicRoomData.hasWorldType(param1)))
            {
                return RoomObjectCategoryEnum.var_354;
            }

            if (param1 == "room")
            {
                return RoomObjectCategoryEnum.var_354;
            }

            if (param1 == "user")
            {
                return RoomObjectCategoryEnum.var_71;
            }

            if (param1 == "pet")
            {
                return RoomObjectCategoryEnum.var_71;
            }

            if (param1 == "bot")
            {
                return RoomObjectCategoryEnum.var_71;
            }

            if (param1 == "tile_cursor" || param1 == "selection_arrow")
            {
                return RoomObjectCategoryEnum.var_355;
            }

            return RoomObjectCategoryEnum.var_352;
        }

        public function getPlaceHolderType(param1: String): String
        {
            if (this._activeObjects[param1] != null)
            {
                return PLACE_HOLDER;
            }

            if (this._wallItems[param1] != null)
            {
                return WALL_PLACE_HOLDER;
            }

            if (this._pets[param1] != null)
            {
                return PET_PLACE_HOLDER;
            }

            if (this._publicRoomData != null && (this._publicRoomData.type == param1 || this._publicRoomData.hasWorldType(param1)))
            {
                return ROOM;
            }

            return PLACE_HOLDER_DEFAULT;
        }

        public function getPlaceHolderTypes(): Array
        {
            return [PLACE_HOLDER, WALL_PLACE_HOLDER, PET_PLACE_HOLDER, ROOM, TILE_CURSOR, SELECTION_ARROW];
        }

        public function getActiveObjectType(param1: int): String
        {
            var _loc2_: String = this._activeObjectTypes.getValue(param1) as String;
            return this.getObjectType(_loc2_);
        }

        public function getWallItemType(param1: int, param2: String = null): String
        {
            var _loc3_: String = this._wallItemTypes.getValue(param1) as String;
            if (_loc3_ == "poster" && param2 != null)
            {
                _loc3_ = _loc3_ + param2;
            }

            return this.getObjectType(_loc3_);
        }

        public function getPetType(param1: int): String
        {
            return this._petTypes.getValue(param1) as String;
        }

        public function getPetColor(param1: int, param2: int): PetColorResult
        {
            var _loc3_: Map = this._petColors[param1];
            if (_loc3_ != null)
            {
                return _loc3_[param2] as PetColorResult;
            }

            return null;
        }

        public function getActiveObjectColorIndex(param1: int): int
        {
            var _loc2_: String = this._activeObjectTypes.getValue(param1) as String;
            return this.getObjectColorIndex(_loc2_);
        }

        public function getWallItemColorIndex(param1: int): int
        {
            var _loc2_: String = this._wallItemTypes.getValue(param1) as String;
            return this.getObjectColorIndex(_loc2_);
        }

        public function getRoomObjectAdURL(param1: String): String
        {
            if (this._objectAdUrls.getValue(param1) != null)
            {
                return this._objectAdUrls.getValue(param1);
            }

            return "";
        }

        private function getObjectType(param1: String): String
        {
            if (param1 == null)
            {
                return null;
            }

            var _loc2_: int = param1.indexOf("*");
            if (_loc2_ >= 0)
            {
                param1 = param1.substr(0, _loc2_);
            }

            return param1;
        }

        private function getObjectColorIndex(param1: String): int
        {
            if (param1 == null)
            {
                return -1;
            }

            var _loc2_: int;
            var _loc3_: int = param1.indexOf("*");
            if (_loc3_ >= 0)
            {
                _loc2_ = int(param1.substr(_loc3_ + 1));
            }

            return _loc2_;
        }

        public function getContentType(param1: String): String
        {
            return param1;
        }

        public function getPublicRoomContentType(param1: String): String
        {
            if (this._publicRoomData != null && this._publicRoomData.hasWorldType(RCL_PUBLIC_ROOM + param1))
            {
                return this._publicRoomData.type;
            }

            return param1;
        }

        public function hasInternalContent(param1: String): Boolean
        {
            return param1 == RoomObjectVisualizationEnum.USER || param1 == RoomObjectVisualizationEnum.PET || param1 == RoomObjectVisualizationEnum.BOT;


        }

        private function getObjectRevision(param1: String): int
        {
            var _loc3_: int;
            var _loc2_: int = this.getObjectCategory(param1);
            if (_loc2_ == RoomObjectCategoryEnum.var_72 || _loc2_ == RoomObjectCategoryEnum.var_73)
            {
                if (param1.indexOf("poster") == 0)
                {
                    param1 = "poster";
                }

                return this._objectRevisions.getValue(param1);
            }

            return 0;
        }

        private function getObjectContentURLs(param1: String): Array
        {
            var _loc2_: String;
            var _loc3_: int;
            var _loc4_: String;
            var _loc5_: String;
            var _loc6_: int;
            var _loc7_: Array;
            var _loc8_: Array;
            var _loc9_: int;
            var _loc10_: String;
            _loc2_ = this.getContentType(param1);
            Logger.log("Getting content URL for object type: " + param1);
            switch (_loc2_)
            {
                case PLACE_HOLDER:
                    return ["PlaceHolderFurniture.swf"];
                case WALL_PLACE_HOLDER:
                    return ["PlaceHolderWallItem.swf"];
                case PET_PLACE_HOLDER:
                    return ["PlaceHolderPet.swf"];
                case ROOM:
                    return ["HabboRoomContent.swf"];
                case TILE_CURSOR:
                    return ["TileCursor.swf"];
                case SELECTION_ARROW:
                    return ["SelectionArrow.swf"];
                default:
                    _loc3_ = this.getObjectCategory(_loc2_);
                    if (_loc3_ == RoomObjectCategoryEnum.var_72 || _loc3_ == RoomObjectCategoryEnum.var_73)
                    {
                        _loc4_ = this.getRoomObjectAlias(_loc2_);
                        _loc5_ = this._furniLoadNameTemplate;
                        _loc5_ = _loc5_.replace(/%typeid%/, _loc4_);
                        _loc6_ = this.getObjectRevision(_loc2_);
                        _loc5_ = _loc5_.replace(/%revision%/, _loc6_);
                        return [(this._furniLoadUrl + _loc5_)];
                    }

                    if (_loc3_ == RoomObjectCategoryEnum.var_71)
                    {
                        return [(_loc2_ + ".swf")];
                    }

                    _loc7_ = _loc2_.split(",");
                    _loc8_ = [];
                    _loc9_ = 0;
                    while (_loc9_ < _loc7_.length)
                    {
                        _loc10_ = this._publicRoomLoadNameTemplate;
                        _loc10_ = _loc10_.replace(/%typeid%/, _loc7_[_loc9_]);
                        _loc8_.push(this._publicRoomLoadUrl + _loc10_);
                        _loc9_++;
                    }

                    return _loc8_;
            }

        }

        public function insertObjectContent(param1: int, param2: int, param3: IAssetLibrary): Boolean
        {
            var _loc6_: Event;
            var _loc7_: IEventDispatcher;
            var _loc4_: String = this.getAssetLibraryType(param3);
            switch (param2)
            {
                case RoomObjectCategoryEnum.var_72:
                    this._activeObjectTypes[param1] = _loc4_;
                    break;
                case RoomObjectCategoryEnum.var_73:
                    this._wallItemTypes[param1] = _loc4_;
                    break;
                default:
                    throw new Error("Registering content library for unsupported category " + param2 + "!");
            }

            var _loc5_: AssetLibraryCollection = this.addAssetLibraryCollection(_loc4_, null) as AssetLibraryCollection;
            if (_loc5_)
            {
                _loc5_.addAssetLibrary(param3);
                if (this.initializeGraphicAssetCollection(_loc4_, param3))
                {
                    switch (param2)
                    {
                        case RoomObjectCategoryEnum.var_72:
                            if (this._activeObjects[_loc4_] == null)
                            {
                                this._activeObjects[_loc4_] = 1;
                            }

                            break;
                        case RoomObjectCategoryEnum.var_73:
                            if (this._wallItems[_loc4_] == null)
                            {
                                this._wallItems[_loc4_] = 1;
                            }

                            break;
                        default:
                            throw new Error("Registering content library for unsupported category " + param2 + "!");
                    }

                    _loc6_ = new RoomContentLoadedEvent(RoomContentLoadedEvent.ROOM_CONTENT_SUCCESS, _loc4_);
                    _loc7_ = this.getAssetLibraryEventDispatcher(_loc4_, true);
                    if (_loc7_)
                    {
                        _loc7_.dispatchEvent(_loc6_);
                    }

                    return true;
                }

            }

            return false;
        }

        public function loadObjectContent(param1: String, param2: IEventDispatcher): Boolean
        {
            var _loc5_: Array;
            var _loc6_: int;
            var _loc7_: LibraryLoader;
            var _loc3_: String;
            if (param1.indexOf(",") >= 0)
            {
                _loc3_ = param1;
                param1 = _loc3_.split(",")[0];
            }

            if (this._publicRooms.getValue(param1) != null)
            {
                this._publicRoomData = (this._publicRooms.getValue(param1) as PublicRoomData);
            }

            if (this.getAssetLibrary(param1) != null || this.getAssetLibraryEventDispatcher(param1) != null)
            {
                return false;
            }

            var _loc4_: AssetLibraryCollection = this.addAssetLibraryCollection(param1, param2) as AssetLibraryCollection;
            if (_loc4_ == null)
            {
                return false;
            }

            if (_loc3_ != null)
            {
                _loc5_ = this.getObjectContentURLs(_loc3_);
            }
            else
            {
                _loc5_ = this.getObjectContentURLs(param1);
            }

            if (_loc5_ != null && _loc5_.length > 0)
            {
                _loc4_.addEventListener(AssetLibrary.ASSET_LIBRARY_LOADED, this.onContentLoaded);
                _loc6_ = 0;
                while (_loc6_ < _loc5_.length)
                {
                    _loc7_ = new LibraryLoader();
                    _loc7_.load(new URLRequest(_loc5_[_loc6_]));
                    _loc4_.loadFromFile(_loc7_, true);
                    _loc7_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
                    _loc6_++;
                }

                return true;
            }

            return false;
        }

        public function loadLegacyContent(param1: String, param2: IEventDispatcher): Array
        {
            var _loc6_: String;
            var _loc7_: String;
            var _loc3_: Array = param1.split(",");
            var _loc4_: Array = [];
            var _loc5_: int;
            while (_loc5_ < _loc3_.length)
            {
                if (_loc3_[_loc5_].toString().length > 0 && this._legacyContentCollection.indexOf(_loc3_[_loc5_]) == -1)
                {
                    _loc6_ = _loc3_[_loc5_].toString();
                    while (_loc6_.indexOf(" ") >= 0)
                    {
                        if (_loc6_.indexOf(" ") == 0)
                        {
                            _loc6_ = _loc6_.substr(1, _loc6_.length - 1);
                        }
                        else
                        {
                            if (_loc6_.indexOf(" ") == _loc6_.length - 1)
                            {
                                _loc6_ = _loc6_.substr(0, _loc6_.length - 2);
                            }

                        }

                    }

                    _loc4_.push(_loc6_);
                }

                _loc5_++;
            }

            if (_loc4_.length > 0)
            {
                _loc7_ = _loc4_[0];
                _loc5_ = 1;
                while (_loc5_ < _loc4_.length)
                {
                    _loc7_ = _loc7_ + ",";
                    _loc7_ = _loc7_ + _loc4_[_loc5_];
                    _loc5_++;
                }

                if (this.loadObjectContent(_loc7_, param2))
                {
                    return [_loc4_[0]];
                }

            }

            return [];
        }

        private function onContentLoadError(param1: Event): void
        {
            var _loc4_: String;
            var _loc5_: Array;
            var _loc2_: LibraryLoader = LibraryLoader(param1.target);
            var _loc3_: Array = this.getPlaceHolderTypes();
            for each (_loc4_ in _loc3_)
            {
                _loc5_ = this.getObjectContentURLs(_loc4_);
                if (_loc5_.length > 0 && _loc2_.url != null && _loc2_.url.indexOf(_loc5_[0]) == 0)
                {
                    Core.crash("Failed to load asset: " + _loc2_.url, Core.ERROR_CATEGORY_DOWNLOAD_ASSET);
                    return;
                }

            }

        }

        private function onContentLoaded(param1: Event): void
        {
            if (this.disposed)
            {
                return;
            }

            var _loc2_: IAssetLibrary = param1.target as IAssetLibrary;
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: RoomContentLoadedEvent;
            var _loc4_: Boolean;
            var _loc5_: String = this.getAssetLibraryType(_loc2_);
            _loc5_ = this.getRoomObjectOriginalName(_loc5_);
            if (_loc5_ != null)
            {
                _loc4_ = this.initializeGraphicAssetCollection(_loc5_, _loc2_);
            }

            if (_loc4_)
            {
                if (this._publicRoomVisualTypeList.indexOf(this.getVisualizationType(_loc5_)) >= 0)
                {
                    this.extractPublicRoomDataFromLoadedContent(_loc5_, _loc2_);
                }
                else
                {
                    if (this._pets[_loc5_] != null)
                    {
                        this.extractPetDataFromLoadedContent(_loc5_);
                    }

                }

                _loc3_ = new RoomContentLoadedEvent(RoomContentLoadedEvent.ROOM_CONTENT_SUCCESS, _loc5_);
            }
            else
            {
                _loc3_ = new RoomContentLoadedEvent(RoomContentLoadedEvent.ROOM_CONTENT_FAILURE, _loc5_);
            }

            var _loc6_: IEventDispatcher = this.getAssetLibraryEventDispatcher(_loc5_, true);
            if (_loc6_ != null && _loc3_ != null)
            {
                _loc6_.dispatchEvent(_loc3_);
            }

        }

        private function extractPetDataFromLoadedContent(param1: String): void
        {
            var _loc3_: Map;
            var _loc4_: Array;
            var _loc5_: String;
            var _loc6_: int;
            var _loc7_: Array;
            var _loc2_: IGraphicAssetCollection = this.getGraphicAssetCollection(param1);
            if (_loc2_ != null)
            {
                _loc3_ = new Map();
                _loc4_ = _loc2_.getPaletteNames();
                for each (_loc5_ in _loc4_)
                {
                    _loc7_ = _loc2_.getPaletteColors(_loc5_);
                    if (_loc7_ != null && _loc7_.length >= 2)
                    {
                        _loc3_.add(_loc5_, new PetColorResult(_loc7_[0], _loc7_[1]));
                    }

                }

                _loc6_ = this._pets[param1];
                this._petColors.add(_loc6_, _loc3_);
            }

        }

        private function extractPublicRoomDataFromLoadedContent(param1: String, param2: IAssetLibrary): void
        {
            var _loc3_: XML = this.getVisualizationXML(param1);
            var _loc4_: PublicRoomData = this.extractPublicRoomFromXML(param1, _loc3_);
            this._publicRooms.add(param1, _loc4_);
            this._publicRoomData = _loc4_;
            this.extractPublicRoomFurniture(param1, param2);
        }

        private function extractPublicRoomFurniture(param1: String, param2: IAssetLibrary): int
        {
            var _loc6_: String;
            var _loc7_: String;
            if (param2 == null)
            {
                return 0;
            }

            var _loc3_: Array = param2.nameArray;
            var _loc4_: int;
            var _loc5_: int;
            while (_loc5_ < _loc3_.length)
            {
                _loc6_ = _loc3_[_loc5_];
                if (_loc6_.indexOf("_index") > 0)
                {
                    _loc7_ = _loc6_.slice(0, _loc6_.indexOf("_index"));
                    if (this.extractObjectContent(param1, _loc7_))
                    {
                        _loc4_++;
                    }

                }

                _loc5_++;
            }

            return _loc4_;
        }

        private function initializeGraphicAssetCollection(param1: String, param2: IAssetLibrary): Boolean
        {
            var _loc5_: XML;
            if (param1 == null || param2 == null)
            {
                return false;
            }

            var _loc3_: Boolean;
            var _loc4_: IGraphicAssetCollection = this.createGraphicAssetCollection(param1, param2);
            if (_loc4_ != null)
            {
                _loc5_ = this.getAssetXML(param1);
                if (_loc4_.define(_loc5_))
                {
                    _loc3_ = true;
                }
                else
                {
                    this.disposeGraphicAssetCollection(param1);
                }

            }

            return _loc3_;
        }

        public function extractObjectContent(param1: String, param2: String): Boolean
        {
            var _loc3_: IAssetLibrary = this.getAssetLibrary(param1);
            this._additionalObjectTypeLibraries.add(param2, param1);
            if (this.initializeGraphicAssetCollection(param2, _loc3_))
            {
                return true;
            }

            this._additionalObjectTypeLibraries.remove(param2);
            return false;
        }

        private function getAssetLibraryName(param1: String): String
        {
            return "RoomContentLoader " + param1;
        }

        private function getAssetLibrary(param1: String): IAssetLibrary
        {
            var _loc4_: String;
            var _loc2_: String = this.getContentType(param1);
            _loc2_ = this.getRoomObjectOriginalName(_loc2_);
            var _loc3_: IAssetLibrary = this._libraries.getValue(this.getAssetLibraryName(_loc2_)) as IAssetLibrary;
            if (_loc3_ == null)
            {
                _loc4_ = this._additionalObjectTypeLibraries.getValue(_loc2_);
                if (_loc4_ != null)
                {
                    _loc2_ = this.getContentType(_loc4_);
                    _loc3_ = (this._libraries.getValue(this.getAssetLibraryName(_loc2_)) as IAssetLibrary);
                }

            }

            return _loc3_;
        }

        private function addAssetLibraryCollection(param1: String, param2: IEventDispatcher): IAssetLibrary
        {
            var _loc3_: String = this.getContentType(param1);
            var _loc4_: IAssetLibrary = this.getAssetLibrary(param1);
            if (_loc4_ != null)
            {
                return _loc4_;
            }

            var _loc5_: String = this.getAssetLibraryName(_loc3_);
            _loc4_ = new AssetLibraryCollection(_loc5_);
            this._libraries.add(_loc5_, _loc4_);
            if (param2 != null && this.getAssetLibraryEventDispatcher(param1) == null)
            {
                this._events.add(_loc3_, param2);
            }

            return _loc4_;
        }

        private function getAssetLibraryEventDispatcher(param1: String, param2: Boolean = false): IEventDispatcher
        {
            var _loc3_: String = this.getContentType(param1);
            if (!param2)
            {
                return this._events.getValue(_loc3_);
            }

            return this._events.remove(_loc3_);
        }

        private function getAssetLibraryType(param1: IAssetLibrary): String
        {
            if (param1 == null)
            {
                return null;
            }

            var _loc2_: IAsset = param1.getAssetByName("index");
            if (_loc2_ == null)
            {
                return null;
            }

            var _loc3_: XML = _loc2_.content as XML;
            if (_loc3_ == null)
            {
                return null;
            }

            return _loc3_.@type;
        }

        public function getVisualizationType(param1: String): String
        {
            if (param1 == null)
            {
                return null;
            }

            var _loc2_: IAssetLibrary = this.getAssetLibrary(param1);
            if (_loc2_ == null)
            {
                return null;
            }

            var _loc3_: IAsset = _loc2_.getAssetByName(param1 + "_index");
            if (_loc3_ == null)
            {
                _loc3_ = _loc2_.getAssetByName("index");
            }

            if (_loc3_ == null)
            {
                return null;
            }

            var _loc4_: XML = _loc3_.content as XML;
            if (_loc4_ == null)
            {
                return null;
            }

            return _loc4_.@visualization;
        }

        public function getLogicType(param1: String): String
        {
            if (param1 == null)
            {
                return null;
            }

            var _loc2_: IAssetLibrary = this.getAssetLibrary(param1);
            if (_loc2_ == null)
            {
                return null;
            }

            var _loc3_: IAsset = _loc2_.getAssetByName(param1 + "_index");
            if (_loc3_ == null)
            {
                _loc3_ = _loc2_.getAssetByName("index");
            }

            if (_loc3_ == null)
            {
                return null;
            }

            var _loc4_: XML = _loc3_.content as XML;
            if (_loc4_ == null)
            {
                return null;
            }

            return _loc4_.@logic;
        }

        public function getVisualizationXML(param1: String): XML
        {
            return this.getXML(param1, "_visualization");
        }

        public function getAssetXML(param1: String): XML
        {
            return this.getXML(param1, "_assets");
        }

        public function getLogicXML(param1: String): XML
        {
            return this.getXML(param1, "_logic");
        }

        private function getXML(param1: String, param2: String): XML
        {
            var _loc3_: IAssetLibrary = this.getAssetLibrary(param1);
            if (_loc3_ == null)
            {
                return null;
            }

            var _loc4_: String = this.getContentType(param1);
            var _loc5_: String = this.getRoomObjectAlias(_loc4_);
            var _loc6_: IAsset = _loc3_.getAssetByName(_loc5_ + param2);
            if (_loc6_ == null)
            {
                return null;
            }

            var _loc7_: XML = _loc6_.content as XML;
            if (_loc7_ == null)
            {
                return null;
            }

            return _loc7_;
        }

        public function addGraphicAsset(param1: String, param2: String, param3: BitmapData, param4: Boolean): Boolean
        {
            var _loc5_: IGraphicAssetCollection = this.getGraphicAssetCollection(param1);
            if (_loc5_ != null)
            {
                return _loc5_.addAsset(param2, param3, param4);
            }

            return false;
        }

        private function createGraphicAssetCollection(param1: String, param2: IAssetLibrary): IGraphicAssetCollection
        {
            var _loc3_: IGraphicAssetCollection = this.getGraphicAssetCollection(param1);
            if (_loc3_ != null)
            {
                return _loc3_;
            }

            if (param2 == null)
            {
                return null;
            }

            _loc3_ = this._visualizationFactory.createGraphicAssetCollection();
            if (_loc3_ != null)
            {
                _loc3_.assetLibrary = param2;
                this._assetCollections.add(param1, _loc3_);
            }

            return _loc3_;
        }

        public function getGraphicAssetCollection(param1: String): IGraphicAssetCollection
        {
            var _loc2_: String = this.getContentType(param1);
            return this._assetCollections.getValue(_loc2_) as IGraphicAssetCollection;
        }

        private function disposeGraphicAssetCollection(param1: String): Boolean
        {
            var _loc3_: IGraphicAssetCollection;
            var _loc2_: String = this.getContentType(param1);
            if (this._assetCollections[_loc2_] != null)
            {
                _loc3_ = this._assetCollections.remove(_loc2_);
                if (_loc3_ != null)
                {
                    _loc3_.dispose();
                }

                return true;
            }

            return false;
        }

        private function extractPublicRoomFromXML(param1: String, param2: XML): PublicRoomData
        {
            var _loc6_: XML;
            var _loc7_: String;
            var _loc8_: Number;
            var _loc9_: Number;
            var _loc3_: XMLList = param2.layoutData;
            var _loc4_: PublicRoomData = new PublicRoomData(param1);
            var _loc5_: int;
            while (_loc5_ < _loc3_.length())
            {
                _loc6_ = _loc3_[_loc5_];
                _loc7_ = RCL_PUBLIC_ROOM + String(_loc6_.@name);
                _loc8_ = 32;
                _loc9_ = 1;
                if (String(_loc6_.@size) != "")
                {
                    _loc8_ = parseInt(_loc6_.@size);
                }

                if (String(_loc6_.@heightScale) != "")
                {
                    _loc9_ = parseFloat(_loc6_.@heightScale);
                }

                _loc4_.addWorld(_loc7_, _loc8_, _loc9_);
                _loc5_++;
            }

            return _loc4_;
        }

        public function isPublicRoomWorldType(param1: String): Boolean
        {
            return this.getObjectCategory(RCL_PUBLIC_ROOM + param1) == RoomObjectCategoryEnum.var_354;


        }

        public function getPublicRoomWorldHeightScale(param1: String): Number
        {
            if (this._publicRoomData != null)
            {
                return this._publicRoomData.getWorldHeightScale(RCL_PUBLIC_ROOM + param1);
            }

            return 1;
        }

        public function getPublicRoomWorldSize(param1: String): int
        {
            if (this._publicRoomData != null)
            {
                return this._publicRoomData.getWorldScale(RCL_PUBLIC_ROOM + param1);
            }

            return 32;
        }

        public function furniDataReady(): void
        {
            this.initFurnitureData();
        }

        public function setActiveObjectType(param1: int, param2: String): void
        {
            this._activeObjectTypes.remove(param1);
            this._activeObjectTypes.add(param1, param2);
        }

    }
}
