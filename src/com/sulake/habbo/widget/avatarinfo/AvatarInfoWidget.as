package com.sulake.habbo.widget.avatarinfo
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.widget.events.RoomWidgetAvatarInfoEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserDataUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetGetUserLocationMessage;

    public class AvatarInfoWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private var var_3479:Component;
        private var var_2063:IHabboConfigurationManager;
        private var _view:AvatarInfoView;
        private var var_2067:Boolean = false;
        private var var_4661:Boolean = false;
        private var var_4660:Timer;
        private var var_4659:int = 3000;
        private var var_4662:Boolean;
        private var var_4663:Boolean;
        private var var_1033:Number;
        private var var_4106:int;
        private var var_4664:int = 500;
        private var var_4665:AvatarInfoData;

        public function AvatarInfoWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboConfigurationManager, param4:IHabboLocalizationManager, param5:Component)
        {
            super(param1, param2, param4);
            this.var_3479 = param5;
            this.var_2063 = param3;
            this.var_4662 = false;
            this.var_4663 = false;
            this.var_4660 = new Timer(this.var_4659, 1);
            this.var_4660.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.var_4665 = new AvatarInfoData();
        }

        public function get configuration():IHabboConfigurationManager
        {
            return (this.var_2063);
        }

        private function onTimerComplete(param1:TimerEvent):void
        {
            this.var_4663 = true;
            this.var_4106 = 0;
        }

        private function getOwnCharacterInfo():void
        {
            messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1254, 0, 0));
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (this.var_3479)
            {
                this.var_3479.removeUpdateReceiver(this);
                this.var_3479 = null;
            };
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            this.var_2063 = null;
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (!param1)
            {
                return;
            };
            param1.addEventListener(RoomWidgetAvatarInfoEvent.var_282, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1255, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1256, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.updateEventHandler);
            param1.addEventListener(RoomWidgetFurniInfoUpdateEvent.var_1258, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.updateEventHandler);
            param1.addEventListener(RoomWidgetPetInfoUpdateEvent.var_1259, this.updateEventHandler);
            param1.addEventListener(RoomWidgetUserDataUpdateEvent.var_399, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1260, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_440, this.updateEventHandler);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_1261, this.updateEventHandler);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetAvatarInfoEvent.var_282, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1255, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1256, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.var_1258, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetPetInfoUpdateEvent.var_1259, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetUserDataUpdateEvent.var_399, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1260, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_440, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_1261, this.updateEventHandler);
        }

        private function updateEventHandler(param1:RoomWidgetUpdateEvent):void
        {
            var _loc2_:RoomWidgetAvatarInfoEvent;
            var _loc3_:RoomWidgetUserInfoUpdateEvent;
            var _loc4_:RoomWidgetUserInfoUpdateEvent;
            var _loc5_:RoomWidgetPetInfoUpdateEvent;
            var _loc6_:RoomWidgetRoomObjectUpdateEvent;
            switch (param1.type)
            {
                case RoomWidgetAvatarInfoEvent.var_282:
                    _loc2_ = (param1 as RoomWidgetAvatarInfoEvent);
                    this.updateView(_loc2_.userId, _loc2_.userName, _loc2_.roomIndex, RoomObjectTypeEnum.var_1262, _loc2_.allowNameChange, null);
                    this.var_2067 = true;
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1257:
                case RoomWidgetFurniInfoUpdateEvent.var_1258:
                    this.removeView();
                    break;
                case RoomWidgetUserInfoUpdateEvent.var_1255:
                    this.getOwnCharacterInfo();
                    break;
                case RoomWidgetUserInfoUpdateEvent.var_1256:
                    _loc3_ = (param1 as RoomWidgetUserInfoUpdateEvent);
                    this.var_4665.amIAnyRoomController = _loc3_.amIAnyRoomController;
                    this.var_4665.amIController = _loc3_.amIController;
                    this.var_4665.amIOwner = _loc3_.amIOwner;
                    this.var_4665.canBeAskedAsFriend = _loc3_.canBeAskedAsFriend;
                    this.var_4665.canBeKicked = _loc3_.canBeKicked;
                    this.var_4665.canTrade = _loc3_.canTrade;
                    this.var_4665.canTradeReason = _loc3_.canTradeReason;
                    this.var_4665.hasFlatControl = _loc3_.hasFlatControl;
                    this.var_4665.isIgnored = _loc3_.isIgnored;
                    this.var_4665.respectLeft = _loc3_.respectLeft;
                    this.updateView(_loc3_.webID, _loc3_.name, _loc3_.userRoomId, RoomObjectTypeEnum.var_1262, false, ((_loc3_.isSpectatorMode) ? null : this.var_4665));
                    break;
                case RoomWidgetUserInfoUpdateEvent.BOT:
                    _loc4_ = (param1 as RoomWidgetUserInfoUpdateEvent);
                    this.updateView(_loc4_.webID, _loc4_.name, _loc4_.userRoomId, RoomObjectTypeEnum.var_1263, false, null);
                    break;
                case RoomWidgetPetInfoUpdateEvent.var_1259:
                    _loc5_ = (param1 as RoomWidgetPetInfoUpdateEvent);
                    this.updateView(_loc5_.id, _loc5_.name, _loc5_.roomIndex, RoomObjectTypeEnum.var_1234, false, null);
                    break;
                case RoomWidgetUserDataUpdateEvent.var_399:
                    if (!this.var_2067)
                    {
                        this.getOwnCharacterInfo();
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1260:
                    _loc6_ = (param1 as RoomWidgetRoomObjectUpdateEvent);
                    if (((this._view) && (this._view.roomIndex == _loc6_.id)))
                    {
                        this.disposeView();
                    };
                    break;
                case RoomWidgetRoomEngineUpdateEvent.var_440:
                    this.var_4661 = false;
                    break;
                case RoomWidgetRoomEngineUpdateEvent.var_1261:
                    this.var_4661 = true;
                    break;
            };
            this.checkUpdateNeed();
        }

        private function updateView(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:AvatarInfoData):void
        {
            this.var_4663 = false;
            if (this.var_4660.running)
            {
                this.var_4660.stop();
            };
            if ((((((this._view == null) || (!(this._view.userId == param1))) || (!(this._view.userName == param2))) || (!(this._view.roomIndex == param3))) || (!(this._view.userType == param4))))
            {
                if (this._view)
                {
                    this.disposeView();
                };
                if (!this.var_4661)
                {
                    if (((param6) && (false)))
                    {
                        this._view = new AvatarMenuView(this, param1, param2, param3, param4, param6);
                    }
                    else
                    {
                        this._view = new AvatarInfoView(this, param1, param2, param3, param4, param5);
                    };
                };
            };
        }

        public function disposeView():void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
                this.var_4662 = true;
                this.var_4663 = false;
            };
        }

        private function removeView():void
        {
            if (!this.var_4662)
            {
                this.var_4662 = true;
                this.var_4660.start();
            }
            else
            {
                if (!this.var_4663)
                {
                    this.disposeView();
                };
            };
        }

        public function checkUpdateNeed():void
        {
            if (!this.var_3479)
            {
                return;
            };
            if (this._view)
            {
                this.var_3479.registerUpdateReceiver(this, 10);
            }
            else
            {
                this.var_3479.removeUpdateReceiver(this);
            };
        }

        public function update(param1:uint):void
        {
            var _loc2_:RoomWidgetUserLocationUpdateEvent;
            if (!this._view)
            {
                return;
            };
            _loc2_ = (messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(this._view.userId, this._view.userType)) as RoomWidgetUserLocationUpdateEvent);
            if (!_loc2_)
            {
                return;
            };
            if (this.var_4663)
            {
                this.var_4106 = (this.var_4106 + param1);
                this.var_1033 = (1 - (this.var_4106 / Number(this.var_4664)));
            }
            else
            {
                this.var_1033 = 1;
            };
            if (this.var_1033 <= 0)
            {
                this.disposeView();
                return;
            };
            this._view.update(_loc2_.rectangle, this.var_1033);
        }

    }
}