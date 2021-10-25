package com.sulake.habbo.navigator.roomsettings
{

    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetRoomSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveableRoomSettingsData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.DeleteRoomMessageComposer;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;

    import flash.geom.Rectangle;

    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveAllRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
    import com.sulake.habbo.navigator.*;

    public class RoomSettingsCtrl
    {

        private var _inRoom: Boolean;
        private var var_2197: IRoomSettingsCtrlOwner;
        private var _roomId: int;
        private var _navigator: HabboNavigator;
        private var _roomSettings: RoomSettingsData;
        private var var_3822: int;
        private var _window: IWindowContainer;
        private var _active: Boolean;
        private var var_3823: Boolean;
        private var var_3824: Boolean;
        private var var_3825: TextFieldManager;
        private var var_3826: TextFieldManager;
        private var var_3741: TextFieldManager;
        private var var_3742: TextFieldManager;
        private var var_3827: TextFieldManager;
        private var var_3828: TextFieldManager;
        private var var_3829: ICheckBoxWindow;
        private var var_3830: ICheckBoxWindow;
        private var var_3831: ICheckBoxWindow;
        private var var_3832: ICheckBoxWindow;
        private var var_3833: IWindowContainer;
        private var var_3834: IWindowContainer;
        private var var_3835: IWindowContainer;
        private var var_3836: IWindowContainer;
        private var _switchViewContainer: IWindowContainer;
        private var var_3837: IWindowContainer;
        private var var_3838: IWindowContainer;
        private var var_3839: IWindowContainer;
        private var var_3840: ITextWindow;
        private var var_3841: ITextWindow;
        private var var_3842: ITextWindow;

        public function RoomSettingsCtrl(param1: HabboNavigator, param2: IRoomSettingsCtrlOwner, param3: Boolean)
        {
            this._navigator = param1;
            this.var_2197 = param2;
            this._inRoom = param3;
        }

        public function set active(value: Boolean): void
        {
            this._active = value;
            this.var_3824 = false;
        }

        public function get active(): Boolean
        {
            return this._active;
        }

        public function load(id: int): void
        {
            this._roomId = id;

            this._navigator.send(new GetRoomSettingsMessageComposer(this._roomId));

            if (this.var_3839 != null)
            {
                this.var_3839.visible = false;
            }

        }

        public function onRoomSettings(roomSettings: RoomSettingsData): void
        {
            if (roomSettings.roomId != this._roomId)
            {
                return;
            }

            this._roomSettings = roomSettings;
            this._active = true;
            this.var_3823 = true;
            this.var_2197.roomSettingsRefreshNeeded();
        }

        public function onFlatControllerAdded(roomId: int, flatControllerData: FlatControllerData): void
        {
            if (roomId != this._roomId)
            {
                return;
            }

            if (!this.controllerExists(flatControllerData.userId))
            {
                this._roomSettings.controllers.splice(0, 0, flatControllerData);
                this._roomSettings.controllerCount++;
            }

            if (this.var_3824)
            {
                this.var_2197.roomSettingsRefreshNeeded();
            }

        }

        private function controllerExists(userId: int): Boolean
        {
            var flatControllerData: FlatControllerData;
            var i: int;

            while (i < this._roomSettings.controllers.length)
            {
                flatControllerData = this._roomSettings.controllers[i];

                if (flatControllerData.userId == userId)
                {
                    return true;
                }

                i++;
            }

            return false;
        }

        public function onFlatControllerRemoved(roomId: int, userId: int): void
        {

            if (roomId != this._roomId)
            {
                return;
            }

            this._roomSettings.controllerCount--;

            var i: int;
            var flatControllerData: FlatControllerData;

            while (i < this._roomSettings.controllers.length)
            {
                flatControllerData = this._roomSettings.controllers[i];

                if (flatControllerData.userId == userId)
                {
                    this._roomSettings.controllers.splice(i, 1);
                }
                else
                {
                    i++;
                }

            }

            if (this.var_3824)
            {
                this.var_2197.roomSettingsRefreshNeeded();
            }

        }

        public function onRoomSettingsSaved(param1: int): void
        {
            if (param1 != this._roomId || this.var_3822 < 1)
            {
                return;
            }

            this.close();
            this.var_2197.roomSettingsRefreshNeeded();
        }

        public function onRoomSettingsSaveError(param1: int, param2: int, param3: String): void
        {
            if (param1 != this._roomId || this.var_3822 < 1)
            {
                return;
            }

            this.var_3822 = 0;
            if (param2 == RoomSettingsSaveErrorMessageParser.ROOM_SETTINGS_NAME_IS_MANDATORY)
            {
                this.var_3825.displayError("${navigator.roomsettings.roomnameismandatory}");
            }
            else
            {
                if (param2 == RoomSettingsSaveErrorMessageParser.ROOM_SETTINGS_UNACCEPTABLE_WORDS_1)
                {
                    this.var_3825.displayError("${navigator.roomsettings.unacceptablewords}");
                }
                else
                {
                    if (param2 == RoomSettingsSaveErrorMessageParser.ROOM_SETTINGS_UNACCEPTABLE_WORDS_2)
                    {
                        this.var_3826.displayError("${navigator.roomsettings.unacceptablewords}");
                    }
                    else
                    {
                        if (param2 == RoomSettingsSaveErrorMessageParser.ROOM_SETTINGS_UNACCEPTABLE_WORDS_3)
                        {
                            this.setTagError(this.var_3741, param3, "${navigator.roomsettings.unacceptablewords}");
                            this.setTagError(this.var_3742, param3, "${navigator.roomsettings.unacceptablewords}");
                        }
                        else
                        {
                            if (param2 == RoomSettingsSaveErrorMessageParser.ROOM_SETTINGS_NON_CHOOSABLE_TAG)
                            {
                                this.setTagError(this.var_3741, param3, "${navigator.roomsettings.nonuserchoosabletag}");
                                this.setTagError(this.var_3742, param3, "${navigator.roomsettings.nonuserchoosabletag}");
                            }
                            else
                            {
                                if (param2 == RoomSettingsSaveErrorMessageParser.ROOM_SETTINGS_PASSWORD_IS_MANDATORY)
                                {
                                    this.var_3827.displayError("${navigator.roomsettings.passwordismandatory}");
                                }
                                else
                                {
                                    this.var_3825.displayError("Update failed: error " + param2);
                                }

                            }

                        }

                    }

                }

            }

        }

        private function setTagError(param1: TextFieldManager, param2: String, param3: String): void
        {
            if (param2 == param1.getText().toLowerCase())
            {
                param1.displayError(param3);
            }

        }

        public function close(): void
        {
            this._active = false;
            this._roomId = 0;
            this._roomSettings = null;
            this.var_3822 = 0;
        }

        private function clearErrors(): void
        {
            this.var_3825.clearErrors();
            this.var_3826.clearErrors();
            this.var_3741.clearErrors();
            this.var_3742.clearErrors();
            this.var_3827.clearErrors();
            this.var_3828.clearErrors();
        }

        private function prepareWindow(container: IWindowContainer): void
        {
            if (this._window != null)
            {
                return;
            }

            this._window = IWindowContainer(this._navigator.getXmlWindow("ros_room_settings"));
            
            container.addChildAt(this._window, 0);
            
            var _loc2_: IRadioButtonWindow = this._window.findChildByName("doormode_password") as IRadioButtonWindow;
            _loc2_.addEventListener(WindowEvent.var_559, this.onDoorModePasswordSelect);
            _loc2_.addEventListener(WindowEvent.var_561, this.onDoorModePasswordUnselect);
            
            this.getSaveButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSaveButtonClick);
            this.getCancelButton()
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelButtonClick);
            this.getDeleteButton()
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onDeleteButtonClick);
            this.getEditThumbnailButton()
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onEditThumbnailButtonClick);
            this.getRemoveAllFlatCtrlsButton()
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRemoveAllFlatCtrlsClick);
            this.getRemoveFlatCtrlsButton()
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRemoveFlatCtrlClick);
            
            this.var_3825 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("room_name")), 60);
            this.var_3826 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("description")), 0xFF);
            this.var_3741 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("tag1")), 30);
            this.var_3742 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("tag2")), 30);
            this.var_3827 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("password")), 30);
            this.var_3828 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("password_confirm")), 30);
            this.var_3829 = ICheckBoxWindow(this._window.findChildByName("allow_pets_checkbox"));
            this.var_3830 = ICheckBoxWindow(this._window.findChildByName("allow_foodconsume_checkbox"));
            this.var_3831 = ICheckBoxWindow(this._window.findChildByName("allow_walk_through_checkbox"));
            this.var_3832 = ICheckBoxWindow(this._window.findChildByName("hide_walls_checkbox"));
            this.var_3833 = IWindowContainer(this._window.findChildByName("header_container"));
            this.var_3834 = IWindowContainer(this._window.findChildByName("thumbnail_container"));
            this.var_3835 = IWindowContainer(this._window.findChildByName("basic_settings_container"));
            this.var_3836 = IWindowContainer(this._window.findChildByName("advanced_settings_container"));
            this._switchViewContainer = IWindowContainer(this._window.findChildByName("switch_view_container"));
            this.var_3837 = IWindowContainer(this._window.findChildByName("footer_container"));
            this.var_3838 = IWindowContainer(this._window.findChildByName("flat_controllers_container"));
            this.var_3839 = IWindowContainer(this._window.findChildByName("password_container"));
            this.var_3840 = ITextWindow(this._window.findChildByName("basic_caption"));
            this.var_3841 = ITextWindow(this._window.findChildByName("advanced_caption"));
            this.var_3842 = ITextWindow(this._window.findChildByName("switch_view_text"));
            this.var_3842.mouseThreshold = 0;
            this.var_3842.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSwitchView);
            this.var_3839.visible = false;
            if (!this._inRoom)
            {
                this._window.color = 0xFFFFFFFF;
                Util.setColors(this._window, 0xFF000000);
            }

        }

        private function getSaveButton(): IButtonWindow
        {
            return IButtonWindow(this._window.findChildByName("save"));
        }

        private function getCancelButton(): IButtonWindow
        {
            return IButtonWindow(this._window.findChildByName("cancel"));
        }

        private function getDeleteButton(): IButtonWindow
        {
            return IButtonWindow(this._window.findChildByName("delete"));
        }

        private function getEditThumbnailButton(): IButtonWindow
        {
            return IButtonWindow(this._window.findChildByName("edit_thumbnail"));
        }

        private function getRemoveAllFlatCtrlsButton(): IButtonWindow
        {
            return IButtonWindow(this._window.findChildByName("remove_all_flat_ctrls"));
        }

        private function getRemoveFlatCtrlsButton(): IButtonWindow
        {
            return IButtonWindow(this._window.findChildByName("remove_flat_ctrl"));
        }

        public function refresh(param1: IWindowContainer): void
        {
            if (!this._active)
            {
                return;
            }

            this.prepareWindow(param1);
            Util.hideChildren(this._window);
            this.var_3833.visible = this._inRoom;
            this._switchViewContainer.visible = this._inRoom;
            this.var_3841.visible = this.var_3824;
            this.var_3840.visible = !this.var_3824;
            if (this.var_3824)
            {
                this.var_3836.visible = true;
                this.var_3837.visible = false;
                this.refreshFlatControllers();
                this.var_3836.height = Util.getLowestPoint(this.var_3836) + 4;
            }
            else
            {
                this.populateForm();
                this.var_3835.visible = true;
                this.var_3837.visible = true;
                this.var_3834.visible = this._inRoom;
                this._navigator.thumbRenderer.refreshThumbnail(IWindowContainer(this.var_3834.findChildByName("picframe")), this._navigator.data.enteredGuestRoom.thumbnail, false);
                this.var_3835.height = Util.getLowestPoint(this.var_3835) + 4;
            }

            this.var_3842.text = this.var_3824
                    ? "${navigator.roomsettings.tobasicsettings}"
                    : "${navigator.roomsettings.toadvancedsettings}";
            Util.moveChildrenToColumn(this._window, [
                this.var_3833.name,
                this.var_3834.name,
                this.var_3835.name,
                this.var_3836.name,
                this.var_3837.name,
                this._switchViewContainer.name
            ], 0, 0);
            this._window.height = Util.getLowestPoint(this._window) + 4;
            this._window.visible = true;
        }

        private function populateForm(): void
        {
            var _loc4_: IRadioButtonWindow;
            var _loc5_: IRadioButtonWindow;
            var _loc6_: Number;
            var _loc7_: uint;
            var _loc8_: ITextWindow;
            if (!this.var_3823)
            {
                return;
            }

            this.var_3823 = false;
            var _loc1_: RoomSettingsData = this._roomSettings;
            this.var_3825.setText(_loc1_.name);
            this.var_3826.setText(_loc1_.description);
            this.var_3827.setText("");
            this.var_3828.setText("");
            var _loc2_: ISelectorWindow = this._window.findChildByName("doormode") as ISelectorWindow;
            var _loc3_: IRadioButtonWindow = this._window.findChildByName("doormode_password") as IRadioButtonWindow;
            switch (_loc1_.doorMode)
            {
                case RoomSettingsData.DOOR_STATE_DOORBELL:
                    _loc4_ = (this._window.findChildByName("doormode_doorbell") as IRadioButtonWindow);
                    _loc2_.setSelected(_loc4_);
                    break;
                case RoomSettingsData.DOOR_STATE_PASSWORD:
                    _loc2_.setSelected(_loc3_);
                    break;
                default:
                    _loc5_ = (this._window.findChildByName("doormode_open") as IRadioButtonWindow);
                    _loc2_.setSelected(_loc5_);
            }

            this.changePasswordField(_loc1_.doorMode == RoomSettingsData.DOOR_STATE_PASSWORD);
            Logger.log("CATEGORY ID: " + _loc1_.categoryId);
            this.setCategorySelection(_loc1_.categoryId);
            this.refreshMaxVisitors(_loc1_);
            this.setTag(this.var_3741, _loc1_.tags[0]);
            this.setTag(this.var_3742, _loc1_.tags[1]);
            if (this.var_3829)
            {
                if (_loc1_.allowPets)
                {
                    this.var_3829.select();
                }
                else
                {
                    this.var_3829.unselect();
                }

            }

            if (this.var_3830)
            {
                if (_loc1_.allowFoodConsume)
                {
                    this.var_3830.select();
                }
                else
                {
                    this.var_3830.unselect();
                }

            }

            if (this.var_3831)
            {
                if (_loc1_.allowWalkThrough)
                {
                    this.var_3831.select();
                }
                else
                {
                    this.var_3831.unselect();
                }

            }

            if (this.var_3832)
            {
                if (_loc1_.hideWalls)
                {
                    this.var_3832.select();
                }
                else
                {
                    this.var_3832.unselect();
                }

                _loc6_ = 1;
                _loc7_ = 0xFFFFFF;
                if (!this.hideWallsAllowed())
                {
                    this.var_3832.disable();
                    _loc6_ = 0.5;
                    _loc7_ = 0x808080;
                }
                else
                {
                    this.var_3832.enable();
                }

                this.var_3832.blend = _loc6_;
                _loc8_ = (this._window.findChildByName("hide_walls_text") as ITextWindow);
                if (_loc8_)
                {
                    _loc8_.textColor = _loc7_;
                }

            }

            this.clearErrors();
        }

        private function hideWallsAllowed(): Boolean
        {
            return this._navigator.sessionData.hasUserRight("fuse_hide_room_walls", HabboClubLevelEnum.HC_LEVEL_VIP);
        }

        private function setTag(param1: TextFieldManager, param2: String): void
        {
            param1.setText(param2 == null ? "" : param2);
        }

        private function refreshMaxVisitors(param1: RoomSettingsData): void
        {
            var _loc2_: Array = [];
            var _loc3_: int = -1;
            var _loc4_: int;
            var _loc5_: int = 10;
            while (_loc5_ <= param1.maximumVisitorsLimit)
            {
                _loc2_.push("" + _loc5_);
                if (_loc5_ == param1.maximumVisitors)
                {
                    _loc3_ = _loc4_;
                }

                _loc4_++;
                _loc5_ = _loc5_ + 5;
            }

            var _loc6_: IDropMenuWindow = this._window.findChildByName("maxvisitors") as IDropMenuWindow;
            _loc6_.populate(_loc2_);
            _loc6_.selection = _loc3_ > -1 ? _loc3_ : 0;
        }

        private function setCategorySelection(param1: int): void
        {
            var _loc6_: FlatCategory;
            var _loc2_: IDropMenuWindow = this._window.findChildByName("categories") as IDropMenuWindow;
            var _loc3_: Array = [];
            var _loc4_: int;
            var _loc5_: int;
            for each (_loc6_ in this._navigator.data.allCategories)
            {
                if (_loc6_.visible || param1 == _loc6_.nodeId)
                {
                    _loc3_.push(_loc6_.nodeName);
                    if (param1 == _loc6_.nodeId)
                    {
                        _loc4_ = _loc5_;
                    }

                    _loc5_++;
                }

            }

            _loc2_.populate(_loc3_);
            _loc2_.selection = _loc4_;
        }

        private function getFlatCategoryByIndex(param1: int, param2: int): FlatCategory
        {
            var _loc4_: FlatCategory;
            var _loc3_: int;
            for each (_loc4_ in this._navigator.data.allCategories)
            {
                if (_loc4_.visible || param1 == _loc4_.nodeId)
                {
                    if (param2 == _loc3_)
                    {
                        return _loc4_;
                    }

                    _loc3_++;
                }

            }

            return null;
        }

        private function onEditThumbnailButtonClick(param1: WindowMouseEvent): void
        {
            this._navigator.roomInfoViewCtrl.startThumbnailEdit();
        }

        private function onSwitchView(param1: WindowEvent): void
        {
            this.var_3824 = !this.var_3824;
            this.var_2197.roomSettingsRefreshNeeded();
        }

        private function onSaveButtonClick(param1: WindowMouseEvent): void
        {
            var _loc8_: String;
            var _loc9_: String;
            if (this._roomSettings == null || this._window == null || this._window.disposed)
            {
                return;
            }

            var _loc2_: SaveableRoomSettingsData = new SaveableRoomSettingsData();
            _loc2_.roomId = this._roomSettings.roomId;
            _loc2_.name = this.var_3825.getText();
            _loc2_.description = this.var_3826.getText();
            var _loc3_: ISelectorWindow = this._window.findChildByName("doormode") as ISelectorWindow;
            var _loc4_: IWindow = _loc3_.getSelected();
            switch (_loc4_.name)
            {
                case "doormode_doorbell":
                    _loc2_.doorMode = RoomSettingsFlatInfo.DOOR_MODE_DOORBELL;
                    break;
                case "doormode_password":
                    _loc2_.doorMode = RoomSettingsFlatInfo.DOOR_MODE_PASSWORD;
                    break;
                default:
                    _loc2_.doorMode = RoomSettingsFlatInfo.DOOR_MODE_OPEN;
            }

            if (_loc2_.doorMode == RoomSettingsFlatInfo.DOOR_MODE_PASSWORD)
            {
                _loc8_ = this.var_3827.getText();
                _loc9_ = this.var_3828.getText();
                if (_loc8_ != _loc9_)
                {
                    this.var_3827.clearErrors();
                    this.var_3828.displayError("${navigator.roomsettings.invalidconfirm}");
                    return;
                }

                if (_loc8_ != "")
                {
                    _loc2_.password = _loc8_;
                }

            }

            var _loc5_: IDropMenuWindow = this._window.findChildByName("categories") as IDropMenuWindow;
            var _loc6_: FlatCategory = this.getFlatCategoryByIndex(this._roomSettings.categoryId, _loc5_.selection);
            _loc2_.categoryId = _loc6_.nodeId;
            var _loc7_: IDropMenuWindow = this._window.findChildByName("maxvisitors") as IDropMenuWindow;
            _loc2_.maximumVisitors = 10 + _loc7_.selection * 5;
            _loc2_.allowPets = this.var_3829.isSelected;
            _loc2_.allowFoodConsume = this.var_3830.isSelected;
            _loc2_.allowWalkThrough = this.var_3831.isSelected;
            _loc2_.hideWalls = this.var_3832.isSelected;
            _loc2_.tags = [];
            this.addTag(this.var_3741, _loc2_.tags);
            this.addTag(this.var_3742, _loc2_.tags);
            this.clearErrors();
            this.var_3822 = _loc2_.roomId;
            this._navigator.send(new SaveRoomSettingsMessageComposer(_loc2_));
        }

        private function addTag(param1: TextFieldManager, param2: Array): void
        {
            if (param1.getText() != "")
            {
                param2.push(param1.getText());
            }

        }

        private function onCancelButtonClick(param1: WindowMouseEvent): void
        {
            this.close();
            this.var_2197.roomSettingsRefreshNeeded();
        }

        private function onDeleteButtonClick(param1: WindowMouseEvent): void
        {
            Logger.log("[RoomSettingsCtrl.onDeleteButtonClick] " + this._roomId);
            this._navigator.registerParameter("navigator.roomsettings.deleteroom.confirm.message", "room_name", this._roomSettings.name);
            var _loc2_: ConfirmDialogView = new ConfirmDialogView(IFrameWindow(this._navigator.getXmlWindow("ros_room_delete_confirm")), this, this.onConfirmRoomDelete, [this._roomId]);
            _loc2_.show();
        }

        private function onConfirmRoomDelete(param1: WindowMouseEvent, param2: int): void
        {
            var _loc3_: GuestRoomSearchResultData;
            this._navigator.send(new DeleteRoomMessageComposer(param2));
            this.close();
            this.var_2197.roomSettingsRefreshNeeded();
            if (this._navigator.data.guestRoomSearchResults != null)
            {
                _loc3_ = this._navigator.data.guestRoomSearchResults;
                this._navigator.mainViewCtrl.startSearch(this._navigator.tabs.getSelected().id, _loc3_.searchType, _loc3_.searchParam);
            }

            this._navigator.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_306, HabboToolbarIconEnum.ROOMINFO));
        }

        private function onDoorModePasswordSelect(param1: WindowEvent): void
        {
            this.changePasswordField(true);
        }

        private function onDoorModePasswordUnselect(param1: WindowEvent): void
        {
            this.changePasswordField(false);
        }

        private function changePasswordField(param1: Boolean): void
        {
            this.var_3839.visible = param1;
            this.var_2197.roomSettingsRefreshNeeded();
        }

        private function refreshFlatControllers(): void
        {
            var _loc10_: FlatControllerData;
            var _loc1_: IWindowContainer = IWindowContainer(this.var_3838.findChildByName("flat_controller_list"));
            var _loc2_: IButtonWindow = IButtonWindow(this.var_3838.findChildByName("remove_flat_ctrl"));
            var _loc3_: IButtonWindow = IButtonWindow(this.var_3838.findChildByName("remove_all_flat_ctrls"));
            var _loc4_: IWindow = this.var_3838.findChildByName("flat_ctrls_caption_txt");
            var _loc5_: IWindow = this.var_3838.findChildByName("flat_ctrls_info_txt");
            var _loc6_: IWindow = this.var_3838.findChildByName("flat_ctrls_limit_txt");
            var _loc7_: IWindowContainer = IWindowContainer(this.var_3838.findChildByName("flat_controllers_footer"));
            Util.hideChildren(this.var_3838);
            this.var_3838.findChildByName("ruler").visible = true;
            this._navigator.registerParameter("navigator.roomsettings.flatctrls.caption", "cnt", "" + this._roomSettings.controllerCount);
            _loc4_.visible = true;
            Util.hideChildren(_loc1_);
            var _loc8_: Boolean;
            var _loc9_: int;
            while (_loc9_ < this._roomSettings.controllers.length)
            {
                _loc10_ = this._roomSettings.controllers[_loc9_];
                this.refreshFlatController(_loc1_, _loc9_, _loc10_);
                if (_loc10_.selected)
                {
                    _loc8_ = true;
                }

                _loc9_++;
            }

            Util.layoutChildrenInArea(_loc1_, _loc1_.width, 15);
            _loc1_.height = Util.getLowestPoint(_loc1_);
            if (this._roomSettings.controllers.length > 0)
            {
                _loc1_.visible = true;
                _loc7_.visible = true;
                _loc5_.visible = true;
                if (this._roomSettings.controllerCount > this._roomSettings.controllers.length)
                {
                    this._navigator.registerParameter("navigator.roomsettings.flatctrls.limitinfo", "cnt", "" + this._roomSettings.controllers.length);
                    _loc6_.visible = true;
                }

                Util.moveChildrenToColumn(this.var_3838, [
                    "flat_ctrls_caption_txt",
                    "flat_ctrls_limit_txt",
                    "flat_controller_list",
                    "flat_ctrls_info_txt",
                    "flat_controllers_footer"
                ], _loc4_.y, 5);
            }
            else
            {
                _loc7_.visible = false;
                _loc5_.visible = false;
                _loc7_.y = _loc1_.y + _loc1_.height + 5;
            }

            if (_loc8_)
            {
                _loc2_.enable();
            }
            else
            {
                _loc2_.disable();
            }

            this.var_3838.height = Util.getLowestPoint(this.var_3838);
        }

        private function refreshFlatController(param1: IWindowContainer, param2: int, param3: FlatControllerData): void
        {
            var _loc6_: ITextWindow;
            var _loc4_: String = "fc." + param2;
            var _loc5_: IWindowContainer = IWindowContainer(param1.getChildByName(_loc4_));
            if (param3 == null)
            {
                if (_loc5_ != null)
                {
                    _loc5_.visible = false;
                }

            }
            else
            {
                if (_loc5_ == null)
                {
                    _loc5_ = this.getFlatControllerContainer(_loc4_);
                    param1.addChild(_loc5_);
                    _loc5_.addChild(this._navigator.getXmlWindow("ros_flat_controller"));
                }

                _loc6_ = ITextWindow(_loc5_.findChildByName("flat_controller"));
                _loc6_.text = param3.userName;
                _loc6_.id = param3.userId;
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onFlatControllerClick);
                _loc6_.width = _loc6_.textWidth + 5;
                _loc5_.width = _loc6_.width + 3;
                _loc5_.height = _loc6_.height;
                _loc6_.color = param3.selected ? 0xFFFFFFFF : 4286216826;
                Logger.log("HUMP: " + param3.userName + ", " + param3.selected + ", " + _loc6_.textBackgroundColor);
                _loc5_.visible = true;
            }

        }

        private function getFlatControllerContainer(param1: String): IWindowContainer
        {
            return IWindowContainer(this._navigator.windowManager.createWindow(param1, "", HabboWindowType.var_182, HabboWindowStyle.var_525, HabboWindowParam.var_158, new Rectangle(0, 0, 100, 20)));
        }

        private function onFlatControllerClick(param1: WindowEvent): void
        {
            var _loc2_: ITextWindow = ITextWindow(param1.target);
            var _loc3_: int = _loc2_.id;
            Logger.log("FC clicked: " + _loc2_.name + ", " + _loc3_);
            var _loc4_: FlatControllerData = this.getFlatCtrl(_loc3_);
            if (_loc4_ == null)
            {
                Logger.log("Couldn't find fc: " + _loc3_);
                return;
            }

            _loc4_.selected = !_loc4_.selected;
            this.var_2197.roomSettingsRefreshNeeded();
        }

        private function getFlatCtrl(param1: int): FlatControllerData
        {
            var _loc2_: FlatControllerData;
            for each (_loc2_ in this._roomSettings.controllers)
            {
                if (_loc2_.userId == param1)
                {
                    return _loc2_;
                }

            }

            return null;
        }

        private function hasSelectedFlatCtrls(): Boolean
        {
            var _loc1_: FlatControllerData;
            for each (_loc1_ in this._roomSettings.controllers)
            {
                if (_loc1_.selected)
                {
                    return true;
                }

            }

            return false;
        }

        private function onRemoveAllFlatCtrlsClick(param1: WindowEvent): void
        {
            Logger.log("Remove all clicked: ");
            this._navigator.send(new RemoveAllRightsMessageComposer(this._roomId));
        }

        private function onRemoveFlatCtrlClick(param1: WindowEvent): void
        {
            var _loc3_: FlatControllerData;
            var _loc4_: RemoveRightsMessageComposer;
            Logger.log("Remove clicked: ");
            var _loc2_: Array = [];
            for each (_loc3_ in this._roomSettings.controllers)
            {
                if (_loc3_.selected)
                {
                    _loc2_.push(_loc3_.userId);
                }

            }

            _loc4_ = new RemoveRightsMessageComposer(_loc2_);
            this._navigator.send(_loc4_);
        }

    }
}
