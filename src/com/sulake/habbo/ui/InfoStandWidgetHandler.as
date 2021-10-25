package com.sulake.habbo.ui
{

    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.session.events.UserTagsReceivedEvent;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;

    import flash.display.BitmapData;

    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomTagSearchMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetGetBadgeDetailsMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetGetBadgeImageMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetChangeMottoMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.widget.events.RoomWidgetBadgeImageUpdateEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.friendlist.IFriend;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;

    import flash.utils.getTimer;

    import com.sulake.habbo.widget.events.RoomWidgetSongUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserBadgesUpdateEvent;

    import flash.events.Event;

    import com.sulake.habbo.widget.events.RoomWidgetUserTagsUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserFigureUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.session.IPetInfo;
    import com.sulake.habbo.widget.events.RoomWidgetPetCommandsUpdateEvent;

    public class InfoStandWidgetHandler implements IRoomWidgetHandler
    {

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;
        private var var_4631: Map = new Map();
        private var var_4478: IHabboMusicController;

        public function InfoStandWidgetHandler(param1: IHabboMusicController)
        {
            this.var_4478 = param1;
            if (this.var_4478 != null)
            {
                this.var_4478.events.addEventListener(NowPlayingEvent.var_1704, this.onNowPlayingChanged);
                this.var_4478.events.addEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
            }

        }

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_259;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            if (this._container != null)
            {
                if (this._container.sessionDataManager != null)
                {
                    this._container.sessionDataManager.events.removeEventListener(UserTagsReceivedEvent.var_1341, this.onUserTags);
                    this._container.sessionDataManager.events.removeEventListener(BadgeImageReadyEvent.var_101, this.onBadgeImage);
                }

                if (this._container.roomSessionManager != null)
                {
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionUserFigureUpdateEvent.var_1342, this.onFigureUpdate);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionPetInfoUpdateEvent.var_1259, this.onPetInfo);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
                }

            }

            this._container = param1;
            if (param1 == null)
            {
                return;
            }

            if (this._container.sessionDataManager != null)
            {
                this._container.sessionDataManager.events.addEventListener(UserTagsReceivedEvent.var_1341, this.onUserTags);
                this._container.sessionDataManager.events.addEventListener(BadgeImageReadyEvent.var_101, this.onBadgeImage);
            }

            if (this._container.roomSessionManager != null)
            {
                this._container.roomSessionManager.events.addEventListener(RoomSessionUserFigureUpdateEvent.var_1342, this.onFigureUpdate);
                this._container.roomSessionManager.events.addEventListener(RoomSessionPetInfoUpdateEvent.var_1259, this.onPetInfo);
                this._container.roomSessionManager.events.addEventListener(RoomSessionPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
            }

        }

        public function dispose(): void
        {
            var _loc1_: int;
            var _loc2_: BitmapData;
            if (this.var_4631 != null)
            {
                _loc1_ = this.var_4631.length - 1;
                while (_loc1_ >= 0)
                {
                    _loc2_ = this.var_4631.getWithIndex(_loc1_);
                    if (_loc2_)
                    {
                        _loc2_.dispose();
                    }

                    _loc2_ = null;
                    _loc1_--;
                }

                this.var_4631.dispose();
                this.var_4631 = null;
            }

            if (this.var_4478 != null)
            {
                this.var_4478.events.removeEventListener(NowPlayingEvent.var_1704, this.onNowPlayingChanged);
                this.var_4478.events.removeEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
                this.var_4478 = null;
            }

            this.var_978 = true;
            this.container = null;
        }

        public function getWidgetMessages(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO);
            _loc1_.push(RoomWidgetUserActionMessage.var_1844);
            _loc1_.push(RoomWidgetUserActionMessage.var_1845);
            _loc1_.push(RoomWidgetUserActionMessage.var_1840);
            _loc1_.push(RoomWidgetUserActionMessage.var_1841);
            _loc1_.push(RoomWidgetUserActionMessage.var_1842);
            _loc1_.push(RoomWidgetUserActionMessage.var_1839);
            _loc1_.push(RoomWidgetUserActionMessage.var_1843);
            _loc1_.push(RoomWidgetUserActionMessage.var_1846);
            _loc1_.push(RoomWidgetUserActionMessage.var_1847);
            _loc1_.push(RoomWidgetUserActionMessage.var_1848);
            _loc1_.push(RoomWidgetUserActionMessage.var_1849);
            _loc1_.push(RoomWidgetFurniActionMessage.var_1102);
            _loc1_.push(RoomWidgetFurniActionMessage.var_1796);
            _loc1_.push(RoomWidgetFurniActionMessage.var_1797);
            _loc1_.push(RoomWidgetRoomTagSearchMessage.var_1905);
            _loc1_.push(RoomWidgetGetBadgeDetailsMessage.var_1906);
            _loc1_.push(RoomWidgetGetBadgeImageMessage.var_1907);
            _loc1_.push(RoomWidgetUserActionMessage.var_1850);
            _loc1_.push(RoomWidgetUserActionMessage.var_1851);
            _loc1_.push(RoomWidgetUserActionMessage.var_1837);
            _loc1_.push(RoomWidgetUserActionMessage.var_1852);
            _loc1_.push(RoomWidgetPetCommandMessage.var_1908);
            _loc1_.push(RoomWidgetPetCommandMessage.var_1909);
            _loc1_.push(RoomWidgetUserActionMessage.var_1838);
            _loc1_.push(RoomWidgetUserActionMessage.var_1346);
            _loc1_.push(RoomWidgetChangeMottoMessage.CHANGE_MOTTO);
            return _loc1_;
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc3_: IUserData;
            var _loc4_: RoomWidgetUserActionMessage;
            var _loc8_: RoomWidgetChatInputContentUpdateEvent;
            var _loc9_: IUserData;
            var _loc10_: RoomWidgetRoomTagSearchMessage;
            var _loc11_: RoomWidgetGetBadgeDetailsMessage;
            var _loc12_: RoomWidgetGetBadgeImageMessage;
            var _loc13_: BitmapData;
            var _loc14_: RoomWidgetPetCommandMessage;
            var _loc15_: RoomWidgetPetCommandMessage;
            var _loc16_: RoomWidgetChangeMottoMessage;
            if (param1 == null)
            {
                return null;
            }

            if (this._container == null)
            {
                return null;
            }

            var _loc2_: int;
            _loc4_ = (param1 as RoomWidgetUserActionMessage);
            if (_loc4_ != null)
            {
                _loc2_ = _loc4_.userId;
                if (_loc4_.type == RoomWidgetUserActionMessage.var_1850)
                {
                    _loc3_ = this._container.roomSession.userDataManager.getUserDataByIndex(_loc2_);
                }
                else
                {
                    if (param1.type == RoomWidgetUserActionMessage.var_1346 || param1.type == RoomWidgetUserActionMessage.var_1838 || param1.type == RoomWidgetUserActionMessage.var_1837)
                    {
                        _loc3_ = this._container.roomSession.userDataManager.getPetUserData(_loc2_);
                    }
                    else
                    {
                        _loc3_ = this._container.roomSession.userDataManager.getUserData(_loc2_);
                    }

                }

                if (_loc3_ == null)
                {
                    return null;
                }

            }

            var _loc5_: int;
            var _loc6_: int;
            var _loc7_: RoomWidgetFurniActionMessage = param1 as RoomWidgetFurniActionMessage;
            if (_loc7_ != null)
            {
                _loc5_ = _loc7_.furniId;
                _loc6_ = _loc7_.furniCategory;
            }

            switch (param1.type)
            {
                case RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO:
                    return this.handleGetObjectInfoMessage(param1 as RoomWidgetRoomObjectMessage);
                case RoomWidgetUserActionMessage.var_1844:
                    this._container.friendList.askForAFriend(_loc2_, _loc3_.name);
                    break;
                case RoomWidgetUserActionMessage.var_1845:
                    this._container.sessionDataManager.giveRespect(_loc2_);
                    break;
                case RoomWidgetUserActionMessage.var_1838:
                    this._container.sessionDataManager.givePetRespect(_loc2_);
                    break;
                case RoomWidgetUserActionMessage.var_1840:
                    _loc8_ = new RoomWidgetChatInputContentUpdateEvent(RoomWidgetChatInputContentUpdateEvent.WHISPER, _loc3_.name);
                    this._container.events.dispatchEvent(_loc8_);
                    break;
                case RoomWidgetUserActionMessage.var_1841:
                    this._container.sessionDataManager.ignoreUser(_loc3_.name);
                    break;
                case RoomWidgetUserActionMessage.var_1842:
                    this._container.sessionDataManager.unignoreUser(_loc3_.name);
                    break;
                case RoomWidgetUserActionMessage.var_1839:
                    this._container.roomSession.kickUser(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_1843:
                    this._container.roomSession.banUser(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_1846:
                    this._container.roomSession.assignRights(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_1847:
                    this._container.roomSession.removeRights(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_1848:
                    _loc9_ = this._container.roomSession.userDataManager.getUserData(_loc4_.userId);
                    this._container.inventory.setupTrading(_loc9_.id, _loc9_.name);
                    break;
                case RoomWidgetUserActionMessage.var_1849:
                    this._container.sessionDataManager.openHabboHomePage(_loc3_.webID);
                    break;
                case RoomWidgetUserActionMessage.var_1837:
                    this._container.roomSession.pickUpPet(_loc2_);
                    break;
                case RoomWidgetFurniActionMessage.var_1796:
                    this._container.roomEngine.modifyRoomObject(_loc5_, _loc6_, RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE);
                    break;
                case RoomWidgetFurniActionMessage.var_1102:
                    this._container.roomEngine.modifyRoomObject(_loc5_, _loc6_, RoomObjectOperationEnum.OBJECT_MOVE);
                    break;
                case RoomWidgetFurniActionMessage.var_1797:
                    this._container.roomEngine.modifyRoomObject(_loc5_, _loc6_, RoomObjectOperationEnum.OBJECT_PICKUP);
                    break;
                case RoomWidgetUserActionMessage.var_1346:
                    if (this._container.roomSession != null && this._container.roomSession.userDataManager != null)
                    {
                        this._container.roomSession.userDataManager.requestPetInfo(_loc2_);
                    }

                    break;
                case RoomWidgetRoomTagSearchMessage.var_1905:
                    _loc10_ = (param1 as RoomWidgetRoomTagSearchMessage);
                    if (_loc10_ == null)
                    {
                        return null;
                    }

                    this._container.navigator.performTagSearch(_loc10_.tag);
                    break;
                case RoomWidgetGetBadgeDetailsMessage.var_1906:
                    _loc11_ = (param1 as RoomWidgetGetBadgeDetailsMessage);
                    if (_loc11_ == null)
                    {
                        return null;
                    }

                    this._container.sessionDataManager.showGroupBadgeInfo(_loc11_.groupId);
                    break;
                case RoomWidgetGetBadgeImageMessage.var_1907:
                    _loc12_ = (param1 as RoomWidgetGetBadgeImageMessage);
                    if (_loc12_ == null)
                    {
                        return null;
                    }

                    _loc13_ = this._container.sessionDataManager.getBadgeImage(_loc12_.badgeId);
                    if (_loc13_ != null)
                    {
                        this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc12_.badgeId, _loc13_));
                    }

                    break;
                case RoomWidgetUserActionMessage.var_1850:
                    this._container.roomSession.kickBot(_loc2_);
                    break;
                case RoomWidgetUserActionMessage.var_1851:
                    if (this._container == null || this._container.habboHelp == null)
                    {
                        break;
                    }
                    if (_loc3_ == null)
                    {
                        break;
                    }
                    this._container.habboHelp.reportUser(_loc2_, _loc3_.name);
                    break;
                case RoomWidgetPetCommandMessage.var_1909:
                    _loc14_ = (param1 as RoomWidgetPetCommandMessage);
                    this._container.roomSession.requestPetCommands(_loc14_.petId);
                    break;
                case RoomWidgetPetCommandMessage.var_1908:
                    _loc15_ = (param1 as RoomWidgetPetCommandMessage);
                    this._container.roomSession.sendChatMessage(_loc15_.value);
                    break;
                case RoomWidgetChangeMottoMessage.CHANGE_MOTTO:
                    _loc16_ = (param1 as RoomWidgetChangeMottoMessage);
                    this._container.roomSession.sendChangeMottoMessage(_loc16_.motto);
                    break;
            }

            return null;
        }

        private function handleGetObjectInfoMessage(param1: RoomWidgetRoomObjectMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: int;
            var _loc3_: int;
            var _loc4_: uint;
            var _loc5_: ImageResult;
            var _loc6_: RoomWidgetFurniInfoUpdateEvent;
            var _loc7_: IRoomObject;
            var _loc8_: IRoomObjectModel;
            var _loc9_: IRoomObject;
            var _loc10_: String;
            var _loc11_: int;
            var _loc12_: int;
            var _loc13_: IUserData;
            var _loc14_: String;
            var _loc15_: RoomWidgetUserInfoUpdateEvent;
            var _loc16_: Array;
            var _loc17_: String;
            var _loc18_: IRoomObject;
            var _loc19_: String;
            var _loc20_: String;
            var _loc21_: IAvatarImage;
            var _loc22_: BitmapData;
            var _loc23_: String;
            var _loc24_: int;
            var _loc25_: int;
            var _loc26_: IFurnitureData;
            var _loc27_: int;
            var _loc28_: String;
            var _loc29_: String;
            var _loc30_: String;
            var _loc31_: IPlayListController;
            var _loc32_: String;
            var _loc33_: ISongInfo;
            var _loc34_: IFriend;
            var _loc35_: Boolean;
            var _loc36_: Boolean;
            var _loc37_: int;
            var _loc38_: Array;
            var _loc39_: String;
            var _loc40_: Array;
            var _loc41_: int;
            var _loc42_: BitmapData;
            _loc2_ = this._container.roomSession.roomId;
            _loc3_ = this._container.roomSession.roomCategory;
            switch (param1.category)
            {
                case RoomObjectCategoryEnum.var_72:
                case RoomObjectCategoryEnum.var_73:
                    if (this._container.events == null || this._container.roomEngine == null)
                    {
                        return null;
                    }

                    if (param1.id < 0)
                    {
                        return null;
                    }

                    _loc4_ = 4282203453;
                    _loc5_ = this._container.roomEngine.getRoomObjectImage(_loc2_, _loc3_, param1.id, param1.category, new Vector3d(180), 32, null, _loc4_);
                    _loc6_ = new RoomWidgetFurniInfoUpdateEvent(RoomWidgetFurniInfoUpdateEvent.var_1258);
                    _loc6_.id = param1.id;
                    _loc6_.category = param1.category;
                    _loc7_ = this._container.roomEngine.getRoomObject(_loc2_, _loc3_, param1.id, param1.category);
                    _loc8_ = _loc7_.getModel();
                    if (_loc8_.getString(RoomWidgetInfostandExtraParamEnum.var_1211) != null)
                    {
                        _loc6_.extraParam = _loc8_.getString(RoomWidgetInfostandExtraParamEnum.var_1211);
                    }

                    _loc9_ = this._container.roomEngine.getRoomObject(_loc2_, _loc3_, param1.id, param1.category);
                    if (_loc9_ == null || _loc9_.getModel() == null)
                    {
                        return null;
                    }

                    _loc10_ = _loc9_.getType();
                    if (_loc10_.indexOf("poster") == 0)
                    {
                        _loc24_ = int(_loc10_.replace("poster", ""));
                        _loc6_.name = "${poster_" + _loc24_ + "_name}";
                        _loc6_.description = "${poster_" + _loc24_ + "_desc}";
                    }
                    else
                    {
                        _loc25_ = _loc9_.getModel().getNumber(RoomObjectVariableEnum.FURNITURE_TYPE_ID);
                        if (param1.category == RoomObjectCategoryEnum.var_72)
                        {
                            _loc26_ = this._container.sessionDataManager.getFloorItemData(_loc25_);
                        }
                        else
                        {
                            if (param1.category == RoomObjectCategoryEnum.var_73)
                            {
                                _loc26_ = this._container.sessionDataManager.getWallItemData(_loc25_);
                            }

                        }

                        if (_loc26_ != null)
                        {
                            _loc6_.name = _loc26_.title;
                            _loc6_.description = _loc26_.description;
                            _loc6_.catalogPageId = _loc26_.catalogPageId;
                            _loc6_.offerId = _loc26_.offerId;
                            if (this._container.userDefinedRoomEvents != null && param1.category == RoomObjectCategoryEnum.var_72)
                            {
                                this._container.userDefinedRoomEvents.stuffSelected(_loc9_.getId(), _loc26_.title);
                            }

                        }

                    }

                    if (_loc10_.indexOf("post_it") > -1)
                    {
                        _loc6_.isStickie = true;
                    }

                    _loc6_.image = _loc5_.data;
                    _loc11_ = _loc9_.getModel().getNumber(RoomObjectVariableEnum.FURNITURE_EXPIRY_TIME);
                    _loc12_ = _loc9_.getModel().getNumber(RoomObjectVariableEnum.var_491);
                    _loc6_.expiration = _loc11_ - (getTimer() - _loc12_) / 60000;
                    _loc6_.isWallItem = param1.category == RoomObjectCategoryEnum.var_73;
                    _loc6_.isRoomOwner = this._container.roomSession.isRoomOwner;
                    _loc6_.isRoomController = this._container.roomSession.isRoomController;
                    _loc6_.isAnyRoomController = this._container.sessionDataManager.isAnyRoomController;
                    this._container.events.dispatchEvent(_loc6_);
                    if (_loc6_.extraParam != null && _loc6_.extraParam.length > 0)
                    {
                        _loc27_ = -1;
                        _loc28_ = "";
                        _loc29_ = "";
                        _loc30_ = "";
                        if (_loc6_.extraParam == RoomWidgetInfostandExtraParamEnum.var_1212)
                        {
                            _loc31_ = this.var_4478.getRoomItemPlaylist();
                            if (_loc31_ != null)
                            {
                                _loc27_ = _loc31_.nowPlayingSongId;
                                _loc30_ = RoomWidgetSongUpdateEvent.var_1344;
                            }

                        }
                        else
                        {
                            if (_loc6_.extraParam.indexOf(RoomWidgetInfostandExtraParamEnum.var_1221) == 0)
                            {
                                _loc32_ = _loc6_.extraParam.substr(RoomWidgetInfostandExtraParamEnum.var_1221.length);
                                _loc27_ = parseInt(_loc32_);
                                _loc30_ = RoomWidgetSongUpdateEvent.var_1345;
                            }

                        }

                        if (_loc27_ != -1)
                        {
                            _loc33_ = this.var_4478.getSongInfo(_loc27_);
                            if (_loc33_ != null)
                            {
                                _loc28_ = _loc33_.name;
                                _loc29_ = _loc33_.creator;
                            }

                            this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(_loc30_, _loc27_, _loc28_, _loc29_));
                        }

                    }

                    break;
                case RoomObjectCategoryEnum.var_71:
                    if (this._container.roomSession == null || this._container.sessionDataManager == null || this._container.events == null || this._container.roomEngine == null || this._container.friendList == null || this._container.toolbar == null)
                    {
                        return null;
                    }

                    _loc13_ = this._container.roomSession.userDataManager.getUserDataByIndex(param1.id);
                    if (_loc13_ == null)
                    {
                        return null;
                    }

                    if (_loc13_.type == RoomObjectTypeEnum.var_1234)
                    {
                        this._container.roomSession.userDataManager.requestPetInfo(_loc13_.webID);
                        return null;
                    }

                    if (_loc13_.type == RoomObjectTypeEnum.var_1262)
                    {
                        _loc14_ = RoomWidgetUserInfoUpdateEvent.var_1255;
                        if (_loc13_.webID != this._container.sessionDataManager.userId)
                        {
                            _loc14_ = RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER;
                        }

                    }
                    else
                    {
                        if (_loc13_.type == RoomObjectTypeEnum.var_1263)
                        {
                            _loc14_ = RoomWidgetUserInfoUpdateEvent.BOT;
                        }
                        else
                        {
                            return null;
                        }

                    }

                    _loc15_ = new RoomWidgetUserInfoUpdateEvent(_loc14_);
                    _loc15_.isSpectatorMode = this._container.roomSession.isSpectatorMode;
                    _loc15_.name = _loc13_.name;
                    _loc15_.motto = _loc13_.custom;
                    _loc15_.achievementScore = _loc13_.achievementScore;
                    _loc15_.webID = _loc13_.webID;
                    _loc15_.userRoomId = param1.id;
                    _loc16_ = [];
                    _loc18_ = this._container.roomEngine.getRoomObject(_loc2_, _loc3_, param1.id, param1.category);
                    if (_loc18_ != null)
                    {
                        _loc15_.carryItem = _loc18_.getModel().getNumber(RoomObjectVariableEnum.AVATAR_CARRY_OBJECT);
                    }

                    if (_loc14_ == RoomWidgetUserInfoUpdateEvent.var_1255)
                    {
                        _loc15_.realName = this._container.sessionDataManager.realName;
                    }

                    if (_loc14_ == RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER)
                    {
                        _loc15_.canBeAskedAsFriend = this._container.friendList.canBeAskedForAFriend(_loc13_.webID);
                        _loc34_ = this._container.friendList.getFriend(_loc13_.webID);
                        if (_loc34_ != null)
                        {
                            _loc15_.realName = _loc34_.realName;
                        }

                        if (_loc18_ != null)
                        {
                            _loc39_ = _loc18_.getModel().getString(RoomObjectVariableEnum.AVATAR_FLAT_CONTROL);
                            _loc15_.hasFlatControl = _loc39_ == "onlyfurniture" || _loc39_ == "useradmin" || _loc39_ == "";
                            _loc15_.canBeKicked = this._container.roomSession.isPrivateRoom;
                        }

                        _loc15_.isIgnored = this._container.sessionDataManager.isIgnored(_loc13_.name);
                        _loc15_.amIOwner = this._container.roomSession.isRoomOwner;
                        _loc15_.amIController = this._container.roomSession.isRoomController;
                        _loc15_.amIAnyRoomController = this._container.sessionDataManager.isAnyRoomController;
                        _loc15_.respectLeft = this._container.sessionDataManager.respectLeft;
                        _loc35_ = !this._container.sessionDataManager.systemShutDown;
                        _loc36_ = this._container.roomSession.isTradingRoom;
                        _loc15_.canTrade = _loc35_ && _loc36_;
                        _loc15_.canTradeReason = RoomWidgetUserInfoUpdateEvent.TRADE_REASON_OK;
                        if (!_loc35_)
                        {
                            _loc15_.canTradeReason = RoomWidgetUserInfoUpdateEvent.var_1809;
                        }

                        if (!_loc36_)
                        {
                            _loc15_.canTradeReason = RoomWidgetUserInfoUpdateEvent.var_1810;
                        }

                        _loc37_ = this._container.sessionDataManager.userId;
                        _loc38_ = this._container.sessionDataManager.getUserTags(_loc37_);
                        this.dispatchUserTags(_loc37_, _loc38_);
                    }

                    if (_loc14_ == RoomWidgetUserInfoUpdateEvent.BOT)
                    {
                        _loc15_.canBeKicked = this._container.roomSession.isRoomOwner;
                        _loc16_.push(RoomWidgetUserInfoUpdateEvent.var_1812);
                    }
                    else
                    {
                        _loc16_ = this._container.roomSession.userDataManager.getUserBadges(_loc13_.webID);
                        _loc17_ = this._container.sessionDataManager.getGroupBadgeId(int(_loc13_.groupID));
                        _loc15_.groupId = int(_loc13_.groupID);
                        _loc15_.groupBadgeId = _loc17_;
                    }

                    _loc15_.badges = _loc16_;
                    _loc19_ = _loc13_.figure;
                    _loc20_ = _loc13_.sex;
                    _loc21_ = this._container.avatarRenderManager.createAvatarImage(_loc19_, AvatarScaleType.var_106, _loc20_);
                    if (_loc21_ != null)
                    {
                        _loc21_.setDirection(AvatarSetType.var_136, 4);
                        _loc15_.image = _loc21_.getImage(AvatarSetType.var_136, true);
                        _loc21_.dispose();
                    }

                    this._container.events.dispatchEvent(_loc15_);
                    if (_loc13_.type == RoomObjectTypeEnum.var_1262)
                    {
                        _loc40_ = this._container.sessionDataManager.getUserTags(_loc13_.webID);
                        this.dispatchUserTags(_loc13_.webID, _loc40_);
                    }

                    _loc41_ = 0;
                    while (_loc41_ < _loc16_.length)
                    {
                        _loc23_ = _loc16_[_loc41_];
                        _loc22_ = this._container.sessionDataManager.getBadgeImage(_loc23_);
                        if (_loc22_ != null)
                        {
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc23_, _loc22_));
                        }

                        _loc41_++;
                    }

                    if (_loc17_ != null)
                    {
                        _loc42_ = this._container.sessionDataManager.getGroupBadgeImage(_loc17_);
                        if (_loc42_ != null)
                        {
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc17_, _loc42_));
                        }

                    }

                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            return [RoomSessionUserBadgesEvent.var_368];
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: RoomSessionUserBadgesEvent;
            var _loc3_: int;
            var _loc4_: String;
            var _loc5_: BitmapData;
            switch (param1.type)
            {
                case RoomSessionUserBadgesEvent.var_368:
                    _loc2_ = (param1 as RoomSessionUserBadgesEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    }

                    this._container.events.dispatchEvent(new RoomWidgetUserBadgesUpdateEvent(_loc2_.userId, _loc2_.badges));
                    _loc3_ = 0;
                    while (_loc3_ < _loc2_.badges.length)
                    {
                        _loc4_ = _loc2_.badges[_loc3_];
                        _loc5_ = this._container.sessionDataManager.getBadgeImage(_loc4_);
                        if (_loc5_ != null)
                        {
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc4_, _loc5_));
                        }

                        _loc3_++;
                    }

                    return;
            }

        }

        private function onUserTags(param1: UserTagsReceivedEvent): void
        {
            this.dispatchUserTags(param1.userId, param1.tags);
        }

        private function dispatchUserTags(param1: int, param2: Array): void
        {
            if (param2 == null)
            {
                return;
            }

            var _loc3_: Boolean;
            if (this._container.sessionDataManager != null)
            {
                _loc3_ = param1 == this._container.sessionDataManager.userId;
            }

            if (this._container != null && this._container.events != null)
            {
                this._container.events.dispatchEvent(new RoomWidgetUserTagsUpdateEvent(param1, param2, _loc3_));
            }

        }

        private function onBadgeImage(param1: BadgeImageReadyEvent): void
        {
            if (this._container != null && this._container.events != null)
            {
                this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(param1.badgeId, param1.badgeImage));
            }

        }

        private function onFigureUpdate(param1: RoomSessionUserFigureUpdateEvent): void
        {
            var _loc5_: IAvatarImage;
            var _loc6_: Boolean;
            if (this._container == null)
            {
                return;
            }

            if (param1 == null)
            {
                return;
            }

            if (param1.userId < 0)
            {
                return;
            }

            var _loc2_: IUserData = this._container.roomSession.userDataManager.getUserDataByIndex(param1.userId);
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: int = _loc2_.webID;
            var _loc4_: BitmapData;
            if (this._container.avatarRenderManager != null)
            {
                _loc5_ = this._container.avatarRenderManager.createAvatarImage(param1.figure, AvatarScaleType.var_106, param1.gender);
                if (_loc5_ != null)
                {
                    _loc5_.setDirection(AvatarSetType.var_136, 4);
                    _loc4_ = _loc5_.getImage(AvatarSetType.var_136, true);
                    _loc5_.dispose();
                }

                _loc6_ = _loc3_ == this._container.sessionDataManager.userId;
                if (this._container != null && this._container.events != null)
                {
                    this._container.events.dispatchEvent(new RoomWidgetUserFigureUpdateEvent(_loc3_, _loc4_, _loc6_, param1.customInfo, param1.achievementScore));
                }

            }

        }

        private function onPetInfo(param1: RoomSessionPetInfoUpdateEvent): void
        {
            var _loc8_: Boolean;
            var _loc9_: RoomWidgetPetInfoUpdateEvent;
            var _loc10_: Boolean;
            var _loc11_: int;
            var _loc12_: int;
            var _loc13_: IUserData;
            var _loc14_: IRoomObject;
            var _loc15_: String;
            var _loc2_: IPetInfo = param1.petInfo;
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: IUserData = this._container.roomSession.userDataManager.getPetUserData(_loc2_.petId);
            if (_loc3_ == null)
            {
                return;
            }

            var _loc4_: String = _loc3_.figure;
            var _loc5_: int = this.getPetType(_loc4_);
            var _loc6_: int = this.getPetRace(_loc4_);
            var _loc7_: BitmapData = this.var_4631.getValue(_loc4_) as BitmapData;
            if (_loc7_ == null)
            {
                _loc7_ = this.getPetImage(_loc4_);
                this.var_4631.add(_loc4_, _loc7_);
            }

            if (this._container != null && this._container.events != null)
            {
                _loc8_ = _loc2_.ownerId == this._container.sessionDataManager.userId;
                _loc9_ = new RoomWidgetPetInfoUpdateEvent(_loc5_, _loc6_, _loc3_.name, _loc2_.petId, _loc7_, _loc8_, _loc2_.ownerId, _loc2_.ownerName, _loc3_.id);
                _loc9_.level = _loc2_.level;
                _loc9_.levelMax = _loc2_.levelMax;
                _loc9_.experience = _loc2_.experience;
                _loc9_.experienceMax = _loc2_.experienceMax;
                _loc9_.energy = _loc2_.energy;
                _loc9_.energyMax = _loc2_.energyMax;
                _loc9_.nutrition = _loc2_.nutrition;
                _loc9_.nutritionMax = _loc2_.nutritionMax;
                _loc9_.petRespect = _loc2_.respect;
                _loc9_.petRespectLeft = this._container.sessionDataManager.petRespectLeft;
                _loc9_.age = _loc2_.age;
                _loc10_ = false;
                _loc11_ = this._container.roomSession.roomId;
                _loc12_ = this._container.roomSession.roomCategory;
                _loc13_ = this._container.roomSession.userDataManager.getUserData(_loc2_.ownerId);
                if (_loc13_ != null)
                {
                    _loc14_ = this._container.roomEngine.getRoomObject(_loc11_, _loc12_, _loc13_.id, RoomObjectCategoryEnum.var_71);
                    if (_loc14_ != null)
                    {
                        _loc15_ = _loc14_.getModel().getString(RoomObjectVariableEnum.AVATAR_FLAT_CONTROL);
                        _loc10_ = (this._container.roomSession.isRoomOwner || this._container.roomSession.isRoomController || this._container.sessionDataManager.isAnyRoomController) && _loc15_ != "useradmin" && this._container.roomSession.isPrivateRoom && !_loc8_;
                    }

                }

                _loc9_.canOwnerBeKicked = _loc10_;
                this._container.events.dispatchEvent(_loc9_);
            }

        }

        private function onPetCommands(param1: RoomSessionPetCommandsUpdateEvent): void
        {
            var _loc2_: RoomWidgetPetCommandsUpdateEvent;
            if (this._container != null && this._container.events != null)
            {
                _loc2_ = new RoomWidgetPetCommandsUpdateEvent(param1.petId, param1.allCommands, param1.enabledCommands);
                this._container.events.dispatchEvent(_loc2_);
            }

        }

        public function update(): void
        {
        }

        private function getPetImage(param1: String): BitmapData
        {
            var _loc4_: IAvatarImage;
            var _loc5_: int;
            var _loc6_: uint;
            var _loc7_: ImageResult;
            var _loc2_: BitmapData;
            var _loc3_: int = this.getPetType(param1);
            if (_loc3_ < 8)
            {
                _loc4_ = this._container.avatarRenderManager.createPetImageFromFigure(param1, AvatarScaleType.var_106, null);
                if (_loc4_ != null)
                {
                    _loc2_ = _loc4_.getCroppedImage(AvatarSetType.var_136);
                    _loc4_.dispose();
                }

            }
            else
            {
                _loc5_ = this.getPetRace(param1);
                _loc6_ = 0;
                _loc7_ = this._container.roomEngine.getPetImage(_loc3_, _loc5_, new Vector3d(90), 64, null, _loc6_);
                if (_loc7_ != null)
                {
                    _loc2_ = _loc7_.data;
                }

            }

            if (_loc2_ == null)
            {
                _loc2_ = new BitmapData(30, 30, false, 4289374890);
            }

            return _loc2_;
        }

        private function getPetType(param1: String): int
        {
            return this.getSpaceSeparatedInteger(param1, 0);
        }

        private function getPetRace(param1: String): int
        {
            return this.getSpaceSeparatedInteger(param1, 1);
        }

        private function getSpaceSeparatedInteger(param1: String, param2: int): int
        {
            var _loc3_: Array;
            if (param1 != null)
            {
                _loc3_ = param1.split(" ");
                if (_loc3_.length > param2)
                {
                    return int(_loc3_[param2]);
                }

            }

            return -1;
        }

        private function onNowPlayingChanged(param1: NowPlayingEvent): void
        {
            var _loc2_: int;
            var _loc3_: String;
            var _loc4_: String;
            var _loc5_: ISongInfo;
            if (this.var_4478 != null)
            {
                _loc2_ = param1.id;
                _loc3_ = "";
                _loc4_ = "";
                if (_loc2_ != -1)
                {
                    _loc5_ = this.var_4478.getSongInfo(_loc2_);
                    if (_loc5_ != null)
                    {
                        _loc3_ = _loc5_.name;
                        _loc4_ = _loc5_.creator;
                    }

                }

                this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(RoomWidgetSongUpdateEvent.var_1344, _loc2_, _loc3_, _loc4_));
            }

        }

        private function onSongInfoReceivedEvent(param1: SongInfoReceivedEvent): void
        {
            var _loc2_: ISongInfo;
            if (this.var_4478 != null)
            {
                _loc2_ = this.var_4478.getSongInfo(param1.id);
                if (_loc2_ != null)
                {
                    this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(RoomWidgetSongUpdateEvent.var_1345, param1.id, _loc2_.name, _loc2_.creator));
                }

            }

        }

    }
}
