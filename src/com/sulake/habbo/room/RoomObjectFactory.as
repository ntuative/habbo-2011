package com.sulake.habbo.room
{

    import com.sulake.core.runtime.Component;
    import com.sulake.room.IRoomObjectFactory;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureLogic;
    import com.sulake.habbo.room.object.RoomObjectLogicEnum;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiStateLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlaceholderLogic;
    import com.sulake.habbo.room.object.logic.AvatarLogic;
    import com.sulake.habbo.room.object.logic.PetLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRandomStateLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCreditLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureStickieLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePresentLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureTrophyLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureTeaserLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEcotronBoxLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureDiceLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHockeyScoreLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHabboWheelLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureQuestVendingWallItemLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureOneWayDoorLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlanetSystemLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureWindowLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomDimmerLogic;
    import com.sulake.habbo.room.object.logic.room.RoomTileCursorLogic;
    import com.sulake.habbo.room.object.logic.room.SelectionArrowLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSoundMachineLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureJukeboxLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSongDiskLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePushableLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureClothingChangeLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCounterClockLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureScoreBoardLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureIceStormLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureFireworksLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureBillboardLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureWelcomeGiftLogic;
    import com.sulake.habbo.room.object.logic.room.RoomLogic;
    import com.sulake.habbo.room.object.logic.room.publicroom.PublicRoomLogic;
    import com.sulake.habbo.room.object.logic.room.publicroom.PublicRoomParkLogic;
    import com.sulake.room.RoomObjectManager;
    import com.sulake.room.IRoomObjectManager;

    public class RoomObjectFactory extends Component implements IRoomObjectFactory
    {

        private var _trackedLogicTypes: Map = new Map();
        private var _roomObjectEvents: Map = new Map();
        private var _objectEventListeners: Array = [];

        public function RoomObjectFactory(ctx: IContext, flags: uint = 0)
        {
            super(ctx, flags);
        }

        public function addObjectEventListener(callback: Function): void
        {
            if (this._objectEventListeners.indexOf(callback) < 0)
            {
                this._objectEventListeners.push(callback);

                if (callback != null)
                {
                    for each (var eventName: String in this._roomObjectEvents.getKeys())
                    {
                        events.addEventListener(eventName, callback);
                    }

                }

            }

        }

        public function removeObjectEventListener(callback: Function): void
        {
            var index: int = this._objectEventListeners.indexOf(callback);

            if (index >= 0)
            {
                this._objectEventListeners.splice(index, 1);

                if (callback != null)
                {
                    for each (var eventName: String in this._roomObjectEvents.getKeys())
                    {
                        events.removeEventListener(eventName, callback);
                    }

                }

            }

        }

        private function addTrackedEventType(eventType: String): void
        {
            if (this._roomObjectEvents.getValue(eventType) == null)
            {
                this._roomObjectEvents.add(eventType, true);

                for each (var callback: Function in this._objectEventListeners)
                {
                    if (callback != null)
                    {
                        events.addEventListener(eventType, callback);
                    }

                }

            }

        }

        public function createRoomObjectLogic(logicType: String): IRoomObjectEventHandler
        {
            var roomObjectLogicHandlerClass: Class = null;

            switch (logicType)
            {
                case RoomObjectLogicEnum.FURNITURE_BASIC:
                    roomObjectLogicHandlerClass = FurnitureLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_MULTISTATE:
                    roomObjectLogicHandlerClass = FurnitureMultiStateLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_PLACEHOLDER:
                    roomObjectLogicHandlerClass = FurniturePlaceholderLogic;
                    break;
                case RoomObjectLogicEnum.USER:
                case RoomObjectLogicEnum.BOT:
                    roomObjectLogicHandlerClass = AvatarLogic;
                    break;
                case RoomObjectLogicEnum.PET:
                    roomObjectLogicHandlerClass = PetLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_RANDOMSTATE:
                    roomObjectLogicHandlerClass = FurnitureRandomStateLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_CREDIT:
                    roomObjectLogicHandlerClass = FurnitureCreditLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_STICKIE:
                    roomObjectLogicHandlerClass = FurnitureStickieLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_PRESENT:
                    roomObjectLogicHandlerClass = FurniturePresentLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_TROPHY:
                    roomObjectLogicHandlerClass = FurnitureTrophyLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_TEASER:
                    roomObjectLogicHandlerClass = FurnitureTeaserLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_ECOTRON_BOX:
                    roomObjectLogicHandlerClass = FurnitureEcotronBoxLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_DICE:
                    roomObjectLogicHandlerClass = FurnitureDiceLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_HOCKY_SCORE:
                    roomObjectLogicHandlerClass = FurnitureHockeyScoreLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_HABBOWHEEL:
                    roomObjectLogicHandlerClass = FurnitureHabboWheelLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_QUEST_WALLITEM:
                    roomObjectLogicHandlerClass = FurnitureQuestVendingWallItemLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_ONE_WAY_DOOR:
                    roomObjectLogicHandlerClass = FurnitureOneWayDoorLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_PLANET_SYSTEM:
                    roomObjectLogicHandlerClass = FurniturePlanetSystemLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_WINDOW:
                    roomObjectLogicHandlerClass = FurnitureWindowLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_ROOMDIMMER:
                    roomObjectLogicHandlerClass = FurnitureRoomDimmerLogic;
                    break;
                case RoomObjectLogicEnum.TILE_CURSOR:
                    roomObjectLogicHandlerClass = RoomTileCursorLogic;
                    break;
                case RoomObjectLogicEnum.SELECTION_ARROW:
                    roomObjectLogicHandlerClass = SelectionArrowLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_SOUND_MACHINE:
                    roomObjectLogicHandlerClass = FurnitureSoundMachineLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_JUKEBOX:
                    roomObjectLogicHandlerClass = FurnitureJukeboxLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_SONG_DISK:
                    roomObjectLogicHandlerClass = FurnitureSongDiskLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_PUSHABLE:
                    roomObjectLogicHandlerClass = FurniturePushableLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_CLOTHING_CHANGE:
                    roomObjectLogicHandlerClass = FurnitureClothingChangeLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_COUNTER_CLOCK:
                    roomObjectLogicHandlerClass = FurnitureCounterClockLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_SCORE:
                    roomObjectLogicHandlerClass = FurnitureScoreBoardLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_ES:
                    roomObjectLogicHandlerClass = FurnitureIceStormLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_FIREWORKS:
                    roomObjectLogicHandlerClass = FurnitureFireworksLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_BILLBOARD:
                    roomObjectLogicHandlerClass = FurnitureBillboardLogic;
                    break;
                case RoomObjectLogicEnum.FURNITURE_WELCOME_GIFT:
                    roomObjectLogicHandlerClass = FurnitureWelcomeGiftLogic;
                    break;
                case RoomObjectLogicEnum.ROOM:
                    roomObjectLogicHandlerClass = RoomLogic;
                    break;
                case RoomObjectLogicEnum.ROOM_PUBLIC:
                    roomObjectLogicHandlerClass = PublicRoomLogic;
                    break;
                case RoomObjectLogicEnum.ROOM_PUBLIC_PARK:
                    roomObjectLogicHandlerClass = PublicRoomParkLogic;
                    break;
            }


            if (roomObjectLogicHandlerClass == null)
            {
                return null;
            }


            var roomObjectLogicHandler: Object = new roomObjectLogicHandlerClass();

            if (roomObjectLogicHandler is IRoomObjectEventHandler)
            {
                var roomObjectEventHandler: IRoomObjectEventHandler = roomObjectLogicHandler as IRoomObjectEventHandler;

                roomObjectEventHandler.eventDispatcher = this.events;

                if (this._trackedLogicTypes.getValue(logicType) == null)
                {
                    this._trackedLogicTypes.add(logicType, true);

                    var eventTypes: Array = roomObjectEventHandler.getEventTypes();

                    for each (var type: String in eventTypes)
                    {
                        this.addTrackedEventType(type);
                    }

                }


                return roomObjectEventHandler;
            }


            return null;
        }

        public function createRoomObjectManager(): IRoomObjectManager
        {
            return new RoomObjectManager();
        }

    }
}
