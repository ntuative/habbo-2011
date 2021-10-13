﻿package com.sulake.habbo.room
{
    import com.sulake.room.renderer.IRoomRenderingCanvasMouseListener;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomObjectRoomActionEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.ChangeRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.publicroom.TryBusMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.LookToMessageComposer;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PickupObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRandomStateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ThrowDiceMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.DiceOffMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SpinWheelOfFortuneMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ViralFurniStatusMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.EnterOneWayDoorMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.QuestVendingWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveAvatarMessageComposer;

    public class RoomObjectEventHandler implements IRoomRenderingCanvasMouseListener 
    {

        private var _roomEngine:IRoomEngineServices = null;
        private var _eventIds:Map = null;
        private var var_4373:int = -1;

        public function RoomObjectEventHandler(param1:IRoomEngineServices)
        {
            this._eventIds = new Map();
            this._roomEngine = param1;
        }

        public function dispose():void
        {
            if (this._eventIds != null)
            {
                this._eventIds.dispose();
                this._eventIds = null;
            };
            this._roomEngine = null;
        }

        public function var_485(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String=null):Boolean
        {
            var _loc7_:IVector3d = new Vector3d(-100, -100);
            var _loc8_:IVector3d = new Vector3d(0);
            this.setSelectedObjectData(param1, param2, param3, param4, _loc7_, _loc8_, RoomObjectOperationEnum.OBJECT_PLACE, param5, param6);
            if (this._roomEngine != null)
            {
                this._roomEngine.setObjectMoverIconSprite(param5, param4, false, param6);
                this._roomEngine.setObjectMoverIconSpriteVisible(false);
            };
            return (true);
        }

        public function cancelRoomObjectInsert(param1:int, param2:int):Boolean
        {
            this.resetSelectedObjectData(param1, param2);
            return (true);
        }

        private function getSelectedObjectData(param1:int, param2:int):SelectedRoomObjectData
        {
            if (this._roomEngine == null)
            {
                return (null);
            };
            var _loc3_:ISelectedRoomObjectData = this._roomEngine.getSelectedObjectData(param1, param2);
            return (_loc3_ as SelectedRoomObjectData);
        }

        private function setSelectedObjectData(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:String, param8:int=0, param9:String=null):void
        {
            this.resetSelectedObjectData(param1, param2);
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc10_:SelectedRoomObjectData = new SelectedRoomObjectData(param3, param4, param7, param5, param6, param8, param9);
            this._roomEngine.setSelectedObjectData(param1, param2, _loc10_);
        }

        private function updateSelectedObjectData(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:String, param8:int=0, param9:String=null):void
        {
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc10_:SelectedRoomObjectData = new SelectedRoomObjectData(param3, param4, param7, param5, param6, param8, param9);
            this._roomEngine.setSelectedObjectData(param1, param2, _loc10_);
        }

        private function resetSelectedObjectData(param1:int, param2:int):void
        {
            var _loc4_:IRoomObjectController;
            var _loc5_:int;
            var _loc6_:int;
            if (this._roomEngine == null)
            {
                return;
            };
            if (this._roomEngine != null)
            {
                this._roomEngine.removeObjectMoverIconSprite();
            };
            var _loc3_:SelectedRoomObjectData = this.getSelectedObjectData(param1, param2);
            if (_loc3_ != null)
            {
                if (_loc3_.operation == RoomObjectOperationEnum.OBJECT_MOVE)
                {
                    _loc4_ = (this._roomEngine.getRoomObject(param1, param2, _loc3_.id, _loc3_.category) as IRoomObjectController);
                    if (_loc4_ != null)
                    {
                        _loc4_.setLocation(_loc3_.loc);
                        _loc4_.setDirection(_loc3_.dir);
                    };
                    this.setObjectAlphaMultiplier(_loc4_, 1);
                };
                if (_loc3_.operation == RoomObjectOperationEnum.OBJECT_PLACE)
                {
                    _loc5_ = _loc3_.id;
                    _loc6_ = _loc3_.category;
                    switch (_loc6_)
                    {
                        case RoomObjectCategoryEnum.var_72:
                            this._roomEngine.disposeObjectFurniture(param1, param2, _loc5_);
                            break;
                        case RoomObjectCategoryEnum.var_73:
                            this._roomEngine.disposeObjectWallItem(param1, param2, _loc5_);
                            break;
                        case RoomObjectCategoryEnum.var_71:
                            this._roomEngine.disposeObjectUser(param1, param2, _loc5_);
                            break;
                    };
                };
                this._roomEngine.setSelectedObjectData(param1, param2, null);
            };
        }

        public function setSelectedObject(param1:int, param2:int, param3:int, param4:int):void
        {
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc5_:IEventDispatcher = this._roomEngine.events;
            if (_loc5_ == null)
            {
                return;
            };
            switch (param4)
            {
                case RoomObjectCategoryEnum.var_71:
                case RoomObjectCategoryEnum.var_72:
                case RoomObjectCategoryEnum.var_73:
                    if (param4 == RoomObjectCategoryEnum.var_71)
                    {
                        this.setSelectedAvatar(param1, param2, param3, true);
                    }
                    else
                    {
                        this.setSelectedAvatar(param1, param2, 0, false);
                    };
                    _loc5_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_402, param1, param2, param3, param4));
                    return;
            };
        }

        public function processRoomCanvasMouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomObject, param3:IRoomGeometry):void
        {
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            var _loc4_:String = param2.getType();
            var _loc5_:int = this._roomEngine.getRoomObjectCategory(_loc4_);
            if (_loc5_ != RoomObjectCategoryEnum.var_354)
            {
                if (!this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory))
                {
                    _loc5_ = RoomObjectCategoryEnum.var_352;
                }
                else
                {
                    if (_loc5_ != RoomObjectCategoryEnum.var_71)
                    {
                        _loc5_ = RoomObjectCategoryEnum.var_352;
                    };
                };
            };
            var _loc6_:String = this.getMouseEventId(_loc5_, param1.type);
            if (_loc6_ == param1.eventId)
            {
                if ((((((param1.type == MouseEvent.CLICK) || (param1.type == MouseEvent.DOUBLE_CLICK)) || (param1.type == MouseEvent.MOUSE_DOWN)) || (param1.type == MouseEvent.MOUSE_UP)) || (param1.type == MouseEvent.MOUSE_MOVE)))
                {
                    return;
                };
            }
            else
            {
                if (param1.eventId != null)
                {
                    this.setMouseEventId(_loc5_, param1.type, param1.eventId);
                };
            };
            if (param2.getMouseHandler() != null)
            {
                param2.getMouseHandler().mouseEvent(param1, param3);
            };
        }

        public function handleRoomObjectEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            if (param1 == null)
            {
                return;
            };
            if ((param1 is RoomObjectMouseEvent))
            {
                this.handleRoomObjectMouseEvent((param1 as RoomObjectMouseEvent), param2, param3);
                return;
            };
            switch (param1.type)
            {
                case RoomObjectStateChangeEvent.var_1180:
                    this.handleObjectStateChange((param1 as RoomObjectStateChangeEvent), param2, param3);
                    return;
                case RoomObjectStateChangeEvent.var_1195:
                    this.handleObjectRandomStateChange((param1 as RoomObjectStateChangeEvent), param2, param3);
                    return;
                case RoomObjectDimmerStateUpdateEvent.var_400:
                    this.handleObjectDimmerStateEvent(param1, param2, param3);
                    return;
                case RoomObjectMoveEvent.var_1202:
                    this.handleSelectedObjectMove(param1, param2, param3);
                    return;
                case RoomObjectMoveEvent.var_1203:
                    this.handleSelectedObjectRemove(param1, param2, param3);
                    return;
                case RoomObjectWidgetRequestEvent.var_411:
                case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                case RoomObjectWidgetRequestEvent.var_407:
                case RoomObjectWidgetRequestEvent.var_408:
                case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_TROPHY:
                case RoomObjectWidgetRequestEvent.var_409:
                case RoomObjectWidgetRequestEvent.var_410:
                case RoomObjectWidgetRequestEvent.var_412:
                case RoomObjectWidgetRequestEvent.var_417:
                case RoomObjectWidgetRequestEvent.var_418:
                case RoomObjectWidgetRequestEvent.var_419:
                    this.handleObjectWidgetRequestEvent(param1, param2, param3);
                    return;
                case RoomObjectFurnitureActionEvent.var_1182:
                case RoomObjectFurnitureActionEvent.var_1183:
                case RoomObjectFurnitureActionEvent.var_1190:
                case RoomObjectFurnitureActionEvent.var_1189:
                case RoomObjectFurnitureActionEvent.var_1184:
                case RoomObjectFurnitureActionEvent.var_1213:
                case RoomObjectFurnitureActionEvent.var_1204:
                    this.handleObjectActionEvent(param1, param2, param3);
                    return;
                case RoomObjectFurnitureActionEvent.var_1194:
                case RoomObjectFurnitureActionEvent.var_1191:
                case RoomObjectFurnitureActionEvent.var_1192:
                case RoomObjectFurnitureActionEvent.var_1193:
                    this.handleObjectSoundMachineEvent(param1, param2, param3);
                    return;
                case RoomObjectFurnitureActionEvent.var_1210:
                case RoomObjectFurnitureActionEvent.var_1207:
                case RoomObjectFurnitureActionEvent.var_1208:
                case RoomObjectFurnitureActionEvent.var_1209:
                    this.handleObjectJukeboxEvent(param1, param2, param3);
                    return;
                case RoomObjectRoomAdEvent.var_50:
                case RoomObjectRoomAdEvent.var_344:
                case RoomObjectRoomAdEvent.var_345:
                case RoomObjectRoomAdEvent.var_346:
                case RoomObjectRoomAdEvent.ROOM_AD_LOAD_IMAGE:
                    this.handleObjectRoomAdEvent(param1, param2, param3);
                    return;
                case RoomObjectRoomActionEvent.var_1197:
                case RoomObjectRoomActionEvent.var_1617:
                case RoomObjectRoomActionEvent.var_1198:
                    this.handleRoomActionEvent(param1, param2, param3);
                    return;
                case RoomObjectFurnitureActionEvent.var_1181:
                case RoomObjectFurnitureActionEvent.var_445:
                    this.handleRoomActionMouseRequestEvent(param1, param2, param3);
                    return;
                default:
                    Logger.log("*** Unhandled room object event in RoomObjectEventHandler::handleRoomObjectEvent !!! ***");
            };
        }

        private function setMouseEventId(param1:int, param2:String, param3:String):void
        {
            var _loc4_:Map = (this._eventIds.getValue(String(param1)) as Map);
            if (_loc4_ == null)
            {
                _loc4_ = new Map();
                this._eventIds.add(param1, _loc4_);
            };
            _loc4_.remove(param2);
            _loc4_.add(param2, param3);
        }

        private function getMouseEventId(param1:int, param2:String):String
        {
            var _loc3_:Map = (this._eventIds.getValue(String(param1)) as Map);
            if (_loc3_ == null)
            {
                return (null);
            };
            return (_loc3_.getValue(param2) as String);
        }

        private function handleRoomObjectMouseEvent(param1:RoomObjectMouseEvent, param2:int, param3:int):void
        {
            switch (param1.type)
            {
                case RoomObjectMouseEvent.var_483:
                    this.handleRoomObjectMouseClick(param1, param2, param3);
                    return;
                case RoomObjectMouseEvent.var_484:
                    this.handleRoomObjectMouseMove(param1, param2, param3);
                    return;
                case RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_DOWN:
                    this.var_4374(param1, param2, param3);
                    return;
            };
        }

        private function handleRoomObjectMouseClick(param1:RoomObjectMouseEvent, param2:int, param3:int):void
        {
            var _loc11_:RoomObjectTileMouseEvent;
            var _loc12_:Boolean;
            var _loc13_:Boolean;
            var _loc14_:String;
            var _loc15_:String;
            var _loc16_:IEventDispatcher;
            if (param1 == null)
            {
                return;
            };
            var _loc4_:String = RoomObjectOperationEnum.OBJECT_UNDEFINED;
            var _loc5_:SelectedRoomObjectData = this.getSelectedObjectData(param2, param3);
            if (_loc5_ != null)
            {
                _loc4_ = _loc5_.operation;
            };
            var _loc6_:int = param1.objectId;
            var _loc7_:String = param1.objectType;
            var _loc8_:int = this._roomEngine.getRoomObjectCategory(_loc7_);
            var _loc9_:int = _loc8_;
            var _loc10_:String = param1.eventId;
            switch (_loc4_)
            {
                case RoomObjectOperationEnum.OBJECT_MOVE:
                    if (_loc8_ == RoomObjectCategoryEnum.var_354)
                    {
                        if (_loc5_ != null)
                        {
                            this.modifyRoomObject(param2, param3, _loc5_.id, _loc5_.category, RoomObjectOperationEnum.OBJECT_MOVE_TO);
                        };
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_PLACE:
                    if (_loc8_ == RoomObjectCategoryEnum.var_354)
                    {
                        this.placeObject(param2, param3);
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_UNDEFINED:
                    if (_loc8_ == RoomObjectCategoryEnum.var_354)
                    {
                        _loc11_ = (param1 as RoomObjectTileMouseEvent);
                        if (_loc11_ != null)
                        {
                            this.walkTo((_loc11_.tileX + 0.499), (_loc11_.tileY + 0.499));
                        };
                    }
                    else
                    {
                        this.setSelectedObject(param2, param3, _loc6_, _loc8_);
                        _loc12_ = false;
                        _loc13_ = false;
                        if (_loc8_ == RoomObjectCategoryEnum.var_71)
                        {
                            if (!this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory))
                            {
                                _loc12_ = true;
                            }
                            else
                            {
                                _loc13_ = true;
                            };
                        }
                        else
                        {
                            if (((_loc8_ == RoomObjectCategoryEnum.var_72) || (_loc8_ == RoomObjectCategoryEnum.var_73)))
                            {
                                if (((param1.ctrlKey) || (param1.shiftKey)))
                                {
                                    if (param1.shiftKey)
                                    {
                                        if (_loc8_ == RoomObjectCategoryEnum.var_72)
                                        {
                                            this.modifyRoomObject(param2, param3, _loc6_, _loc8_, RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE);
                                        };
                                    }
                                    else
                                    {
                                        this.modifyRoomObject(param2, param3, _loc6_, _loc8_, RoomObjectOperationEnum.OBJECT_PICKUP);
                                    };
                                    if (!this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory))
                                    {
                                        _loc12_ = true;
                                    }
                                    else
                                    {
                                        _loc13_ = true;
                                    };
                                };
                            };
                        };
                        if (_loc10_ != null)
                        {
                            if (_loc12_)
                            {
                                this.setMouseEventId(RoomObjectCategoryEnum.var_354, MouseEvent.CLICK, _loc10_);
                            };
                            if (_loc13_)
                            {
                                this.setMouseEventId(RoomObjectCategoryEnum.var_352, MouseEvent.CLICK, _loc10_);
                            };
                        };
                    };
                    break;
            };
            if (_loc8_ == RoomObjectCategoryEnum.var_354)
            {
                _loc14_ = this.getMouseEventId(RoomObjectCategoryEnum.var_352, MouseEvent.CLICK);
                _loc15_ = this.getMouseEventId(RoomObjectCategoryEnum.var_71, MouseEvent.CLICK);
                if (((!(_loc14_ == _loc10_)) && (!(_loc15_ == _loc10_))))
                {
                    _loc16_ = this._roomEngine.events;
                    if (_loc16_ != null)
                    {
                        _loc16_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_403, param2, param3, -1, RoomObjectCategoryEnum.var_352));
                    };
                    this.setSelectedAvatar(param2, param3, 0, false);
                };
            };
        }

        private function handleRoomObjectMouseMove(param1:RoomObjectMouseEvent, param2:int, param3:int):void
        {
            var _loc8_:IRoomObjectController;
            var _loc9_:RoomObjectTileMouseEvent;
            var _loc10_:RoomObjectUpdateMessage;
            var _loc11_:int;
            var _loc12_:int;
            var _loc13_:int;
            if (param1 == null)
            {
                return;
            };
            var _loc4_:String = RoomObjectOperationEnum.OBJECT_UNDEFINED;
            var _loc5_:SelectedRoomObjectData = this.getSelectedObjectData(param2, param3);
            if (_loc5_ != null)
            {
                _loc4_ = _loc5_.operation;
            };
            var _loc6_:String = param1.objectType;
            var _loc7_:int = this._roomEngine.getRoomObjectCategory(_loc6_);
            if (this._roomEngine != null)
            {
                _loc8_ = this._roomEngine.getTileCursor(param2, param3);
                if (((!(_loc8_ == null)) && (!(_loc8_.getEventHandler() == null))))
                {
                    _loc9_ = (param1 as RoomObjectTileMouseEvent);
                    _loc10_ = null;
                    if (_loc9_ != null)
                    {
                        _loc11_ = (_loc9_.tileX + 0.499);
                        _loc12_ = (_loc9_.tileY + 0.499);
                        _loc13_ = (_loc9_.tileZ + 0.499);
                        _loc10_ = new RoomObjectUpdateMessage(new Vector3d(_loc11_, _loc12_, _loc13_), null);
                        _loc8_.getEventHandler().processUpdateMessage(_loc10_);
                        _loc10_ = new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.var_1185);
                    }
                    else
                    {
                        _loc10_ = new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.var_1186);
                    };
                    _loc8_.getEventHandler().processUpdateMessage(_loc10_);
                };
            };
            switch (_loc4_)
            {
                case RoomObjectOperationEnum.OBJECT_MOVE:
                    if (_loc7_ == RoomObjectCategoryEnum.var_354)
                    {
                        this.handleObjectMove(param1, param2, param3);
                    };
                    return;
                case RoomObjectOperationEnum.OBJECT_PLACE:
                    if (_loc7_ == RoomObjectCategoryEnum.var_354)
                    {
                        this.handleObjectPlace(param1, param2, param3);
                    };
            };
        }

        private function var_4374(param1:RoomObjectMouseEvent, param2:int, param3:int):void
        {
            var _loc10_:IEventDispatcher;
            if (param1 == null)
            {
                return;
            };
            var _loc4_:String = RoomObjectOperationEnum.OBJECT_UNDEFINED;
            var _loc5_:SelectedRoomObjectData = this.getSelectedObjectData(param2, param3);
            if (_loc5_ != null)
            {
                _loc4_ = _loc5_.operation;
            };
            var _loc6_:int = param1.objectId;
            var _loc7_:String = param1.objectType;
            var _loc8_:int = this._roomEngine.getRoomObjectCategory(_loc7_);
            var _loc9_:int = _loc8_;
            switch (_loc4_)
            {
                case RoomObjectOperationEnum.OBJECT_UNDEFINED:
                    if (((_loc8_ == RoomObjectCategoryEnum.var_72) || (_loc8_ == RoomObjectCategoryEnum.var_73)))
                    {
                        if (param1.altKey)
                        {
                            _loc10_ = this._roomEngine.events;
                            if (_loc10_ != null)
                            {
                                _loc10_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_406, param2, param3, _loc6_, _loc8_));
                            };
                        };
                    };
                    return;
            };
        }

        private function handleObjectMove(param1:RoomObjectMouseEvent, param2:int, param3:int):void
        {
            var _loc7_:Boolean;
            var _loc8_:TileHeightMap;
            var _loc9_:RoomObjectTileMouseEvent;
            var _loc10_:RoomObjectWallMouseEvent;
            var _loc11_:IVector3d;
            var _loc12_:IVector3d;
            var _loc13_:IVector3d;
            var _loc14_:Number;
            var _loc15_:Number;
            var _loc16_:Number;
            if (((param1 == null) || (this._roomEngine == null)))
            {
                return;
            };
            var _loc4_:IEventDispatcher = this._roomEngine.events;
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:SelectedRoomObjectData = this.getSelectedObjectData(param2, param3);
            if (_loc5_ == null)
            {
                return;
            };
            var _loc6_:IRoomObjectController = (this._roomEngine.getRoomObject(param2, param3, _loc5_.id, _loc5_.category) as IRoomObjectController);
            if (_loc6_ != null)
            {
                _loc7_ = true;
                if (_loc5_.category == RoomObjectCategoryEnum.var_72)
                {
                    _loc8_ = this._roomEngine.getTileHeightMap(param2, param3);
                    _loc9_ = (param1 as RoomObjectTileMouseEvent);
                    if (!((!(_loc9_ == null)) && (this.handleFurnitureMove(_loc6_, _loc5_, (_loc9_.tileX + 0.5), (_loc9_.tileY + 0.5), _loc8_))))
                    {
                        this.handleFurnitureMove(_loc6_, _loc5_, _loc5_.loc.x, _loc5_.loc.y, _loc8_);
                        _loc7_ = false;
                    };
                }
                else
                {
                    if (_loc5_.category == RoomObjectCategoryEnum.var_73)
                    {
                        _loc7_ = false;
                        _loc10_ = (param1 as RoomObjectWallMouseEvent);
                        if (_loc10_ != null)
                        {
                            _loc11_ = _loc10_.wallLocation;
                            _loc12_ = _loc10_.wallWidth;
                            _loc13_ = _loc10_.wallHeight;
                            _loc14_ = _loc10_.x;
                            _loc15_ = _loc10_.y;
                            _loc16_ = _loc10_.direction;
                            if (this.handleWallItemMove(_loc6_, _loc5_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_, _loc16_))
                            {
                                _loc7_ = true;
                            };
                        };
                        if (!_loc7_)
                        {
                            _loc6_.setLocation(_loc5_.loc);
                            _loc6_.setDirection(_loc5_.dir);
                        };
                        this._roomEngine.updateObjectRoomWindow(param2, param3, _loc5_.id, _loc7_);
                    };
                };
                if (_loc7_)
                {
                    this.setObjectAlphaMultiplier(_loc6_, 0.5);
                    this._roomEngine.setObjectMoverIconSpriteVisible(false);
                }
                else
                {
                    this.setObjectAlphaMultiplier(_loc6_, 0);
                    this._roomEngine.setObjectMoverIconSpriteVisible(true);
                };
            };
        }

        private function handleObjectPlace(param1:RoomObjectMouseEvent, param2:int, param3:int):void
        {
            var _loc9_:Array;
            var _loc10_:IVector3d;
            var _loc11_:Boolean;
            var _loc12_:TileHeightMap;
            var _loc13_:IVector3d;
            var _loc14_:IVector3d;
            var _loc15_:IVector3d;
            var _loc16_:Number;
            var _loc17_:Number;
            var _loc18_:Number;
            if (((param1 == null) || (this._roomEngine == null)))
            {
                return;
            };
            var _loc4_:IEventDispatcher = this._roomEngine.events;
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:SelectedRoomObjectData = this.getSelectedObjectData(param2, param3);
            if (_loc5_ == null)
            {
                return;
            };
            var _loc6_:IRoomObjectController = (this._roomEngine.getRoomObject(param2, param3, _loc5_.id, _loc5_.category) as IRoomObjectController);
            var _loc7_:RoomObjectTileMouseEvent = (param1 as RoomObjectTileMouseEvent);
            var _loc8_:RoomObjectWallMouseEvent = (param1 as RoomObjectWallMouseEvent);
            if (_loc6_ == null)
            {
                if (((_loc5_.category == RoomObjectCategoryEnum.var_72) && (!(_loc7_ == null))))
                {
                    this._roomEngine.addObjectFurniture(param2, param3, _loc5_.id, _loc5_.typeId, new Vector3d(), new Vector3d(), 0, null, Number(_loc5_.instanceData));
                }
                else
                {
                    if (((_loc5_.category == RoomObjectCategoryEnum.var_73) && (!(_loc8_ == null))))
                    {
                        this._roomEngine.addObjectWallItem(param2, param3, _loc5_.id, _loc5_.typeId, new Vector3d(), new Vector3d(), 0, _loc5_.instanceData);
                    }
                    else
                    {
                        if (((_loc5_.category == RoomObjectCategoryEnum.var_71) && (!(_loc7_ == null))))
                        {
                            this._roomEngine.addObjectUser(param2, param3, _loc5_.id, new Vector3d(), new Vector3d(180), 180, _loc5_.typeId, _loc5_.instanceData);
                        };
                    };
                };
                _loc6_ = (this._roomEngine.getRoomObject(param2, param3, _loc5_.id, _loc5_.category) as IRoomObjectController);
                if (_loc6_ != null)
                {
                    if (_loc5_.category == RoomObjectCategoryEnum.var_72)
                    {
                        if (_loc6_.getModel() != null)
                        {
                            _loc9_ = _loc6_.getModel().getNumberArray(RoomObjectVariableEnum.var_744);
                            if (((!(_loc9_ == null)) && (_loc9_.length > 0)))
                            {
                                _loc10_ = new Vector3d(_loc9_[0]);
                                _loc6_.setDirection(_loc10_);
                                this.updateSelectedObjectData(param2, param3, _loc5_.id, _loc5_.category, _loc5_.loc, _loc10_, _loc5_.operation, _loc5_.typeId, _loc5_.instanceData);
                                _loc5_ = this.getSelectedObjectData(param2, param3);
                                if (_loc5_ == null)
                                {
                                    return;
                                };
                            };
                        };
                    };
                };
                this.setObjectAlphaMultiplier(_loc6_, 0.5);
                this._roomEngine.setObjectMoverIconSpriteVisible(true);
            };
            if (_loc6_ != null)
            {
                _loc11_ = true;
                _loc12_ = this._roomEngine.getTileHeightMap(param2, param3);
                if (_loc5_.category == RoomObjectCategoryEnum.var_72)
                {
                    if (!((!(_loc7_ == null)) && (this.handleFurnitureMove(_loc6_, _loc5_, (_loc7_.tileX + 0.5), (_loc7_.tileY + 0.5), _loc12_))))
                    {
                        this._roomEngine.disposeObjectFurniture(param2, param3, _loc5_.id);
                        _loc11_ = false;
                    };
                }
                else
                {
                    if (_loc5_.category == RoomObjectCategoryEnum.var_73)
                    {
                        _loc11_ = false;
                        if (_loc8_ != null)
                        {
                            _loc13_ = _loc8_.wallLocation;
                            _loc14_ = _loc8_.wallWidth;
                            _loc15_ = _loc8_.wallHeight;
                            _loc16_ = _loc8_.x;
                            _loc17_ = _loc8_.y;
                            _loc18_ = _loc8_.direction;
                            if (this.handleWallItemMove(_loc6_, _loc5_, _loc13_, _loc14_, _loc15_, _loc16_, _loc17_, _loc18_))
                            {
                                _loc11_ = true;
                            };
                        };
                        if (!_loc11_)
                        {
                            this._roomEngine.disposeObjectWallItem(param2, param3, _loc5_.id);
                        };
                        this._roomEngine.updateObjectRoomWindow(param2, param3, _loc5_.id, _loc11_);
                    }
                    else
                    {
                        if (_loc5_.category == RoomObjectCategoryEnum.var_71)
                        {
                            if (!((!(_loc7_ == null)) && (this.handleUserMove(_loc6_, _loc5_, (_loc7_.tileX + 0.5), (_loc7_.tileY + 0.5), _loc12_))))
                            {
                                this._roomEngine.disposeObjectUser(param2, param3, _loc5_.id);
                                _loc11_ = false;
                            };
                        };
                    };
                };
                this._roomEngine.setObjectMoverIconSpriteVisible((!(_loc11_)));
            };
        }

        private function handleObjectStateChange(param1:RoomObjectStateChangeEvent, param2:int, param3:int):void
        {
            if (param1 == null)
            {
                return;
            };
            this.changeObjectState(param2, param3, param1.objectId, param1.objectType, param1.param, false);
        }

        private function handleObjectRandomStateChange(param1:RoomObjectStateChangeEvent, param2:int, param3:int):void
        {
            if (param1 == null)
            {
                return;
            };
            this.changeObjectState(param2, param3, param1.objectId, param1.objectType, param1.param, true);
        }

        private function handleObjectWidgetRequestEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            if (((this._roomEngine == null) || (param1 == null)))
            {
                return;
            };
            var _loc4_:int = param1.objectId;
            var _loc5_:String = param1.objectType;
            var _loc6_:int = this._roomEngine.getRoomObjectCategory(_loc5_);
            var _loc7_:IEventDispatcher = this._roomEngine.events;
            if (_loc7_ != null)
            {
                switch (param1.type)
                {
                    case RoomObjectWidgetRequestEvent.var_411:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_411, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_407:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_407, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_408:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_408, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_TROPHY:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_TROPHY, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_409:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_409, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_410:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_410, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_412:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_412, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_417:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_417, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_418:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_418, param2, param3, _loc4_, _loc6_));
                        return;
                    case RoomObjectWidgetRequestEvent.var_419:
                        _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.var_419, param2, param3, _loc4_, _loc6_));
                        return;
                };
            };
        }

        private function handleObjectRoomAdEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            var _loc7_:String;
            var _loc8_:RoomObjectRoomAdEvent;
            if ((((this._roomEngine == null) || (this._roomEngine.events == null)) || (param1 == null)))
            {
                return;
            };
            var _loc4_:int = param1.objectId;
            var _loc5_:String = param1.objectType;
            var _loc6_:int = this._roomEngine.getRoomObjectCategory(_loc5_);
            switch (param1.type)
            {
                case RoomObjectRoomAdEvent.var_50:
                    this._roomEngine.events.dispatchEvent(param1);
                    _loc7_ = RoomEngineObjectEvent.var_413;
                    break;
                case RoomObjectRoomAdEvent.var_344:
                    _loc7_ = RoomEngineObjectEvent.var_414;
                    break;
                case RoomObjectRoomAdEvent.var_345:
                    _loc7_ = RoomEngineObjectEvent.var_415;
                    break;
                case RoomObjectRoomAdEvent.var_346:
                    _loc7_ = RoomEngineObjectEvent.var_416;
                    break;
                case RoomObjectRoomAdEvent.ROOM_AD_LOAD_IMAGE:
                    if ((param1 is RoomObjectRoomAdEvent))
                    {
                        _loc8_ = (param1 as RoomObjectRoomAdEvent);
                        this._roomEngine.requestRoomAdImage(param2, _loc4_, _loc8_.imageUrl, _loc8_.clickUrl);
                    };
                    break;
            };
            if (_loc7_ == null)
            {
                return;
            };
            this._roomEngine.events.dispatchEvent(new RoomEngineObjectEvent(_loc7_, param2, param3, _loc4_, _loc6_));
        }

        private function handleObjectActionEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            if (param1 == null)
            {
                return;
            };
            this.useObject(param2, param3, param1.objectId, param1.objectType, param1.type);
        }

        private function handleObjectSoundMachineEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc4_:int = this._roomEngine.getRoomObjectCategory(param1.objectType);
            var _loc5_:SelectedRoomObjectData = this.getSelectedObjectData(param2, param3);
            if (_loc5_ != null)
            {
                if (((_loc5_.category == _loc4_) && (_loc5_.id == param1.objectId)))
                {
                    if (_loc5_.operation == RoomObjectOperationEnum.OBJECT_PLACE)
                    {
                        return;
                    };
                };
            };
            switch (param1.type)
            {
                case RoomObjectFurnitureActionEvent.var_1194:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_932, param2, param3, param1.objectId, _loc4_));
                    return;
                case RoomObjectFurnitureActionEvent.var_1191:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_1552, param2, param3, param1.objectId, _loc4_));
                    return;
                case RoomObjectFurnitureActionEvent.var_1192:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_1553, param2, param3, param1.objectId, _loc4_));
                    return;
                case RoomObjectFurnitureActionEvent.var_1193:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_933, param2, param3, param1.objectId, _loc4_));
                    return;
            };
        }

        private function handleObjectJukeboxEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc4_:int = this._roomEngine.getRoomObjectCategory(param1.objectType);
            var _loc5_:SelectedRoomObjectData = this.getSelectedObjectData(param2, param3);
            if (_loc5_ != null)
            {
                if (((_loc5_.category == _loc4_) && (_loc5_.id == param1.objectId)))
                {
                    if (_loc5_.operation == RoomObjectOperationEnum.OBJECT_PLACE)
                    {
                        return;
                    };
                };
            };
            switch (param1.type)
            {
                case RoomObjectFurnitureActionEvent.var_1210:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_931, param2, param3, param1.objectId, _loc4_));
                    return;
                case RoomObjectFurnitureActionEvent.var_1207:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_1554, param2, param3, param1.objectId, _loc4_));
                    return;
                case RoomObjectFurnitureActionEvent.var_1208:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_1555, param2, param3, param1.objectId, _loc4_));
                    return;
                case RoomObjectFurnitureActionEvent.var_1209:
                    this._roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent(RoomEngineSoundMachineEvent.var_420, param2, param3, param1.objectId, _loc4_));
                    return;
            };
        }

        private function handleRoomActionEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            var _loc4_:RoomObjectRoomActionEvent;
            if (param1 == null)
            {
                return;
            };
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.connection == null))))
            {
                switch (param1.type)
                {
                    case RoomObjectRoomActionEvent.var_1197:
                        _loc4_ = (param1 as RoomObjectRoomActionEvent);
                        if (_loc4_ != null)
                        {
                            this._roomEngine.connection.send(new ChangeRoomMessageComposer(_loc4_.param));
                        };
                        return;
                    case RoomObjectRoomActionEvent.var_1198:
                        this._roomEngine.connection.send(new TryBusMessageComposer());
                        return;
                };
            };
        }

        private function handleRoomActionMouseRequestEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            this._roomEngine.requestMouseCursor(param1.type, param1.objectId, param1.objectType);
        }

        private function handleObjectInitializeEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            if (param1 == null)
            {
                return;
            };
            this.initializeObject(param2, param3, param1.objectId, param1.objectType, param1.type);
        }

        private function handleObjectDimmerStateEvent(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            var _loc5_:RoomObjectDimmerStateUpdateEvent;
            var _loc6_:RoomEngineDimmerStateEvent;
            var _loc4_:int = param1.objectId;
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.connection == null))))
            {
                switch (param1.type)
                {
                    case RoomObjectDimmerStateUpdateEvent.var_400:
                        _loc5_ = (param1 as RoomObjectDimmerStateUpdateEvent);
                        if (_loc5_ != null)
                        {
                            _loc6_ = new RoomEngineDimmerStateEvent(param2, param3, _loc5_.state, _loc5_.presetId, _loc5_.effectId, _loc5_.color, _loc5_.brightness);
                            this._roomEngine.events.dispatchEvent(_loc6_);
                        };
                        return;
                };
            };
        }

        private function handleSelectedObjectMove(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            var _loc9_:IVector3d;
            var _loc10_:RoomObjectUpdateMessage;
            if (this._roomEngine == null)
            {
                return;
            };
            var _loc4_:int = param1.objectId;
            var _loc5_:String = param1.objectType;
            var _loc6_:int = this._roomEngine.getRoomObjectCategory(_loc5_);
            var _loc7_:IRoomObjectController = (this._roomEngine.getRoomObject(param2, param3, _loc4_, _loc6_) as IRoomObjectController);
            var _loc8_:IRoomObjectController = this._roomEngine.getSelectionArrow(param2, param3);
            if ((((!(_loc7_ == null)) && (!(_loc8_ == null))) && (!(_loc8_.getEventHandler() == null))))
            {
                _loc9_ = _loc7_.getLocation();
                _loc10_ = new RoomObjectUpdateMessage(_loc9_, null);
                _loc8_.getEventHandler().processUpdateMessage(_loc10_);
            };
        }

        private function handleSelectedObjectRemove(param1:RoomObjectEvent, param2:int, param3:int):void
        {
            this.setSelectedAvatar(param2, param3, 0, false);
        }

        private function handleFurnitureMove(param1:IRoomObjectController, param2:SelectedRoomObjectData, param3:int, param4:int, param5:TileHeightMap):Boolean
        {
            if (((param1 == null) || (param2 == null)))
            {
                return (false);
            };
            var _loc6_:Vector3d = new Vector3d();
            _loc6_.assign(param1.getDirection());
            param1.setDirection(param2.dir);
            var _loc7_:Vector3d = new Vector3d(param3, param4, 0);
            var _loc8_:Vector3d = new Vector3d();
            _loc8_.assign(param1.getDirection());
            var _loc9_:Vector3d = this.validateFurnitureLocation(param1, _loc7_, param2.loc, param2.dir, param5);
            if (_loc9_ == null)
            {
                _loc8_.x = this.getValidFurnitureDirection(param1, true);
                param1.setDirection(_loc8_);
                _loc9_ = this.validateFurnitureLocation(param1, _loc7_, param2.loc, param2.dir, param5);
            };
            if (_loc9_ == null)
            {
                param1.setDirection(_loc6_);
                return (false);
            };
            param1.setLocation(_loc9_);
            if (_loc8_)
            {
                param1.setDirection(_loc8_);
            };
            return (true);
        }

        private function handleWallItemMove(param1:IRoomObjectController, param2:SelectedRoomObjectData, param3:IVector3d, param4:IVector3d, param5:IVector3d, param6:Number, param7:Number, param8:Number):Boolean
        {
            if (((param1 == null) || (param2 == null)))
            {
                return (false);
            };
            var _loc9_:Vector3d = new Vector3d(param8);
            var _loc10_:Vector3d = this.validateWallItemLocation(param1, param3, param4, param5, param6, param7, param2);
            if (_loc10_ == null)
            {
                return (false);
            };
            param1.setLocation(_loc10_);
            param1.setDirection(_loc9_);
            return (true);
        }

        private function handleUserMove(param1:IRoomObjectController, param2:SelectedRoomObjectData, param3:int, param4:int, param5:TileHeightMap):Boolean
        {
            if (((param1 == null) || (param2 == null)))
            {
                return (false);
            };
            var _loc6_:Vector3d = new Vector3d(param3, param4, 0);
            var _loc7_:Vector3d = this.validateUserLocation(param1, _loc6_, param2.loc, param2.dir, param5);
            if (_loc7_ == null)
            {
                return (false);
            };
            param1.setLocation(_loc7_);
            return (true);
        }

        private function validateFurnitureDirection(param1:IRoomObject, param2:IVector3d, param3:TileHeightMap):Boolean
        {
            if ((((param1 == null) || (param1.getModel() == null)) || (param2 == null)))
            {
                return (false);
            };
            var _loc4_:IVector3d = param1.getDirection();
            var _loc5_:IVector3d = param1.getLocation();
            if (((_loc4_ == null) || (_loc5_ == null)))
            {
                return (false);
            };
            if ((_loc4_.x % 180) == (param2.x % 180))
            {
                return (true);
            };
            var _loc6_:int = param1.getModel().getNumber(RoomObjectVariableEnum.var_738);
            var _loc7_:int = param1.getModel().getNumber(RoomObjectVariableEnum.var_739);
            if (_loc6_ < 1)
            {
                _loc6_ = 1;
            };
            if (_loc7_ < 1)
            {
                _loc7_ = 1;
            };
            var _loc8_:int = _loc6_;
            var _loc9_:int = _loc7_;
            var _loc10_:int;
            var _loc11_:int = int(((int((param2.x + 45)) % 360) / 90));
            if (((_loc11_ == 1) || (_loc11_ == 3)))
            {
                _loc10_ = _loc6_;
                _loc6_ = _loc7_;
                _loc7_ = _loc10_;
            };
            _loc11_ = int(((int((_loc4_.x + 45)) % 360) / 90));
            if (((_loc11_ == 1) || (_loc11_ == 3)))
            {
                _loc10_ = _loc8_;
                _loc8_ = _loc9_;
                _loc9_ = _loc10_;
            };
            if (((!(param3 == null)) && (!(_loc5_ == null))))
            {
                if (param3.validateLocation(_loc5_.x, _loc5_.y, _loc6_, _loc7_, _loc5_.x, _loc5_.y, _loc8_, _loc9_))
                {
                    return (true);
                };
                return (false);
            };
            return (false);
        }

        private function validateFurnitureLocation(param1:IRoomObject, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:TileHeightMap):Vector3d
        {
            var _loc15_:Vector3d;
            if ((((param1 == null) || (param1.getModel() == null)) || (param2 == null)))
            {
                return (null);
            };
            var _loc6_:IVector3d = param1.getDirection();
            if (_loc6_ == null)
            {
                return (null);
            };
            if (((param3 == null) || (param4 == null)))
            {
                return (null);
            };
            if (((param2.x == param3.x) && (param2.y == param3.y)))
            {
                if (_loc6_.x == param4.x)
                {
                    _loc15_ = new Vector3d();
                    _loc15_.assign(param3);
                    return (_loc15_);
                };
            };
            var _loc7_:int = param1.getModel().getNumber(RoomObjectVariableEnum.var_738);
            var _loc8_:int = param1.getModel().getNumber(RoomObjectVariableEnum.var_739);
            if (_loc7_ < 1)
            {
                _loc7_ = 1;
            };
            if (_loc8_ < 1)
            {
                _loc8_ = 1;
            };
            var _loc9_:int = param3.x;
            var _loc10_:int = param3.y;
            var _loc11_:int = _loc7_;
            var _loc12_:int = _loc8_;
            var _loc13_:int;
            var _loc14_:int = int(((int((_loc6_.x + 45)) % 360) / 90));
            if (((_loc14_ == 1) || (_loc14_ == 3)))
            {
                _loc13_ = _loc7_;
                _loc7_ = _loc8_;
                _loc8_ = _loc13_;
            };
            _loc14_ = int(((int((param4.x + 45)) % 360) / 90));
            if (((_loc14_ == 1) || (_loc14_ == 3)))
            {
                _loc13_ = _loc11_;
                _loc11_ = _loc12_;
                _loc12_ = _loc13_;
            };
            if (((!(param5 == null)) && (!(param2 == null))))
            {
                if (param5.validateLocation(param2.x, param2.y, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_))
                {
                    return (new Vector3d(param2.x, param2.y, param5.getTileHeight(param2.x, param2.y)));
                };
                return (null);
            };
            return (null);
        }

        private function validateWallItemLocation(param1:IRoomObject, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:Number, param6:Number, param7:SelectedRoomObjectData):Vector3d
        {
            if (((((((param1 == null) || (param1.getModel() == null)) || (param2 == null)) || (param3 == null)) || (param4 == null)) || (param7 == null)))
            {
                return (null);
            };
            var _loc8_:Number = param1.getModel().getNumber(RoomObjectVariableEnum.var_738);
            var _loc9_:Number = param1.getModel().getNumber(RoomObjectVariableEnum.var_740);
            var _loc10_:Number = param1.getModel().getNumber(RoomObjectVariableEnum.var_743);
            if (((((param5 < (_loc8_ / 2)) || (param5 > (param3.length - (_loc8_ / 2)))) || (param6 < _loc10_)) || (param6 > (param4.length - (_loc9_ - _loc10_)))))
            {
                if (((param5 < (_loc8_ / 2)) && (param5 <= (param3.length - (_loc8_ / 2)))))
                {
                    param5 = (_loc8_ / 2);
                }
                else
                {
                    if (((param5 >= (_loc8_ / 2)) && (param5 > (param3.length - (_loc8_ / 2)))))
                    {
                        param5 = (param3.length - (_loc8_ / 2));
                    };
                };
                if (((param6 < _loc10_) && (param6 <= (param4.length - (_loc9_ - _loc10_)))))
                {
                    param6 = _loc10_;
                }
                else
                {
                    if (((param6 >= _loc10_) && (param6 > (param4.length - (_loc9_ - _loc10_)))))
                    {
                        param6 = (param4.length - (_loc9_ - _loc10_));
                    };
                };
            };
            if (((((param5 < (_loc8_ / 2)) || (param5 > (param3.length - (_loc8_ / 2)))) || (param6 < _loc10_)) || (param6 > (param4.length - (_loc9_ - _loc10_)))))
            {
                return (null);
            };
            var _loc11_:Vector3d = Vector3d.sum(Vector3d.product(param3, (param5 / param3.length)), Vector3d.product(param4, (param6 / param4.length)));
            return (Vector3d.sum(param2, _loc11_));
        }

        private function validateUserLocation(param1:IRoomObject, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:TileHeightMap):Vector3d
        {
            if (((param2 == null) || (param5 == null)))
            {
                return (null);
            };
            if (param5.isRoomTile(param2.x, param2.y))
            {
                return (new Vector3d(param2.x, param2.y, param5.getTileHeight(param2.x, param2.y)));
            };
            return (null);
        }

        private function setObjectAlphaMultiplier(param1:IRoomObjectController, param2:Number):void
        {
            if (((!(param1 == null)) && (!(param1.getModelController() == null))))
            {
                param1.getModelController().setNumber(RoomObjectVariableEnum.var_154, param2);
            };
        }

        public function setSelectedAvatar(roomId:int, roomCategory:int, objectId:int, isSelected:Boolean):void
        {
            if (this._roomEngine == null)
            {
                return;
            };
            var category:int = RoomObjectCategoryEnum.var_71;
            var object:IRoomObjectController = (this._roomEngine.getRoomObject(roomId, roomCategory, this.var_4373, category) as IRoomObjectController);
            if (((!(object == null)) && (!(object.getEventHandler() == null))))
            {
                object.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(false));
                this.var_4373 = -1;
            };
            var wasSelected:Boolean;
            if (isSelected)
            {
                object = (this._roomEngine.getRoomObject(roomId, roomCategory, objectId, category) as IRoomObjectController);
                if (((!(object == null)) && (!(object.getEventHandler() == null))))
                {
                    object.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(true));
                    wasSelected = true;
                    this.var_4373 = objectId;
                    try
                    {
                        this._roomEngine.connection.send(new LookToMessageComposer(object.getLocation().x, object.getLocation().y));
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            var selectionArrow:IRoomObjectController = this._roomEngine.getSelectionArrow(roomId, roomCategory);
            if (((!(selectionArrow == null)) && (!(selectionArrow.getEventHandler() == null))))
            {
                if (((wasSelected) && (!(this._roomEngine.getIsPlayingGame(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory)))))
                {
                    selectionArrow.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.var_1185));
                }
                else
                {
                    selectionArrow.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.var_1186));
                };
            };
        }

        public function getSelectedAvatarId():int
        {
            return (this.var_4373);
        }

        private function getValidFurnitureDirection(param1:IRoomObjectController, param2:Boolean):int
        {
            var _loc5_:int;
            var _loc6_:int;
            if (((param1 == null) || (param1.getModel() == null)))
            {
                return (0);
            };
            var _loc3_:Array;
            if (param1.getModel() != null)
            {
                _loc3_ = param1.getModel().getNumberArray(RoomObjectVariableEnum.var_744);
            };
            var _loc4_:int = param1.getDirection().x;
            if (((!(_loc3_ == null)) && (_loc3_.length > 0)))
            {
                _loc5_ = _loc3_.indexOf(_loc4_);
                if (_loc5_ < 0)
                {
                    _loc5_ = 0;
                    _loc6_ = 0;
                    while (_loc6_ < _loc3_.length)
                    {
                        if (_loc4_ <= _loc3_[_loc6_]) break;
                        _loc5_++;
                        _loc6_++;
                    };
                    _loc5_ = (_loc5_ % _loc3_.length);
                };
                if (param2)
                {
                    _loc5_ = ((_loc5_ + 1) % _loc3_.length);
                }
                else
                {
                    _loc5_ = (((_loc5_ - 1) + _loc3_.length) % _loc3_.length);
                };
                _loc4_ = _loc3_[_loc5_];
            };
            return (_loc4_);
        }

        public function modifyRoomObject(param1:int, param2:int, param3:int, param4:int, param5:String):Boolean
        {
            var _loc11_:LegacyWallGeometry;
            var _loc12_:String;
            if (this._roomEngine == null)
            {
                return (false);
            };
            var _loc6_:IRoomObjectController = (this._roomEngine.getRoomObject(param1, param2, param3, param4) as IRoomObjectController);
            if (_loc6_ == null)
            {
                return (false);
            };
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:Boolean = true;
            switch (param5)
            {
                case RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE:
                case RoomObjectOperationEnum.OBJECT_ROTATE_NEGATIVE:
                    if (this._roomEngine.connection)
                    {
                        if (param5 == RoomObjectOperationEnum.OBJECT_ROTATE_NEGATIVE)
                        {
                            _loc9_ = this.getValidFurnitureDirection(_loc6_, false);
                        }
                        else
                        {
                            _loc9_ = this.getValidFurnitureDirection(_loc6_, true);
                        };
                        _loc7_ = _loc6_.getLocation().x;
                        _loc8_ = _loc6_.getLocation().y;
                        if (this.validateFurnitureDirection(_loc6_, new Vector3d(_loc9_), this._roomEngine.getTileHeightMap(param1, param2)))
                        {
                            _loc9_ = int(int((_loc9_ / 45)));
                            this._roomEngine.connection.send(new MoveObjectMessageComposer(param3, _loc7_, _loc8_, _loc9_));
                        };
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_PICKUP:
                    if (this._roomEngine.connection)
                    {
                        this._roomEngine.connection.send(new PickupObjectMessageComposer(param3, param4));
                    };
                    break;
                case RoomObjectOperationEnum.OBJECT_MOVE:
                    _loc10_ = false;
                    this.setObjectAlphaMultiplier(_loc6_, 0.5);
                    this.setSelectedObjectData(param1, param2, _loc6_.getId(), param4, _loc6_.getLocation(), _loc6_.getDirection(), param5);
                    this._roomEngine.setObjectMoverIconSprite(_loc6_.getId(), param4, true);
                    this._roomEngine.setObjectMoverIconSpriteVisible(false);
                    break;
                case RoomObjectOperationEnum.OBJECT_MOVE_TO:
                    this.setObjectAlphaMultiplier(_loc6_, 1);
                    this._roomEngine.removeObjectMoverIconSprite();
                    if (this._roomEngine.connection)
                    {
                        if (param4 == RoomObjectCategoryEnum.var_72)
                        {
                            _loc9_ = (int(_loc6_.getDirection().x) % 360);
                            _loc7_ = _loc6_.getLocation().x;
                            _loc8_ = _loc6_.getLocation().y;
                            _loc9_ = int(int((_loc9_ / 45)));
                            this._roomEngine.connection.send(new MoveObjectMessageComposer(param3, _loc7_, _loc8_, _loc9_));
                        }
                        else
                        {
                            if (param4 == RoomObjectCategoryEnum.var_73)
                            {
                                _loc9_ = (int(_loc6_.getDirection().x) % 360);
                                _loc11_ = this._roomEngine.getLegacyGeometry(param1, param2);
                                if (((this._roomEngine.connection) && (_loc11_)))
                                {
                                    _loc12_ = _loc11_.getOldLocationString(_loc6_.getLocation(), _loc9_);
                                    if (_loc12_ != null)
                                    {
                                        this._roomEngine.connection.send(new PickupObjectMessageComposer(param3, param4));
                                        this._roomEngine.connection.send(new PlaceObjectMessageComposer(param3, RoomObjectCategoryEnum.var_73, _loc12_, 0, 0, 0));
                                    };
                                };
                            };
                        };
                    };
                    break;
            };
            if (_loc10_)
            {
                this.resetSelectedObjectData(param1, param2);
            };
            return (true);
        }

        private function placeObject(param1:int, param2:int):void
        {
            var _loc6_:IRoomObjectController;
            var _loc13_:IVector3d;
            var _loc14_:LegacyWallGeometry;
            var _loc15_:Boolean;
            var _loc3_:SelectedRoomObjectData = this.getSelectedObjectData(param1, param2);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:int = _loc3_.id;
            var _loc5_:int = _loc3_.category;
            var _loc7_:String = "";
            var _loc8_:Number = 0;
            var _loc9_:Number = 0;
            var _loc10_:Number = 0;
            var _loc11_:int;
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.connection == null))))
            {
                _loc6_ = (this._roomEngine.getRoomObject(param1, param2, _loc4_, _loc5_) as IRoomObjectController);
                if (_loc6_ != null)
                {
                    _loc11_ = _loc6_.getDirection().x;
                    _loc13_ = _loc6_.getLocation();
                    if (((_loc5_ == RoomObjectCategoryEnum.var_72) || (_loc5_ == RoomObjectCategoryEnum.var_71)))
                    {
                        _loc8_ = _loc13_.x;
                        _loc9_ = _loc13_.y;
                    }
                    else
                    {
                        if (_loc5_ == RoomObjectCategoryEnum.var_73)
                        {
                            _loc8_ = _loc13_.x;
                            _loc9_ = _loc13_.y;
                            _loc10_ = _loc13_.z;
                            _loc14_ = this._roomEngine.getLegacyGeometry(param1, param2);
                            if (_loc14_ != null)
                            {
                                _loc7_ = _loc14_.getOldLocationString(_loc13_, _loc11_);
                            };
                        };
                    };
                    _loc11_ = int(((((_loc11_ / 45) % 8) + 8) % 8));
                    if (((_loc5_ == RoomObjectCategoryEnum.var_71) && (_loc3_.typeId == RoomObjectTypeEnum.var_1234)))
                    {
                        this._roomEngine.connection.send(new PlacePetMessageComposer(_loc4_, int(_loc8_), int(_loc9_)));
                    }
                    else
                    {
                        this._roomEngine.connection.send(new PlaceObjectMessageComposer(_loc4_, _loc5_, _loc7_, int(_loc8_), int(_loc9_), _loc11_));
                    };
                };
            };
            var _loc12_:SelectedRoomObjectData = new SelectedRoomObjectData(_loc3_.id, _loc3_.category, null, null, null);
            this._roomEngine.setPlacedObjectData(param1, param2, _loc12_);
            this.resetSelectedObjectData(param1, param2);
            if (((this._roomEngine) && (this._roomEngine.events)))
            {
                _loc15_ = ((_loc6_) && (_loc6_.getId() == _loc3_.id));
                this._roomEngine.events.dispatchEvent(new RoomEngineObjectPlacedEvent(RoomEngineObjectEvent.var_141, param1, param2, _loc4_, _loc5_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc15_));
            };
        }

        private function changeObjectState(param1:int, param2:int, param3:int, param4:String, param5:int, param6:Boolean):void
        {
            var _loc7_:int;
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.connection == null))))
            {
                _loc7_ = this._roomEngine.getRoomObjectCategory(param4);
                if (_loc7_ == RoomObjectCategoryEnum.var_72)
                {
                    if (!param6)
                    {
                        this._roomEngine.connection.send(new UseFurnitureMessageComposer(param3, param5));
                    }
                    else
                    {
                        this._roomEngine.connection.send(new SetRandomStateMessageComposer(param3, param5));
                    };
                }
                else
                {
                    if (_loc7_ == RoomObjectCategoryEnum.var_73)
                    {
                        this._roomEngine.connection.send(new UseWallItemMessageComposer(param3, param5));
                    };
                };
            };
        }

        private function useObject(param1:int, param2:int, param3:int, param4:String, param5:String):void
        {
            if (((!(this._roomEngine == null)) && (!(this._roomEngine.connection == null))))
            {
                switch (param5)
                {
                    case RoomObjectFurnitureActionEvent.var_1182:
                        this._roomEngine.connection.send(new ThrowDiceMessageComposer(param3));
                        return;
                    case RoomObjectFurnitureActionEvent.var_1183:
                        this._roomEngine.connection.send(new DiceOffMessageComposer(param3));
                        return;
                    case RoomObjectFurnitureActionEvent.var_1190:
                        this._roomEngine.connection.send(new SpinWheelOfFortuneMessageComposer(param3));
                        return;
                    case RoomObjectFurnitureActionEvent.var_1189:
                        this._roomEngine.connection.send(new GetItemDataMessageComposer(param3));
                        return;
                    case RoomObjectFurnitureActionEvent.var_1184:
                        this._roomEngine.connection.send(new ViralFurniStatusMessageComposer(param3));
                        return;
                    case RoomObjectFurnitureActionEvent.var_1213:
                        this._roomEngine.connection.send(new EnterOneWayDoorMessageComposer(param3));
                        return;
                    case RoomObjectFurnitureActionEvent.var_1204:
                        this._roomEngine.connection.send(new QuestVendingWallItemMessageComposer(param3));
                };
            };
        }

        private function initializeObject(param1:int, param2:int, param3:int, param4:String, param5:String):void
        {
        }

        public function modifyWallItemData(param1:int, param2:int, param3:int, param4:String):Boolean
        {
            if (((this._roomEngine == null) || (this._roomEngine.connection == null)))
            {
                return (false);
            };
            this._roomEngine.connection.send(new SetItemDataMessageComposer(param3, param4, param1, param2));
            return (true);
        }

        public function deleteWallItem(param1:int, param2:int, param3:int):Boolean
        {
            if (((this._roomEngine == null) || (this._roomEngine.connection == null)))
            {
                return (false);
            };
            this._roomEngine.connection.send(new RemoveItemMessageComposer(param3, param1, param2));
            return (true);
        }

        private function walkTo(param1:int, param2:int):void
        {
            if (this._roomEngine == null)
            {
                return;
            };
            if (this._roomEngine.connection)
            {
                this._roomEngine.connection.send(new MoveAvatarMessageComposer(param1, param2));
            };
        }

    }
}