package com.sulake.habbo.navigator.inroom
{
    import com.sulake.habbo.navigator.roomsettings.IRoomSettingsCtrlOwner;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailCtrl;
    import com.sulake.habbo.navigator.TagRenderer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import flash.events.TimerEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import flash.events.Event;
    import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.navigator.SimpleAlertView;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateNavigatorSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.navigator.*;

    public class RoomInfoViewCtrl implements IRoomSettingsCtrlOwner 
    {

        private var _navigator:HabboNavigator;
        private var _window:IWindowContainer;
        private var var_1997:IWindowContainer;
        private var var_3754:int;
        private var var_3755:RoomEventViewCtrl;
        private var var_3753:Timer;
        private var var_3752:RoomSettingsCtrl;
        private var var_3756:RoomThumbnailCtrl;
        private var var_3757:TagRenderer;
        private var var_3758:IWindowContainer;
        private var var_3759:IWindowContainer;
        private var var_3760:IWindowContainer;
        private var var_3761:IWindowContainer;
        private var var_3762:IWindowContainer;
        private var var_3763:IWindowContainer;
        private var var_2970:ITextWindow;
        private var var_3764:ITextWindow;
        private var _ownerName:ITextWindow;
        private var var_3765:ITextWindow;
        private var var_3766:ITextWindow;
        private var var_3767:ITextWindow;
        private var var_3768:ITextWindow;
        private var var_3258:ITextWindow;
        private var var_3769:IWindowContainer;
        private var var_3770:IWindowContainer;
        private var var_3771:IWindowContainer;
        private var var_3010:ITextWindow;
        private var var_3772:ITextWindow;
        private var var_3773:IWindow;
        private var var_3774:IContainerButtonWindow;
        private var var_3775:IContainerButtonWindow;
        private var var_3776:IContainerButtonWindow;
        private var var_3777:IContainerButtonWindow;
        private var var_3778:IContainerButtonWindow;
        private var var_3779:IContainerButtonWindow;
        private var var_3780:IButtonWindow;
        private var var_3781:IButtonWindow;
        private var var_3782:IButtonWindow;
        private var var_3783:IWindowContainer;
        private var var_3784:ITextWindow;
        private var var_3785:ITextFieldWindow;
        private var _buttons:IWindowContainer;
        private var var_3786:IButtonWindow;
        private var var_3787:IButtonWindow;
        private var var_3788:String;
        private var var_3789:String;
        private var var_3790:Boolean = true;

        public function RoomInfoViewCtrl(param1:HabboNavigator)
        {
            this._navigator = param1;
            this.var_3755 = new RoomEventViewCtrl(this._navigator);
            this.var_3752 = new RoomSettingsCtrl(this._navigator, this, true);
            this.var_3756 = new RoomThumbnailCtrl(this._navigator);
            this.var_3757 = new TagRenderer(this._navigator);
            this._navigator.roomSettingsCtrls.push(this.var_3752);
            this.var_3753 = new Timer(6000, 1);
            this.var_3753.addEventListener(TimerEvent.TIMER, this.hideInfo);
        }

        public function dispose():void
        {
            if (this._navigator.toolbar)
            {
                this._navigator.toolbar.events.removeEventListener(HabboToolbarSetIconEvent.var_176, this.onToolbarIconState);
            };
            if (this.var_3753)
            {
                this.var_3753.removeEventListener(TimerEvent.TIMER, this.hideInfo);
                this.var_3753.reset();
                this.var_3753 = null;
            };
        }

        public function roomSettingsRefreshNeeded():void
        {
            this.refresh();
        }

        public function startEventEdit():void
        {
            this.var_3753.reset();
            this.var_3755.active = true;
            this.var_3752.active = false;
            this.var_3756.active = false;
            this.reload();
        }

        public function startRoomSettingsEdit(param1:int):void
        {
            this.var_3753.reset();
            this.var_3752.load(param1);
            this.var_3752.active = true;
            this.var_3755.active = false;
            this.var_3756.active = false;
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
        }

        public function backToRoomSettings():void
        {
            this.var_3752.active = true;
            this.var_3755.active = false;
            this.var_3756.active = false;
            this.reload();
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
        }

        public function startThumbnailEdit():void
        {
            this.var_3753.reset();
            this.var_3752.active = false;
            this.var_3755.active = false;
            this.var_3756.active = true;
            this.reload();
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS));
        }

        public function close():void
        {
            if (this.var_3790)
            {
                this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_435, HabboToolbarIconEnum.ROOMINFO, this._window, false));
            };
            if (this._window == null)
            {
                return;
            };
            this._window.visible = false;
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED));
        }

        public function reload():void
        {
            if (((!(this._window == null)) && (this._window.visible)))
            {
                this.refresh();
            };
        }

        public function open(param1:Boolean):void
        {
            this.var_3753.reset();
            this.var_3755.active = false;
            this.var_3752.active = false;
            this.var_3756.active = false;
            if (param1)
            {
                this.startRoomSettingsEdit(this._navigator.data.enteredGuestRoom.flatId);
            };
            this.refresh();
            this._window.visible = true;
            if (this.var_3790)
            {
                this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_146, HabboToolbarIconEnum.ROOMINFO, this._window, false));
            };
            this._window.parent.activate();
            this._window.activate();
            if (!param1)
            {
                this.var_3753.start();
            };
        }

        public function toggle():void
        {
            this.var_3753.reset();
            this.var_3755.active = false;
            this.var_3752.active = false;
            this.var_3756.active = false;
            this.refresh();
            if (this.var_3790)
            {
                if (!this._window.visible)
                {
                    this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_146, HabboToolbarIconEnum.ROOMINFO, this._window, false));
                    this._window.parent.activate();
                }
                else
                {
                    this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_433, HabboToolbarIconEnum.ROOMINFO, this._window, false));
                };
            }
            else
            {
                this._window.visible = (!(this._window.visible));
                this._window.center();
            };
        }

        private function refresh():void
        {
            var _loc1_:int;
            this.prepareWindow();
            this.refreshRoom();
            this.refreshEvent();
            this.refreshEmbed();
            this.refreshButtons();
            if (this.var_3790)
            {
                Util.moveChildrenToColumn(this._window, ["room_info", "event_info", "embed_info", "buttons_container"], 0, 2);
                this._window.height = Util.getLowestPoint(this._window);
                this._window.y = ((this._window.desktop.height - this._window.height) - 5);
                Logger.log(((((("MAIN: " + this.var_3758.rectangle) + ", ") + this.var_3769.rectangle) + ", ") + this._window.rectangle));
            }
            else
            {
                Util.moveChildrenToColumn(this.var_1997, ["room_info", "event_info", "embed_info", "buttons_container"], 0, 2);
                this.var_1997.height = Util.getLowestPoint(this.var_1997);
                _loc1_ = (this._window.desktop.height - this._window.height);
                if (this._window.y > _loc1_)
                {
                    this._window.y = ((_loc1_ < 0) ? 0 : _loc1_);
                };
            };
        }

        private function refreshRoom():void
        {
            Util.hideChildren(this.var_3758);
            if (this.var_3790)
            {
                this.var_3758.findChildByName("close").visible = true;
            };
            var _loc1_:GuestRoomData = this._navigator.data.enteredGuestRoom;
            var _loc2_:Boolean = ((!(_loc1_ == null)) && (_loc1_.flatId == this._navigator.data.homeRoomId));
            this.refreshRoomDetails(_loc1_, _loc2_);
            this.refreshPublicSpaceDetails(this._navigator.data.enteredPublicSpace);
            this.refreshRoomButtons(_loc2_);
            this.var_3752.refresh(this.var_3758);
            this.var_3756.refresh(this.var_3758);
            Util.moveChildrenToColumn(this.var_3758, ["room_details", "room_buttons"], 0, 2);
            this.var_3758.height = Util.getLowestPoint(this.var_3758);
            this.var_3758.visible = true;
            Logger.log(((((((((("XORP: " + this.var_3759.visible) + ", ") + this.var_3763.visible) + ", ") + this.var_3760.visible) + ", ") + this.var_3760.rectangle) + ", ") + this.var_3758.rectangle));
        }

        private function refreshEvent():void
        {
            Util.hideChildren(this.var_3769);
            var _loc1_:RoomEventData = this._navigator.data.roomEventData;
            this.refreshEventDetails(_loc1_);
            this.refreshEventButtons(_loc1_);
            this.var_3755.refresh(this.var_3769);
            if (((Util.hasVisibleChildren(this.var_3769)) && (!((this.var_3752.active) || (this.var_3756.active)))))
            {
                Util.moveChildrenToColumn(this.var_3769, ["event_details", "event_buttons"], 0, 2);
                this.var_3769.height = Util.getLowestPoint(this.var_3769);
                this.var_3769.visible = true;
            }
            else
            {
                this.var_3769.visible = false;
            };
            Logger.log(((("EVENT: " + this.var_3769.visible) + ", ") + this.var_3769.rectangle));
        }

        private function refreshEmbed():void
        {
            var _loc1_:* = (this._navigator.configuration.getKey("embed.showInRoomInfo", "false") == "true");
            var _loc2_:* = (!(this._navigator.data.enteredGuestRoom == null));
            if ((((((_loc2_) && (_loc1_)) && (!(this.var_3752.active))) && (!(this.var_3756.active))) && (!(this.var_3755.active))))
            {
                this.var_3783.visible = true;
                this.var_3785.text = this.getEmbedData();
            }
            else
            {
                this.var_3783.visible = false;
            };
        }

        private function refreshButtons():void
        {
            var _loc1_:Boolean;
            if (!this._buttons)
            {
                return;
            };
            if (this.var_3752.active)
            {
                this._buttons.visible = false;
                return;
            };
            this._buttons.visible = true;
            if (this.var_3786)
            {
                if (this.var_3788 == "exit_homeroom")
                {
                    this.var_3786.caption = ("$" + "{navigator.homeroom}");
                }
                else
                {
                    this.var_3786.caption = ("$" + "{navigator.hotelview}");
                };
            };
            if (this.var_3787)
            {
                _loc1_ = (!(this._navigator.data.enteredGuestRoom == null));
                this.var_3787.visible = _loc1_;
                if (this.var_3789 == "0")
                {
                    this.var_3787.caption = ("$" + "{navigator.zoom.in}");
                }
                else
                {
                    this.var_3787.caption = ("$" + "{navigator.zoom.out}");
                };
            };
        }

        private function refreshRoomDetails(param1:GuestRoomData, param2:Boolean):void
        {
            if ((((param1 == null) || (this.var_3752.active)) || (this.var_3756.active)))
            {
                return;
            };
            this.var_2970.text = param1.roomName;
            this.var_2970.height = (this.var_2970.textHeight + 5);
            this._ownerName.text = param1.ownerName;
            this.var_3765.text = param1.description;
            this.var_3757.refreshTags(this.var_3759, param1.tags);
            this.var_3765.visible = false;
            if (param1.description != "")
            {
                this.var_3765.height = (this.var_3765.textHeight + 5);
                this.var_3765.visible = true;
            };
            var _loc3_:Boolean = Boolean((this._navigator.configuration.getKey("client.allow.facebook.like") == "1"));
            this._navigator.refreshButton(this.var_3775, "facebook_logo_small", _loc3_, null, 0);
            this.var_3775.visible = _loc3_;
            var _loc4_:* = (this._navigator.data.currentRoomRating == -1);
            this._navigator.refreshButton(this.var_3774, "thumb_up", _loc4_, null, 0);
            this.var_3774.visible = _loc4_;
            this.var_3768.visible = (!(_loc4_));
            this.var_3258.visible = (!(_loc4_));
            this.var_3258.text = ("" + this._navigator.data.currentRoomRating);
            this.refreshStuffPick();
            this._navigator.refreshButton(this.var_3759, "home", param2, null, 0);
            this._navigator.refreshButton(this.var_3759, "favourite", ((!(param2)) && (this._navigator.data.isCurrentRoomFavourite())), null, 0);
            Util.moveChildrenToColumn(this.var_3759, ["room_name", "owner_name_cont", "tags", "room_desc", "rating_cont", "staff_pick_button"], this.var_2970.y, 0);
            this.var_3759.visible = true;
            this.var_3759.height = Util.getLowestPoint(this.var_3759);
        }

        private function refreshStuffPick():void
        {
            var _loc1_:IWindow = this.var_3759.findChildByName("staff_pick_button");
            if (!this._navigator.data.roomPicker)
            {
                _loc1_.visible = false;
                return;
            };
            _loc1_.visible = true;
            _loc1_.caption = this._navigator.getText(((this._navigator.data.currentRoomIsStaffPick) ? "navigator.staffpicks.unpick" : "navigator.staffpicks.pick"));
        }

        private function refreshPublicSpaceDetails(param1:PublicRoomShortData):void
        {
            if ((((param1 == null) || (this.var_3752.active)) || (this.var_3756.active)))
            {
                return;
            };
            this.var_3764.text = this._navigator.getPublicSpaceName(param1.unitPropertySet, param1.worldId);
            this.var_3764.height = (this.var_3764.textHeight + 5);
            this.var_3766.text = this._navigator.getPublicSpaceDesc(param1.unitPropertySet, param1.worldId);
            this.var_3766.height = (this.var_3766.textHeight + 5);
            Util.moveChildrenToColumn(this.var_3760, ["public_space_name", "public_space_desc"], this.var_3764.y, 0);
            this.var_3760.visible = true;
            this.var_3760.height = Math.max(86, Util.getLowestPoint(this.var_3760));
        }

        private function refreshEventDetails(param1:RoomEventData):void
        {
            if (((param1 == null) || (this.var_3755.active)))
            {
                return;
            };
            this.var_3010.text = param1.eventName;
            this.var_3772.text = param1.eventDescription;
            this.var_3757.refreshTags(this.var_3770, [this._navigator.getText(("roomevent_type_" + param1.eventType)), param1.tags[0], param1.tags[1]]);
            this.var_3772.visible = false;
            if (param1.eventDescription != "")
            {
                this.var_3772.height = (this.var_3772.textHeight + 5);
                this.var_3772.y = (Util.getLowestPoint(this.var_3770) + 2);
                this.var_3772.visible = true;
            };
            this.var_3770.visible = true;
            this.var_3770.height = Util.getLowestPoint(this.var_3770);
        }

        private function refreshRoomButtons(param1:Boolean):void
        {
            if ((((this._navigator.data.enteredGuestRoom == null) || (this.var_3752.active)) || (this.var_3756.active)))
            {
                return;
            };
            this.var_3780.visible = this._navigator.data.canEditRoomSettings;
            var _loc2_:Boolean = this._navigator.data.isCurrentRoomFavourite();
            this.var_3776.visible = ((this._navigator.data.canAddFavourite) && (!(_loc2_)));
            this.var_3777.visible = ((this._navigator.data.canAddFavourite) && (_loc2_));
            this.var_3778.visible = ((this._navigator.data.canEditRoomSettings) && (!(param1)));
            this.var_3779.visible = ((this._navigator.data.canEditRoomSettings) && (param1));
            this.var_3763.visible = Util.hasVisibleChildren(this.var_3763);
        }

        private function refreshEventButtons(param1:RoomEventData):void
        {
            if (this.var_3755.active)
            {
                return;
            };
            this.var_3781.visible = ((param1 == null) && (this._navigator.data.currentRoomOwner));
            this.var_3782.visible = ((!(param1 == null)) && ((this._navigator.data.currentRoomOwner) || (this._navigator.data.eventMod)));
            this.var_3771.visible = Util.hasVisibleChildren(this.var_3771);
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            if (this.var_3790)
            {
                this._window = IWindowContainer(this._navigator.getXmlWindow("iro_room_details"));
                this._window.setParamFlag(HabboWindowParam.var_158, false);
                this._window.setParamFlag(HabboWindowParam.var_799, true);
            }
            else
            {
                this._window = IWindowContainer(this._navigator.getXmlWindow("iro_room_details_framed"));
                this.var_1997 = (this._window.findChildByName("content") as IWindowContainer);
            };
            this._window.visible = false;
            this.var_3758 = IWindowContainer(this.find("room_info"));
            this.var_3759 = IWindowContainer(this.find("room_details"));
            this.var_3760 = IWindowContainer(this.find("public_space_details"));
            this.var_3761 = IWindowContainer(this.find("owner_name_cont"));
            this.var_3762 = IWindowContainer(this.find("rating_cont"));
            this.var_3763 = IWindowContainer(this.find("room_buttons"));
            this.var_2970 = ITextWindow(this.find("room_name"));
            this.var_3764 = ITextWindow(this.find("public_space_name"));
            this._ownerName = ITextWindow(this.find("owner_name"));
            this.var_3765 = ITextWindow(this.find("room_desc"));
            this.var_3766 = ITextWindow(this.find("public_space_desc"));
            this.var_3767 = ITextWindow(this.find("owner_caption"));
            this.var_3768 = ITextWindow(this.find("rating_caption"));
            this.var_3258 = ITextWindow(this.find("rating_txt"));
            this.var_3769 = IWindowContainer(this.find("event_info"));
            this.var_3770 = IWindowContainer(this.find("event_details"));
            this.var_3771 = IWindowContainer(this.find("event_buttons"));
            this.var_3010 = ITextWindow(this.find("event_name"));
            this.var_3772 = ITextWindow(this.find("event_desc"));
            this.var_3775 = IContainerButtonWindow(this.find("facebook_like_button"));
            this.var_3774 = IContainerButtonWindow(this.find("rate_up_button"));
            this.var_3773 = this.find("staff_pick_button");
            this.var_3776 = IContainerButtonWindow(this.find("add_favourite_button"));
            this.var_3777 = IContainerButtonWindow(this.find("rem_favourite_button"));
            this.var_3778 = IContainerButtonWindow(this.find("make_home_button"));
            this.var_3779 = IContainerButtonWindow(this.find("unmake_home_button"));
            this.var_3780 = IButtonWindow(this.find("room_settings_button"));
            this.var_3781 = IButtonWindow(this.find("create_event_button"));
            this.var_3782 = IButtonWindow(this.find("edit_event_button"));
            this.var_3783 = IWindowContainer(this.find("embed_info"));
            this.var_3784 = ITextWindow(this.find("embed_info_txt"));
            this.var_3785 = ITextFieldWindow(this.find("embed_src_txt"));
            this._buttons = IWindowContainer(this.find("buttons_container"));
            this.var_3786 = IButtonWindow(this.find("exit_room_button"));
            this.var_3787 = IButtonWindow(this.find("zoom_button"));
            Util.setProcDirectly(this.var_3776, this.onAddFavouriteClick);
            Util.setProcDirectly(this.var_3777, this.onRemoveFavouriteClick);
            Util.setProcDirectly(this.var_3780, this.onRoomSettingsClick);
            Util.setProcDirectly(this.var_3778, this.onMakeHomeClick);
            Util.setProcDirectly(this.var_3779, this.onUnmakeHomeClick);
            Util.setProcDirectly(this.var_3781, this.onEventSettingsClick);
            Util.setProcDirectly(this.var_3782, this.onEventSettingsClick);
            Util.setProcDirectly(this.var_3785, this.onEmbedSrcClick);
            Util.setProcDirectly(this.var_3774, this.onThumbUp);
            Util.setProcDirectly(this.var_3773, this.onStaffPick);
            Util.setProcDirectly(this.var_3775, this.onFacebookLike);
            Util.setProcDirectly(this.var_3787, this.onZoomClick);
            Util.setProcDirectly(this.var_3786, this.onExitRoomClick);
            this._navigator.refreshButton(this.var_3776, "favourite", true, null, 0);
            this._navigator.refreshButton(this.var_3777, "favourite", true, null, 0);
            this._navigator.refreshButton(this.var_3778, "home", true, null, 0);
            this._navigator.refreshButton(this.var_3779, "home", true, null, 0);
            if (this.var_3790)
            {
                this._window.findChildByName("close").procedure = this.onCloseButtonClick;
            }
            else
            {
                this._window.findChildByTag("close").procedure = this.onCloseButtonClick;
            };
            Util.setProcDirectly(this.var_3758, this.onHover);
            Util.setProcDirectly(this.var_3769, this.onHover);
            this.var_3767.width = this.var_3767.textWidth;
            Util.moveChildrenToRow(this.var_3761, ["owner_caption", "owner_name"], this.var_3767.x, this.var_3767.y, 3);
            this.var_3768.width = this.var_3768.textWidth;
            Util.moveChildrenToRow(this.var_3762, ["rating_caption", "rating_txt"], this.var_3768.x, this.var_3768.y, 3);
            this.var_3784.height = (this.var_3784.textHeight + 5);
            Util.moveChildrenToColumn(this.var_3783, ["embed_info_txt", "embed_src_txt"], this.var_3784.y, 2);
            this.var_3783.height = (Util.getLowestPoint(this.var_3783) + 5);
            this.var_3754 = (this._window.y + this._window.height);
        }

        private function find(param1:String):IWindow
        {
            var _loc2_:IWindow = this._window.findChildByName(param1);
            if (_loc2_ == null)
            {
                throw (new Error((("Window element with name: " + param1) + " cannot be found!")));
            };
            return (_loc2_);
        }

        private function getButtonsMinHeight():int
        {
            return ((this._navigator.data.currentRoomOwner) ? 0 : 21);
        }

        private function getRoomInfoMinHeight():int
        {
            return (37);
        }

        private function getEventInfoMinHeight():int
        {
            return (18);
        }

        public function onAddFavouriteClick(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:SimpleAlertView;
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            if (this._navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            if (this._navigator.data.isFavouritesFull())
            {
                _loc3_ = new SimpleAlertView(this._navigator, "${navigator.favouritesfull.title}", "${navigator.favouritesfull.body}");
                _loc3_.show();
            }
            else
            {
                this._navigator.send(new AddFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
            };
        }

        public function onRemoveFavouriteClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            if (this._navigator.data.enteredGuestRoom == null)
            {
                return;
            };
            this._navigator.send(new DeleteFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
        }

        private function onEventSettingsClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            if (this._navigator.data.roomEventData == null)
            {
                if (this._navigator.data.currentRoomOwner)
                {
                    this._navigator.send(new CanCreateEventMessageComposer());
                };
            }
            else
            {
                this.startEventEdit();
            };
        }

        private function onRoomSettingsClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:GuestRoomData = this._navigator.data.enteredGuestRoom;
            if (_loc3_ == null)
            {
                Logger.log("No entered room data?!");
                return;
            };
            this.startRoomSettingsEdit(_loc3_.flatId);
        }

        private function onMakeHomeClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:GuestRoomData = this._navigator.data.enteredGuestRoom;
            if (_loc3_ == null)
            {
                Logger.log("No entered room data?!");
                return;
            };
            Logger.log(("SETTING HOME ROOM TO: " + _loc3_.flatId));
            this._navigator.send(new UpdateNavigatorSettingsMessageComposer(_loc3_.flatId));
        }

        private function onUnmakeHomeClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("CLEARING HOME ROOM:");
            this._navigator.send(new UpdateNavigatorSettingsMessageComposer(0));
        }

        private function onCloseButtonClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.hideInfo(null);
        }

        private function onThumbUp(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this._navigator.send(new RateFlatMessageComposer(1));
        }

        private function onStaffPick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this._navigator.send(new ToggleStaffPickMessageComposer(this._navigator.data.enteredGuestRoom.flatId, this._navigator.data.currentRoomIsStaffPick));
        }

        private function onThumbDown(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this._navigator.send(new RateFlatMessageComposer(-1));
        }

        private function onFacebookLike(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            HabboWebTools.facebookLike(this._navigator.data.enteredGuestRoom.flatId);
        }

        private function onEmbedSrcClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_3785.setSelection(0, this.var_3785.text.length);
        }

        private function onZoomClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:HabboToolbarEvent = new HabboToolbarEvent(HabboToolbarEvent.var_49);
            _loc3_.iconId = HabboToolbarIconEnum.ZOOM;
            _loc3_.iconName = "ZOOM";
            this._navigator.toolbar.events.dispatchEvent(_loc3_);
        }

        private function onExitRoomClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:HabboToolbarEvent = new HabboToolbarEvent(HabboToolbarEvent.var_49);
            _loc3_.iconId = HabboToolbarIconEnum.EXITROOM;
            _loc3_.iconName = "EXITROOM";
            this._navigator.toolbar.events.dispatchEvent(_loc3_);
        }

        private function onToolbarIconState(param1:HabboToolbarSetIconEvent):void
        {
            if (param1.type != HabboToolbarSetIconEvent.var_176)
            {
                return;
            };
            switch (param1.iconId)
            {
                case HabboToolbarIconEnum.ZOOM:
                    this.var_3789 = param1.iconState;
                    this.refreshButtons();
                    return;
                case HabboToolbarIconEnum.EXITROOM:
                    this.var_3788 = param1.iconState;
                    this.refreshButtons();
                    return;
            };
        }

        private function onHover(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                return;
            };
            this.var_3753.reset();
        }

        private function hideInfo(param1:Event):void
        {
            if (this.var_3790)
            {
                this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_433, HabboToolbarIconEnum.ROOMINFO, this._window, false));
            }
            else
            {
                this._window.visible = false;
            };
        }

        private function getEmbedData():String
        {
            var _loc1_:String;
            var _loc2_:String;
            if (this._navigator.data.enteredGuestRoom != null)
            {
                _loc1_ = "private";
                _loc2_ = ("" + this._navigator.data.enteredGuestRoom.flatId);
            }
            else
            {
                _loc1_ = "public";
                _loc2_ = ("" + this._navigator.data.publicSpaceNodeId);
                Logger.log(("Node id is: " + _loc2_));
            };
            var _loc3_:String = this._navigator.configuration.getKey("user.hash", "");
            this._navigator.registerParameter("navigator.embed.src", "roomType", _loc1_);
            this._navigator.registerParameter("navigator.embed.src", "embedCode", _loc3_);
            this._navigator.registerParameter("navigator.embed.src", "roomId", _loc2_);
            return (this._navigator.getText("navigator.embed.src"));
        }

        public function registerToolbarEvents():void
        {
            if (this._navigator.toolbar)
            {
                this._navigator.toolbar.events.addEventListener(HabboToolbarSetIconEvent.var_176, this.onToolbarIconState);
            };
        }

        public function handleToolbarEvent(param1:HabboToolbarEvent):void
        {
            if (((!(this.var_3790)) || (!(param1.type == HabboToolbarEvent.var_49))))
            {
                return;
            };
            switch (param1.iconId)
            {
                case HabboToolbarIconEnum.MEMENU:
                    this.close();
                    return;
                case HabboToolbarIconEnum.ROOMINFO:
                    this.toggle();
                    return;
            };
        }

        public function configure():void
        {
            if (this._navigator.configuration)
            {
                this.var_3790 = (!(this._navigator.configuration.getKey("roominfo.widget.enabled") == "1"));
            };
        }

    }
}