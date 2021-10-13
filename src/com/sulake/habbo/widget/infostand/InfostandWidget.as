package com.sulake.habbo.widget.infostand
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import flash.events.TimerEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserTagsUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserFigureUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserBadgesUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetBadgeImageUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetPetCommandsUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetSongUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;

    public class InfostandWidget extends RoomWidgetBase 
    {

        private const var_4811:String = "infostand_user_view";
        private const var_4810:String = "infostand_furni_view";
        private const var_4812:String = "infostand_pet_view";
        private const var_4813:String = "infostand_bot_view";
        private const var_4814:String = "infostand_jukebox_view";
        private const var_4815:String = "infostand_songdisk_view";
        private const var_4816:int = 3000;

        private var var_4818:InfoStandFurniView;
        private var var_4819:InfoStandUserView;
        private var var_4820:InfoStandPetView;
        private var var_4821:InfoStandBotView;
        private var var_4822:InfoStandJukeboxView;
        private var var_4823:InfoStandSongDiskView;
        private var var_4824:Array;
        private var var_4825:InfostandUserData;
        private var var_2678:InfostandFurniData;
        private var _petData:InfoStandPetData;
        private var _mainContainer:IWindowContainer;
        private var var_4817:Timer;
        private var _config:IHabboConfigurationManager;
        private var _catalog:IHabboCatalog;

        public function InfostandWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager, param5:IHabboCatalog)
        {
            super(param1, param2, param3);
            this._config = param4;
            this._catalog = param5;
            this.var_4818 = new InfoStandFurniView(this, this.var_4810, this._catalog);
            this.var_4819 = new InfoStandUserView(this, this.var_4811);
            this.var_4820 = new InfoStandPetView(this, this.var_4812, this._catalog);
            this.var_4821 = new InfoStandBotView(this, this.var_4813);
            this.var_4822 = new InfoStandJukeboxView(this, this.var_4814, this._catalog);
            this.var_4823 = new InfoStandSongDiskView(this, this.var_4815, this._catalog);
            this.var_4825 = new InfostandUserData();
            this.var_2678 = new InfostandFurniData();
            this._petData = new InfoStandPetData();
            this.var_4817 = new Timer(this.var_4816);
            this.var_4817.addEventListener(TimerEvent.TIMER, this.onUpdateTimer);
            this.mainContainer.visible = false;
        }

        override public function get mainWindow():IWindow
        {
            return (this.mainContainer);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }

        public function get mainContainer():IWindowContainer
        {
            if (this._mainContainer == null)
            {
                this._mainContainer = (windowManager.createWindow("infostand_main_container", "", HabboWindowType.var_182, HabboWindowStyle.var_156, HabboWindowParam.var_156, new Rectangle(0, 0, 50, 100)) as IWindowContainer);
                this._mainContainer.tags.push("room_widget_infostand");
                this._mainContainer.background = true;
                this._mainContainer.color = 0;
            };
            return (this._mainContainer);
        }

        public function getXmlWindow(name:String):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try
            {
                asset = assets.getAssetByName(name);
                xmlAsset = XmlAsset(asset);
                window = windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error)
            {
                Logger.log(("[InfoStandWidget] Missing window XML: " + name));
            };
            return (window);
        }

        override public function dispose():void
        {
            if (this.var_4817)
            {
                this.var_4817.stop();
            };
            this.var_4817 = null;
            if (this.var_4819)
            {
                this.var_4819.dispose();
            };
            this.var_4819 = null;
            if (this.var_4818)
            {
                this.var_4818.dispose();
            };
            this.var_4818 = null;
            if (this.var_4821)
            {
                this.var_4821.dispose();
            };
            this.var_4821 = null;
            if (this.var_4820)
            {
                this.var_4820.dispose();
            };
            this.var_4820 = null;
            if (this.var_4822)
            {
                this.var_4822.dispose();
            };
            this.var_4822 = null;
            if (this.var_4823)
            {
                this.var_4823.dispose();
            };
            this.var_4823 = null;
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1340, this.onRoomObjectSelected);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.onClose);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1260, this.onRoomObjectRemoved);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1280, this.onRoomObjectRemoved);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1255, this.onUserInfo);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1256, this.onUserInfo);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.onBotInfo);
            param1.addEventListener(RoomWidgetFurniInfoUpdateEvent.var_1258, this.onFurniInfo);
            param1.addEventListener(RoomWidgetUserTagsUpdateEvent.var_1341, this.onUserTags);
            param1.addEventListener(RoomWidgetUserFigureUpdateEvent.var_1342, this.onUserFigureUpdate);
            param1.addEventListener(RoomWidgetUserBadgesUpdateEvent.var_368, this.onUserBadges);
            param1.addEventListener(RoomWidgetBadgeImageUpdateEvent.var_1343, this.onBadgeImage);
            param1.addEventListener(RoomWidgetPetInfoUpdateEvent.var_1259, this.onPetInfo);
            param1.addEventListener(RoomWidgetPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
            param1.addEventListener(RoomWidgetSongUpdateEvent.var_1344, this.onSongUpdate);
            param1.addEventListener(RoomWidgetSongUpdateEvent.var_1345, this.onSongUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1340, this.onRoomObjectSelected);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.onClose);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1260, this.onRoomObjectRemoved);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1280, this.onRoomObjectRemoved);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1255, this.onUserInfo);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1256, this.onUserInfo);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.onBotInfo);
            param1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.var_1258, this.onFurniInfo);
            param1.removeEventListener(RoomWidgetUserTagsUpdateEvent.var_1341, this.onUserTags);
            param1.removeEventListener(RoomWidgetUserFigureUpdateEvent.var_1342, this.onUserFigureUpdate);
            param1.removeEventListener(RoomWidgetUserBadgesUpdateEvent.var_368, this.onUserBadges);
            param1.removeEventListener(RoomWidgetBadgeImageUpdateEvent.var_1343, this.onBadgeImage);
            param1.removeEventListener(RoomWidgetPetInfoUpdateEvent.var_1259, this.onPetInfo);
            param1.removeEventListener(RoomWidgetPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
            param1.removeEventListener(RoomWidgetSongUpdateEvent.var_1344, this.onSongUpdate);
            param1.removeEventListener(RoomWidgetSongUpdateEvent.var_1345, this.onSongUpdate);
        }

        public function get userData():InfostandUserData
        {
            return (this.var_4825);
        }

        public function get furniData():InfostandFurniData
        {
            return (this.var_2678);
        }

        public function get petData():InfoStandPetData
        {
            return (this._petData);
        }

        private function onUpdateTimer(param1:TimerEvent):void
        {
            if (this.var_4820 == null)
            {
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.var_1346, this.var_4820.getCurrentPetId()));
        }

        private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.userData.setData(param1);
            this.var_4819.update(param1);
            this.selectView(this.var_4811);
            if (this.var_4817)
            {
                this.var_4817.stop();
            };
        }

        private function onBotInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.userData.setData(param1);
            this.var_4821.update(param1);
            this.selectView(this.var_4813);
            if (this.var_4817)
            {
                this.var_4817.stop();
            };
        }

        private function onFurniInfo(param1:RoomWidgetFurniInfoUpdateEvent):void
        {
            this.furniData.setData(param1);
            if (param1.extraParam == RoomWidgetInfostandExtraParamEnum.var_1212)
            {
                this.var_4822.update(param1);
                this.selectView(this.var_4814);
            }
            else
            {
                if (param1.extraParam.indexOf(RoomWidgetInfostandExtraParamEnum.var_1221) != -1)
                {
                    this.var_4823.update(param1);
                    this.selectView(this.var_4815);
                }
                else
                {
                    this.var_4818.update(param1);
                    this.selectView(this.var_4810);
                };
            };
            if (this.var_4817)
            {
                this.var_4817.stop();
            };
        }

        private function onPetInfo(param1:RoomWidgetPetInfoUpdateEvent):void
        {
            this.petData.setData(param1);
            this.userData.petRespectLeft = param1.petRespectLeft;
            this.var_4820.update(this.petData);
            this.selectView(this.var_4812);
            if (this.var_4817)
            {
                this.var_4817.start();
            };
        }

        private function onPetCommands(param1:RoomWidgetPetCommandsUpdateEvent):void
        {
            this.var_4820.updateEnabledTrainingCommands(param1.id, new CommandConfiguration(param1.allCommands, param1.enabledCommands));
        }

        private function onUserTags(param1:RoomWidgetUserTagsUpdateEvent):void
        {
            if (param1.isOwnUser)
            {
                this.var_4824 = param1.tags;
            };
            if (param1.userId != this.userData.userId)
            {
                return;
            };
            if (param1.isOwnUser)
            {
                this.var_4819.setTags(param1.tags);
            }
            else
            {
                this.var_4819.setTags(param1.tags, this.var_4824);
            };
        }

        private function onUserFigureUpdate(param1:RoomWidgetUserFigureUpdateEvent):void
        {
            if (param1.userId != this.userData.userId)
            {
                return;
            };
            if (this.userData.isBot())
            {
                this.var_4821.image = param1.image;
            }
            else
            {
                this.var_4819.image = param1.image;
                this.var_4819.setMotto(param1.customInfo, param1.isOwnUser);
                this.var_4819.achievementScore = param1.achievementScore;
            };
        }

        private function onUserBadges(param1:RoomWidgetUserBadgesUpdateEvent):void
        {
            if (param1.userId != this.userData.userId)
            {
                return;
            };
            this.userData.badges = param1.badges;
            this.var_4819.clearBadges();
        }

        private function onBadgeImage(param1:RoomWidgetBadgeImageUpdateEvent):void
        {
            var _loc2_:int = this.userData.badges.indexOf(param1.badgeID);
            if (_loc2_ >= 0)
            {
                if (this.userData.isBot())
                {
                    this.var_4821.setBadgeImage(_loc2_, param1.badgeImage);
                }
                else
                {
                    this.var_4819.setBadgeImage(_loc2_, param1.badgeImage);
                };
                return;
            };
            if (param1.badgeID == this.userData.groupBadgeId)
            {
                this.var_4819.setGroupBadgeImage(param1.badgeImage);
            };
        }

        private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1336, param1.id, param1.category);
            messageListener.processWidgetMessage(_loc2_);
        }

        private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _loc2_:Boolean;
            switch (param1.type)
            {
                case RoomWidgetRoomObjectUpdateEvent.var_1280:
                    _loc2_ = (param1.id == this.var_2678.id);
                    break;
                case RoomWidgetRoomObjectUpdateEvent.var_1260:
                    if ((((!(this.var_4819 == null)) && (!(this.var_4819.window == null))) && (this.var_4819.window.visible)))
                    {
                        _loc2_ = (param1.id == this.var_4825.userRoomId);
                        break;
                    };
                    if ((((!(this.var_4820 == null)) && (!(this.var_4820.window == null))) && (this.var_4820.window.visible)))
                    {
                        _loc2_ = (param1.id == this._petData.roomIndex);
                        break;
                    };
                    if ((((!(this.var_4821 == null)) && (!(this.var_4821.window == null))) && (this.var_4821.window.visible)))
                    {
                        _loc2_ = (param1.id == this.var_4825.userRoomId);
                        break;
                    };
            };
            if (_loc2_)
            {
                this.close();
            };
        }

        private function onSongUpdate(param1:RoomWidgetSongUpdateEvent):void
        {
            this.var_4822.updateSongInfo(param1);
            this.var_4823.updateSongInfo(param1);
        }

        public function close():void
        {
            this.hideChildren();
            if (this.var_4817)
            {
                this.var_4817.stop();
            };
        }

        private function onClose(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            this.close();
            if (this.var_4817)
            {
                this.var_4817.stop();
            };
        }

        private function hideChildren():void
        {
            var _loc1_:int;
            if (this._mainContainer != null)
            {
                _loc1_ = 0;
                while (_loc1_ < this._mainContainer.numChildren)
                {
                    this._mainContainer.getChildAt(_loc1_).visible = false;
                    _loc1_++;
                };
            };
        }

        private function selectView(param1:String):void
        {
            this.hideChildren();
            var _loc2_:IWindow = (this.mainContainer.getChildByName(param1) as IWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.visible = true;
            this.mainContainer.visible = true;
            this.mainContainer.width = _loc2_.width;
            this.mainContainer.height = _loc2_.height;
        }

        public function refreshContainer():void
        {
            var _loc1_:IWindow;
            var _loc2_:int;
            while (_loc2_ < this.mainContainer.numChildren)
            {
                _loc1_ = this.mainContainer.getChildAt(_loc2_);
                if (_loc1_.visible)
                {
                    this.mainContainer.width = _loc1_.width;
                    this.mainContainer.height = _loc1_.height;
                };
                _loc2_++;
            };
        }

    }
}