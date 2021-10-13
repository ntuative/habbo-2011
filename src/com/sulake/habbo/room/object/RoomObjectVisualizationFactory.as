package com.sulake.habbo.room.object
{
    import com.sulake.core.runtime.Component;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.room.object.visualization.room.RoomVisualization;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomVisualization;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomParkVisualization;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomPoolVisualization;
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
    import com.sulake.habbo.room.object.visualization.pet.PetVisualization;
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.ResettingAnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePosterVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureHabboWheelVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureValRandomizerVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBottleVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePlanetSystemVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureQueueTileVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePartyBeamerVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureCuboidVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGiftWrappedVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureCounterClockVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureWaterAreaVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureScoreBoardVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureFireworksVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBillboardVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureStickieVisualization;
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData;
    import com.sulake.habbo.room.object.visualization.pet.PetVisualizationData;
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData;
    import com.sulake.room.object.visualization.utils.GraphicAssetCollection;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class RoomObjectVisualizationFactory extends Component implements IRoomObjectVisualizationFactory 
    {

        private var var_4269:IAvatarRenderManager = null;
        private var _visualizationDatas:Map;
        private var var_4270:Boolean = true;

        public function RoomObjectVisualizationFactory(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_4270 = (param2 == 0);
            this._visualizationDatas = new Map();
            queueInterface(new IIDAvatarRenderManager(), this.avatarReady);
        }

        override public function dispose():void
        {
            var _loc1_:IRoomObjectVisualizationData;
            var _loc2_:int;
            super.dispose();
            if (this.var_4269 != null)
            {
                release(new IIDAvatarRenderManager());
                this.var_4269 = null;
            };
            if (this._visualizationDatas != null)
            {
                _loc1_ = null;
                _loc2_ = 0;
                while (_loc2_ < this._visualizationDatas.length)
                {
                    _loc1_ = (this._visualizationDatas.getWithIndex(_loc2_) as IRoomObjectVisualizationData);
                    if (_loc1_ != null)
                    {
                        _loc1_.dispose();
                    };
                    _loc2_++;
                };
                this._visualizationDatas.dispose();
                this._visualizationDatas = null;
            };
        }

        private function avatarReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_4269 = (param2 as IAvatarRenderManager);
        }

        public function createRoomObjectVisualization(param1:String):IRoomObjectGraphicVisualization
        {
            var _loc2_:Class;
            switch (param1)
            {
                case RoomObjectVisualizationEnum.var_247:
                    _loc2_ = RoomVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_248:
                    _loc2_ = PublicRoomVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_249:
                    _loc2_ = PublicRoomParkVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_319:
                    _loc2_ = PublicRoomPoolVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_218:
                    _loc2_ = AvatarVisualization;
                    break;
                case RoomObjectVisualizationEnum.BOT:
                    _loc2_ = AvatarVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_180:
                    _loc2_ = PetVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_320:
                    _loc2_ = AnimatedPetVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_321:
                    _loc2_ = FurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_322:
                    _loc2_ = AnimatedFurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_323:
                    _loc2_ = ResettingAnimatedFurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_324:
                    _loc2_ = FurniturePosterVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_228:
                    _loc2_ = FurnitureHabboWheelVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_325:
                    _loc2_ = FurnitureValRandomizerVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_326:
                    _loc2_ = FurnitureBottleVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_231:
                    _loc2_ = FurniturePlanetSystemVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_327:
                    _loc2_ = FurnitureQueueTileVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_328:
                    _loc2_ = FurniturePartyBeamerVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_329:
                    _loc2_ = FurnitureCuboidVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_330:
                    _loc2_ = FurnitureGiftWrappedVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_241:
                    _loc2_ = FurnitureCounterClockVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_331:
                    _loc2_ = FurnitureWaterAreaVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_242:
                    _loc2_ = FurnitureScoreBoardVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_244:
                    _loc2_ = FurnitureFireworksVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_245:
                    _loc2_ = FurnitureBillboardVisualization;
                    break;
                case RoomObjectVisualizationEnum.var_221:
                    _loc2_ = FurnitureStickieVisualization;
                    break;
            };
            if (_loc2_ == null)
            {
                return (null);
            };
            var _loc3_:Object = new (_loc2_)();
            if ((_loc3_ is IRoomObjectGraphicVisualization))
            {
                return (_loc3_ as IRoomObjectGraphicVisualization);
            };
            return (null);
        }

        public function getRoomObjectVisualizationData(param1:String, param2:String, param3:XML):IRoomObjectVisualizationData
        {
            var _loc6_:IRoomObjectVisualizationData;
            var _loc7_:AvatarVisualizationData;
            var _loc8_:PetVisualizationData;
            var _loc9_:AnimatedPetVisualizationData;
            var _loc4_:IRoomObjectVisualizationData;
            _loc4_ = (this._visualizationDatas.getValue(param1) as IRoomObjectVisualizationData);
            if (_loc4_ != null)
            {
                return (_loc4_);
            };
            var _loc5_:Class;
            switch (param2)
            {
                case RoomObjectVisualizationEnum.var_321:
                case RoomObjectVisualizationEnum.var_330:
                case RoomObjectVisualizationEnum.var_245:
                case RoomObjectVisualizationEnum.var_221:
                    _loc5_ = FurnitureVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.var_322:
                case RoomObjectVisualizationEnum.var_323:
                case RoomObjectVisualizationEnum.var_324:
                case RoomObjectVisualizationEnum.var_228:
                case RoomObjectVisualizationEnum.var_325:
                case RoomObjectVisualizationEnum.var_326:
                case RoomObjectVisualizationEnum.var_231:
                case RoomObjectVisualizationEnum.var_327:
                case RoomObjectVisualizationEnum.var_328:
                case RoomObjectVisualizationEnum.var_241:
                case RoomObjectVisualizationEnum.var_331:
                case RoomObjectVisualizationEnum.var_242:
                case RoomObjectVisualizationEnum.var_244:
                    _loc5_ = AnimatedFurnitureVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.var_319:
                case RoomObjectVisualizationEnum.var_249:
                case RoomObjectVisualizationEnum.var_248:
                    _loc5_ = PublicRoomVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.var_247:
                    _loc5_ = RoomVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.var_218:
                    _loc5_ = AvatarVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.BOT:
                    _loc5_ = AvatarVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.var_180:
                    _loc5_ = PetVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.var_320:
                    _loc5_ = AnimatedPetVisualizationData;
                    break;
            };
            if (_loc5_ == null)
            {
                return (null);
            };
            _loc4_ = new (_loc5_)();
            if (_loc4_ != null)
            {
                _loc6_ = null;
                _loc6_ = (_loc4_ as IRoomObjectVisualizationData);
                if (!_loc6_.initialize(param3))
                {
                    _loc6_.dispose();
                    return (null);
                };
                if ((_loc6_ is AvatarVisualizationData))
                {
                    _loc7_ = (_loc4_ as AvatarVisualizationData);
                    _loc7_.avatarRenderer = this.var_4269;
                }
                else
                {
                    if ((_loc6_ is PetVisualizationData))
                    {
                        _loc8_ = (_loc4_ as PetVisualizationData);
                        _loc8_.avatarRenderer = this.var_4269;
                    }
                    else
                    {
                        if ((_loc6_ is AnimatedPetVisualizationData))
                        {
                            _loc9_ = (_loc4_ as AnimatedPetVisualizationData);
                            _loc9_.commonAssets = assets;
                        };
                    };
                };
                if (this.var_4270)
                {
                    this._visualizationDatas.add(param1, _loc6_);
                };
                return (_loc6_);
            };
            return (null);
        }

        public function createGraphicAssetCollection():IGraphicAssetCollection
        {
            return (new GraphicAssetCollection());
        }

    }
}