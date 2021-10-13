package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import flash.utils.getTimer;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class PetLogic extends MovingObjectLogic 
    {

        private var var_3982:int = 0;
        private var var_3986:int = 0;
        private var var_3985:int = 0;
        private var _selected:Boolean = false;
        private var var_3979:Vector3d = null;
        private var var_3996:Boolean = false;
        private var var_3997:int = 0;
        private var var_3998:int = 0;
        private var var_3999:int = 0;

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectMouseEvent.var_483, RoomObjectMoveEvent.var_1202];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            var _loc1_:RoomObjectEvent;
            if (((this._selected) && (!(object == null))))
            {
                if (eventDispatcher != null)
                {
                    _loc1_ = new RoomObjectMoveEvent(RoomObjectMoveEvent.var_1203, object.getId(), object.getType());
                    eventDispatcher.dispatchEvent(_loc1_);
                };
            };
            super.dispose();
            this.var_3979 = null;
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc3_:RoomObjectAvatarPostureUpdateMessage;
            var _loc4_:RoomObjectAvatarUpdateMessage;
            var _loc5_:RoomObjectAvatarChatUpdateMessage;
            var _loc6_:RoomObjectAvatarPetGestureUpdateMessage;
            var _loc7_:RoomObjectAvatarSleepUpdateMessage;
            var _loc8_:RoomObjectAvatarSelectedMessage;
            var _loc9_:RoomObjectAvatarExperienceUpdateMessage;
            var _loc10_:RoomObjectAvatarFigureUpdateMessage;
            var _loc11_:String;
            if (((param1 == null) || (object == null)))
            {
                return;
            };
            var _loc2_:IRoomObjectModelController = object.getModelController();
            if (!this.var_3996)
            {
                super.processUpdateMessage(param1);
                if ((param1 is RoomObjectAvatarPostureUpdateMessage))
                {
                    _loc3_ = (param1 as RoomObjectAvatarPostureUpdateMessage);
                    _loc2_.setString(RoomObjectVariableEnum.var_728, _loc3_.postureType);
                    return;
                };
                if ((param1 is RoomObjectAvatarUpdateMessage))
                {
                    _loc4_ = (param1 as RoomObjectAvatarUpdateMessage);
                    _loc2_.setNumber(RoomObjectVariableEnum.var_495, _loc4_.dirHead);
                    return;
                };
                if ((param1 is RoomObjectAvatarChatUpdateMessage))
                {
                    _loc5_ = (param1 as RoomObjectAvatarChatUpdateMessage);
                    _loc2_.setNumber(RoomObjectVariableEnum.var_720, 1);
                    this.var_3982 = (getTimer() + (_loc5_.numberOfWords * 1000));
                    return;
                };
                if ((param1 is RoomObjectAvatarPetGestureUpdateMessage))
                {
                    _loc6_ = (param1 as RoomObjectAvatarPetGestureUpdateMessage);
                    _loc2_.setString(RoomObjectVariableEnum.var_727, _loc6_.gesture);
                    this.var_3986 = (getTimer() + (3 * 1000));
                    return;
                };
                if ((param1 is RoomObjectAvatarSleepUpdateMessage))
                {
                    _loc7_ = (param1 as RoomObjectAvatarSleepUpdateMessage);
                    _loc2_.setNumber(RoomObjectVariableEnum.var_722, Number(_loc7_.isSleeping));
                    return;
                };
            };
            if ((param1 is RoomObjectAvatarSelectedMessage))
            {
                _loc8_ = (param1 as RoomObjectAvatarSelectedMessage);
                this._selected = _loc8_.selected;
                this.var_3979 = null;
                return;
            };
            if ((param1 is RoomObjectAvatarExperienceUpdateMessage))
            {
                _loc9_ = (param1 as RoomObjectAvatarExperienceUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.AVATAR_EXPERIENCE_TIMESTAMP, Number(getTimer()));
                _loc2_.setNumber(RoomObjectVariableEnum.var_736, Number(_loc9_.gainedExperience));
                return;
            };
            if ((param1 is RoomObjectAvatarFigureUpdateMessage))
            {
                _loc10_ = (param1 as RoomObjectAvatarFigureUpdateMessage);
                _loc11_ = _loc2_.getString(RoomObjectVariableEnum.var_497);
                _loc2_.setString(RoomObjectVariableEnum.var_497, _loc10_.figure);
                _loc2_.setString(RoomObjectVariableEnum.var_718, _loc10_.race);
                _loc2_.setNumber(RoomObjectVariableEnum.var_502, this.getPaletteIndex(_loc10_.figure));
                return;
            };
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc6_:int;
            var _loc7_:String;
            var _loc8_:RoomObjectMouseEvent;
            if (((object == null) || (param1 == null)))
            {
                return;
            };
            var _loc3_:IRoomObjectModelController = object.getModelController();
            var _loc4_:IVector3d;
            var _loc5_:Vector3d;
            switch (param1.type)
            {
                case MouseEvent.CLICK:
                    _loc6_ = object.getId();
                    _loc7_ = object.getType();
                    if (eventDispatcher != null)
                    {
                        _loc8_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.var_483, param1.eventId, _loc6_, _loc7_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                        eventDispatcher.dispatchEvent(_loc8_);
                    };
                    if (this.var_3996)
                    {
                        this.debugMouseEvent(param1);
                    };
                    return;
                case MouseEvent.DOUBLE_CLICK:
                    return;
            };
        }

        private function debugMouseEvent(param1:RoomSpriteMouseEvent):void
        {
            var _loc3_:int;
            var _loc2_:IRoomObjectModelController = object.getModelController();
            if (((!(param1.altKey)) && (!(param1.ctrlKey))))
            {
                _loc3_ = object.getDirection().x;
                _loc3_ = ((_loc3_ + 45) % 360);
                object.setDirection(new Vector3d(_loc3_));
                _loc2_.setNumber(RoomObjectVariableEnum.var_495, (_loc3_ + this.var_3999));
            }
            else
            {
                if (((param1.altKey) && (!(param1.ctrlKey))))
                {
                    this.var_3997++;
                    _loc2_.setNumber(RoomObjectVariableEnum.var_728, this.var_3997);
                    _loc2_.setNumber(RoomObjectVariableEnum.var_727, NaN);
                }
                else
                {
                    if (((param1.ctrlKey) && (!(param1.altKey))))
                    {
                        this.var_3998++;
                        _loc2_.setNumber(RoomObjectVariableEnum.var_727, this.var_3998);
                    }
                    else
                    {
                        this.var_3999 = (this.var_3999 + 45);
                        if (this.var_3999 > 45)
                        {
                            this.var_3999 = -45;
                        };
                        _loc3_ = object.getDirection().x;
                        _loc2_.setNumber(RoomObjectVariableEnum.var_495, (_loc3_ + this.var_3999));
                    };
                };
            };
        }

        override public function update(param1:int):void
        {
            var _loc2_:IVector3d;
            var _loc3_:RoomObjectEvent;
            super.update(param1);
            if (((this._selected) && (!(object == null))))
            {
                if (eventDispatcher != null)
                {
                    _loc2_ = object.getLocation();
                    if (((((this.var_3979 == null) || (!(this.var_3979.x == _loc2_.x))) || (!(this.var_3979.y == _loc2_.y))) || (!(this.var_3979.z == _loc2_.z))))
                    {
                        if (this.var_3979 == null)
                        {
                            this.var_3979 = new Vector3d();
                        };
                        this.var_3979.assign(_loc2_);
                        _loc3_ = new RoomObjectMoveEvent(RoomObjectMoveEvent.var_1202, object.getId(), object.getType());
                        eventDispatcher.dispatchEvent(_loc3_);
                    };
                };
            };
            if (((!(object == null)) && (!(object.getModelController() == null))))
            {
                this.updateActions(param1, object.getModelController());
            };
        }

        private function updateActions(param1:int, param2:IRoomObjectModelController):void
        {
            if (((this.var_3986 > 0) && (param1 > this.var_3986)))
            {
                param2.setString(RoomObjectVariableEnum.var_727, null);
                this.var_3986 = 0;
            };
            if (this.var_3982 > 0)
            {
                if (param1 > this.var_3982)
                {
                    param2.setNumber(RoomObjectVariableEnum.var_720, 0);
                    this.var_3982 = 0;
                };
            };
            if (((this.var_3985 > 0) && (param1 > this.var_3985)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_721, 0);
                this.var_3985 = 0;
            };
        }

        private function getPaletteIndex(param1:String):int
        {
            var _loc2_:Array;
            if (param1 != null)
            {
                _loc2_ = param1.split(" ");
                if (_loc2_.length >= 2)
                {
                    return (parseInt(_loc2_[1]));
                };
            };
            return (0);
        }

    }
}