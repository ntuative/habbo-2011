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

        private var _avatarRenderManager: IAvatarRenderManager = null;
        private var _visualizationDatas: Map;
        private var _unlocked: Boolean = true;

        public function RoomObjectVisualizationFactory(ctx: IContext, flags: uint = 0, assets: IAssetLibrary = null)
        {
            super(ctx, flags, assets);

            this._unlocked = flags == 0;
            this._visualizationDatas = new Map();

            queueInterface(new IIDAvatarRenderManager(), this.avatarReady);
        }

        override public function dispose(): void
        {
            super.dispose();

            if (this._avatarRenderManager != null)
            {
                this.release(new IIDAvatarRenderManager());
                this._avatarRenderManager = null;
            }


            if (this._visualizationDatas != null)
            {
                var visualizationData: IRoomObjectVisualizationData = null;

                for (var i: int = 0; i < this._visualizationDatas.length; i++)
                {
                    visualizationData = (this._visualizationDatas.getWithIndex(i) as IRoomObjectVisualizationData);

                    if (visualizationData != null)
                    {
                        visualizationData.dispose();
                    }

                }


                this._visualizationDatas.dispose();
                this._visualizationDatas = null;
            }

        }

        private function avatarReady(iid: IID = null, avatarRenderManager: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }


            this._avatarRenderManager = avatarRenderManager as IAvatarRenderManager;
        }

        public function createRoomObjectVisualization(objectType: String): IRoomObjectGraphicVisualization
        {
            var objectVisualizationHandlerClass: Class;

            switch (objectType)
            {
                case RoomObjectVisualizationEnum.ROOM:
                    objectVisualizationHandlerClass = RoomVisualization;
                    break;
                case RoomObjectVisualizationEnum.ROOM_PUBLIC:
                    objectVisualizationHandlerClass = PublicRoomVisualization;
                    break;
                case RoomObjectVisualizationEnum.ROOM_PUBLIC_PARK:
                    objectVisualizationHandlerClass = PublicRoomParkVisualization;
                    break;
                case RoomObjectVisualizationEnum.ROOM_PUBLIC_POOL:
                    objectVisualizationHandlerClass = PublicRoomPoolVisualization;
                    break;
                case RoomObjectVisualizationEnum.USER:
                    objectVisualizationHandlerClass = AvatarVisualization;
                    break;
                case RoomObjectVisualizationEnum.BOT:
                    objectVisualizationHandlerClass = AvatarVisualization;
                    break;
                case RoomObjectVisualizationEnum.PET:
                    objectVisualizationHandlerClass = PetVisualization;
                    break;
                case RoomObjectVisualizationEnum.PET_ANIMATED:
                    objectVisualizationHandlerClass = AnimatedPetVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_STATIC:
                    objectVisualizationHandlerClass = FurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_ANIMATED:
                    objectVisualizationHandlerClass = AnimatedFurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_RESETTING_ANIMATED:
                    objectVisualizationHandlerClass = ResettingAnimatedFurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_POSTER:
                    objectVisualizationHandlerClass = FurniturePosterVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_HABBOWHEEL:
                    objectVisualizationHandlerClass = FurnitureHabboWheelVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_VAL_RANDOMIZER:
                    objectVisualizationHandlerClass = FurnitureValRandomizerVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_BOTTLE:
                    objectVisualizationHandlerClass = FurnitureBottleVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_PLANET_SYSTEM:
                    objectVisualizationHandlerClass = FurniturePlanetSystemVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_QUEUE_TILE:
                    objectVisualizationHandlerClass = FurnitureQueueTileVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_PARTY_BEAMER:
                    objectVisualizationHandlerClass = FurniturePartyBeamerVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_CUBOID:
                    objectVisualizationHandlerClass = FurnitureCuboidVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_GIFT_WRAPPED:
                    objectVisualizationHandlerClass = FurnitureGiftWrappedVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_COUNTER_CLOCK:
                    objectVisualizationHandlerClass = FurnitureCounterClockVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_WATER_AREA:
                    objectVisualizationHandlerClass = FurnitureWaterAreaVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_SCORE_BOARD:
                    objectVisualizationHandlerClass = FurnitureScoreBoardVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_FIREWORKS:
                    objectVisualizationHandlerClass = FurnitureFireworksVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_BILLBOARD:
                    objectVisualizationHandlerClass = FurnitureBillboardVisualization;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_STICKIE:
                    objectVisualizationHandlerClass = FurnitureStickieVisualization;
                    break;
            }


            if (objectVisualizationHandlerClass == null)
            {
                return null;
            }


            var ObjectVisualizationHandler: Object = new objectVisualizationHandlerClass();

            if (ObjectVisualizationHandler is IRoomObjectGraphicVisualization)
            {
                return ObjectVisualizationHandler as IRoomObjectGraphicVisualization;
            }


            return null;
        }

        public function getRoomObjectVisualizationData(id: String, objectType: String, data: XML): IRoomObjectVisualizationData
        {
            var roomObjectVisualizationData: IRoomObjectVisualizationData;
            var avatarVisualizationData: AvatarVisualizationData;
            var petVisualizationData: PetVisualizationData;
            var animatedPetVisualizationData: AnimatedPetVisualizationData;

            var visualizationData: IRoomObjectVisualizationData = this._visualizationDatas.getValue(id) as IRoomObjectVisualizationData;

            if (visualizationData != null)
            {
                return visualizationData;
            }


            var roomObjectVisualizationDataClass: Class;

            switch (objectType)
            {
                case RoomObjectVisualizationEnum.FURNITURE_STATIC:
                case RoomObjectVisualizationEnum.FURNITURE_GIFT_WRAPPED:
                case RoomObjectVisualizationEnum.FURNITURE_BILLBOARD:
                case RoomObjectVisualizationEnum.FURNITURE_STICKIE:
                    roomObjectVisualizationDataClass = FurnitureVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.FURNITURE_ANIMATED:
                case RoomObjectVisualizationEnum.FURNITURE_RESETTING_ANIMATED:
                case RoomObjectVisualizationEnum.FURNITURE_POSTER:
                case RoomObjectVisualizationEnum.FURNITURE_HABBOWHEEL:
                case RoomObjectVisualizationEnum.FURNITURE_VAL_RANDOMIZER:
                case RoomObjectVisualizationEnum.FURNITURE_BOTTLE:
                case RoomObjectVisualizationEnum.FURNITURE_PLANET_SYSTEM:
                case RoomObjectVisualizationEnum.FURNITURE_QUEUE_TILE:
                case RoomObjectVisualizationEnum.FURNITURE_PARTY_BEAMER:
                case RoomObjectVisualizationEnum.FURNITURE_COUNTER_CLOCK:
                case RoomObjectVisualizationEnum.FURNITURE_WATER_AREA:
                case RoomObjectVisualizationEnum.FURNITURE_SCORE_BOARD:
                case RoomObjectVisualizationEnum.FURNITURE_FIREWORKS:
                    roomObjectVisualizationDataClass = AnimatedFurnitureVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.ROOM_PUBLIC_POOL:
                case RoomObjectVisualizationEnum.ROOM_PUBLIC_PARK:
                case RoomObjectVisualizationEnum.ROOM_PUBLIC:
                    roomObjectVisualizationDataClass = PublicRoomVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.ROOM:
                    roomObjectVisualizationDataClass = RoomVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.USER:
                    roomObjectVisualizationDataClass = AvatarVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.BOT:
                    roomObjectVisualizationDataClass = AvatarVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.PET:
                    roomObjectVisualizationDataClass = PetVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.PET_ANIMATED:
                    roomObjectVisualizationDataClass = AnimatedPetVisualizationData;
                    break;
            }


            if (roomObjectVisualizationDataClass == null)
            {
                return null;
            }


            visualizationData = new roomObjectVisualizationDataClass();

            if (visualizationData != null)
            {
                roomObjectVisualizationData = null;
                roomObjectVisualizationData = (visualizationData as IRoomObjectVisualizationData);

                if (!roomObjectVisualizationData.initialize(data))
                {
                    roomObjectVisualizationData.dispose();
                    return null;
                }


                if (roomObjectVisualizationData is AvatarVisualizationData)
                {
                    avatarVisualizationData = visualizationData as AvatarVisualizationData;
                    avatarVisualizationData.avatarRenderer = this._avatarRenderManager;
                }
                else if (roomObjectVisualizationData is PetVisualizationData)
                {
                    petVisualizationData = visualizationData as PetVisualizationData;
                    petVisualizationData.avatarRenderer = this._avatarRenderManager;
                }
                else if (roomObjectVisualizationData is AnimatedPetVisualizationData)
                {
                    animatedPetVisualizationData = visualizationData as AnimatedPetVisualizationData;
                    animatedPetVisualizationData.commonAssets = assets;
                }


                if (this._unlocked)
                {
                    this._visualizationDatas.add(id, roomObjectVisualizationData);
                }


                return roomObjectVisualizationData;
            }


            return null;
        }

        public function createGraphicAssetCollection(): IGraphicAssetCollection
        {
            return new GraphicAssetCollection();
        }

    }
}
