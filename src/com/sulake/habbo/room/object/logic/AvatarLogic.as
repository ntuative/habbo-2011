package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.utils.Vector3d;
    import flash.utils.getTimer;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarWaveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.IVector3d;

    public class AvatarLogic extends MovingObjectLogic 
    {

        private static const var_1220:Number = 1.5;
        private static const var_1217:int = 28;
        private static const var_1219:int = 29;
        private static const var_1218:int = 500;
        private static const var_1214:int = 999999999;

        private var _selected:Boolean = false;
        private var var_3979:Vector3d = null;
        private var var_3980:int = 0;
        private var var_3981:int = 0;
        private var var_3982:int = 0;
        private var var_3983:int = 0;
        private var var_3984:int = 0;
        private var var_3985:int = 0;
        private var var_3986:int = 0;
        private var var_3987:int = 0;
        private var var_3988:int = 0;
        private var var_3989:Boolean = false;
        private var var_3990:int = 0;
        private var var_3991:int = 0;
        private var var_3992:int = 0;

        public function AvatarLogic()
        {
            this.var_3991 = (getTimer() + this.getBlinkInterval());
        }

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
            var _loc4_:RoomObjectAvatarChatUpdateMessage;
            var _loc5_:RoomObjectAvatarTypingUpdateMessage;
            var _loc6_:RoomObjectAvatarUpdateMessage;
            var _loc7_:RoomObjectAvatarGestureUpdateMessage;
            var _loc8_:RoomObjectAvatarWaveUpdateMessage;
            var _loc9_:RoomObjectAvatarDanceUpdateMessage;
            var _loc10_:RoomObjectAvatarSleepUpdateMessage;
            var _loc11_:RoomObjectAvatarPlayerValueUpdateMessage;
            var _loc12_:RoomObjectAvatarEffectUpdateMessage;
            var _loc13_:int;
            var _loc14_:int;
            var _loc15_:RoomObjectAvatarCarryObjectUpdateMessage;
            var _loc16_:RoomObjectAvatarUseObjectUpdateMessage;
            var _loc17_:RoomObjectAvatarSignUpdateMessage;
            var _loc18_:RoomObjectAvatarFlatControlUpdateMessage;
            var _loc19_:RoomObjectAvatarFigureUpdateMessage;
            var _loc20_:String;
            var _loc21_:String;
            var _loc22_:String;
            var _loc23_:RoomObjectAvatarSelectedMessage;
            if (((param1 == null) || (object == null)))
            {
                return;
            };
            super.processUpdateMessage(param1);
            var _loc2_:IRoomObjectModelController = object.getModelController();
            if ((param1 is RoomObjectAvatarPostureUpdateMessage))
            {
                _loc3_ = (param1 as RoomObjectAvatarPostureUpdateMessage);
                _loc2_.setString(RoomObjectVariableEnum.var_728, _loc3_.postureType);
                _loc2_.setString(RoomObjectVariableEnum.var_729, _loc3_.parameter);
                return;
            };
            if ((param1 is RoomObjectAvatarChatUpdateMessage))
            {
                _loc4_ = (param1 as RoomObjectAvatarChatUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_720, 1);
                this.var_3982 = (getTimer() + (_loc4_.numberOfWords * 1000));
                return;
            };
            if ((param1 is RoomObjectAvatarTypingUpdateMessage))
            {
                _loc5_ = (param1 as RoomObjectAvatarTypingUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_734, Number(_loc5_.var_1215));
                return;
            };
            if ((param1 is RoomObjectAvatarUpdateMessage))
            {
                _loc6_ = (param1 as RoomObjectAvatarUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_495, _loc6_.dirHead);
                return;
            };
            if ((param1 is RoomObjectAvatarGestureUpdateMessage))
            {
                _loc7_ = (param1 as RoomObjectAvatarGestureUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_727, _loc7_.gesture);
                this.var_3986 = (getTimer() + (3 * 1000));
                return;
            };
            if ((param1 is RoomObjectAvatarWaveUpdateMessage))
            {
                _loc8_ = (param1 as RoomObjectAvatarWaveUpdateMessage);
                if (_loc8_.isWaving)
                {
                    _loc2_.setNumber(RoomObjectVariableEnum.var_721, 1);
                    this.var_3985 = (getTimer() + (AvatarAction.var_1216 * 1000));
                }
                else
                {
                    _loc2_.setNumber(RoomObjectVariableEnum.var_721, 0);
                    this.var_3985 = 0;
                };
                return;
            };
            if ((param1 is RoomObjectAvatarDanceUpdateMessage))
            {
                _loc9_ = (param1 as RoomObjectAvatarDanceUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.set, _loc9_.danceStyle);
                return;
            };
            if ((param1 is RoomObjectAvatarSleepUpdateMessage))
            {
                _loc10_ = (param1 as RoomObjectAvatarSleepUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_722, Number(_loc10_.isSleeping));
                return;
            };
            if ((param1 is RoomObjectAvatarPlayerValueUpdateMessage))
            {
                _loc11_ = (param1 as RoomObjectAvatarPlayerValueUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_737, _loc11_.value);
                this.var_3992 = (getTimer() + 3000);
                return;
            };
            if ((param1 is RoomObjectAvatarEffectUpdateMessage))
            {
                _loc12_ = (param1 as RoomObjectAvatarEffectUpdateMessage);
                _loc13_ = _loc12_.effect;
                _loc14_ = _loc12_.delayMilliSeconds;
                this.updateEffect(_loc13_, _loc14_, _loc2_);
                return;
            };
            if ((param1 is RoomObjectAvatarCarryObjectUpdateMessage))
            {
                _loc15_ = (param1 as RoomObjectAvatarCarryObjectUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_725, _loc15_.itemType);
                if (_loc15_.itemType < var_1214)
                {
                    this.var_3988 = (getTimer() + (100 * 1000));
                    this.var_3989 = true;
                }
                else
                {
                    this.var_3988 = (getTimer() + 1500);
                    this.var_3989 = false;
                };
                return;
            };
            if ((param1 is RoomObjectAvatarUseObjectUpdateMessage))
            {
                _loc16_ = (param1 as RoomObjectAvatarUseObjectUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_726, _loc16_.itemType);
                return;
            };
            if ((param1 is RoomObjectAvatarSignUpdateMessage))
            {
                _loc17_ = (param1 as RoomObjectAvatarSignUpdateMessage);
                _loc2_.setNumber(RoomObjectVariableEnum.var_731, _loc17_.signType);
                this.var_3987 = (getTimer() + (5 * 1000));
                return;
            };
            if ((param1 is RoomObjectAvatarFlatControlUpdateMessage))
            {
                _loc18_ = (param1 as RoomObjectAvatarFlatControlUpdateMessage);
                _loc2_.setString(RoomObjectVariableEnum.var_732, _loc18_.rawData);
                _loc2_.setNumber(RoomObjectVariableEnum.var_733, Number(_loc18_.isAdmin));
                return;
            };
            if ((param1 is RoomObjectAvatarFigureUpdateMessage))
            {
                _loc19_ = (param1 as RoomObjectAvatarFigureUpdateMessage);
                _loc20_ = _loc2_.getString(RoomObjectVariableEnum.var_497);
                _loc21_ = _loc19_.figure;
                _loc22_ = _loc19_.gender;
                if (((!(_loc20_ == null)) && (!(_loc20_.indexOf(".bds-") == -1))))
                {
                    _loc21_ = (_loc21_ + _loc20_.substr(_loc20_.indexOf(".bds-")));
                };
                _loc2_.setString(RoomObjectVariableEnum.var_497, _loc21_);
                _loc2_.setString(RoomObjectVariableEnum.var_719, _loc22_);
                return;
            };
            if ((param1 is RoomObjectAvatarSelectedMessage))
            {
                _loc23_ = (param1 as RoomObjectAvatarSelectedMessage);
                this._selected = _loc23_.selected;
                this.var_3979 = null;
                return;
            };
        }

        private function updateEffect(param1:int, param2:int, param3:IRoomObjectModelController):void
        {
            if (param1 == var_1217)
            {
                this.var_3980 = (getTimer() + var_1218);
                this.var_3981 = var_1219;
            }
            else
            {
                if (param3.getNumber(RoomObjectVariableEnum.var_724) == var_1219)
                {
                    this.var_3980 = (getTimer() + var_1218);
                    this.var_3981 = param1;
                    param1 = var_1217;
                }
                else
                {
                    if (param2 == 0)
                    {
                        this.var_3980 = 0;
                    }
                    else
                    {
                        this.var_3980 = (getTimer() + param2);
                        this.var_3981 = param1;
                        return;
                    };
                };
            };
            param3.setNumber(RoomObjectVariableEnum.var_724, param1);
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc3_:int;
            var _loc4_:String;
            var _loc5_:RoomObjectEvent;
            if (((object == null) || (param1 == null)))
            {
                return;
            };
            switch (param1.type)
            {
                case MouseEvent.CLICK:
                    _loc3_ = object.getId();
                    _loc4_ = object.getType();
                    if (eventDispatcher != null)
                    {
                        _loc5_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.var_483, param1.eventId, _loc3_, _loc4_, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown);
                        eventDispatcher.dispatchEvent(_loc5_);
                    };
                    return;
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
            if (this.var_3982 > 0)
            {
                if (param1 > this.var_3982)
                {
                    param2.setNumber(RoomObjectVariableEnum.var_720, 0);
                    this.var_3982 = 0;
                    this.var_3984 = 0;
                    this.var_3983 = 0;
                }
                else
                {
                    if (((this.var_3983 == 0) && (this.var_3984 == 0)))
                    {
                        this.var_3984 = (param1 + this.getTalkingPauseInterval());
                        this.var_3983 = (this.var_3984 + this.getTalkingPauseLength());
                    }
                    else
                    {
                        if (((this.var_3984 > 0) && (param1 > this.var_3984)))
                        {
                            param2.setNumber(RoomObjectVariableEnum.var_720, 0);
                            this.var_3984 = 0;
                        }
                        else
                        {
                            if (((this.var_3983 > 0) && (param1 > this.var_3983)))
                            {
                                param2.setNumber(RoomObjectVariableEnum.var_720, 1);
                                this.var_3983 = 0;
                            };
                        };
                    };
                };
            };
            if (((this.var_3985 > 0) && (param1 > this.var_3985)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_721, 0);
                this.var_3985 = 0;
            };
            if (((this.var_3986 > 0) && (param1 > this.var_3986)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_727, 0);
                this.var_3986 = 0;
            };
            if (((this.var_3987 > 0) && (param1 > this.var_3987)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_731, 0);
                this.var_3987 = 0;
            };
            if (this.var_3988 > 0)
            {
                if (param1 > this.var_3988)
                {
                    param2.setNumber(RoomObjectVariableEnum.var_725, 0);
                    this.var_3988 = 0;
                }
                else
                {
                    if (((((this.var_3988 - param1) % 10000) < 1000) && (this.var_3989)))
                    {
                        param2.setNumber(RoomObjectVariableEnum.var_726, 1);
                    }
                    else
                    {
                        param2.setNumber(RoomObjectVariableEnum.var_726, 0);
                    };
                };
            };
            if (param1 > this.var_3991)
            {
                param2.setNumber(RoomObjectVariableEnum.var_723, 1);
                this.var_3991 = (param1 + this.getBlinkInterval());
                this.var_3990 = (param1 + this.getBlinkLength());
            };
            if (((this.var_3990 > 0) && (param1 > this.var_3990)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_723, 0);
                this.var_3990 = 0;
            };
            if (((this.var_3980 > 0) && (param1 > this.var_3980)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_724, this.var_3981);
                this.var_3980 = 0;
            };
            if (((this.var_3992 > 0) && (param1 > this.var_3992)))
            {
                param2.setNumber(RoomObjectVariableEnum.var_737, 0);
                this.var_3992 = 0;
            };
        }

        private function getTalkingPauseInterval():int
        {
            return (100 + (Math.random() * 200));
        }

        private function getTalkingPauseLength():int
        {
            return (75 + (Math.random() * 75));
        }

        private function getBlinkInterval():int
        {
            return (4500 + (Math.random() * 1000));
        }

        private function getBlinkLength():int
        {
            return (50 + (Math.random() * 200));
        }

        private function targetIsWarping(param1:IVector3d):Boolean
        {
            var _loc2_:IVector3d = object.getLocation();
            if (param1 == null)
            {
                return (false);
            };
            if (((_loc2_.x == 0) && (_loc2_.y == 0)))
            {
                return (false);
            };
            if (((Math.abs((_loc2_.x - param1.x)) > var_1220) || (Math.abs((_loc2_.y - param1.y)) > var_1220)))
            {
                return (true);
            };
            return (false);
        }

    }
}