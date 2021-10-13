package com.sulake.habbo.widget.memenu
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;
    import flash.geom.Point;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.widget.events.RoomWidgetWaveUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetDanceUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetToolbarClickedUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetAvatarEditorUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetAvatarActionUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetTutorialEvent;
    import com.sulake.habbo.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetToolbarMessage;
    import flash.events.Event;
    import com.sulake.habbo.widget.memenu.enum.HabboMeMenuTrackingEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import flash.utils.getTimer;
    import com.sulake.habbo.widget.messages.RoomWidgetSelectOutfitMessage;

    public class MeMenuWidget extends RoomWidgetBase 
    {

        public static const var_1291:String = "me_menu_top_view";
        public static const var_1292:String = "me_menu_rooms_view";
        public static const var_1293:String = "me_menu_my_clothes_view";
        public static const var_1294:String = "me_menu_dance_moves_view";
        public static const var_1295:String = "me_menu_effects_view";
        public static const var_1296:String = "me_menu_settings_view";
        public static const var_1297:String = "me_menu_sound_settings";
        private static const var_1312:int = 5000;

        private var var_3495:IMeMenuView;
        private var _mainContainer:IWindowContainer;
        private var _eventDispatcher:IEventDispatcher;
        private var var_4845:Point;
        private var var_4846:int = 0;
        private var var_4847:int = 0;
        private var var_4848:int = 0;
        private var var_4849:Boolean = false;
        private var var_4850:int = 0;
        private var var_4851:Boolean = false;
        private var var_4852:Boolean = false;
        private var var_3542:Boolean = false;
        private var var_2563:int = 0;
        private var var_4853:Boolean = false;
        private var var_4854:int = 0;
        private var var_4661:Boolean = false;
        private var _config:IHabboConfigurationManager;

        public function MeMenuWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IEventDispatcher, param5:IHabboConfigurationManager)
        {
            super(param1, param2, param3);
            this._config = param5;
            this.var_4845 = new Point(0, 0);
            this._eventDispatcher = param4;
            if (((!(param5 == null)) && (ExternalInterface.available)))
            {
                this.var_4853 = (param5.getKey("client.news.embed.enabled", "false") == "true");
            };
            this.changeView(var_1291);
            this.hide();
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            this.hide();
            this._eventDispatcher = null;
            if (this.var_3495 != null)
            {
                this.var_3495.dispose();
                this.var_3495 = null;
            };
            super.dispose();
        }

        override public function get mainWindow():IWindow
        {
            return (this._mainContainer);
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetWaveUpdateEvent.var_1298, this.onWaveEvent);
            param1.addEventListener(RoomWidgetDanceUpdateEvent.var_1299, this.onDanceEvent);
            param1.addEventListener(RoomWidgetUpdateEffectsUpdateEvent.var_1300, this.onUpdateEffects);
            param1.addEventListener(RoomWidgetToolbarClickedUpdateEvent.var_1301, this.onToolbarClicked);
            param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1302, this.onAvatarEditorClosed);
            param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1303, this.onHideAvatarEditor);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.onAvatarDeselected);
            param1.addEventListener(RoomWidgetHabboClubUpdateEvent.var_123, this.onHabboClubEvent);
            param1.addEventListener(RoomWidgetAvatarActionUpdateEvent.var_1304, this.onAvatarActionEvent);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1255, this.onUserInfo);
            param1.addEventListener(RoomWidgetSettingsUpdateEvent.var_1305, this.onSettingsUpdate);
            param1.addEventListener(RoomWidgetTutorialEvent.var_1306, this.onTutorialEvent);
            param1.addEventListener(RoomWidgetTutorialEvent.var_1307, this.onTutorialEvent);
            param1.addEventListener(RoomWidgetPurseUpdateEvent.var_150, this.onCreditBalance);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_440, this.onNormalMode);
            param1.addEventListener(RoomWidgetRoomEngineUpdateEvent.var_1261, this.onGameMode);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetWaveUpdateEvent.var_1298, this.onWaveEvent);
            param1.removeEventListener(RoomWidgetDanceUpdateEvent.var_1299, this.onDanceEvent);
            param1.removeEventListener(RoomWidgetUpdateEffectsUpdateEvent.var_1300, this.onUpdateEffects);
            param1.removeEventListener(RoomWidgetToolbarClickedUpdateEvent.var_1301, this.onToolbarClicked);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.onAvatarDeselected);
            param1.removeEventListener(RoomWidgetHabboClubUpdateEvent.var_123, this.onHabboClubEvent);
            param1.removeEventListener(RoomWidgetAvatarActionUpdateEvent.var_1304, this.onAvatarActionEvent);
            param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1302, this.onHideAvatarEditor);
            param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.var_1303, this.onAvatarEditorClosed);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1255, this.onUserInfo);
            param1.removeEventListener(RoomWidgetSettingsUpdateEvent.var_1305, this.onSettingsUpdate);
            param1.removeEventListener(RoomWidgetTutorialEvent.var_1307, this.onTutorialEvent);
            param1.removeEventListener(RoomWidgetTutorialEvent.var_1306, this.onTutorialEvent);
            param1.removeEventListener(RoomWidgetPurseUpdateEvent.var_150, this.onCreditBalance);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_440, this.onNormalMode);
            param1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.var_440, this.onGameMode);
        }

        public function hide(param1:RoomWidgetRoomObjectUpdateEvent=null):void
        {
            var _loc2_:RoomWidgetToolbarMessage = new RoomWidgetToolbarMessage(RoomWidgetToolbarMessage.var_1308);
            _loc2_.window = (this._mainContainer.parent as IWindowContainer);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc2_);
            };
            if (this.var_3495 != null)
            {
                this._mainContainer.removeChild(this.var_3495.window);
                this.var_3495.dispose();
                this.var_3495 = null;
            };
            this.var_3542 = false;
            this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_CLOSE));
        }

        private function show():void
        {
            if (((!(this._mainContainer)) || (!(this._mainContainer.parent))))
            {
                return;
            };
            this.changeView(var_1291);
            var _loc1_:RoomWidgetToolbarMessage = new RoomWidgetToolbarMessage(RoomWidgetToolbarMessage.var_1309);
            _loc1_.window = (this._mainContainer.parent as IWindowContainer);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc1_);
            };
            this.var_3542 = true;
        }

        private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            var _loc2_:RoomWidgetRequestWidgetMessage;
            if (!((this.var_3542) && (this.var_3495.window.name == var_1293)))
            {
                _loc2_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_1310);
                if (messageListener != null)
                {
                    if (!this.var_4661)
                    {
                        messageListener.processWidgetMessage(_loc2_);
                    };
                };
            };
        }

        private function onSettingsUpdate(param1:RoomWidgetSettingsUpdateEvent):void
        {
            if (!this.var_3542)
            {
                return;
            };
            if (this.var_3495.window.name == var_1297)
            {
                (this.var_3495 as MeMenuSoundSettingsView).updateSettings(param1);
            };
        }

        private function onTutorialEvent(param1:RoomWidgetTutorialEvent):void
        {
            switch (param1.type)
            {
                case RoomWidgetTutorialEvent.var_1307:
                    Logger.log(((("* MeMenuWidget: onHighlightClothesIcon " + this.var_3542) + " view: ") + this.var_3495.window.name));
                    if (((!(this.var_3542 == true)) || (!(this.var_3495.window.name == var_1291))))
                    {
                        return;
                    };
                    (this.var_3495 as MeMenuMainView).setIconAssets("clothes_icon", var_1291, "clothes_highlighter_blue");
                    return;
                case RoomWidgetTutorialEvent.var_1306:
                    this.hide();
                    return;
            };
        }

        private function onToolbarClicked(param1:RoomWidgetToolbarClickedUpdateEvent):void
        {
            switch (param1.iconType)
            {
                case RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU:
                    this.var_3542 = (!(this.var_3542));
                    break;
                case RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ROOM_INFO:
                    this.var_3542 = false;
                    break;
                default:
                    return;
            };
            if (this.var_3542)
            {
                this.show();
            }
            else
            {
                this.hide();
            };
        }

        private function onUpdateEffects(param1:RoomWidgetUpdateEffectsUpdateEvent):void
        {
            var _loc2_:IWidgetAvatarEffect;
            this.var_4851 = false;
            for each (_loc2_ in param1.effects)
            {
                if (_loc2_.isInUse)
                {
                    this.var_4851 = true;
                };
            };
            if (((!(this.var_3495 == null)) && (this.var_3495.window.name == var_1295)))
            {
                (this.var_3495 as MeMenuEffectsView).updateEffects(param1.effects);
            };
        }

        private function onAvatarDeselected(param1:Event):void
        {
            if (((!(this.var_3495 == null)) && (!(this.var_3495.window.name == var_1293))))
            {
                this.hide();
            };
        }

        private function onAvatarEditorClosed(param1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!(this.var_3495 == null)) && (this.var_3495.window.name == var_1293)))
            {
                this.changeView(var_1291);
            };
        }

        private function onHideAvatarEditor(param1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!(this.var_3495 == null)) && (this.var_3495.window.name == var_1293)))
            {
                this.changeView(var_1291);
            };
        }

        private function onWaveEvent(param1:RoomWidgetWaveUpdateEvent):void
        {
            Logger.log("[MeMenuWidget] Wave Event received");
        }

        private function onDanceEvent(param1:RoomWidgetDanceUpdateEvent):void
        {
            Logger.log(("[MeMenuWidget] Dance Event received, style: " + param1.style));
        }

        private function onHabboClubEvent(param1:RoomWidgetHabboClubUpdateEvent):void
        {
            var _loc2_:* = (!(param1.daysLeft == this.var_4846));
            this.var_4846 = param1.daysLeft;
            this.var_4847 = param1.periodsLeft;
            this.var_4848 = param1.pastPeriods;
            this.var_4849 = param1.var_1311;
            _loc2_ = ((_loc2_) || (!(param1.clubLevel == this.var_4850)));
            this.var_4850 = param1.clubLevel;
            if (_loc2_)
            {
                if (this.var_3495 != null)
                {
                    this.changeView(this.var_3495.window.name);
                };
            };
        }

        private function onAvatarActionEvent(param1:RoomWidgetAvatarActionUpdateEvent):void
        {
            switch (param1.actionType)
            {
                case RoomWidgetAvatarActionUpdateEvent.EFFECT_ACTIVE:
                    this.var_4851 = true;
                    return;
                case RoomWidgetAvatarActionUpdateEvent.EFFECT_INACTIVE:
                    this.var_4851 = false;
                    return;
            };
        }

        private function onCreditBalance(param1:RoomWidgetPurseUpdateEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            this.var_4854 = param1.balance;
            localizations.registerParameter("widget.memenu.credits", "credits", this.var_4854.toString());
        }

        private function onNormalMode(param1:RoomWidgetRoomEngineUpdateEvent):void
        {
            this.var_4661 = false;
        }

        private function onGameMode(param1:RoomWidgetRoomEngineUpdateEvent):void
        {
            this.var_4661 = true;
        }

        public function get mainContainer():IWindowContainer
        {
            if (this._mainContainer == null)
            {
                this._mainContainer = (windowManager.createWindow("me_menu_main_container", "", HabboWindowType.var_890, HabboWindowStyle.var_845, HabboWindowParam.var_156, new Rectangle(0, 0, 170, 260)) as IWindowContainer);
                this._mainContainer.tags.push("room_widget_me_menu");
            };
            return (this._mainContainer);
        }

        public function changeView(param1:String):void
        {
            var _loc2_:IMeMenuView;
            switch (param1)
            {
                case var_1291:
                    _loc2_ = new MeMenuMainView();
                    this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DEFAULT));
                    break;
                case var_1295:
                    _loc2_ = new MeMenuEffectsView();
                    this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_EFFECTS));
                    break;
                case var_1294:
                    _loc2_ = new MeMenuDanceView();
                    this._eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DANCE));
                    break;
                case var_1293:
                    _loc2_ = new MeMenuClothesView();
                    break;
                case var_1292:
                    _loc2_ = new MeMenuRoomsView();
                    break;
                case var_1296:
                    _loc2_ = new MeMenuSettingsMenuView();
                    break;
                case var_1297:
                    _loc2_ = new MeMenuSoundSettingsView();
                    break;
                default:
                    Logger.log(("Me Menu Change view: unknown view: " + param1));
            };
            if (_loc2_ != null)
            {
                if (this.var_3495 != null)
                {
                    this._mainContainer.removeChild(this.var_3495.window);
                    this.var_3495.dispose();
                    this.var_3495 = null;
                };
                this.var_3495 = _loc2_;
                this.var_3495.init(this, param1);
            };
            this.updateSize();
        }

        public function updateSize():void
        {
            if (this.var_3495 != null)
            {
                this.var_4845.x = (this.var_3495.window.width + 10);
                this.var_4845.y = this.var_3495.window.height;
                this.var_3495.window.x = 5;
                this.var_3495.window.y = 0;
                this._mainContainer.width = this.var_4845.x;
                this._mainContainer.height = this.var_4845.y;
            };
        }

        public function get allowHabboClubDances():Boolean
        {
            return (this.var_4849);
        }

        public function get isHabboClubActive():Boolean
        {
            return (this.var_4846 > 0);
        }

        public function get habboClubDays():int
        {
            return (this.var_4846);
        }

        public function get habboClubPeriods():int
        {
            return (this.var_4847);
        }

        public function get habboClubPastPeriods():int
        {
            return (this.var_4848);
        }

        public function get habboClubLevel():int
        {
            return (this.var_4850);
        }

        public function get isNewsEnabled():Boolean
        {
            return (this.var_4853);
        }

        public function get creditBalance():int
        {
            return (this.var_4854);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }

        public function changeToOutfit(param1:int):void
        {
            this.var_2563 = getTimer();
            this.messageListener.processWidgetMessage(new RoomWidgetSelectOutfitMessage(param1));
        }

        public function canChangeOutfit():Boolean
        {
            var _loc1_:Number = getTimer();
            return ((_loc1_ - this.var_2563) > var_1312);
        }

        public function get hasEffectOn():Boolean
        {
            return (this.var_4851);
        }

        public function get isDancing():Boolean
        {
            return (this.var_4852);
        }

        public function set isDancing(param1:Boolean):void
        {
            this.var_4852 = param1;
        }

    }
}