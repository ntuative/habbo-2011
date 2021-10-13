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

        private var var_4375:Map = new Map();
        private var var_4376:Map = new Map();
        private var var_4377:Array = [];

        public function RoomObjectFactory(param1:IContext, param2:uint=0)
        {
            super(param1, param2);
        }

        public function addObjectEventListener(param1:Function):void
        {
            var _loc2_:String;
            if (this.var_4377.indexOf(param1) < 0)
            {
                this.var_4377.push(param1);
                if (param1 != null)
                {
                    for each (_loc2_ in this.var_4376.getKeys())
                    {
                        events.addEventListener(_loc2_, param1);
                    };
                };
            };
        }

        public function removeObjectEventListener(param1:Function):void
        {
            var _loc2_:String;
            var _loc3_:int = this.var_4377.indexOf(param1);
            if (_loc3_ >= 0)
            {
                this.var_4377.splice(_loc3_, 1);
                if (param1 != null)
                {
                    for each (_loc2_ in this.var_4376.getKeys())
                    {
                        events.removeEventListener(_loc2_, param1);
                    };
                };
            };
        }

        private function addTrackedEventType(param1:String):void
        {
            var _loc2_:Function;
            if (this.var_4376.getValue(param1) == null)
            {
                this.var_4376.add(param1, true);
                for each (_loc2_ in this.var_4377)
                {
                    if (_loc2_ != null)
                    {
                        events.addEventListener(param1, _loc2_);
                    };
                };
            };
        }

        public function createRoomObjectLogic(param1:String):IRoomObjectEventHandler
        {
            var _loc4_:IRoomObjectEventHandler;
            var _loc5_:Array;
            var _loc6_:String;
            var _loc2_:Class;
            switch (param1)
            {
                case RoomObjectLogicEnum.var_215:
                    _loc2_ = FurnitureLogic;
                    break;
                case RoomObjectLogicEnum.var_216:
                    _loc2_ = FurnitureMultiStateLogic;
                    break;
                case RoomObjectLogicEnum.var_217:
                    _loc2_ = FurniturePlaceholderLogic;
                    break;
                case RoomObjectLogicEnum.var_218:
                case RoomObjectLogicEnum.BOT:
                    _loc2_ = AvatarLogic;
                    break;
                case RoomObjectLogicEnum.var_180:
                    _loc2_ = PetLogic;
                    break;
                case RoomObjectLogicEnum.var_219:
                    _loc2_ = FurnitureRandomStateLogic;
                    break;
                case RoomObjectLogicEnum.var_220:
                    _loc2_ = FurnitureCreditLogic;
                    break;
                case RoomObjectLogicEnum.var_221:
                    _loc2_ = FurnitureStickieLogic;
                    break;
                case RoomObjectLogicEnum.var_222:
                    _loc2_ = FurniturePresentLogic;
                    break;
                case RoomObjectLogicEnum.var_223:
                    _loc2_ = FurnitureTrophyLogic;
                    break;
                case RoomObjectLogicEnum.var_224:
                    _loc2_ = FurnitureTeaserLogic;
                    break;
                case RoomObjectLogicEnum.var_225:
                    _loc2_ = FurnitureEcotronBoxLogic;
                    break;
                case RoomObjectLogicEnum.var_226:
                    _loc2_ = FurnitureDiceLogic;
                    break;
                case RoomObjectLogicEnum.var_227:
                    _loc2_ = FurnitureHockeyScoreLogic;
                    break;
                case RoomObjectLogicEnum.var_228:
                    _loc2_ = FurnitureHabboWheelLogic;
                    break;
                case RoomObjectLogicEnum.var_229:
                    _loc2_ = FurnitureQuestVendingWallItemLogic;
                    break;
                case RoomObjectLogicEnum.var_230:
                    _loc2_ = FurnitureOneWayDoorLogic;
                    break;
                case RoomObjectLogicEnum.var_231:
                    _loc2_ = FurniturePlanetSystemLogic;
                    break;
                case RoomObjectLogicEnum.var_232:
                    _loc2_ = FurnitureWindowLogic;
                    break;
                case RoomObjectLogicEnum.var_233:
                    _loc2_ = FurnitureRoomDimmerLogic;
                    break;
                case RoomObjectLogicEnum.var_234:
                    _loc2_ = RoomTileCursorLogic;
                    break;
                case RoomObjectLogicEnum.var_235:
                    _loc2_ = SelectionArrowLogic;
                    break;
                case RoomObjectLogicEnum.var_236:
                    _loc2_ = FurnitureSoundMachineLogic;
                    break;
                case RoomObjectLogicEnum.var_237:
                    _loc2_ = FurnitureJukeboxLogic;
                    break;
                case RoomObjectLogicEnum.var_238:
                    _loc2_ = FurnitureSongDiskLogic;
                    break;
                case RoomObjectLogicEnum.var_239:
                    _loc2_ = FurniturePushableLogic;
                    break;
                case RoomObjectLogicEnum.var_240:
                    _loc2_ = FurnitureClothingChangeLogic;
                    break;
                case RoomObjectLogicEnum.var_241:
                    _loc2_ = FurnitureCounterClockLogic;
                    break;
                case RoomObjectLogicEnum.var_242:
                    _loc2_ = FurnitureScoreBoardLogic;
                    break;
                case RoomObjectLogicEnum.var_243:
                    _loc2_ = FurnitureIceStormLogic;
                    break;
                case RoomObjectLogicEnum.var_244:
                    _loc2_ = FurnitureFireworksLogic;
                    break;
                case RoomObjectLogicEnum.var_245:
                    _loc2_ = FurnitureBillboardLogic;
                    break;
                case RoomObjectLogicEnum.var_246:
                    _loc2_ = FurnitureWelcomeGiftLogic;
                    break;
                case RoomObjectLogicEnum.var_247:
                    _loc2_ = RoomLogic;
                    break;
                case RoomObjectLogicEnum.var_248:
                    _loc2_ = PublicRoomLogic;
                    break;
                case RoomObjectLogicEnum.var_249:
                    _loc2_ = PublicRoomParkLogic;
                    break;
            };
            if (_loc2_ == null)
            {
                return (null);
            };
            var _loc3_:Object = new (_loc2_)();
            if ((_loc3_ is IRoomObjectEventHandler))
            {
                _loc4_ = (_loc3_ as IRoomObjectEventHandler);
                _loc4_.eventDispatcher = this.events;
                if (this.var_4375.getValue(param1) == null)
                {
                    this.var_4375.add(param1, true);
                    _loc5_ = _loc4_.getEventTypes();
                    for each (_loc6_ in _loc5_)
                    {
                        this.addTrackedEventType(_loc6_);
                    };
                };
                return (_loc4_);
            };
            return (null);
        }

        public function createRoomObjectManager():IRoomObjectManager
        {
            return (new RoomObjectManager());
        }

    }
}