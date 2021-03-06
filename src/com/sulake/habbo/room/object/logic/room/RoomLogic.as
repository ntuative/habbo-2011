package com.sulake.habbo.room.object.logic.room
{

    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.ColorConverter;
    import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskData;
    import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;

    import flash.utils.getTimer;

    import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;

    import flash.events.MouseEvent;
    import flash.geom.Point;

    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.object.RoomPlaneData;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class RoomLogic extends ObjectLogicBase
    {

        protected var _planeParser: RoomPlaneParser = null;
        private var var_3972: RoomPlaneBitmapMaskParser = null;
        private var _color: uint = 0xFFFFFF;
        private var var_3058: int = 0xFF;
        private var var_3973: uint = 0xFFFFFF;
        private var var_3974: int = 0xFF;
        private var var_3975: uint = 0xFFFFFF;
        private var var_3976: int = 0xFF;
        private var var_3977: int = 0;
        private var var_3978: int = 1500;

        public function RoomLogic()
        {
            this._planeParser = new RoomPlaneParser();
            this.var_3972 = new RoomPlaneBitmapMaskParser();
        }

        override public function getEventTypes(): Array
        {
            var _loc1_: Array = [RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_MOVE, RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_CLICK];
            return getAllEventTypes(super.getEventTypes(), _loc1_);
        }

        override public function dispose(): void
        {
            super.dispose();
            if (this._planeParser != null)
            {
                this._planeParser.dispose();
                this._planeParser = null;
            }

            if (this.var_3972 != null)
            {
                this.var_3972.dispose();
                this.var_3972 = null;
            }

        }

        override public function initialize(param1: XML): void
        {
            if (param1 == null || object == null)
            {
                return;
            }

            if (!this._planeParser.initializeFromXML(param1))
            {
                return;
            }

            var _loc2_: IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
            if (_loc2_ != null)
            {
                _loc2_.setString(RoomObjectVariableEnum.var_754, param1.toString(), true);
                _loc2_.setNumber(RoomObjectVariableEnum.var_759, 0xFFFFFF);
                _loc2_.setNumber(RoomObjectVariableEnum.var_756, 1);
                _loc2_.setNumber(RoomObjectVariableEnum.var_757, 1);
                _loc2_.setNumber(RoomObjectVariableEnum.var_758, 1);
            }

        }

        override public function update(param1: int): void
        {
            super.update(param1);
            this.updateBackgroundColor(param1);
        }

        private function updateBackgroundColor(param1: int): void
        {
            var _loc2_: int;
            var _loc3_: int;
            var _loc4_: int;
            var _loc5_: int;
            var _loc6_: IRoomObjectModelController;
            var _loc7_: int;
            var _loc8_: int;
            var _loc9_: int;
            var _loc10_: int;
            var _loc11_: int;
            var _loc12_: int;
            var _loc13_: Number;
            if (object == null)
            {
                return;
            }

            if (this.var_3977)
            {
                _loc2_ = param1;
                _loc3_ = this._color;
                _loc4_ = this.var_3058;
                if (_loc2_ - this.var_3977 >= this.var_3978)
                {
                    _loc3_ = this.var_3975;
                    _loc4_ = this.var_3976;
                    this.var_3977 = 0;
                }
                else
                {
                    _loc7_ = this.var_3973 >> 16 & 0xFF;
                    _loc8_ = this.var_3973 >> 8 & 0xFF;
                    _loc9_ = this.var_3973 & 0xFF;
                    _loc10_ = this.var_3975 >> 16 & 0xFF;
                    _loc11_ = this.var_3975 >> 8 & 0xFF;
                    _loc12_ = this.var_3975 & 0xFF;
                    _loc13_ = (_loc2_ - this.var_3977) / this.var_3978;
                    _loc7_ = _loc7_ + (_loc10_ - _loc7_) * _loc13_;
                    _loc8_ = _loc8_ + (_loc11_ - _loc8_) * _loc13_;
                    _loc9_ = _loc9_ + (_loc12_ - _loc9_) * _loc13_;
                    _loc3_ = (_loc7_ << 16) + (_loc8_ << 8) + _loc9_;
                    _loc4_ = this.var_3974 + (this.var_3976 - this.var_3974) * _loc13_;
                    this._color = _loc3_;
                    this.var_3058 = _loc4_;
                }

                _loc5_ = ColorConverter.rgbToHSL(_loc3_);
                _loc5_ = (_loc5_ & 0xFFFF00) + _loc4_;
                _loc3_ = ColorConverter.hslToRGB(_loc5_);
                _loc6_ = (object.getModel() as IRoomObjectModelController);
                if (_loc6_ == null)
                {
                    return;
                }

                _loc6_.setNumber(RoomObjectVariableEnum.var_759, _loc3_);
            }

        }

        private function updatePlaneProperties(param1: RoomObjectRoomUpdateMessage, param2: IRoomObjectModelController): void
        {
            switch (param1.type)
            {
                case RoomObjectRoomUpdateMessage.RORUM_ROOM_FLOOR_UPDATE:
                    param2.setString(RoomObjectVariableEnum.var_465, param1.value);
                    return;
                case RoomObjectRoomUpdateMessage.RORUM_ROOM_WALL_UPDATE:
                    param2.setString(RoomObjectVariableEnum.var_467, param1.value);
                    return;
                case RoomObjectRoomUpdateMessage.RORUM_ROOM_LANDSCAPE_UPDATE:
                    param2.setString(RoomObjectVariableEnum.var_469, param1.value);
                    return;
            }

        }

        private function updatePlaneMasks(param1: RoomObjectRoomMaskUpdateMessage, param2: IRoomObjectModelController): void
        {
            var _loc5_: String;
            var _loc6_: XML;
            var _loc7_: String;
            var _loc3_: RoomPlaneBitmapMaskData;
            var _loc4_: Boolean;
            switch (param1.type)
            {
                case RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK:
                    _loc5_ = RoomPlaneBitmapMaskData.WINDOW;
                    if (param1.maskCategory == RoomObjectRoomMaskUpdateMessage.HOLE)
                    {
                        _loc5_ = RoomPlaneBitmapMaskData.HOLE;
                    }

                    this.var_3972.addMask(param1.maskId, param1.maskType, param1.maskLocation, _loc5_);
                    _loc4_ = true;
                    break;
                case RoomObjectRoomMaskUpdateMessage.RORMUM_ADD_MASK2:
                    _loc4_ = this.var_3972.removeMask(param1.maskId);
                    break;
            }

            if (_loc4_)
            {
                _loc6_ = this.var_3972.getXML();
                _loc7_ = _loc6_.toXMLString();
                param2.setString(RoomObjectVariableEnum.var_755, _loc7_);
            }

        }

        private function updatePlaneVisibilities(param1: RoomObjectRoomPlaneVisibilityUpdateMessage, param2: IRoomObjectModelController): void
        {
            var _loc3_: int;
            if (param1.visible)
            {
                _loc3_ = 1;
            }

            switch (param1.type)
            {
                case RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_FLOOR_VISIBILITY:
                    param2.setNumber(RoomObjectVariableEnum.var_756, _loc3_);
                    return;
                case RoomObjectRoomPlaneVisibilityUpdateMessage.RORPVUM_WALL_VISIBILITY:
                    param2.setNumber(RoomObjectVariableEnum.var_757, _loc3_);
                    param2.setNumber(RoomObjectVariableEnum.var_758, _loc3_);
                    return;
            }

        }

        private function updateColors(param1: RoomObjectRoomColorUpdateMessage, param2: IRoomObjectModelController): void
        {
            var _loc3_: int = param1.color;
            var _loc4_: int = param1.light;
            param2.setNumber(RoomObjectVariableEnum.var_760, int(param1.bgOnly));
            this.var_3973 = this._color;
            this.var_3974 = this.var_3058;
            this.var_3975 = _loc3_;
            this.var_3976 = _loc4_;
            this.var_3977 = getTimer();
            this.var_3978 = 1500;
        }

        override public function processUpdateMessage(param1: RoomObjectUpdateMessage): void
        {
            if (param1 == null || object == null)
            {
                return;
            }

            var _loc2_: IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: RoomObjectRoomUpdateMessage = param1 as RoomObjectRoomUpdateMessage;
            if (_loc3_ != null)
            {
                this.updatePlaneProperties(_loc3_, _loc2_);
                return;
            }

            var _loc4_: RoomObjectRoomMaskUpdateMessage = param1 as RoomObjectRoomMaskUpdateMessage;
            if (_loc4_ != null)
            {
                this.updatePlaneMasks(_loc4_, _loc2_);
                return;
            }

            var _loc5_: RoomObjectRoomPlaneVisibilityUpdateMessage = param1 as RoomObjectRoomPlaneVisibilityUpdateMessage;
            if (_loc5_ != null)
            {
                this.updatePlaneVisibilities(_loc5_, _loc2_);
                return;
            }

            var _loc6_: RoomObjectRoomColorUpdateMessage = param1 as RoomObjectRoomColorUpdateMessage;
            if (_loc6_ != null)
            {
                this.updateColors(_loc6_, _loc2_);

            }

        }

        override public function mouseEvent(param1: RoomSpriteMouseEvent, param2: IRoomGeometry): void
        {
            var _loc25_: String;
            var _loc26_: Number;
            var _loc27_: Number;
            var _loc28_: Number;
            if (param2 == null)
            {
                return;
            }

            var _loc3_: RoomSpriteMouseEvent = param1;
            if (_loc3_ == null)
            {
                return;
            }

            if (object == null || param1 == null)
            {
                return;
            }

            var _loc4_: IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
            if (_loc4_ == null)
            {
                return;
            }

            var _loc5_: int;
            var _loc6_: String = _loc3_.spriteTag;
            if (_loc6_.indexOf("@") >= 0)
            {
                _loc5_ = parseInt(_loc6_.substr(_loc6_.indexOf("@") + 1));
            }

            if (_loc5_ < 1 || _loc5_ > this._planeParser.planeCount)
            {
                if (param1.type == MouseEvent.ROLL_OUT)
                {
                    _loc4_.setNumber(RoomObjectVariableEnum.var_767, 0);
                }

                return;
            }

            _loc5_--;
            var _loc7_: Point;
            var _loc8_: IVector3d = this._planeParser.getPlaneLocation(_loc5_);
            var _loc9_: IVector3d = this._planeParser.getPlaneLeftSide(_loc5_);
            var _loc10_: IVector3d = this._planeParser.getPlaneRightSide(_loc5_);
            var _loc11_: IVector3d = this._planeParser.getPlaneNormalDirection(_loc5_);
            var _loc12_: int = this._planeParser.getPlaneType(_loc5_);
            if (_loc8_ == null || _loc9_ == null || _loc10_ == null || _loc11_ == null)
            {
                return;
            }

            var _loc13_: Number = _loc9_.length;
            var _loc14_: Number = _loc10_.length;
            if (_loc13_ == 0 || _loc14_ == 0)
            {
                return;
            }

            var _loc15_: Number = _loc3_.screenX;
            var _loc16_: Number = _loc3_.screenY;
            var _loc17_: Point = new Point(_loc15_, _loc16_);
            _loc7_ = param2.getPlanePosition(_loc17_, _loc8_, _loc9_, _loc10_);
            if (_loc7_ == null)
            {
                _loc4_.setNumber(RoomObjectVariableEnum.var_767, 0);
                return;
            }

            var _loc18_: Vector3d = Vector3d.product(_loc9_, _loc7_.x / _loc13_);
            _loc18_.add(Vector3d.product(_loc10_, _loc7_.y / _loc14_));
            _loc18_.add(_loc8_);
            var _loc19_: Number = _loc18_.x;
            var _loc20_: Number = _loc18_.y;
            var _loc21_: Number = _loc18_.z;
            if (_loc7_.x >= 0 && _loc7_.x < _loc13_ && _loc7_.y >= 0 && _loc7_.y < _loc14_)
            {
                _loc4_.setNumber(RoomObjectVariableEnum.var_764, _loc19_);
                _loc4_.setNumber(RoomObjectVariableEnum.var_765, _loc20_);
                _loc4_.setNumber(RoomObjectVariableEnum.var_766, _loc21_);
                _loc4_.setNumber(RoomObjectVariableEnum.var_767, _loc5_ + 1);
            }
            else
            {
                _loc4_.setNumber(RoomObjectVariableEnum.var_767, 0);
                return;
            }

            var _loc22_: String = "";
            var _loc23_: int;
            var _loc24_: RoomObjectEvent;
            switch (param1.type)
            {
                case MouseEvent.MOUSE_MOVE:
                case MouseEvent.ROLL_OVER:
                case MouseEvent.CLICK:
                    _loc25_ = "";
                    if (param1.type == MouseEvent.MOUSE_MOVE || param1.type == MouseEvent.ROLL_OVER)
                    {
                        _loc25_ = RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_MOVE;
                    }
                    else
                    {
                        if (param1.type == MouseEvent.CLICK)
                        {
                            _loc25_ = RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_CLICK;
                        }

                    }

                    _loc23_ = object.getId();
                    _loc22_ = object.getType();
                    if (eventDispatcher != null)
                    {
                        if (_loc12_ == RoomPlaneData.PLANE_FLOOR)
                        {
                            _loc24_ = new RoomObjectTileMouseEvent(_loc25_, param1.eventId, _loc23_, _loc22_, _loc19_, _loc20_, _loc21_);
                        }
                        else
                        {
                            if (_loc12_ == RoomPlaneData.PLANE_WALL || _loc12_ == RoomPlaneData.PLANE_LANDSCAPE)
                            {
                                _loc26_ = 90;
                                if (_loc11_ != null)
                                {
                                    _loc26_ = _loc11_.x + 90;
                                    if (_loc26_ > 360)
                                    {
                                        _loc26_ = _loc26_ - 360;
                                    }

                                }

                                _loc27_ = (_loc9_.length * _loc7_.x) / _loc13_;
                                _loc28_ = (_loc10_.length * _loc7_.y) / _loc14_;
                                _loc24_ = new RoomObjectWallMouseEvent(_loc25_, param1.eventId, _loc23_, _loc22_, _loc8_, _loc9_, _loc10_, _loc27_, _loc28_, _loc26_);
                            }

                        }

                        if (_loc24_ != null)
                        {
                            eventDispatcher.dispatchEvent(_loc24_);
                        }

                    }

                    return;
            }

        }

    }
}
