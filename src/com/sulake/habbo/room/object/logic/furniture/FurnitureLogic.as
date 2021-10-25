package com.sulake.habbo.room.object.logic.furniture
{

    import com.sulake.habbo.room.object.logic.MovingObjectLogic;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.events.RoomObjectEvent;

    import flash.events.MouseEvent;

    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureLogic extends MovingObjectLogic
    {

        private var var_3959: Boolean = false;
        private var var_3038: Number = 0;
        private var var_3039: Number = 0;
        private var var_3960: Number = 0;
        private var var_3961: Number = 0;
        private var var_3962: Number = 0;
        private var var_3963: Number = 0;
        private var var_3964: Array = [];

        override public function getEventTypes(): Array
        {
            var _loc1_: Array = [
                RoomObjectRoomAdEvent.var_345,
                RoomObjectRoomAdEvent.var_346,
                RoomObjectRoomAdEvent.var_344,
                RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE,
                RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_CLICK,
                RoomObjectRoomAdEvent.var_50,
                RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_DOWN
            ];
            return getAllEventTypes(super.getEventTypes(), _loc1_);
        }

        override public function dispose(): void
        {
            super.dispose();
            this.var_3964 = null;
        }

        override public function initialize(param1: XML): void
        {
            var _loc7_: XML;
            var _loc8_: int;
            if (param1 == null)
            {
                return;
            }

            this.var_3038 = 0;
            this.var_3039 = 0;
            this.var_3960 = 0;
            this.var_3964 = [];
            var _loc2_: XMLList = param1.model.dimensions;
            if (_loc2_.length() == 0)
            {
                return;
            }

            var _loc3_: XMLList = _loc2_.@x;
            if (_loc3_.length() == 1)
            {
                this.var_3038 = Number(_loc3_);
            }

            _loc3_ = _loc2_.@y;
            if (_loc3_.length() == 1)
            {
                this.var_3039 = Number(_loc3_);
            }

            _loc3_ = _loc2_.@z;
            if (_loc3_.length() == 1)
            {
                this.var_3960 = Number(_loc3_);
            }

            this.var_3961 = this.var_3038 / 2;
            this.var_3962 = this.var_3039 / 2;
            _loc3_ = _loc2_.@centerZ;
            if (_loc3_.length() == 1)
            {
                this.var_3963 = Number(_loc3_);
            }
            else
            {
                this.var_3963 = this.var_3960 / 2;
            }

            var _loc4_: XMLList = param1.model.directions.direction;
            var _loc5_: Array = ["id"];
            var _loc6_: int;
            while (_loc6_ < _loc4_.length())
            {
                _loc7_ = _loc4_[_loc6_];
                if (XMLValidator.checkRequiredAttributes(_loc7_, _loc5_))
                {
                    _loc8_ = parseInt(_loc7_.@id);
                    this.var_3964.push(_loc8_);
                }

                _loc6_++;
            }

            this.var_3964.sort(Array.NUMERIC);
            if (object == null || object.getModelController() == null)
            {
                return;
            }

            object.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_SIZE_X, this.var_3038, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_SIZE_Y, this.var_3039, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_SIZE_Z, this.var_3960, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_CENTER_X, this.var_3961, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_CENTER_Y, this.var_3962, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_CENTER_Z, this.var_3963, true);
            object.getModelController()
                    .setNumberArray(RoomObjectVariableEnum.FURNITURE_ALLOWED_DIRECTIONS, this.var_3964, true);
            object.getModelController().setNumber(RoomObjectVariableEnum.FURNITURE_ALPHA_MULTIPLIER, 1);
        }

        protected function getAdClickUrl(param1: IRoomObjectModelController): String
        {
            return param1.getString(RoomObjectVariableEnum.var_488);
        }

        protected function handleAdClick(param1: int, param2: String, param3: String): void
        {
            if (eventDispatcher != null)
            {
                eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_50, param1, param2));
            }

        }

        override public function mouseEvent(param1: RoomSpriteMouseEvent, param2: IRoomGeometry): void
        {
            var _loc4_: int;
            var _loc5_: String;
            var _loc6_: RoomObjectEvent;
            if (param1 == null || param2 == null)
            {
                return;
            }

            if (param1.type == MouseEvent.MOUSE_MOVE)
            {
                return;
            }

            if (object == null)
            {
                return;
            }

            var _loc3_: IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
            if (_loc3_ == null)
            {
                return;
            }

            var _loc7_: String = this.getAdClickUrl(_loc3_);
            switch (param1.type)
            {
                case MouseEvent.ROLL_OVER:
                    if (!this.var_3959)
                    {
                        if (eventDispatcher != null && _loc7_ != null && _loc7_.indexOf("http") == 0)
                        {
                            _loc4_ = object.getId();
                            _loc5_ = object.getType();
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_345, _loc4_, _loc5_));
                        }

                        this.var_3959 = true;
                    }

                    return;
                case MouseEvent.ROLL_OUT:
                    if (this.var_3959)
                    {
                        if (eventDispatcher != null && _loc7_ != null && _loc7_.indexOf("http") == 0)
                        {
                            _loc4_ = object.getId();
                            _loc5_ = object.getType();
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_346, _loc4_, _loc5_));
                        }

                        this.var_3959 = false;
                    }

                    return;
                case MouseEvent.DOUBLE_CLICK:
                    _loc4_ = object.getId();
                    _loc5_ = object.getType();
                    if (eventDispatcher != null && _loc7_ != null && _loc7_.indexOf("http") == 0)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_344, _loc4_, _loc5_));
                    }

                    if (eventDispatcher != null)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.ROSCE_STATE_CHANGE, _loc4_, _loc5_));
                    }

                    return;
                case MouseEvent.CLICK:
                    _loc4_ = object.getId();
                    _loc5_ = object.getType();
                    if (eventDispatcher != null)
                    {
                        _loc6_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_CLICK, param1.eventId, _loc4_, _loc5_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                        eventDispatcher.dispatchEvent(_loc6_);
                    }

                    if (eventDispatcher != null && _loc7_ != null && _loc7_.indexOf("http") == 0)
                    {
                        this.handleAdClick(_loc4_, _loc5_, _loc7_);
                    }

                    return;
                case MouseEvent.MOUSE_DOWN:
                    if (eventDispatcher != null)
                    {
                        _loc4_ = object.getId();
                        _loc5_ = object.getType();
                        _loc6_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.ROOM_OBJECT_MOUSE_DOWN, param1.eventId, _loc4_, _loc5_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                        eventDispatcher.dispatchEvent(_loc6_);
                    }

                    return;
            }

        }

        override public function processUpdateMessage(param1: RoomObjectUpdateMessage): void
        {
            var _loc2_: IRoomObjectModelController = object.getModelController();
            var _loc3_: RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
            if (_loc3_ != null)
            {
                object.setState(_loc3_.state, 0);
                if (_loc2_ != null)
                {
                    _loc2_.setString(RoomObjectVariableEnum.FURNITURE_DATA, _loc3_.data);
                    if (!isNaN(_loc3_.extra))
                    {
                        _loc2_.setString(RoomObjectVariableEnum.FURNITURE_EXTRAS, String(_loc3_.extra));
                    }

                    _loc2_.setNumber(RoomObjectVariableEnum.var_746, lastUpdateTime);
                }

                return;
            }

            var _loc4_: RoomObjectItemDataUpdateMessage = param1 as RoomObjectItemDataUpdateMessage;
            if (_loc4_ != null)
            {
                if (_loc2_ != null)
                {
                    _loc2_.setString(RoomObjectVariableEnum.FURNITURE_ITEMDATA, _loc4_.itemData);
                }

                return;
            }

            this.var_3959 = false;
            super.processUpdateMessage(param1);
        }

    }
}
