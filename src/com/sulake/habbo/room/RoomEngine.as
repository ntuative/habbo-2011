package com.sulake.habbo.room
{

    import com.sulake.core.runtime.Component;
    import com.sulake.room.IRoomManagerListener;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.room.IRoomManager;
    import com.sulake.room.renderer.IRoomRendererFactory;
    import com.sulake.room.IRoomObjectFactory;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.habbo.advertisement.IAdManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.room.utils.NumberBank;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDRoomObjectFactory;
    import com.sulake.iid.IIDRoomObjectVisualizationFactory;
    import com.sulake.iid.IIDRoomManager;
    import com.sulake.iid.IIDRoomRendererFactory;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboAdManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.habbo.room.utils.RoomInstanceData;
    import com.sulake.habbo.room.utils.TileHeightMap;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.room.utils.RoomCamera;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.room.IRoomInstance;

    import flash.ui.Mouse;
    import flash.ui.MouseCursor;

    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.utils.FurnitureData;

    import flash.utils.getTimer;

    import com.sulake.room.object.IRoomObject;

    import flash.geom.Rectangle;

    import com.sulake.room.utils.Vector3d;

    import flash.geom.Point;
    import flash.geom.Matrix;

    import com.sulake.room.renderer.IRoomRenderingCanvas;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;

    import flash.events.Event;

    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.room.utils.RoomData;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
    import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;

    import flash.display.Sprite;

    import com.sulake.room.renderer.IRoomRenderer;

    import flash.display.DisplayObject;

    import com.sulake.room.utils.IRoomGeometry;

    import flash.events.MouseEvent;

    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.events.RoomObjectMouseEvent;

    import flash.display.Bitmap;
    import flash.display.BitmapData;

    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectUpdateStateMessage;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.object.RoomPlaneData;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.iid.*;
    import com.sulake.room.object.*;

    public class RoomEngine extends Component implements IRoomEngine, IRoomManagerListener, IRoomCreator, IRoomEngineServices, IUpdateReceiver
    {

        private static const var_501: String = "temporary_room";
        private static const var_453: int = -1;
        private static const var_454: String = "room";
        private static const var_455: int = -2;
        private static const var_456: String = "tile_cursor";
        private static const var_457: int = -3;
        private static const var_458: String = "selection_arrow";
        private static const OVERLAY_SPRITE: String = "overlay";
        private static const var_482: String = "object_icon_sprite";
        private static const var_481: int = 15;
        private static const var_446: int = 40;

        private var _communication: IHabboCommunicationManager = null;
        private var _connection: IConnection = null;
        private var _roomManager: IRoomManager = null;
        private var _roomRenderer: IRoomRendererFactory = null;
        private var _roomObjectFactory: IRoomObjectFactory = null;
        private var var_4325: IRoomObjectVisualizationFactory = null;
        private var var_4345: IAdManager = null;
        private var var_2847: ISessionDataManager = null;
        private var var_2868: IHabboConfigurationManager;
        private var var_4346: RoomObjectEventHandler = null;
        private var var_4347: RoomMessageHandler = null;
        private var var_4348: RoomContentLoader = null;
        private var var_4349: Boolean = false;
        private var var_4350: NumberBank;
        private var var_4351: Map;
        private var _isInitialized: Boolean = false;
        private var _activeRoomId: int = 0;
        private var _activeRoomCategory: int = 0;
        private var var_4355: int = -1;
        private var var_4356: int = 0;
        private var var_4357: int = 0;
        private var var_4358: Boolean = false;
        private var var_4359: Boolean = false;
        private var var_4360: int = 0;
        private var var_4361: int = 0;
        private var var_4362: Boolean = false;
        private var var_4363: Map = null;
        private var var_4364: Map = null;
        private var var_4365: Boolean = false;
        private var var_4366: Array = [];
        private var var_4367: Boolean;

        public function RoomEngine(param1: IContext, param2: uint = 0)
        {
            super(param1, param2);
            this.var_4364 = new Map();
            this.var_4350 = new NumberBank(1000);
            this.var_4351 = new Map();
            this.var_4363 = new Map();
            this.var_4346 = new RoomObjectEventHandler(this);
            this.var_4347 = new RoomMessageHandler(this);
            this.var_4348 = new RoomContentLoader();
            queueInterface(new IIDRoomObjectFactory(), this.onObjectFactoryReady);
            queueInterface(new IIDRoomObjectVisualizationFactory(), this.onVisualizationFactoryReady);
            queueInterface(new IIDRoomManager(), this.onRoomManagerReady);
            queueInterface(new IIDRoomRendererFactory(), this.onRendererFactoryReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationReady);
            queueInterface(new IIDHabboAdManager(), this.onAdManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            this.initialize();
            registerUpdateReceiver(this, 1);
        }

        public function get isInitialized(): Boolean
        {
            return this._isInitialized;
        }

        public function get roomManager(): IRoomManager
        {
            return this._roomManager;
        }

        public function get connection(): IConnection
        {
            return this._connection;
        }

        public function get activeRoomId(): int
        {
            return this._activeRoomId;
        }

        public function get activeRoomCategory(): int
        {
            return this._activeRoomCategory;
        }

        private function get useOffsetScrolling(): Boolean
        {
            return true;
        }

        public function isPublicRoomWorldType(param1: String): Boolean
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.isPublicRoomWorldType(param1);
            }

            return false;
        }

        override public function dispose(): void
        {
            var _loc1_: int;
            var _loc2_: RoomInstanceData;
            removeUpdateReceiver(this);
            if (this._roomObjectFactory != null)
            {
                this._roomObjectFactory.release(new IIDRoomObjectFactory());
                this._roomObjectFactory = null;
            }

            if (this.var_4325 != null)
            {
                this.var_4325.release(new IIDRoomObjectVisualizationFactory());
                this.var_4325 = null;
            }

            if (this._roomManager != null)
            {
                this._roomManager.release(new IIDRoomManager());
                this._roomManager = null;
            }

            if (this._roomRenderer != null)
            {
                this._roomRenderer.release(new IIDRoomRendererFactory());
                this._roomRenderer = null;
            }

            if (this._communication != null)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            }

            if (this.var_2868 != null)
            {
                this.var_2868.release(new IIDHabboConfigurationManager());
                this.var_2868 = null;
            }

            if (this.var_4345)
            {
                this.var_4345.release(new IIDHabboAdManager());
                this.var_4345 = null;
            }

            this._connection = null;
            if (this.var_4350 != null)
            {
                this.var_4350.dispose();
                this.var_4350 = null;
            }

            if (this.var_4351 != null)
            {
                this.var_4351.dispose();
            }

            if (this.var_4346 != null)
            {
                this.var_4346.dispose();
                this.var_4346 = null;
            }

            if (this.var_4347 != null)
            {
                this.var_4347.dispose();
                this.var_4347 = null;
            }

            if (this.var_4348 != null)
            {
                this.var_4348.dispose();
                this.var_4348 = null;
            }

            if (this.var_4363 != null)
            {
                this.var_4363.dispose();
                this.var_4363 = null;
            }

            if (this.var_4364 != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this.var_4364.length)
                {
                    _loc2_ = (this.var_4364.getWithIndex(_loc1_) as RoomInstanceData);
                    if (_loc2_ != null)
                    {
                        _loc2_.dispose();
                    }

                    _loc1_++;
                }

                this.var_4364.dispose();
                this.var_4364 = null;
            }

            super.dispose();
        }

        private function initialize(): void
        {
        }

        private function getRoomInstanceData(param1: int, param2: int): RoomInstanceData
        {
            var _loc3_: String = this.getRoomIdentifier(param1, param2);
            var _loc4_: RoomInstanceData = this.var_4364.getValue(_loc3_) as RoomInstanceData;
            if (_loc4_ == null)
            {
                _loc4_ = new RoomInstanceData(param1, param2);
                this.var_4364.add(_loc3_, _loc4_);
            }

            return _loc4_;
        }

        public function setTileHeightMap(param1: int, param2: int, param3: TileHeightMap): void
        {
            var _loc4_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc4_ != null)
            {
                _loc4_.tileHeightMap = param3;
            }

        }

        public function getTileHeightMap(param1: int, param2: int): TileHeightMap
        {
            var _loc3_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc3_ != null)
            {
                return _loc3_.tileHeightMap;
            }

            return null;
        }

        public function setWorldType(param1: int, param2: int, param3: String): void
        {
            var _loc4_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc4_ != null)
            {
                _loc4_.worldType = param3;
            }

        }

        public function getWorldType(param1: int, param2: int): String
        {
            var _loc3_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc3_ != null)
            {
                return _loc3_.worldType;
            }

            return null;
        }

        public function getLegacyGeometry(param1: int, param2: int): LegacyWallGeometry
        {
            var _loc3_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc3_ != null)
            {
                return _loc3_.legacyGeometry;
            }

            return null;
        }

        private function getRoomCamera(param1: int, param2: int): RoomCamera
        {
            var _loc3_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc3_ != null)
            {
                return _loc3_.roomCamera;
            }

            return null;
        }

        public function setSelectedObjectData(param1: int, param2: int, param3: SelectedRoomObjectData): void
        {
            var _loc4_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc4_ != null)
            {
                _loc4_.selectedObject = param3;
                if (param3 != null)
                {
                    _loc4_.placedObject = null;
                }

            }

        }

        public function getSelectedObjectData(param1: int, param2: int): ISelectedRoomObjectData
        {
            var _loc3_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc3_ != null)
            {
                return _loc3_.selectedObject;
            }

            return null;
        }

        public function setPlacedObjectData(param1: int, param2: int, param3: SelectedRoomObjectData): void
        {
            var _loc4_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc4_ != null)
            {
                _loc4_.placedObject = param3;
            }

        }

        public function getPlacedObjectData(param1: int, param2: int): ISelectedRoomObjectData
        {
            var _loc3_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc3_ != null)
            {
                return _loc3_.placedObject;
            }

            return null;
        }

        public function update(param1: uint): void
        {
            var _loc2_: IRoomInstance;
            if (this._roomManager != null)
            {
                this.createRoomFurniture();
                this._roomManager.update(param1);
                _loc2_ = this._roomManager.getRoom(this.getRoomIdentifier(this._activeRoomId, this._activeRoomCategory));
                if (_loc2_ != null && _loc2_.getRenderer() != null)
                {
                    _loc2_.getRenderer().update(param1);
                }

                this.updateRoomCameras(param1);
                if (this.var_4367)
                {
                    this.updateMouseCursor();
                }

            }

        }

        private function updateMouseCursor(): void
        {
            this.var_4367 = false;
            if (this.var_4366 && this.var_4366.length > 0)
            {
                Mouse.cursor = MouseCursor.BUTTON;
            }
            else
            {
                Mouse.cursor = MouseCursor.ARROW;
            }

            this.var_4367 = false;
        }

        public function requestMouseCursor(param1: String, param2: int, param3: String): void
        {
            var _loc4_: int = this.getRoomObjectCategory(param3);
            switch (param1)
            {
                case RoomObjectFurnitureActionEvent.var_445:
                    this.addBtnMouseCursorOwner(_loc4_, param2);
                    return;
                default:
                    this.removeBtnMouseCursorOwner(_loc4_, param2);
            }

        }

        private function addBtnMouseCursorOwner(param1: int, param2: int): void
        {
            if (!this.var_4366)
            {
                return;
            }

            if (param1 == RoomObjectCategoryEnum.var_72)
            {
                param2 = param2 * -1;
            }

            var _loc3_: int = this.var_4366.indexOf(param2);
            if (_loc3_ == -1)
            {
                this.var_4366.push(param2);
                this.var_4367 = true;
            }

        }

        private function removeBtnMouseCursorOwner(param1: int, param2: int): void
        {
            if (!this.var_4366)
            {
                return;
            }

            if (param1 == RoomObjectCategoryEnum.var_72)
            {
                param2 = param2 * -1;
            }

            var _loc3_: int = this.var_4366.indexOf(param2);
            if (_loc3_ > -1)
            {
                this.var_4366.splice(_loc3_, 1);
                this.var_4367 = true;
            }

        }

        private function createRoomFurniture(): void
        {
            var _loc3_: int;
            var _loc4_: RoomInstanceData;
            var _loc5_: int;
            var _loc6_: FurnitureData;
            if (this.var_4365)
            {
                this.var_4365 = false;
                return;
            }

            var _loc1_: int = getTimer();
            var _loc2_: int = 5;
            for each (_loc4_ in this.var_4364)
            {
                _loc5_ = 0;
                _loc6_ = null;
                while ((_loc6_ = _loc4_.getFurnitureData()) != null)
                {
                    this.addObjectFurnitureFromData(_loc4_.roomId, _loc4_.roomCategory, _loc6_.id, _loc6_);
                    if (++_loc5_ % _loc2_ == 0)
                    {
                        _loc3_ = getTimer();
                        if (_loc3_ - _loc1_ >= var_446)
                        {
                            this.var_4365 = true;
                            break;
                        }

                    }

                }

                while (!this.var_4365 && (_loc6_ = _loc4_.getWallItemData()) != null)
                {
                    this.addObjectWallItemFromData(_loc4_.roomId, _loc4_.roomCategory, _loc6_.id, _loc6_);
                    if (++_loc5_ % _loc2_ == 0)
                    {
                        _loc3_ = getTimer();
                        if (_loc3_ - _loc1_ >= var_446)
                        {
                            this.var_4365 = true;
                            break;
                        }

                    }

                }

                if (this.var_4365)
                {
                    return;
                }

            }

        }

        private function updateRoomCameras(param1: uint): void
        {
            var _loc3_: RoomInstanceData;
            var _loc4_: RoomCamera;
            var _loc5_: int;
            var _loc6_: int;
            var _loc7_: int;
            var _loc8_: int;
            var _loc9_: int;
            var _loc10_: IRoomObject;
            var _loc2_: int;
            while (_loc2_ < this.var_4364.length)
            {
                _loc3_ = (this.var_4364.getWithIndex(_loc2_) as RoomInstanceData);
                _loc4_ = null;
                _loc5_ = 0;
                _loc6_ = 0;
                if (_loc3_ != null)
                {
                    _loc4_ = _loc3_.roomCamera;
                    _loc5_ = _loc3_.roomId;
                    _loc6_ = _loc3_.roomCategory;
                }

                if (_loc4_ != null)
                {
                    _loc7_ = 1;
                    _loc8_ = _loc4_.targetId;
                    _loc9_ = _loc4_.targetCategory;
                    _loc10_ = this.getRoomObject(_loc5_, _loc6_, _loc8_, _loc9_);
                    if (_loc10_ != null)
                    {
                        if (_loc5_ != this._activeRoomId || _loc6_ != this._activeRoomCategory || !this.var_4358)
                        {
                            this.updateRoomCamera(_loc5_, _loc6_, _loc7_, _loc10_.getLocation(), param1);
                        }

                    }

                }

                _loc2_++;
            }

        }

        private function updateRoomCamera(param1: int, param2: int, param3: int, param4: IVector3d, param5: uint): void
        {
            var _loc11_: Number;
            var _loc12_: Rectangle;
            var _loc13_: int;
            var _loc14_: int;
            var _loc15_: Vector3d;
            var _loc16_: Number;
            var _loc17_: Number;
            var _loc18_: Number;
            var _loc19_: Number;
            var _loc20_: Number;
            var _loc21_: Number;
            var _loc22_: Number;
            var _loc23_: Point;
            var _loc24_: Number;
            var _loc25_: Number;
            var _loc26_: Matrix;
            var _loc27_: Number;
            var _loc28_: Number;
            var _loc29_: Number;
            var _loc30_: Number;
            var _loc31_: Number;
            var _loc32_: Number;
            var _loc33_: Point;
            var _loc34_: Rectangle;
            var _loc35_: Boolean;
            var _loc36_: Boolean;
            var _loc37_: Boolean;
            var _loc38_: Boolean;
            var _loc39_: Number;
            var _loc40_: Number;
            var _loc41_: Number;
            var _loc42_: Number;
            var _loc43_: Number;
            var _loc44_: int;
            var _loc45_: int;
            var _loc46_: Point;
            var _loc47_: Vector3d;
            var _loc6_: IRoomRenderingCanvas = this.getRoomCanvas(param1, param2, param3);
            var _loc7_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc6_ == null || _loc7_ == null)
            {
                return;
            }

            var _loc8_: RoomGeometry = _loc6_.geometry as RoomGeometry;
            var _loc9_: RoomCamera = _loc7_.roomCamera;
            var _loc10_: IRoomInstance = this.getRoom(param1, param2);
            if (_loc8_ != null && _loc9_ != null && _loc10_ != null)
            {
                _loc11_ = Math.floor(param4.z) + 1;
                _loc12_ = this.getRoomCanvasRectangle(param1, param2, param3);
                if (_loc12_ != null)
                {
                    _loc13_ = Math.round(_loc12_.width);
                    _loc14_ = Math.round(_loc12_.height);
                    if (_loc9_.screenWd != _loc13_ || _loc9_.screenHt != _loc14_ || _loc9_.scale != _loc8_.scale || _loc9_.geometryUpdateId != _loc8_.updateId || !Vector3d.isEqual(param4, _loc9_.targetObjectLoc) || _loc9_.isMoving)
                    {
                        _loc9_.targetObjectLoc = param4;
                        _loc15_ = new Vector3d();
                        _loc15_.assign(param4);
                        _loc15_.x = Math.round(_loc15_.x);
                        _loc15_.y = Math.round(_loc15_.y);
                        _loc16_ = _loc10_.getNumber(RoomVariableEnum.var_447) - 0.5;
                        _loc17_ = _loc10_.getNumber(RoomVariableEnum.var_448) - 0.5;
                        _loc18_ = _loc10_.getNumber(RoomVariableEnum.var_449) + 0.5;
                        _loc19_ = _loc10_.getNumber(RoomVariableEnum.var_450) + 0.5;
                        _loc20_ = Math.round((_loc16_ + _loc18_) / 2);
                        _loc21_ = Math.round((_loc17_ + _loc19_) / 2);
                        _loc22_ = 2;
                        _loc23_ = new Point(_loc15_.x - _loc20_, _loc15_.y - _loc21_);
                        _loc24_ = _loc8_.scale / Math.sqrt(2);
                        _loc25_ = _loc24_ / 2;
                        _loc26_ = new Matrix();
                        _loc26_.rotate((-(_loc8_.direction.x + 90) / 180) * Math.PI);
                        _loc23_ = _loc26_.transformPoint(_loc23_);
                        _loc23_.y = _loc23_.y * (_loc25_ / _loc24_);
                        _loc27_ = _loc12_.width / 2 / _loc24_ - 1;
                        _loc28_ = _loc12_.height / 2 / _loc25_ - 1;
                        _loc29_ = 0;
                        _loc30_ = 0;
                        _loc31_ = 0;
                        _loc32_ = 0;
                        _loc33_ = _loc8_.getScreenPoint(new Vector3d(_loc20_, _loc21_, _loc22_));
                        _loc33_.x = _loc33_.x + Math.round(_loc12_.width / 2);
                        _loc33_.y = _loc33_.y + Math.round(_loc12_.height / 2);
                        _loc34_ = this.getActiveRoomBoundingRectangle(param3);
                        if (_loc34_ != null)
                        {
                            _loc34_.offset(-_loc6_.screenOffsetX, -_loc6_.screenOffsetY);
                            if (_loc34_.width > 1 && _loc34_.height > 1)
                            {
                                _loc29_ = (_loc34_.left - _loc33_.x - _loc8_.scale * 0.25) / _loc24_;
                                _loc31_ = ((_loc34_.right - _loc33_.x) + _loc8_.scale * 0.25) / _loc24_;
                                _loc30_ = (_loc34_.top - _loc33_.y - _loc8_.scale * 0.5) / _loc25_;
                                _loc32_ = ((_loc34_.bottom - _loc33_.y) + _loc8_.scale * 0.5) / _loc25_;
                            }
                            else
                            {
                                _loc8_.adjustLocation(new Vector3d(-30, -30), 25);
                                return;
                            }

                        }
                        else
                        {
                            _loc8_.adjustLocation(new Vector3d(0, 0), 25);
                            return;
                        }

                        _loc35_ = false;
                        _loc36_ = false;
                        _loc37_ = false;
                        _loc38_ = false;
                        _loc39_ = Math.round((_loc31_ - _loc29_) * _loc24_);
                        if (_loc39_ < _loc12_.width)
                        {
                            _loc11_ = 2;
                            _loc23_.x = (_loc31_ + _loc29_) / 2;
                            _loc37_ = true;
                        }
                        else
                        {
                            if (_loc23_.x > _loc31_ - _loc27_)
                            {
                                _loc23_.x = _loc31_ - _loc27_;
                                _loc35_ = true;
                            }

                            if (_loc23_.x < _loc29_ + _loc27_)
                            {
                                _loc23_.x = _loc29_ + _loc27_;
                                _loc35_ = true;
                            }

                        }

                        _loc40_ = Math.round((_loc32_ - _loc30_) * _loc25_);
                        if (_loc40_ < _loc12_.height)
                        {
                            _loc11_ = 2;
                            _loc23_.y = (_loc32_ + _loc30_) / 2;
                            _loc38_ = true;
                        }
                        else
                        {
                            if (_loc23_.y > _loc32_ - _loc28_)
                            {
                                _loc23_.y = _loc32_ - _loc28_;
                                _loc36_ = true;
                            }

                            if (_loc23_.y < _loc30_ + _loc28_)
                            {
                                _loc23_.y = _loc30_ + _loc28_;
                                _loc36_ = true;
                            }

                            _loc23_.y = _loc23_.y / (_loc25_ / _loc24_);
                        }

                        _loc26_.invert();
                        _loc23_ = _loc26_.transformPoint(_loc23_);
                        _loc23_.x = _loc23_.x + _loc20_;
                        _loc23_.y = _loc23_.y + _loc21_;
                        _loc41_ = 0.35;
                        _loc42_ = 0.1;
                        _loc43_ = 0.2;
                        _loc44_ = 10;
                        _loc45_ = 10;
                        if (_loc9_.limitedLocationX && _loc9_.screenWd == _loc13_ && _loc9_.screenHt == _loc14_)
                        {
                            _loc43_ = 0;
                        }

                        if (_loc9_.limitedLocationY && _loc9_.screenWd == _loc13_ && _loc9_.screenHt == _loc14_)
                        {
                            _loc41_ = 0;
                            _loc42_ = 0;
                        }

                        _loc12_.right = _loc12_.right * (1 - _loc43_ * 2);
                        _loc12_.bottom = _loc12_.bottom * (1 - (_loc41_ + _loc42_));
                        if (_loc12_.right < _loc44_)
                        {
                            _loc12_.right = _loc44_;
                        }

                        if (_loc12_.bottom < _loc45_)
                        {
                            _loc12_.bottom = _loc45_;
                        }

                        if (_loc41_ + _loc42_ > 0)
                        {
                            _loc12_.offset(-_loc12_.width / 2, -_loc12_.height * (_loc42_ / (_loc41_ + _loc42_)));
                        }
                        else
                        {
                            _loc12_.offset(-_loc12_.width / 2, -_loc12_.height / 2);
                        }

                        _loc33_ = _loc8_.getScreenPoint(_loc15_);
                        if (_loc33_ != null)
                        {
                            _loc33_.x = _loc33_.x + _loc6_.screenOffsetX;
                            _loc33_.y = _loc33_.y + _loc6_.screenOffsetY;
                            _loc15_.z = _loc11_;
                            _loc15_.x = Math.round(_loc23_.x * 2) / 2;
                            _loc15_.y = Math.round(_loc23_.y * 2) / 2;
                            if (_loc9_.location == null)
                            {
                                _loc8_.location = _loc15_;
                                if (this.useOffsetScrolling)
                                {
                                    _loc9_.initializeLocation(new Vector3d(0, 0, 0));
                                }
                                else
                                {
                                    _loc9_.initializeLocation(_loc15_);
                                }

                            }

                            _loc46_ = _loc8_.getScreenPoint(_loc15_);
                            _loc47_ = new Vector3d(0, 0, 0);
                            if (_loc46_ != null)
                            {
                                _loc47_.x = _loc46_.x;
                                _loc47_.y = _loc46_.y;
                            }

                            if ((_loc33_.x < _loc12_.left || _loc33_.x > _loc12_.right) && !_loc37_ || (_loc33_.y < _loc12_.top || _loc33_.y > _loc12_.bottom) && !_loc38_ || _loc37_ && !_loc9_.centeredLocX || _loc38_ && !_loc9_.centeredLocY || (_loc9_.roomWd != _loc34_.width || _loc9_.roomHt != _loc34_.height))
                            {
                                _loc9_.limitedLocationX = _loc35_;
                                _loc9_.limitedLocationY = _loc36_;
                                if (this.useOffsetScrolling)
                                {
                                    _loc9_.target = _loc47_;
                                }
                                else
                                {
                                    _loc9_.target = _loc15_;
                                }

                            }
                            else
                            {
                                if (!_loc35_)
                                {
                                    _loc9_.limitedLocationX = false;
                                }

                                if (!_loc36_)
                                {
                                    _loc9_.limitedLocationY = false;
                                }

                            }

                        }

                        _loc9_.centeredLocX = _loc37_;
                        _loc9_.centeredLocY = _loc38_;
                        _loc9_.screenWd = _loc13_;
                        _loc9_.screenHt = _loc14_;
                        _loc9_.scale = _loc8_.scale;
                        _loc9_.geometryUpdateId = _loc8_.updateId;
                        _loc9_.roomWd = _loc34_.width;
                        _loc9_.roomHt = _loc34_.height;
                        if (this.useOffsetScrolling)
                        {
                            _loc9_.update(param5, _loc8_.scale / 2, _loc8_.scale);
                        }
                        else
                        {
                            _loc9_.update(param5, 0.5, 1);
                        }

                        if (this.useOffsetScrolling)
                        {
                            _loc6_.screenOffsetX = -_loc9_.location.x;
                            _loc6_.screenOffsetY = -_loc9_.location.y;
                        }
                        else
                        {
                            _loc8_.adjustLocation(_loc9_.location, 25);
                        }

                    }

                }

            }

        }

        private function onObjectFactoryReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._roomObjectFactory = (param2 as IRoomObjectFactory);
            this.initializeObjectEvents();
            this.initializeRoomManager();
        }

        private function onVisualizationFactoryReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_4325 = (param2 as IRoomObjectVisualizationFactory);
            if (this.var_4348 != null)
            {
                this.var_4348.visualizationFactory = this.var_4325;
            }

            this.initializeRoomManager();
        }

        private function onRoomManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._roomManager = (param2 as IRoomManager);
            if (this._roomManager != null)
            {
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.var_72);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.var_73);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.var_71);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.var_355);
                this._roomManager.addObjectUpdateCategory(RoomObjectCategoryEnum.var_354);
                this._roomManager.setContentLoader(this.var_4348);
            }

            this.initializeRoomManager();
        }

        private function onRendererFactoryReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._roomRenderer = (param2 as IRoomRendererFactory);
            this.initializeRoomManager();
        }

        private function onCommunicationReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this._communication = (param2 as IHabboCommunicationManager);
            if (this._communication != null)
            {
                this._connection = this._communication.getHabboMainConnection(this.onConnectionReady);
                if (this._connection != null)
                {
                    this.onConnectionReady(this._connection);
                }

            }

            this.initializeRoomManager();
        }

        private function onConnectionReady(param1: IConnection): void
        {
            if (disposed)
            {
                return;
            }

            if (param1 != null)
            {
                this._connection = param1;
                if (this.var_4347 != null)
                {
                    this.var_4347.connection = param1;
                }

            }

        }

        private function onHabboConfigurationReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_2868 = (param2 as IHabboConfigurationManager);
            if (this.var_4348 != null)
            {
                events.addEventListener(RoomContentLoader.RCL_LOADER_READY, this.onContentLoaderReady);
                this.var_4348.initialize(events, this.var_2868);
            }

            this.var_4362 = this.var_2868.getKey("room.dragging.always_center", "0") == "1";
            this.initializeRoomManager();
        }

        private function onContentLoaderReady(param1: Event): void
        {
            if (param1 != null && param1.type == RoomContentLoader.RCL_LOADER_READY)
            {
                this.var_4349 = true;
                this.initializeRoomManager();
            }

        }

        private function onAdManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_4345 = (param2 as IAdManager);
            this.var_4345.events.addEventListener(AdEvent.ROOM_AD_SHOW, this.showRoomAd);
            this.var_4345.events.addEventListener(AdEvent.ROOM_AD_IMAGE_LOADED, this.onRoomAdImageLoaded);
            this.var_4345.events.addEventListener(AdEvent.ROOM_AD_IMAGE_LOADING_FAILED, this.onRoomAdImageLoaded);
        }

        private function onSessionDataManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            if (disposed)
            {
                return;
            }

            this.var_2847 = (param2 as ISessionDataManager);
            this.var_4348.sessionDataManager = this.var_2847;
        }

        private function initializeObjectEvents(): void
        {
            if (this._roomObjectFactory != null)
            {
                this._roomObjectFactory.addObjectEventListener(this.roomObjectEventHandler);
            }

        }

        private function initializeRoomManager(): void
        {
            if (this._roomObjectFactory == null || this.var_4325 == null || this._roomManager == null || this._roomRenderer == null || this._communication == null || this.var_2868 == null || !this.var_4349)
            {
                return;
            }

            this._roomManager.initialize(<nothing/>
                    , this);
        }

        public function roomManagerInitialized(param1: Boolean = true): void
        {
            var _loc2_: int;
            var _loc3_: RoomData;
            if (param1)
            {
                this._isInitialized = true;
                events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_ENGINE_INITIALIZED, 0, 0));
                _loc2_ = 0;
                while (_loc2_ < this.var_4363.length)
                {
                    _loc3_ = (this.var_4363.getWithIndex(_loc2_) as RoomData);
                    if (_loc3_ != null)
                    {
                        this.initializeRoom(_loc3_.roomId, _loc3_.roomCategory, _loc3_.data);
                    }

                    _loc2_++;
                }

            }

        }

        public function setActiveRoom(param1: int, param2: int): void
        {
            this._activeRoomId = param1;
            this._activeRoomCategory = param2;
        }

        public function getRoomIdentifier(param1: int, param2: int): String
        {
            return "hard_coded_room_id";
        }

        private function getRoomId(param1: String): int
        {
            return 1;
        }

        private function getRoomCategory(param1: String): int
        {
            return 1;
        }

        public function isPublicRoom(param1: int, param2: int): Boolean
        {
            return this.isPublicRoomWorldType(this.getWorldType(param1, param2));
        }

        public function getRoomNumberValue(param1: int, param2: int, param3: String): Number
        {
            var _loc4_: IRoomInstance = this.getRoom(param1, param2);
            if (_loc4_ != null)
            {
                return _loc4_.getNumber(param3);
            }

            return NaN;
        }

        public function getRoomStringValue(param1: int, param2: int, param3: String): String
        {
            var _loc4_: IRoomInstance = this.getRoom(param1, param2);
            if (_loc4_ != null)
            {
                return _loc4_.getString(param3);
            }

            return null;
        }

        public function setIsPlayingGame(param1: int, param2: int, param3: Boolean): void
        {
            var _loc5_: int;
            var _loc4_: IRoomInstance = this.getRoom(param1, param2);
            if (_loc4_ != null)
            {
                _loc5_ = param3 ? 1 : 0;
                _loc4_.setNumber(RoomVariableEnum.var_452, _loc5_);
                if (_loc5_ == 0)
                {
                    events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_NORMAL_MODE, param1, param2));
                }
                else
                {
                    events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_GAME_MODE, param1, param2));
                }

            }

        }

        public function getIsPlayingGame(param1: int, param2: int): Boolean
        {
            var _loc4_: Number;
            var _loc3_: IRoomInstance = this.getRoom(param1, param2);
            if (_loc3_ != null)
            {
                _loc4_ = _loc3_.getNumber(RoomVariableEnum.var_452);
                if (_loc4_ > 0)
                {
                    return true;
                }

            }

            return false;
        }

        public function getRoom(param1: int, param2: int): IRoomInstance
        {
            if (!this._isInitialized)
            {
                return null;
            }

            var _loc3_: String = this.getRoomIdentifier(param1, param2);
            return this._roomManager.getRoom(_loc3_);
        }

        public function initializeRoom(param1: int, param2: int, param3: XML): void
        {
            var _loc4_: String = this.getRoomIdentifier(param1, param2);
            var _loc5_: RoomData;
            var _loc6_: String = "111";
            var _loc7_: String = "201";
            var _loc8_: String = "1";
            if (!this._isInitialized)
            {
                _loc5_ = this.var_4363.remove(_loc4_);
                if (_loc5_ != null)
                {
                    _loc6_ = _loc5_.floorType;
                    _loc7_ = _loc5_.wallType;
                    _loc8_ = _loc5_.landscapeType;
                }

                _loc5_ = new RoomData(param1, param2, param3);
                _loc5_.floorType = _loc6_;
                _loc5_.wallType = _loc7_;
                _loc5_.landscapeType = _loc8_;
                this.var_4363.add(_loc4_, _loc5_);
                Logger.log("Room Engine not initilized yet, can not create room. Room data stored for later initialization.");
                return;
            }

            if (param3 == null)
            {
                Logger.log("Room property messages received before floor height map, will initialize when floor height map received.");
                return;
            }

            _loc5_ = this.var_4363.remove(_loc4_);
            if (_loc5_ != null)
            {
                if (_loc5_.floorType != null && _loc5_.floorType.length > 0)
                {
                    _loc6_ = _loc5_.floorType;
                }

                if (_loc5_.wallType != null && _loc5_.wallType.length > 0)
                {
                    _loc7_ = _loc5_.wallType;
                }

                if (_loc5_.landscapeType != null && _loc5_.landscapeType.length > 0)
                {
                    _loc8_ = _loc5_.landscapeType;
                }

            }

            var _loc9_: IRoomInstance = this.createRoom(_loc4_, param3, _loc6_, _loc7_, _loc8_, this.getWorldType(param1, param2));
            if (_loc9_ == null)
            {
                return;
            }

            events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_INITIALIZED, param1, param2));
        }

        private function createRoom(param1: String, param2: XML, param3: String, param4: String, param5: String, param6: String): IRoomInstance
        {
            var _loc11_: String;
            var _loc12_: int;
            var _loc13_: int;
            var _loc14_: XML;
            var _loc15_: Number;
            var _loc16_: Number;
            var _loc17_: Number;
            var _loc18_: Number;
            var _loc19_: RoomObjectRoomUpdateMessage;
            var _loc20_: XMLList;
            var _loc21_: Array;
            var _loc22_: RoomObjectRoomMaskUpdateMessage;
            var _loc23_: int;
            var _loc24_: XML;
            var _loc25_: Number;
            var _loc26_: Number;
            var _loc27_: Number;
            var _loc28_: Number;
            var _loc29_: String;
            var _loc30_: String;
            var _loc31_: Vector3d;
            if (!this._isInitialized)
            {
                return null;
            }

            var _loc7_: IRoomInstance = this._roomManager.createRoom(param1, param2);
            if (_loc7_ == null)
            {
                return null;
            }

            var _loc8_: int = RoomObjectCategoryEnum.var_354;
            var _loc9_: IRoomObjectController;
            var _loc10_: Number = 1;
            if (this.isPublicRoomWorldType(param6))
            {
                _loc11_ = this.var_4348.getPublicRoomContentType(param6);
                _loc9_ = (_loc7_.createRoomObject(var_453, _loc11_, _loc8_) as IRoomObjectController);
                _loc9_.getModelController().setString(RoomObjectVariableEnum.var_459, param6, true);
                _loc7_.setNumber(RoomVariableEnum.var_460, 1, true);
                _loc12_ = parseInt(this.var_2868.getKey("ads.billboard.displayDelayMillis", "1000"));
                _loc9_.getModelController().setNumber(RoomVariableEnum.var_461, _loc12_, true);
                if (this.var_4348 != null)
                {
                    _loc10_ = this.var_4348.getPublicRoomWorldHeightScale(param6);
                }

            }
            else
            {
                _loc9_ = (_loc7_.createRoomObject(var_453, var_454, _loc8_) as IRoomObjectController);
                _loc7_.setNumber(RoomVariableEnum.var_460, 0, true);
            }

            _loc7_.setNumber(RoomVariableEnum.var_462, _loc10_, true);
            if (param2 != null)
            {
                _loc13_ = 0;
                if (param2.dimensions.length() == 1)
                {
                    _loc14_ = param2.dimensions[0];
                    _loc15_ = Number(_loc14_.@minX);
                    _loc16_ = Number(_loc14_.@maxX);
                    _loc17_ = Number(_loc14_.@minY);
                    _loc18_ = Number(_loc14_.@maxY);
                    _loc7_.setNumber(RoomVariableEnum.var_447, _loc15_);
                    _loc7_.setNumber(RoomVariableEnum.var_449, _loc16_);
                    _loc7_.setNumber(RoomVariableEnum.var_448, _loc17_);
                    _loc7_.setNumber(RoomVariableEnum.var_450, _loc18_);
                    _loc13_ = _loc13_ + (_loc15_ * 423 + _loc16_ * 671 + _loc17_ * 913 + _loc18_ * 7509);
                    if (_loc9_ != null && _loc9_.getModelController() != null)
                    {
                        _loc9_.getModelController().setNumber(RoomObjectVariableEnum.var_463, _loc13_, true);
                    }

                }

            }

            if (_loc9_ != null && _loc9_.getEventHandler() != null)
            {
                _loc9_.getEventHandler().initialize(param2);
                _loc19_ = null;
                if (param3 != null)
                {
                    _loc19_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_FLOOR_UPDATE, param3);
                    _loc9_.getEventHandler().processUpdateMessage(_loc19_);
                    _loc7_.setString(RoomObjectVariableEnum.var_465, param3);
                }

                if (param4 != null)
                {
                    _loc19_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_WALL_UPDATE, param4);
                    _loc9_.getEventHandler().processUpdateMessage(_loc19_);
                    _loc7_.setString(RoomObjectVariableEnum.var_467, param4);
                }

                if (param5 != null)
                {
                    _loc19_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_LANDSCAPE_UPDATE, param5);
                    _loc9_.getEventHandler().processUpdateMessage(_loc19_);
                    _loc7_.setString(RoomObjectVariableEnum.var_469, param5);
                }

                if (param2 != null)
                {
                    if (param2.doors.door.length() > 0)
                    {
                        _loc20_ = param2.doors.door;
                        _loc21_ = ["x", "y", "z", "dir"];
                        _loc22_ = null;
                        _loc23_ = 0;
                        while (_loc23_ < _loc20_.length())
                        {
                            _loc24_ = _loc20_[_loc23_];
                            if (XMLValidator.checkRequiredAttributes(_loc24_, _loc21_))
                            {
                                _loc25_ = Number(_loc24_.@x);
                                _loc26_ = Number(_loc24_.@y);
                                _loc27_ = Number(_loc24_.@z);
                                _loc28_ = Number(_loc24_.@dir);
                                _loc29_ = RoomObjectRoomMaskUpdateMessage.DOOR;
                                _loc30_ = "door_" + _loc23_;
                                _loc31_ = new Vector3d(_loc25_, _loc26_, _loc27_);
                                _loc22_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _loc30_, _loc29_, _loc31_, RoomObjectRoomMaskUpdateMessage.HOLE);
                                _loc9_.getEventHandler().processUpdateMessage(_loc22_);
                                if (_loc28_ == 90 || _loc28_ == 180)
                                {
                                    if (_loc28_ == 90)
                                    {
                                        _loc7_.setNumber(RoomObjectVariableEnum.var_473, _loc25_ - 0.5, true);
                                        _loc7_.setNumber(RoomObjectVariableEnum.var_474, _loc26_, true);
                                    }

                                    if (_loc28_ == 180)
                                    {
                                        _loc7_.setNumber(RoomObjectVariableEnum.var_473, _loc25_, true);
                                        _loc7_.setNumber(RoomObjectVariableEnum.var_474, _loc26_ - 0.5, true);
                                    }

                                    _loc7_.setNumber(RoomObjectVariableEnum.var_475, _loc27_, true);
                                    _loc7_.setNumber(RoomObjectVariableEnum.var_476, _loc28_, true);
                                }

                            }

                            _loc23_++;
                        }

                    }

                }

            }

            _loc7_.createRoomObject(var_455, var_456, RoomObjectCategoryEnum.var_355);
            if (this.var_2868.getKey("avatar.widget.enabled", "0") == "0")
            {
                _loc7_.createRoomObject(var_457, var_458, RoomObjectCategoryEnum.var_355);
            }

            return _loc7_;
        }

        public function getObjectRoom(param1: int, param2: int): IRoomObjectController
        {
            return this.getObject(this.getRoomIdentifier(param1, param2), var_453, RoomObjectCategoryEnum.var_354);
        }

        public function updateObjectRoom(param1: int, param2: int, param3: String = null, param4: String = null, param5: String = null): Boolean
        {
            var _loc9_: String;
            var _loc10_: RoomData;
            var _loc6_: IRoomObjectController = this.getObjectRoom(param1, param2);
            var _loc7_: IRoomInstance = this.getRoom(param1, param2);
            if (_loc6_ == null)
            {
                _loc9_ = this.getRoomIdentifier(param1, param2);
                _loc10_ = this.var_4363.getValue(_loc9_);
                if (_loc10_ == null)
                {
                    _loc10_ = new RoomData(param1, param2, null);
                    this.var_4363.add(_loc9_, _loc10_);
                }

                if (param3 != null)
                {
                    _loc10_.floorType = param3;
                }

                if (param4 != null)
                {
                    _loc10_.wallType = param4;
                }

                if (param5 != null)
                {
                    _loc10_.landscapeType = param5;
                }

                return true;
            }

            if (_loc6_.getEventHandler() == null)
            {
                return false;
            }

            var _loc8_: RoomObjectRoomUpdateMessage;
            if (param3 != null)
            {
                if (_loc7_ != null)
                {
                    _loc7_.setString(RoomObjectVariableEnum.var_465, param3);
                }

                _loc8_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_FLOOR_UPDATE, param3);
                _loc6_.getEventHandler().processUpdateMessage(_loc8_);
            }

            if (param4 != null)
            {
                if (_loc7_ != null)
                {
                    _loc7_.setString(RoomObjectVariableEnum.var_467, param4);
                }

                _loc8_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_WALL_UPDATE, param4);
                _loc6_.getEventHandler().processUpdateMessage(_loc8_);
            }

            if (param5 != null)
            {
                if (_loc7_ != null)
                {
                    _loc7_.setString(RoomObjectVariableEnum.var_469, param5);
                }

                _loc8_ = new RoomObjectRoomUpdateMessage(RoomObjectRoomUpdateMessage.RORUM_ROOM_LANDSCAPE_UPDATE, param5);
                _loc6_.getEventHandler().processUpdateMessage(_loc8_);
            }

            return true;
        }

        public function updateObjectRoomColor(param1: int, param2: int, param3: uint, param4: int, param5: Boolean): Boolean
        {
            var _loc6_: IRoomObjectController = this.getObjectRoom(param1, param2);
            if (_loc6_ == null || _loc6_.getEventHandler() == null)
            {
                return false;
            }

            var _loc7_: RoomObjectRoomColorUpdateMessage;
            _loc7_ = new RoomObjectRoomColorUpdateMessage(RoomObjectRoomColorUpdateMessage.RORCUM_BACKGROUND_COLOR, param3, param4, param5);
            _loc6_.getEventHandler().processUpdateMessage(_loc7_);
            events.dispatchEvent(new RoomEngineRoomColorEvent(param1, param2, param3, param4, param5));
            return true;
        }

        public function updateObjectRoomVisibilities(param1: int, param2: int, param3: Boolean, param4: Boolean = true): Boolean
        {
            var _loc5_: IRoomObjectController = this.getObjectRoom(param1, param2);
            if (_loc5_ == null || _loc5_.getEventHandler() == null)
            {
                return false;
            }

            var _loc6_: RoomObjectRoomPlaneVisibilityUpdateMessage;
            _loc6_ = new RoomObjectRoomPlaneVisibilityUpdateMessage(RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_WALL_VISIBILITY, param3);
            _loc5_.getEventHandler().processUpdateMessage(_loc6_);
            _loc6_ = new RoomObjectRoomPlaneVisibilityUpdateMessage(RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_FLOOR_VISIBILITY, param4);
            _loc5_.getEventHandler().processUpdateMessage(_loc6_);
            return true;
        }

        public function disposeRoom(param1: int, param2: int): void
        {
            var _loc3_: String = this.getRoomIdentifier(param1, param2);
            this._roomManager.disposeRoom(_loc3_);
            var _loc4_: RoomInstanceData = this.var_4364.remove(_loc3_);
            if (_loc4_ != null)
            {
                _loc4_.dispose();
            }

            events.dispatchEvent(new RoomEngineEvent(RoomEngineEvent.REE_DISPOSED, param1, param2));
        }

        public function setOwnUserId(param1: int, param2: int, param3: int): void
        {
            var _loc4_: RoomCamera = this.getRoomCamera(param1, param2);
            if (_loc4_ != null)
            {
                _loc4_.targetId = param3;
                _loc4_.targetCategory = RoomObjectCategoryEnum.var_71;
            }

        }

        public function createRoomCanvas(param1: int, param2: int, param3: int, param4: int, param5: int, param6: int): DisplayObject
        {
            var _loc12_: String;
            var _loc13_: Number;
            var _loc14_: Number;
            var _loc15_: Number;
            var _loc16_: Number;
            var _loc17_: Vector3d;
            var _loc18_: Vector3d;
            var _loc19_: Sprite;
            var _loc7_: String = this.getRoomIdentifier(param1, param2);
            var _loc8_: IRoomInstance = this._roomManager.getRoom(_loc7_);
            if (_loc8_ == null)
            {
                return null;
            }

            var _loc9_: IRoomRenderer = _loc8_.getRenderer() as IRoomRenderer;
            if (_loc9_ == null)
            {
                _loc9_ = this._roomRenderer.createRenderer();
            }

            if (_loc9_ == null)
            {
                return null;
            }

            _loc9_.roomObjectVariableAccurateZ = RoomObjectVariableEnum.OBJECT_ACCURATE_Z_VALUE;
            _loc8_.setRenderer(_loc9_);
            var _loc10_: IRoomRenderingCanvas = _loc9_.createCanvas(param3, param4, param5, param6);
            if (_loc10_ == null)
            {
                return null;
            }

            _loc10_.mouseListener = this.var_4346;
            if (_loc10_.geometry != null)
            {
                _loc12_ = this.getWorldType(param1, param2);
                if (this.isPublicRoomWorldType(_loc12_))
                {
                    if (this.var_4348 != null)
                    {
                        if (this.var_4348.getPublicRoomWorldSize(_loc12_) != 64)
                        {
                            _loc10_.geometry.performZoomOut();
                        }

                    }

                }

                _loc10_.geometry.z_scale = _loc8_.getNumber(RoomVariableEnum.var_462);
            }

            if (_loc10_.geometry != null)
            {
                _loc13_ = _loc8_.getNumber(RoomObjectVariableEnum.var_473);
                _loc14_ = _loc8_.getNumber(RoomObjectVariableEnum.var_474);
                _loc15_ = _loc8_.getNumber(RoomObjectVariableEnum.var_475);
                _loc16_ = _loc8_.getNumber(RoomObjectVariableEnum.var_476);
                _loc17_ = new Vector3d(_loc13_, _loc14_, _loc15_);
                _loc18_ = null;
                if (_loc16_ == 90)
                {
                    _loc18_ = new Vector3d(-1000, 0, 0);
                }

                if (_loc16_ == 180)
                {
                    _loc18_ = new Vector3d(0, -1000, 0);
                }

                _loc10_.geometry.setDisplacement(_loc17_, _loc18_);
            }

            var _loc11_: Sprite = _loc10_.displayObject as Sprite;
            if (_loc11_ != null)
            {
                _loc19_ = new Sprite();
                _loc19_.name = OVERLAY_SPRITE;
                _loc19_.mouseEnabled = false;
                _loc11_.addChild(_loc19_);
            }

            return _loc11_;
        }

        private function getRoomCanvas(param1: int, param2: int, param3: int): IRoomRenderingCanvas
        {
            var _loc4_: String = this.getRoomIdentifier(param1, param2);
            var _loc5_: IRoomInstance = this._roomManager.getRoom(_loc4_);
            if (_loc5_ == null)
            {
                return null;
            }

            var _loc6_: IRoomRenderer = _loc5_.getRenderer() as IRoomRenderer;
            if (_loc6_ == null)
            {
                return null;
            }

            return _loc6_.getCanvas(param3);
        }

        public function modifyRoomCanvas(param1: int, param2: int, param3: int, param4: int, param5: int): Boolean
        {
            var _loc6_: IRoomRenderingCanvas = this.getRoomCanvas(param1, param2, param3);
            if (_loc6_ == null)
            {
                return false;
            }

            _loc6_.initialize(param4, param5);
            return true;
        }

        public function setRoomCanvasMask(param1: int, param2: int, param3: int, param4: Boolean): void
        {
            var _loc5_: IRoomRenderingCanvas = this.getRoomCanvas(param1, param2, param3);
            if (_loc5_ == null)
            {
                return;
            }

            _loc5_.useMask = param4;
        }

        private function getRoomCanvasRectangle(param1: int, param2: int, param3: int): Rectangle
        {
            var _loc4_: IRoomRenderingCanvas = this.getRoomCanvas(param1, param2, param3);
            if (_loc4_ == null)
            {
                return null;
            }

            return new Rectangle(0, 0, _loc4_.width, _loc4_.height);
        }

        public function getRoomCanvasGeometry(param1: int, param2: int, param3: int): IRoomGeometry
        {
            var _loc4_: IRoomRenderingCanvas = this.getRoomCanvas(param1, param2, param3);
            if (_loc4_ == null)
            {
                return null;
            }

            return _loc4_.geometry;
        }

        public function getRoomCanvasScreenOffset(param1: int, param2: int, param3: int): Point
        {
            var _loc4_: IRoomRenderingCanvas = this.getRoomCanvas(param1, param2, param3);
            if (_loc4_ == null)
            {
                return null;
            }

            return new Point(_loc4_.screenOffsetX, _loc4_.screenOffsetY);
        }

        private function handleRoomDragging(param1: IRoomRenderingCanvas, param2: int, param3: int, param4: String, param5: Boolean, param6: Boolean, param7: Boolean): Boolean
        {
            var _loc10_: RoomInstanceData;
            var _loc11_: RoomCamera;
            var _loc8_: int = param2 - this.var_4356;
            var _loc9_: int = param3 - this.var_4357;
            if (param4 == MouseEvent.MOUSE_DOWN)
            {
                if (!param5 && !param6 && !param7)
                {
                    this.var_4358 = true;
                    this.var_4359 = false;
                    this.var_4360 = this.var_4356;
                    this.var_4361 = this.var_4357;
                }

            }
            else
            {
                if (param4 == MouseEvent.MOUSE_UP)
                {
                    if (this.var_4358)
                    {
                        this.var_4358 = false;
                        if (this.var_4359)
                        {
                            _loc10_ = this.getRoomInstanceData(this._activeRoomId, this._activeRoomCategory);
                            if (_loc10_ != null)
                            {
                                _loc11_ = _loc10_.roomCamera;
                                if (_loc11_ != null)
                                {
                                    if (this.useOffsetScrolling)
                                    {
                                        if (!_loc11_.isMoving)
                                        {
                                            _loc11_.centeredLocX = false;
                                            _loc11_.centeredLocY = false;
                                        }

                                        _loc11_.resetLocation(new Vector3d(-param1.screenOffsetX, -param1.screenOffsetY));
                                    }

                                    if (this.var_4362)
                                    {
                                        _loc11_.scale = 0;
                                    }

                                }

                            }

                        }

                    }

                }
                else
                {
                    if (param4 == MouseEvent.MOUSE_MOVE)
                    {
                        if (this.var_4358)
                        {
                            if (!this.var_4359)
                            {
                                _loc8_ = param2 - this.var_4360;
                                _loc9_ = param3 - this.var_4361;
                                if (_loc8_ <= -var_481 || _loc8_ >= var_481 || _loc9_ <= -var_481 || _loc9_ >= var_481)
                                {
                                    this.var_4359 = true;
                                }

                                _loc8_ = 0;
                                _loc9_ = 0;
                            }

                            if (_loc8_ != 0 || _loc9_ != 0)
                            {
                                param1.screenOffsetX = param1.screenOffsetX + _loc8_;
                                param1.screenOffsetY = param1.screenOffsetY + _loc9_;
                                this.var_4359 = true;
                            }

                        }

                    }
                    else
                    {
                        if (param4 == MouseEvent.CLICK)
                        {
                            if (this.var_4359)
                            {
                                this.var_4359 = false;
                                return true;
                            }

                        }

                    }

                }

            }

            return false;
        }

        public function handleRoomCanvasMouseEvent(param1: int, param2: int, param3: int, param4: String, param5: Boolean, param6: Boolean, param7: Boolean, param8: Boolean): void
        {
            var _loc10_: Sprite;
            var _loc11_: Sprite;
            var _loc12_: Rectangle;
            var _loc13_: String;
            var _loc14_: RoomObjectEvent;
            var _loc9_: IRoomRenderingCanvas = this.getRoomCanvas(this._activeRoomId, this._activeRoomCategory, param1);
            if (_loc9_ != null)
            {
                _loc10_ = this.getOverlaySprite(_loc9_);
                _loc11_ = this.getOverlayIconSprite(_loc10_, var_482);
                if (_loc11_ != null)
                {
                    _loc12_ = _loc11_.getRect(_loc11_);
                    _loc11_.x = param2 - _loc12_.width / 2;
                    _loc11_.y = param3 - _loc12_.height / 2;
                }

                if (!this.handleRoomDragging(_loc9_, param2, param3, param4, param5, param6, param7))
                {
                    if (!_loc9_.handleMouseEvent(param2, param3, param4, param5, param6, param7, param8))
                    {
                        _loc13_ = "";
                        if (param4 == MouseEvent.CLICK)
                        {
                            if (events != null)
                            {
                                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_OBJECT_DESELECTED, this._activeRoomId, this._activeRoomCategory, -1, RoomObjectCategoryEnum.var_352));
                            }

                            _loc13_ = RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_CLICK;
                        }
                        else
                        {
                            if (param4 == MouseEvent.MOUSE_MOVE)
                            {
                                _loc13_ = RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_MOVE;
                            }
                            else
                            {
                                if (param4 == MouseEvent.MOUSE_DOWN)
                                {
                                    _loc13_ = RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_DOWN;
                                }

                            }

                        }

                        if (this.var_4346 != null)
                        {
                            _loc14_ = new RoomObjectMouseEvent(_loc13_, null, var_453, var_454);
                            this.var_4346.handleRoomObjectEvent(_loc14_, this._activeRoomId, this._activeRoomCategory);
                        }

                    }

                }

                this.var_4355 = param1;
                this.var_4356 = param2;
                this.var_4357 = param3;
            }

        }

        private function getOverlaySprite(param1: IRoomRenderingCanvas): Sprite
        {
            if (param1 == null)
            {
                return null;
            }

            var _loc2_: Sprite = param1.displayObject as Sprite;
            if (_loc2_ == null)
            {
                return null;
            }

            return _loc2_.getChildByName(OVERLAY_SPRITE) as Sprite;
        }

        private function addOverlayIconSprite(param1: Sprite, param2: String, param3: BitmapData): Sprite
        {
            if (param1 == null || param3 == null)
            {
                return null;
            }

            var _loc4_: Sprite = this.getOverlayIconSprite(param1, param2);
            if (_loc4_ != null)
            {
                return null;
            }

            _loc4_ = new Sprite();
            _loc4_.name = param2;
            _loc4_.mouseEnabled = false;
            var _loc5_: Bitmap = new Bitmap(param3);
            _loc4_.addChild(_loc5_);
            param1.addChild(_loc4_);
            return _loc4_;
        }

        private function removeOverlayIconSprite(param1: Sprite, param2: String): Boolean
        {
            var _loc4_: Sprite;
            var _loc5_: Bitmap;
            if (param1 == null)
            {
                return false;
            }

            var _loc3_: int = param1.numChildren - 1;
            while (_loc3_ >= 0)
            {
                _loc4_ = (param1.getChildAt(_loc3_) as Sprite);
                if (_loc4_ != null)
                {
                    if (_loc4_.name == param2)
                    {
                        param1.removeChildAt(_loc3_);
                        _loc5_ = (_loc4_.getChildAt(0) as Bitmap);
                        if (_loc5_ != null && _loc5_.bitmapData != null)
                        {
                            _loc5_.bitmapData.dispose();
                            _loc5_.bitmapData = null;
                        }

                        return true;
                    }

                }

                _loc3_--;
            }

            return false;
        }

        private function getOverlayIconSprite(param1: Sprite, param2: String): Sprite
        {
            var _loc4_: Sprite;
            if (param1 == null)
            {
                return null;
            }

            var _loc3_: int = param1.numChildren - 1;
            while (_loc3_ >= 0)
            {
                _loc4_ = (param1.getChildAt(_loc3_) as Sprite);
                if (_loc4_ != null)
                {
                    if (_loc4_.name == param2)
                    {
                        return _loc4_;
                    }

                }

                _loc3_--;
            }

            return null;
        }

        public function setObjectMoverIconSprite(param1: int, param2: int, param3: Boolean, param4: String = null): void
        {
            var _loc7_: String;
            var _loc8_: int;
            var _loc9_: Sprite;
            var _loc10_: Sprite;
            var _loc5_: ImageResult;
            if (param3)
            {
                _loc5_ = this.getRoomObjectImage(this._activeRoomId, this._activeRoomCategory, param1, param2, new Vector3d(), 1, null);
            }
            else
            {
                if (this.var_4348 != null)
                {
                    _loc7_ = null;
                    _loc8_ = 0;
                    if (param2 == RoomObjectCategoryEnum.var_72)
                    {
                        _loc7_ = this.var_4348.getActiveObjectType(param1);
                        _loc8_ = this.var_4348.getActiveObjectColorIndex(param1);
                    }
                    else
                    {
                        if (param2 == RoomObjectCategoryEnum.var_73)
                        {
                            _loc7_ = this.var_4348.getWallItemType(param1, param4);
                            _loc8_ = this.var_4348.getWallItemColorIndex(param1);
                        }

                    }

                    if (param2 == RoomObjectCategoryEnum.var_71)
                    {
                        _loc7_ = this.getUserType(param1);
                        if (_loc7_ == "pet")
                        {
                            _loc7_ = this.getPetType(param4);
                        }

                        _loc5_ = this.getGenericRoomObjectImage(_loc7_, param4, new Vector3d(180), 1, null);
                    }
                    else
                    {
                        _loc5_ = this.getGenericRoomObjectImage(_loc7_, String(_loc8_), new Vector3d(), 1, null, 0, param4);
                    }

                }

            }

            if (_loc5_ == null || _loc5_.data == null)
            {
                return;
            }

            var _loc6_: IRoomRenderingCanvas = this.getRoomCanvas(this._activeRoomId, this._activeRoomCategory, this.var_4355);
            if (_loc6_ != null)
            {
                _loc9_ = this.getOverlaySprite(_loc6_);
                this.removeOverlayIconSprite(_loc9_, var_482);
                _loc10_ = this.addOverlayIconSprite(_loc9_, var_482, _loc5_.data);
                if (_loc10_ != null)
                {
                    _loc10_.x = this.var_4356 - _loc5_.data.width / 2;
                    _loc10_.y = this.var_4357 - _loc5_.data.height / 2;
                }

            }

        }

        public function setObjectMoverIconSpriteVisible(param1: Boolean): void
        {
            var _loc3_: Sprite;
            var _loc4_: Sprite;
            var _loc2_: IRoomRenderingCanvas = this.getRoomCanvas(this._activeRoomId, this._activeRoomCategory, this.var_4355);
            if (_loc2_ != null)
            {
                _loc3_ = this.getOverlaySprite(_loc2_);
                _loc4_ = this.getOverlayIconSprite(_loc3_, var_482);
                if (_loc4_ != null)
                {
                    _loc4_.visible = param1;
                }

            }

        }

        public function removeObjectMoverIconSprite(): void
        {
            var _loc2_: Sprite;
            var _loc1_: IRoomRenderingCanvas = this.getRoomCanvas(this._activeRoomId, this._activeRoomCategory, this.var_4355);
            if (_loc1_ != null)
            {
                _loc2_ = this.getOverlaySprite(_loc1_);
                this.removeOverlayIconSprite(_loc2_, var_482);
            }

        }

        public function getRoomObjectCount(param1: int, param2: int, param3: int): int
        {
            if (!this._isInitialized)
            {
                return 0;
            }

            var _loc4_: String = this.getRoomIdentifier(param1, param2);
            var _loc5_: IRoomInstance = this._roomManager.getRoom(_loc4_);
            if (_loc5_ == null)
            {
                return 0;
            }

            return _loc5_.getObjectCount(param3);
        }

        public function getRoomObject(param1: int, param2: int, param3: int, param4: int): IRoomObject
        {
            if (!this._isInitialized)
            {
                return null;
            }

            var _loc5_: String = this.getRoomIdentifier(param1, param2);
            return this.getObject(_loc5_, param3, param4);
        }

        public function getRoomObjectWithIndex(param1: int, param2: int, param3: int, param4: int): IRoomObject
        {
            if (!this._isInitialized)
            {
                return null;
            }

            var _loc5_: String = this.getRoomIdentifier(param1, param2);
            var _loc6_: IRoomInstance = this._roomManager.getRoom(_loc5_);
            if (_loc6_ == null)
            {
                return null;
            }

            return _loc6_.getObjectWithIndex(param3, param4);
        }

        public function modifyRoomObject(param1: int, param2: int, param3: String): Boolean
        {
            if (this.var_4346 != null)
            {
                return this.var_4346.modifyRoomObject(this._activeRoomId, this._activeRoomCategory, param1, param2, param3);
            }

            return false;
        }

        public function modifyRoomObjectData(param1: int, param2: int, param3: String): Boolean
        {
            if (this.var_4346 != null)
            {
                if (param2 == RoomObjectCategoryEnum.var_73)
                {
                    return this.var_4346.modifyWallItemData(this._activeRoomId, this._activeRoomCategory, param1, param3);
                }

            }

            return false;
        }

        public function deleteRoomObject(param1: int, param2: int): Boolean
        {
            if (this.var_4346 != null)
            {
                if (param2 == RoomObjectCategoryEnum.var_73)
                {
                    return this.var_4346.deleteWallItem(this._activeRoomId, this._activeRoomCategory, param1);
                }

            }

            return false;
        }

        public function initializeRoomObjectInsert(param1: int, param2: int, param3: int, param4: String = null): Boolean
        {
            var _loc5_: IRoomInstance = this.getRoom(this._activeRoomId, this._activeRoomCategory);
            if (_loc5_ == null || _loc5_.getNumber(RoomVariableEnum.var_460) != 0)
            {
                return false;
            }

            if (this.var_4346 != null)
            {
                return this.var_4346.initializeRoomObjectInsert(this._activeRoomId, this._activeRoomCategory, param1, param2, param3, param4);
            }

            return false;
        }

        public function cancelRoomObjectInsert(): void
        {
            if (this.var_4346 != null)
            {
                this.var_4346.cancelRoomObjectInsert(this._activeRoomId, this._activeRoomCategory);
            }

        }

        private function getRoomObjectAdURL(param1: String): String
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.getRoomObjectAdURL(param1);
            }

            return "";
        }

        public function setRoomObjectAlias(param1: String, param2: String): void
        {
            if (this.var_4348 != null)
            {
                this.var_4348.setRoomObjectAlias(param1, param2);
            }

        }

        public function getRoomObjectCategory(param1: String): int
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.getObjectCategory(param1);
            }

            return RoomObjectCategoryEnum.var_352;
        }

        private function getFurnitureType(param1: int): String
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.getActiveObjectType(param1);
            }

            return "";
        }

        private function getWallItemType(param1: int, param2: String = null): String
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.getWallItemType(param1, param2);
            }

            return "";
        }

        private function getUserType(param1: int): String
        {
            switch (param1)
            {
                case 1:
                    return "user";
                case 2:
                    return "pet";
                case 3:
                    return "bot";
            }

            return null;
        }

        private function getPetType(param1: String): String
        {
            var _loc2_: Array;
            var _loc3_: int;
            if (param1 != null)
            {
                _loc2_ = param1.split(" ");
                if (_loc2_.length > 1)
                {
                    _loc3_ = parseInt(_loc2_[0]);
                    if (_loc3_ >= 8)
                    {
                        if (this.var_4348 != null)
                        {
                            return this.var_4348.getPetType(_loc3_);
                        }

                    }

                    return "pet";
                }

            }

            return null;
        }

        public function getPetColor(param1: int, param2: int): PetColorResult
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.getPetColor(param1, param2);
            }

            return null;
        }

        private function getFurnitureColorIndex(param1: int): int
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.getActiveObjectColorIndex(param1);
            }

            return 0;
        }

        private function getWallItemColorIndex(param1: int): int
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.getWallItemColorIndex(param1);
            }

            return 0;
        }

        public function getSelectionArrow(param1: int, param2: int): IRoomObjectController
        {
            return this.getObject(this.getRoomIdentifier(param1, param2), var_457, RoomObjectCategoryEnum.var_355);
        }

        public function getTileCursor(param1: int, param2: int): IRoomObjectController
        {
            return this.getObject(this.getRoomIdentifier(param1, param2), var_455, RoomObjectCategoryEnum.var_355);
        }

        public function addObjectFurniture(param1: int, param2: int, param3: int, param4: int, param5: IVector3d, param6: IVector3d, param7: int, param8: String, param9: Number = NaN, param10: int = -1): Boolean
        {
            var _loc12_: FurnitureData;
            var _loc11_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc11_ != null)
            {
                _loc12_ = new FurnitureData(param3, param4, null, param5, param6, param7, param8, param9, param10);
                _loc11_.addFurnitureData(_loc12_);
            }

            return true;
        }

        public function addObjectFurnitureByName(param1: int, param2: int, param3: int, param4: String, param5: IVector3d, param6: IVector3d, param7: int, param8: String, param9: Number = NaN): Boolean
        {
            var _loc12_: String;
            var _loc13_: FurnitureData;
            var _loc10_: String = this.getWorldType(param1, param2);
            if (this.isPublicRoomWorldType(_loc10_) && this.var_4348 != null)
            {
                _loc12_ = this.var_4348.getPublicRoomContentType(_loc10_) + "_";
                param4 = _loc12_ + param4;
            }

            var _loc11_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc11_ != null)
            {
                _loc13_ = new FurnitureData(param3, 0, param4, param5, param6, param7, param8, param9, 0);
                _loc11_.addFurnitureData(_loc13_);
            }

            return true;
        }

        private function addObjectFurnitureFromData(param1: int, param2: int, param3: int, param4: FurnitureData): Boolean
        {
            var _loc11_: RoomInstanceData;
            if (param4 == null)
            {
                _loc11_ = this.getRoomInstanceData(param1, param2);
                if (_loc11_ != null)
                {
                    param4 = _loc11_.getFurnitureDataWithId(param3);
                }

            }

            if (param4 == null)
            {
                return false;
            }

            var _loc5_: Boolean;
            var _loc6_: String = param4.type;
            if (_loc6_ == null)
            {
                _loc6_ = this.getFurnitureType(param4.typeId);
                _loc5_ = true;
            }

            var _loc7_: int = this.getFurnitureColorIndex(param4.typeId);
            var _loc8_: String = this.getRoomObjectAdURL(_loc6_);
            if (_loc6_ == null)
            {
                _loc6_ = "";
            }

            var _loc9_: IRoomObjectController = this.createObjectFurniture(param1, param2, param3, _loc6_);
            if (_loc9_ == null)
            {
                return false;
            }

            if (_loc9_ != null && _loc9_.getModelController() != null && _loc5_)
            {
                _loc9_.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_COLOR, _loc7_, true);
                _loc9_.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_TYPE_ID, param4.typeId, true);
                _loc9_.getModelController().setString(RoomObjectVariableEnum.var_488, _loc8_, true);
                _loc9_.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_REAL_ROOM_OBJECT, 1, true);
                _loc9_.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_EXPIRY_TIME, param4.expiryTime);
                _loc9_.getModelController().setNumber(RoomObjectVariableEnum.var_491, getTimer());
            }

            if (!this.updateObjectFurniture(param1, param2, param3, param4.loc, param4.dir, param4.state, param4.data, param4.extra))
            {
                return false;
            }

            if (events != null)
            {
                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_ADDED, param1, param2, param3, RoomObjectCategoryEnum.var_72));
            }

            var _loc10_: ISelectedRoomObjectData = this.getPlacedObjectData(param1, param2);
            if (_loc10_ && Math.abs(_loc10_.id) == param3 && _loc10_.category == RoomObjectCategoryEnum.var_72)
            {
                this.selectRoomObject(param1, param2, param3, RoomObjectCategoryEnum.var_72);
            }

            return true;
        }

        public function updateObjectFurniture(param1: int, param2: int, param3: int, param4: IVector3d, param5: IVector3d, param6: int, param7: String, param8: Number = NaN): Boolean
        {
            var _loc9_: IRoomObjectController = this.getObjectFurniture(param1, param2, param3);
            if (_loc9_ == null)
            {
                return false;
            }

            var _loc10_: RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param4, param5);
            var _loc11_: RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param6, param7, param8);
            if (_loc9_ != null && _loc9_.getEventHandler() != null)
            {
                _loc9_.getEventHandler().processUpdateMessage(_loc10_);
                _loc9_.getEventHandler().processUpdateMessage(_loc11_);
            }

            return true;
        }

        public function updateObjectFurnitureLocation(param1: int, param2: int, param3: int, param4: RoomObjectUpdateMessage): Boolean
        {
            var _loc5_: IRoomObjectController = this.getObjectFurniture(param1, param2, param3);
            if (_loc5_ == null)
            {
                return false;
            }

            if (_loc5_ != null && _loc5_.getEventHandler() != null)
            {
                _loc5_.getEventHandler().processUpdateMessage(param4);
            }

            return true;
        }

        private function createObjectFurniture(param1: int, param2: int, param3: int, param4: String): IRoomObjectController
        {
            var _loc5_: int = RoomObjectCategoryEnum.var_72;
            return this.createObject(this.getRoomIdentifier(param1, param2), param3, param4, _loc5_);
        }

        private function getObjectFurniture(param1: int, param2: int, param3: int): IRoomObjectController
        {
            return this.getObject(this.getRoomIdentifier(param1, param2), param3, RoomObjectCategoryEnum.var_72);
        }

        public function disposeObjectFurniture(param1: int, param2: int, param3: int): void
        {
            var _loc4_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc4_ != null)
            {
                _loc4_.getFurnitureDataWithId(param3);
            }

            this.disposeObject(this.getRoomIdentifier(param1, param2), param3, RoomObjectCategoryEnum.var_72);
            this.removeBtnMouseCursorOwner(RoomObjectCategoryEnum.var_72, param3);
        }

        public function addObjectWallItem(param1: int, param2: int, param3: int, param4: int, param5: IVector3d, param6: IVector3d, param7: int, param8: String): Boolean
        {
            var _loc10_: FurnitureData;
            var _loc9_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc9_ != null)
            {
                _loc10_ = new FurnitureData(param3, param4, null, param5, param6, param7, param8);
                _loc9_.addWallItemData(_loc10_);
            }

            return true;
        }

        private function addObjectWallItemFromData(param1: int, param2: int, param3: int, param4: FurnitureData): Boolean
        {
            var _loc10_: RoomInstanceData;
            if (param4 == null)
            {
                _loc10_ = this.getRoomInstanceData(param1, param2);
                if (_loc10_ != null)
                {
                    param4 = _loc10_.getWallItemDataWithId(param3);
                }

            }

            if (param4 == null)
            {
                return false;
            }

            var _loc5_: String = this.getWallItemType(param4.typeId, param4.data);
            var _loc6_: int = this.getWallItemColorIndex(param4.typeId);
            var _loc7_: String = this.getRoomObjectAdURL(_loc5_);
            if (_loc5_ == null)
            {
                _loc5_ = "";
            }

            var _loc8_: IRoomObjectController = this.createObjectWallItem(param1, param2, param3, _loc5_);
            if (_loc8_ == null)
            {
                return false;
            }

            if (_loc8_ != null && _loc8_.getModelController() != null)
            {
                _loc8_.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_COLOR, _loc6_, false);
                _loc8_.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_TYPE_ID, param4.typeId, true);
                _loc8_.getModelController().setString(RoomObjectVariableEnum.var_488, _loc7_, true);
                _loc8_.getModelController().setNumber(RoomObjectVariableEnum.OBJECT_ACCURATE_Z_VALUE, 1, true);
            }

            if (!this.updateObjectWallItem(param1, param2, param3, param4.loc, param4.dir, param4.state, param4.data))
            {
                return false;
            }

            if (events != null)
            {
                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_ADDED, param1, param2, param3, RoomObjectCategoryEnum.var_73));
            }

            var _loc9_: ISelectedRoomObjectData = this.getPlacedObjectData(param1, param2);
            if (_loc9_ && _loc9_.id == param3 && _loc9_.category == RoomObjectCategoryEnum.var_73)
            {
                this.selectRoomObject(param1, param2, param3, RoomObjectCategoryEnum.var_73);
            }

            return true;
        }

        public function updateObjectWallItem(param1: int, param2: int, param3: int, param4: IVector3d, param5: IVector3d, param6: int, param7: String): Boolean
        {
            var _loc8_: IRoomObjectController = this.getObjectWallItem(param1, param2, param3);
            if (_loc8_ == null)
            {
                return false;
            }

            var _loc9_: RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param4, param5);
            var _loc10_: RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param6, param7);
            if (_loc8_ != null && _loc8_.getEventHandler() != null)
            {
                _loc8_.getEventHandler().processUpdateMessage(_loc9_);
                _loc8_.getEventHandler().processUpdateMessage(_loc10_);
            }

            this.updateObjectRoomWindow(param1, param2, param3);
            return true;
        }

        public function updateObjectRoomWindow(param1: int, param2: int, param3: int, param4: Boolean = true): void
        {
            var _loc9_: String;
            var _loc10_: IVector3d;
            var _loc5_: String = RoomObjectCategoryEnum.var_73 + "_" + param3;
            var _loc6_: RoomObjectRoomMaskUpdateMessage;
            var _loc7_: IRoomObjectController = this.getObjectWallItem(param1, param2, param3);
            if (_loc7_ != null)
            {
                if (_loc7_.getModel() != null)
                {
                    if (_loc7_.getModel().getNumber(RoomObjectVariableEnum.var_492) > 0)
                    {
                        _loc9_ = _loc7_.getModel().getString(RoomObjectVariableEnum.var_493);
                        _loc10_ = _loc7_.getLocation();
                        if (param4)
                        {
                            _loc6_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _loc5_, _loc9_, _loc10_);
                        }
                        else
                        {
                            _loc6_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK2, _loc5_);
                        }

                    }

                }

            }
            else
            {
                _loc6_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK2, _loc5_);
            }

            var _loc8_: IRoomObjectController = this.getObjectRoom(param1, param2);
            if (_loc8_ != null && _loc8_.getEventHandler() != null && _loc6_ != null)
            {
                _loc8_.getEventHandler().processUpdateMessage(_loc6_);
            }

        }

        public function updateObjectWallItemData(param1: int, param2: int, param3: int, param4: String): Boolean
        {
            var _loc5_: IRoomObjectController = this.getObjectWallItem(param1, param2, param3);
            if (_loc5_ == null)
            {
                return false;
            }

            var _loc6_: RoomObjectItemDataUpdateMessage = new RoomObjectItemDataUpdateMessage(param4);
            if (_loc5_ != null && _loc5_.getEventHandler() != null)
            {
                _loc5_.getEventHandler().processUpdateMessage(_loc6_);
            }

            return true;
        }

        private function createObjectWallItem(param1: int, param2: int, param3: int, param4: String): IRoomObjectController
        {
            var _loc5_: int = RoomObjectCategoryEnum.var_73;
            return this.createObject(this.getRoomIdentifier(param1, param2), param3, param4, _loc5_);
        }

        private function getObjectWallItem(param1: int, param2: int, param3: int): IRoomObjectController
        {
            return this.getObject(this.getRoomIdentifier(param1, param2), param3, RoomObjectCategoryEnum.var_73);
        }

        public function disposeObjectWallItem(param1: int, param2: int, param3: int): void
        {
            var _loc4_: RoomInstanceData = this.getRoomInstanceData(param1, param2);
            if (_loc4_ != null)
            {
                _loc4_.getWallItemDataWithId(param3);
            }

            this.disposeObject(this.getRoomIdentifier(param1, param2), param3, RoomObjectCategoryEnum.var_73);
            this.updateObjectRoomWindow(param1, param2, param3, false);
            this.removeBtnMouseCursorOwner(RoomObjectCategoryEnum.var_73, param3);
        }

        public function addObjectUser(param1: int, param2: int, param3: int, param4: IVector3d, param5: IVector3d, param6: Number, param7: int, param8: String = null): Boolean
        {
            var _loc11_: RoomObjectUpdateMessage;
            var _loc12_: RoomObjectAvatarFigureUpdateMessage;
            if (this.getObjectUser(param1, param2, param3) != null)
            {
                return false;
            }

            var _loc9_: String = this.getUserType(param7);
            if (_loc9_ == "pet")
            {
                _loc9_ = this.getPetType(param8);
            }

            var _loc10_: IRoomObjectController = this.createObjectUser(param1, param2, param3, _loc9_);
            if (_loc10_ == null)
            {
                return false;
            }

            if (_loc10_ != null && _loc10_.getEventHandler() != null)
            {
                _loc11_ = new RoomObjectUpdateMessage(param4, param5);
                _loc10_.getEventHandler().processUpdateMessage(_loc11_);
                if (param8 != null)
                {
                    _loc12_ = new RoomObjectAvatarFigureUpdateMessage(param8);
                    _loc10_.getEventHandler().processUpdateMessage(_loc12_);
                }

            }

            if (events != null)
            {
                events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOB_OBJECT_ADDED, param1, param2, param3, RoomObjectCategoryEnum.var_71));
            }

            return true;
        }

        public function updateObjectUser(param1: int, param2: int, param3: int, param4: IVector3d, param5: IVector3d, param6: IVector3d = null, param7: Number = NaN): Boolean
        {
            var _loc8_: IRoomObjectController = this.getObjectUser(param1, param2, param3);
            if (_loc8_ == null || _loc8_.getEventHandler() == null || _loc8_.getModel() == null)
            {
                return false;
            }

            if (param4 == null)
            {
                param4 = _loc8_.getLocation();
            }

            if (param6 == null)
            {
                param6 = _loc8_.getDirection();
            }

            if (isNaN(param7))
            {
                param7 = _loc8_.getModel().getNumber(RoomObjectVariableEnum.HEAD_DIRECTION);
            }

            var _loc9_: RoomObjectUpdateMessage = new RoomObjectAvatarUpdateMessage(param4, param5, param6, param7);
            _loc8_.getEventHandler().processUpdateMessage(_loc9_);
            return true;
        }

        public function updateObjectUserState(param1: int, param2: int, param3: int, param4: RoomObjectUpdateStateMessage): Boolean
        {
            var _loc5_: IRoomObjectController = this.getObjectUser(param1, param2, param3);
            if (_loc5_ == null || _loc5_.getEventHandler() == null)
            {
                return false;
            }

            _loc5_.getEventHandler().processUpdateMessage(param4);
            return true;
        }

        private function createObjectUser(param1: int, param2: int, param3: int, param4: String): IRoomObjectController
        {
            var _loc5_: int = RoomObjectCategoryEnum.var_71;
            return this.createObject(this.getRoomIdentifier(param1, param2), param3, param4, _loc5_);
        }

        private function getObjectUser(param1: int, param2: int, param3: int): IRoomObjectController
        {
            return this.getObject(this.getRoomIdentifier(param1, param2), param3, RoomObjectCategoryEnum.var_71);
        }

        public function disposeObjectUser(param1: int, param2: int, param3: int): void
        {
            this.disposeObject(this.getRoomIdentifier(param1, param2), param3, RoomObjectCategoryEnum.var_71);
        }

        private function createObject(param1: String, param2: int, param3: String, param4: int): IRoomObjectController
        {
            var _loc5_: IRoomInstance = this._roomManager.getRoom(param1);
            if (_loc5_ == null)
            {
                return null;
            }

            var _loc6_: IRoomObjectController;
            return _loc5_.createRoomObject(param2, param3, param4) as IRoomObjectController;
        }

        private function getObject(param1: String, param2: int, param3: int): IRoomObjectController
        {
            var _loc4_: IRoomInstance = this._roomManager.getRoom(param1);
            if (_loc4_ == null)
            {
                return null;
            }

            var _loc5_: IRoomObjectController;
            _loc5_ = (_loc4_.getObject(param2, param3) as IRoomObjectController);
            if (_loc5_ == null)
            {
                if (param3 == RoomObjectCategoryEnum.var_72)
                {
                    this.addObjectFurnitureFromData(this.getRoomId(param1), this.getRoomCategory(param1), param2, null);
                    _loc5_ = (_loc4_.getObject(param2, param3) as IRoomObjectController);
                }
                else
                {
                    if (param3 == RoomObjectCategoryEnum.var_73)
                    {
                        this.addObjectWallItemFromData(this.getRoomId(param1), this.getRoomCategory(param1), param2, null);
                        _loc5_ = (_loc4_.getObject(param2, param3) as IRoomObjectController);
                    }

                }

            }

            return _loc5_;
        }

        private function disposeObject(param1: String, param2: int, param3: int): void
        {
            var _loc4_: IRoomInstance = this._roomManager.getRoom(param1);
            if (_loc4_ == null)
            {
                return;
            }

            if (_loc4_.disposeObject(param2, param3))
            {
                if (events != null)
                {
                    events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.REOE_OBJECT_REMOVED, this._activeRoomId, this._activeRoomCategory, param2, param3));
                }

            }

        }

        private function roomObjectEventHandler(param1: RoomObjectEvent): void
        {
            if (this.var_4346 != null)
            {
                this.var_4346.handleRoomObjectEvent(param1, this._activeRoomId, this._activeRoomCategory);
            }

        }

        public function getFurnitureIcon(param1: int, param2: IGetImageListener, param3: String = null): ImageResult
        {
            return this.getFurnitureImage(param1, new Vector3d(), 1, param2, 0, param3);
        }

        public function getWallItemIcon(param1: int, param2: IGetImageListener, param3: String = null): ImageResult
        {
            return this.getWallItemImage(param1, new Vector3d(), 1, param2, 0, param3);
        }

        public function getFurnitureImage(param1: int, param2: IVector3d, param3: int, param4: IGetImageListener, param5: uint = 0, param6: String = null, param7: int = -1, param8: int = -1): ImageResult
        {
            var _loc9_: String;
            var _loc10_: String = "";
            if (this.var_4348 != null)
            {
                _loc9_ = this.var_4348.getActiveObjectType(param1);
                _loc10_ = String(this.var_4348.getActiveObjectColorIndex(param1));
            }

            return this.getGenericRoomObjectImage(_loc9_, _loc10_, param2, param3, param4, param5, param6, param7, param8);
        }

        public function getPetImage(param1: int, param2: int, param3: IVector3d, param4: int, param5: IGetImageListener, param6: uint = 0): ImageResult
        {
            var _loc7_: String;
            var _loc8_: * = param2 + "";
            if (this.var_4348 != null)
            {
                _loc7_ = this.var_4348.getPetType(param1);
            }

            return this.getGenericRoomObjectImage(_loc7_, _loc8_, param3, param4, param5, param6);
        }

        public function getWallItemImage(param1: int, param2: IVector3d, param3: int, param4: IGetImageListener, param5: uint = 0, param6: String = null, param7: int = -1, param8: int = -1): ImageResult
        {
            var _loc9_: String;
            var _loc10_: String = "";
            if (this.var_4348 != null)
            {
                _loc9_ = this.var_4348.getWallItemType(param1, param6);
                _loc10_ = String(this.var_4348.getWallItemColorIndex(param1));
            }

            return this.getGenericRoomObjectImage(_loc9_, _loc10_, param2, param3, param4, param5, param6, param7, param8);
        }

        public function getRoomImage(param1: String, param2: String, param3: String, param4: int, param5: IGetImageListener, param6: String = null): ImageResult
        {
            if (param1 == null)
            {
                param1 = "";
            }

            if (param2 == null)
            {
                param2 = "";
            }

            if (param3 == null)
            {
                param3 = "";
            }

            var _loc7_: String = var_454;
            var _loc8_: * = param1 + "\n" + param2 + "\n" + param3 + "\n";
            if (param6 != null)
            {
                _loc8_ = _loc8_ + param6;
            }

            return this.getGenericRoomObjectImage(_loc7_, _loc8_, new Vector3d(), param4, param5);
        }

        public function getRoomObjectImage(param1: int, param2: int, param3: int, param4: int, param5: IVector3d, param6: int, param7: IGetImageListener, param8: uint = 0): ImageResult
        {
            var _loc11_: String;
            var _loc14_: IRoomObject;
            var _loc9_: String;
            var _loc10_: String = "";
            var _loc12_: String = this.getRoomIdentifier(param1, param2);
            var _loc13_: IRoomInstance = this._roomManager.getRoom(_loc12_);
            if (_loc13_ != null)
            {
                _loc14_ = _loc13_.getObject(param3, param4);
                if (_loc14_ != null && _loc14_.getModel() != null)
                {
                    _loc9_ = _loc14_.getType();
                    switch (param4)
                    {
                        case RoomObjectCategoryEnum.var_72:
                        case RoomObjectCategoryEnum.var_73:
                            _loc10_ = String(_loc14_.getModel().getNumber(RoomObjectVariableEnum.FURNITURE_COLOR));
                            _loc11_ = _loc14_.getModel().getString(RoomObjectVariableEnum.FURNITURE_EXTRAS);
                            break;
                        case RoomObjectCategoryEnum.var_71:
                            _loc10_ = _loc14_.getModel().getString(RoomObjectVariableEnum.FIGURE);
                            break;
                    }

                }

            }

            return this.getGenericRoomObjectImage(_loc9_, _loc10_, param5, param6, param7, param8, _loc11_);
        }

        private function initializeRoomForGettingImage(param1: IRoomObjectController, param2: String): void
        {
            var _loc3_: Array;
            var _loc4_: String;
            var _loc5_: String;
            var _loc6_: String;
            var _loc7_: String;
            var _loc8_: RoomPlaneParser;
            var _loc9_: XML;
            var _loc10_: RoomObjectRoomMaskUpdateMessage;
            var _loc11_: String;
            if (param2 != null)
            {
                _loc3_ = param2.split("\n");
                if (_loc3_.length >= 3)
                {
                    _loc4_ = _loc3_[0];
                    _loc5_ = _loc3_[1];
                    _loc6_ = _loc3_[2];
                    _loc7_ = _loc3_[3];
                    _loc8_ = new RoomPlaneParser();
                    _loc8_.addPlane(RoomPlaneData.PLANE_FLOOR, new Vector3d(0, 0, 0), new Vector3d(10, 0, 0), new Vector3d(0, 10, 0));
                    _loc8_.addPlane(RoomPlaneData.PLANE_WALL, new Vector3d(0, 0, 0), new Vector3d(0, 10, 0), new Vector3d(0, 0, 10));
                    _loc8_.addPlane(RoomPlaneData.PLANE_WALL, new Vector3d(10, 0, 0), new Vector3d(-10, 0, 0), new Vector3d(0, 0, 10));
                    _loc8_.addPlane(RoomPlaneData.PLANE_LANDSCAPE, new Vector3d(10, 0, 0), new Vector3d(-10, 0, 0), new Vector3d(0, 0, 10));
                    _loc9_ = _loc8_.getXML();
                    param1.getEventHandler().initialize(_loc9_);
                    param1.getModelController().setString(RoomObjectVariableEnum.var_465, _loc4_);
                    param1.getModelController().setString(RoomObjectVariableEnum.var_467, _loc5_);
                    param1.getModelController().setString(RoomObjectVariableEnum.var_469, _loc6_);
                    if (_loc7_ != null)
                    {
                        _loc10_ = null;
                        _loc11_ = RoomObjectCategoryEnum.var_73 + "_1";
                        _loc10_ = new RoomObjectRoomMaskUpdateMessage(RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK, _loc11_, _loc7_, new Vector3d(2, 0, 1.75));
                        param1.getEventHandler().processUpdateMessage(_loc10_);
                    }

                }

            }

        }

        public function getGenericRoomObjectImage(param1: String, param2: String, param3: IVector3d, param4: int, param5: IGetImageListener, param6: uint = 0, param7: String = null, param8: int = -1, param9: int = -1): ImageResult
        {
            var _loc18_: String;
            var _loc19_: RoomObjectDataUpdateMessage;
            var _loc20_: int;
            var _loc10_: ImageResult = new ImageResult();
            _loc10_.id = -1;
            if (!this._isInitialized || param1 == null)
            {
                return _loc10_;
            }

            var _loc11_: IRoomInstance = this._roomManager.getRoom(var_501);
            if (_loc11_ == null)
            {
                _loc11_ = this._roomManager.createRoom(var_501, null);
                if (_loc11_ == null)
                {
                    return _loc10_;
                }

            }

            var _loc12_: int = this.var_4350.reserveNumber();
            var _loc13_: int = this.getRoomObjectCategory(param1);
            if (_loc12_ < 0)
            {
                return _loc10_;
            }

            _loc12_ = _loc12_ + 1;
            var _loc14_: IRoomObjectController = _loc11_.createRoomObject(_loc12_, param1, _loc13_) as IRoomObjectController;
            if (_loc14_ == null || _loc14_.getModelController() == null || _loc14_.getEventHandler() == null)
            {
                return _loc10_;
            }

            switch (_loc13_)
            {
                case RoomObjectCategoryEnum.var_72:
                case RoomObjectCategoryEnum.var_73:
                    _loc14_.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_COLOR, int(param2));
                    _loc14_.getModelController().setString(RoomObjectVariableEnum.FURNITURE_EXTRAS, param7);
                    break;
                case RoomObjectCategoryEnum.var_71:
                    if (param1 == "user" || param1 == "bot" || param1 == "pet")
                    {
                        _loc14_.getModelController().setString(RoomObjectVariableEnum.FIGURE, param2);
                    }
                    else
                    {
                        _loc14_.getModelController().setNumber(RoomObjectVariableEnum.PET_PALETTE_INDEX, int(param2));
                    }

                    break;
                case RoomObjectCategoryEnum.var_354:
                    this.initializeRoomForGettingImage(_loc14_, param2);
                    break;
            }

            _loc14_.setDirection(param3);
            var _loc15_: IRoomObjectSpriteVisualization;
            _loc15_ = (_loc14_.getVisualization() as IRoomObjectSpriteVisualization);
            if (_loc15_ == null)
            {
                _loc11_.disposeObject(_loc12_, _loc13_);
                return _loc10_;
            }

            if (param8 > -1)
            {
                _loc18_ = _loc14_.getModel().getString(RoomObjectVariableEnum.FURNITURE_DATA);
                _loc19_ = new RoomObjectDataUpdateMessage(param8, _loc18_);
                if (_loc14_.getEventHandler() != null)
                {
                    _loc14_.getEventHandler().processUpdateMessage(_loc19_);
                }

            }

            var _loc16_: RoomGeometry = new RoomGeometry(param4, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
            _loc15_.update(_loc16_, 0, true, false);
            if (param9 > 0)
            {
                _loc20_ = 0;
                while (_loc20_ < param9)
                {
                    _loc15_.update(_loc16_, 0, true, false);
                    _loc20_++;
                }

            }

            var _loc17_: BitmapData = _loc15_.getImage(param6);
            _loc10_.data = _loc17_;
            _loc10_.id = _loc12_;
            if (!this.isRoomObjectContentAvailable(param1) && param5 != null)
            {
                this.var_4351.add(String(_loc12_), param5);
                _loc14_.getModelController().setNumber(RoomObjectVariableEnum.IMAGE_QUERY_SCALE, param4, true);
            }
            else
            {
                _loc11_.disposeObject(_loc12_, _loc13_);
                this.var_4350.freeNumber(_loc12_ - 1);
                _loc10_.id = 0;
            }

            _loc16_.dispose();
            return _loc10_;
        }

        public function getRoomObjectBoundingRectangle(param1: int, param2: int, param3: int, param4: int, param5: int): Rectangle
        {
            var _loc7_: IRoomObject;
            var _loc8_: IRoomObjectVisualization;
            var _loc9_: Rectangle;
            var _loc10_: Point;
            var _loc11_: IRoomRenderingCanvas;
            var _loc6_: IRoomGeometry = this.getRoomCanvasGeometry(param1, param2, param5);
            if (_loc6_ != null)
            {
                _loc7_ = this.getRoomObject(param1, param2, param3, param4);
                if (_loc7_ != null)
                {
                    _loc8_ = _loc7_.getVisualization();
                    if (_loc8_ != null)
                    {
                        _loc9_ = _loc8_.boundingRectangle;
                        _loc10_ = _loc6_.getScreenPoint(_loc7_.getLocation());
                        if (_loc10_ != null)
                        {
                            _loc9_.offset(_loc10_.x, _loc10_.y);
                            _loc11_ = this.getRoomCanvas(param1, param2, param5);
                            if (_loc11_ != null)
                            {
                                _loc9_.offset(_loc11_.width / 2 + _loc11_.screenOffsetX, _loc11_.height / 2 + _loc11_.screenOffsetY);
                                return _loc9_;
                            }

                        }

                    }

                }

            }

            return null;
        }

        public function getActiveRoomBoundingRectangle(param1: int): Rectangle
        {
            return this.getRoomObjectBoundingRectangle(this._activeRoomId, this._activeRoomCategory, var_453, RoomObjectCategoryEnum.var_354, param1);
        }

        public function isRoomObjectContentAvailable(param1: String): Boolean
        {
            return this._roomManager.isContentAvailable(param1);
        }

        public function contentLoaded(param1: String, param2: Boolean = false): void
        {
            var _loc9_: IRoomObject;
            var _loc10_: int;
            var _loc11_: BitmapData;
            var _loc12_: IRoomObjectSpriteVisualization;
            var _loc13_: IGetImageListener;
            var _loc14_: Number;
            var _loc3_: IRoomInstance = this._roomManager.getRoom(var_501);
            if (_loc3_ == null)
            {
                return;
            }

            if (this.var_4348 == null)
            {
                return;
            }

            var _loc4_: RoomGeometry;
            var _loc5_: Number = 0;
            var _loc6_: int = this.var_4348.getObjectCategory(param1);
            var _loc7_: int = _loc3_.getObjectCount(_loc6_);
            var _loc8_: int = _loc7_ - 1;
            while (_loc8_ >= 0)
            {
                _loc9_ = _loc3_.getObjectWithIndex(_loc8_, _loc6_);
                if (_loc9_ != null && _loc9_.getModel() != null && _loc9_.getType() == param1)
                {
                    _loc10_ = _loc9_.getId();
                    _loc11_ = null;
                    _loc12_ = null;
                    _loc12_ = (_loc9_.getVisualization() as IRoomObjectSpriteVisualization);
                    if (_loc12_ != null)
                    {
                        _loc14_ = _loc9_.getModel().getNumber(RoomObjectVariableEnum.IMAGE_QUERY_SCALE);
                        if (_loc4_ != null && _loc5_ != _loc14_)
                        {
                            _loc4_.dispose();
                            _loc4_ = null;
                        }

                        if (_loc4_ == null)
                        {
                            _loc5_ = _loc14_;
                            _loc4_ = new RoomGeometry(_loc14_, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
                        }

                        _loc12_.update(_loc4_, 0, true, false);
                        _loc11_ = _loc12_.image;
                    }

                    _loc3_.disposeObject(_loc10_, _loc6_);
                    this.var_4350.freeNumber(_loc10_ - 1);
                    _loc13_ = (this.var_4351.remove(String(_loc10_)) as IGetImageListener);
                    if (_loc13_ != null && _loc11_ != null)
                    {
                        _loc13_.imageReady(_loc10_, _loc11_);
                    }
                    else
                    {
                        if (_loc11_ != null)
                        {
                            _loc11_.dispose();
                        }

                    }

                }

                _loc8_--;
            }

            if (_loc4_ != null)
            {
                _loc4_.dispose();
            }

        }

        public function objectInitialized(param1: String, param2: int, param3: int): void
        {
            var _loc7_: String;
            var _loc8_: int;
            var _loc9_: RoomObjectDataUpdateMessage;
            var _loc4_: int = this.getRoomId(param1);
            var _loc5_: int = this.getRoomCategory(param1);
            if (param3 == RoomObjectCategoryEnum.var_73)
            {
                this.updateObjectRoomWindow(_loc4_, _loc5_, param2);
            }

            var _loc6_: IRoomObjectController = this.getRoomObject(_loc4_, _loc5_, param2, param3) as IRoomObjectController;
            if (_loc6_ != null && _loc6_.getModel() != null && _loc6_.getEventHandler() != null)
            {
                _loc7_ = _loc6_.getModel().getString(RoomObjectVariableEnum.FURNITURE_DATA);
                if (_loc7_ != null)
                {
                    _loc8_ = _loc6_.getState(0);
                    _loc9_ = new RoomObjectDataUpdateMessage(_loc8_, _loc7_);
                    _loc6_.getEventHandler().processUpdateMessage(_loc9_);
                }

            }

        }

        public function selectAvatar(param1: int, param2: int, param3: int, param4: Boolean): void
        {
            if (this.var_4346 != null)
            {
                this.var_4346.setSelectedAvatar(param1, param2, param3, param4);
            }

        }

        public function getSelectedAvatarId(): int
        {
            if (this.var_4346 != null)
            {
                return this.var_4346.getSelectedAvatarId();
            }

            return -1;
        }

        public function selectRoomObject(param1: int, param2: int, param3: int, param4: int): void
        {
            if (this.var_4346 == null)
            {
                return;
            }

            this.var_4346.setSelectedObject(param1, param2, param3, param4);
        }

        public function loadRoomResources(param1: String): Array
        {
            if (this.var_4348 != null)
            {
                return this.var_4348.loadLegacyContent(param1, events);
            }

            return [];
        }

        private function showRoomAd(param1: AdEvent): void
        {
            var _loc2_: String;
            var _loc3_: IRoomObjectController;
            var _loc4_: RoomObjectRoomAdUpdateMessage;
            if (this.var_4348 != null)
            {
                _loc2_ = this.getWorldType(param1.roomId, param1.roomCategory);
                this.var_4348.addGraphicAsset(this.var_4348.getPublicRoomContentType(_loc2_), RoomObjectVariableEnum.var_505, param1.image, true);
                this.var_4348.addGraphicAsset(this.var_4348.getPublicRoomContentType(_loc2_), RoomObjectVariableEnum.var_506, param1.adWarningL, true);
                this.var_4348.addGraphicAsset(this.var_4348.getPublicRoomContentType(_loc2_), RoomObjectVariableEnum.var_507, param1.adWarningR, true);
                _loc3_ = this.getObjectRoom(param1.roomId, param1.roomCategory);
                if (_loc3_ == null)
                {
                    return;
                }

                _loc4_ = null;
                _loc4_ = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.RORUM_ROOM_AD_ACTIVATE, RoomObjectVariableEnum.var_505, param1.clickUrl);
                _loc3_.getEventHandler().processUpdateMessage(_loc4_);
            }

        }

        public function requestRoomAdImage(param1: int, param2: int, param3: String, param4: String): void
        {
            if (this.var_4345 != null)
            {
                this.var_4345.loadRoomAdImage(param1, param2, param3, param4);
            }

        }

        private function onRoomAdImageLoaded(param1: AdEvent): void
        {
            var _loc4_: RoomObjectRoomAdUpdateMessage;
            var _loc2_: IRoomObjectController = this.getObjectRoom(param1.roomId, param1.roomCategory);
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: IRoomObjectController = this.getObjectFurniture(param1.roomId, param1.roomCategory, param1.objectId);
            if (_loc3_ == null || _loc3_.getEventHandler() == null)
            {
                return;
            }

            if (param1.image != null)
            {
                this.var_4348.addGraphicAsset(_loc3_.getType(), param1.imageUrl, param1.image, true);
            }

            switch (param1.type)
            {
                case AdEvent.ROOM_AD_IMAGE_LOADED:
                    _loc4_ = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.RORUM_ROOM_BILLBOARD_IMAGE_LOADED, param1.imageUrl, param1.clickUrl, param1.objectId, param1.image);
                    break;
                case AdEvent.ROOM_AD_IMAGE_LOADING_FAILED:
                    _loc4_ = new RoomObjectRoomAdUpdateMessage(RoomObjectRoomAdUpdateMessage.RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED, param1.imageUrl, param1.clickUrl, param1.objectId, param1.image);
                    break;
            }

            if (_loc4_ != null)
            {
                _loc3_.getEventHandler().processUpdateMessage(_loc4_);
            }

        }

        public function insertContentLibrary(param1: int, param2: int, param3: IAssetLibrary): Boolean
        {
            return this.var_4348.insertObjectContent(param1, param2, param3);
        }

        public function setActiveObjectType(param1: int, param2: String): void
        {
            this.var_4348.setActiveObjectType(param1, param2);
        }

    }
}
