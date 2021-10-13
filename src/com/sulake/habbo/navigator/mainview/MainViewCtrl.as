package com.sulake.habbo.navigator.mainview
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.navigator.domain.Tab;
    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.events.Event;
    import com.sulake.habbo.navigator.events.HabboNavigatorTrackingEvent;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTagSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.LatestEventsSearchMessageComposer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;

    public class MainViewCtrl implements IUpdateReceiver, IDisposable 
    {

        public static const var_828:int = 1;
        public static const var_829:int = 2;
        public static const var_830:int = 3;
        public static const var_831:int = 4;
        private static const var_833:int = 1;
        private static const var_832:int = 2;
        private static const var_843:int = 3;
        private static const var_844:int = 4;
        private static const SCROLLBAR_WIDTH:int = 22;

        private var _navigator:HabboNavigator;
        private var var_3431:IFrameWindow;
        private var var_1997:IWindowContainer;
        private var var_3798:IWindowContainer;
        private var var_3433:IWindowContainer;
        private var var_3799:IWindowContainer;
        private var var_3800:PopularTagsListCtrl;
        private var var_3801:GuestRoomListCtrl;
        private var var_3802:OfficialRoomListCtrl;
        private var var_3653:ITabContextWindow;
        private var var_3803:Boolean;
        private var var_3804:int;
        private var var_3805:Boolean = true;
        private var var_3806:int = 0;
        private var var_3807:IWindow;
        private var var_3808:IRegionWindow;
        private var var_3809:int = 0;
        private var var_3635:Timer;
        private var _disposed:Boolean = false;

        public function MainViewCtrl(param1:HabboNavigator):void
        {
            this._navigator = param1;
            this.var_3800 = new PopularTagsListCtrl(this._navigator);
            this.var_3801 = new GuestRoomListCtrl(this._navigator);
            this.var_3802 = new OfficialRoomListCtrl(this._navigator);
            this.var_3635 = new Timer(300, 1);
            this.var_3635.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function onNavigatorToolBarIconClick():Boolean
        {
            if (this.isOpen())
            {
                this.close();
                return (false);
            };
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.navigatorOpenedWhileInTab();
            return (true);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this._navigator = null;
                if (this.var_3431)
                {
                    this.var_3431.dispose();
                    this.var_3431 = null;
                };
                if (this.var_1997)
                {
                    this.var_1997.dispose();
                    this.var_1997 = null;
                };
                if (this.var_3635)
                {
                    this.var_3635.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                    this.var_3635.reset();
                    this.var_3635 = null;
                };
                if (this.var_3800)
                {
                    this.var_3800.dispose();
                    this.var_3800 = null;
                };
                if (this.var_3801)
                {
                    this.var_3801.dispose();
                    this.var_3801 = null;
                };
                if (this.var_3802)
                {
                    this.var_3802.dispose();
                    this.var_3802 = null;
                };
            };
        }

        public function open():void
        {
            var _loc1_:Boolean;
            if (this.var_3431 == null)
            {
                this.prepare();
                _loc1_ = true;
            };
            this.refresh();
            this.var_3431.visible = true;
            this.var_3431.activate();
            if (_loc1_)
            {
                this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_146, HabboToolbarIconEnum.NAVIGATOR, this.var_3431));
            };
        }

        public function isOpen():Boolean
        {
            return ((!(this.var_3431 == null)) && (this.var_3431.visible));
        }

        public function close():void
        {
            if (this.var_3431 != null)
            {
                this.var_3431.visible = false;
            };
        }

        public function get mainWindow():IFrameWindow
        {
            return (this.var_3431);
        }

        private function prepare():void
        {
            var _loc2_:Tab;
            var _loc3_:ITabButtonWindow;
            if (!this._navigator)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _navigator is null!");
            };
            this.var_3431 = IFrameWindow(this._navigator.getXmlWindow("grs_main_window"));
            if (!this.var_3431)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _mainWindow is null!");
            };
            this.var_3653 = ITabContextWindow(this.var_3431.findChildByName("tab_context"));
            if (!this.var_3653)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _tabContext is null!");
            };
            this.var_1997 = IWindowContainer(this.var_3431.findChildByName("tab_content"));
            this.var_3798 = IWindowContainer(this.var_3431.findChildByName("custom_content"));
            this.var_3799 = IWindowContainer(this.var_3431.findChildByName("list_content"));
            this.var_3433 = IWindowContainer(this.var_3431.findChildByName("custom_footer"));
            this.var_3807 = this.var_3431.findChildByName("loading_text");
            var _loc1_:IWindow = this.var_3431.findChildByTag("close");
            _loc1_.procedure = this.onWindowClose;
            this.var_3808 = IRegionWindow(this.var_3431.findChildByName("to_hotel_view"));
            if (!this.var_3808)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _toHotelView is null!");
            };
            this.var_3808.procedure = this.onHotelView;
            this.refreshToHotelViewButton(false);
            this.var_3431.procedure = this.onWindow;
            for each (_loc2_ in this._navigator.tabs.tabs)
            {
                _loc3_ = this.var_3653.getTabItemByID(_loc2_.id);
                if (!_loc3_)
                {
                    ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: but is null!");
                };
                _loc3_.setParamFlag(HabboWindowParam.var_157, true);
                _loc3_.procedure = this.onTabClick;
                _loc2_.button = _loc3_;
            };
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_821, false);
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_820, true);
        }

        public function refresh():void
        {
            if (this.var_3431 == null)
            {
                return;
            };
            this.refreshTab();
            this.refreshCustomContent();
            this.refreshListContent(true);
            this.refreshFooter();
            this.var_3798.height = Util.getLowestPoint(this.var_3798);
            this.var_3433.height = Util.getLowestPoint(this.var_3433);
            var _loc1_:int = this.var_3799.y;
            Util.moveChildrenToColumn(this.var_1997, ["custom_content", "list_content"], this.var_3798.y, 8);
            this.var_3799.height = ((((this.var_3799.height + _loc1_) - this.var_3799.y) - this.var_3433.height) + this.var_3809);
            Util.moveChildrenToColumn(this.var_1997, ["list_content", "custom_footer"], this.var_3799.y, 0);
            this.var_3809 = this.var_3433.height;
            this.onResizeTimer(null);
        }

        private function refreshTab():void
        {
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            var _loc2_:ISelectableWindow = this.var_3653.selector.getSelected();
            if (_loc1_.button != _loc2_)
            {
                this.var_3803 = true;
                this.var_3653.selector.setSelected(_loc1_.button);
            };
        }

        private function refreshCustomContent():void
        {
            Util.hideChildren(this.var_3798);
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.refreshCustomContent(this.var_3798);
            if (Util.hasVisibleChildren(this.var_3798))
            {
                this.var_3798.visible = true;
            }
            else
            {
                this.var_3798.visible = false;
                this.var_3798.blend = 1;
            };
        }

        private function refreshFooter():void
        {
            Util.hideChildren(this.var_3433);
            var _loc1_:Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.refreshFooter(this.var_3433);
            if (Util.hasVisibleChildren(this.var_3433))
            {
                this.var_3433.visible = true;
            }
            else
            {
                this.var_3433.visible = false;
            };
        }

        private function refreshListContent(param1:Boolean):void
        {
            Util.hideChildren(this.var_3799);
            this.refreshGuestRooms(param1, this._navigator.data.guestRoomSearchArrived);
            this.refreshPopularTags(param1, this._navigator.data.popularTagsArrived);
            this.refreshOfficialRooms(param1, this._navigator.data.officialRoomsArrived);
        }

        private function refreshGuestRooms(param1:Boolean, param2:Boolean):void
        {
            this.refreshList(param1, param2, this.var_3801, "guest_rooms");
        }

        private function refreshPopularTags(param1:Boolean, param2:Boolean):void
        {
            this.refreshList(param1, param2, this.var_3800, "popular_tags");
        }

        private function refreshOfficialRooms(param1:Boolean, param2:Boolean):void
        {
            this.refreshList(param1, param2, this.var_3802, "official_rooms");
        }

        private function refreshList(param1:Boolean, param2:Boolean, param3:IViewCtrl, param4:String):void
        {
            var _loc5_:IWindow;
            if (!param2)
            {
                return;
            };
            if (param3.content == null)
            {
                _loc5_ = this.var_3799.getChildByName(param4);
                param3.content = IWindowContainer(_loc5_);
            };
            if (param1)
            {
                param3.refresh();
            };
            param3.content.visible = true;
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Close window");
            this.close();
        }

        private function onTabClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowEvent.var_560)
            {
                return;
            };
            var _loc3_:int = param2.id;
            if (this.var_3803)
            {
                this.var_3803 = false;
                return;
            };
            var _loc4_:Tab = this._navigator.tabs.getTab(_loc3_);
            _loc4_.sendSearchRequest();
            switch (_loc4_.id)
            {
                case Tabs.var_163:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS));
                    return;
                case Tabs.var_162:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME));
                    return;
                case Tabs.var_161:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL));
                    return;
                case Tabs.var_160:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS));
                    return;
                case Tabs.var_164:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH));
                    return;
            };
        }

        public function reloadRoomList(param1:int):Boolean
        {
            ErrorReportStorage.addDebugData("MainViewCtrl", "Reloading RoomList");
            if ((((this.isOpen()) && (!(this._navigator.data.guestRoomSearchResults == null))) && (this._navigator.data.guestRoomSearchResults.searchType == param1)))
            {
                this.startSearch(this._navigator.tabs.getSelected().id, param1, "");
                return (true);
            };
            return (false);
        }

        public function startSearch(param1:int, param2:int, param3:String="-1", param4:int=1):void
        {
            var _loc5_:Tab = this._navigator.tabs.getSelected();
            this._navigator.tabs.setSelectedTab(param1);
            var _loc6_:Tab = this._navigator.tabs.getSelected();
            ErrorReportStorage.addDebugData("StartSearch", ((("Start search " + _loc5_.id) + " => ") + _loc6_.id));
            this.var_3805 = (!(_loc5_ == _loc6_));
            if (_loc5_ != _loc6_)
            {
                _loc6_.tabPageDecorator.tabSelected();
            };
            this._navigator.data.startLoading();
            if (param4 == var_828)
            {
                this._navigator.send(this.getSearchMsg(param2, param3));
            }
            else
            {
                if (param4 == var_829)
                {
                    this._navigator.send(new GetPopularRoomTagsMessageComposer());
                }
                else
                {
                    this._navigator.send(new GetOfficialRoomsMessageComposer());
                };
            };
            if (!this.isOpen())
            {
                this.open();
                this.var_3804 = var_832;
                this.var_3799.blend = 0;
                if (this.var_3798.visible)
                {
                    this.var_3798.blend = 0;
                    this.var_3433.blend = 0;
                };
            }
            else
            {
                this.var_3804 = var_833;
            };
            this.var_3806 = 0;
            this._navigator.registerUpdateReceiver(this, 2);
            this.sendTrackingEvent(param2);
        }

        private function sendTrackingEvent(param1:int):void
        {
            switch (param1)
            {
                case Tabs.var_834:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS));
                    return;
                case Tabs.var_835:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES));
                    return;
                case Tabs.var_836:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS));
                    return;
                case Tabs.var_837:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY));
                    return;
                case Tabs.var_166:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS));
                    return;
                case Tabs.var_838:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS));
                    return;
                case Tabs.var_839:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS));
                    return;
                case Tabs.var_840:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE));
                    return;
                case Tabs.var_841:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE));
                    return;
                case Tabs.var_165:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH));
                    return;
                case Tabs.var_842:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH));
                    return;
            };
        }

        private function getSearchMsg(param1:int, param2:String):IMessageComposer
        {
            if (param1 == Tabs.var_835)
            {
                return (new MyFavouriteRoomsSearchMessageComposer());
            };
            if (param1 == Tabs.var_836)
            {
                return (new MyFriendsRoomsSearchMessageComposer());
            };
            if (param1 == Tabs.var_837)
            {
                return (new MyRoomHistorySearchMessageComposer());
            };
            if (param1 == Tabs.var_166)
            {
                return (new MyRoomsSearchMessageComposer());
            };
            if (param1 == Tabs.var_839)
            {
                return (new PopularRoomsSearchMessageComposer(param2, this._navigator.data.adIndex));
            };
            if (param1 == Tabs.var_840)
            {
                return (new RoomsWhereMyFriendsAreSearchMessageComposer());
            };
            if (param1 == Tabs.var_841)
            {
                return (new RoomsWithHighestScoreSearchMessageComposer(this._navigator.data.adIndex));
            };
            if (param1 == Tabs.var_165)
            {
                return (new RoomTagSearchMessageComposer(param2));
            };
            if (param1 == Tabs.var_842)
            {
                return (new RoomTextSearchMessageComposer(param2));
            };
            if (param1 == Tabs.var_834)
            {
                return (new LatestEventsSearchMessageComposer(param2, this._navigator.data.adIndex));
            };
            Logger.log(("No message for searchType: " + param1));
            return (null);
        }

        public function update(param1:uint):void
        {
            var _loc3_:Number;
            if (this.var_3799 == null)
            {
                return;
            };
            var _loc2_:Number = (param1 / 150);
            if (this.var_3804 == var_833)
            {
                _loc3_ = Math.min(1, Math.max(0, (this.var_3799.blend - _loc2_)));
                this.var_3799.blend = _loc3_;
                this.var_3798.blend = ((this.var_3805) ? _loc3_ : 1);
                this.var_3433.blend = ((this.var_3805) ? _loc3_ : 1);
                if (_loc3_ == 0)
                {
                    this.var_3804 = var_832;
                };
            }
            else
            {
                if (this.var_3804 == var_832)
                {
                    if ((this.var_3806 % 10) == 1)
                    {
                        this.var_3807.visible = (!(this.var_3807.visible));
                    };
                    this.var_3806++;
                    if (!this._navigator.data.isLoading())
                    {
                        this.var_3804 = var_843;
                    };
                }
                else
                {
                    if (this.var_3804 == var_843)
                    {
                        this.refresh();
                        this.var_3804 = var_844;
                    }
                    else
                    {
                        this.var_3807.visible = false;
                        _loc3_ = Math.min(1, Math.max(0, (this.var_3799.blend + _loc2_)));
                        this.var_3799.blend = _loc3_;
                        this.var_3798.blend = ((this.var_3805) ? _loc3_ : 1);
                        this.var_3433.blend = ((this.var_3805) ? _loc3_ : 1);
                        if (this.var_3799.blend >= 1)
                        {
                            this._navigator.removeUpdateReceiver(this);
                        };
                    };
                };
            };
        }

        private function onWindow(param1:WindowEvent, param2:IWindow):void
        {
            if (((!(param1.type == WindowEvent.var_573)) || (!(param2 == this.var_3431))))
            {
                return;
            };
            if (!this.var_3635.running)
            {
                this.var_3635.reset();
                this.var_3635.start();
            };
        }

        private function onResizeTimer(param1:TimerEvent):void
        {
            this.refreshScrollbar(this.var_3800);
            this.refreshScrollbar(this.var_3801);
        }

        private function refreshScrollbar(param1:IViewCtrl):void
        {
            if (((param1.content == null) || (!(param1.content.visible))))
            {
                return;
            };
            var _loc2_:IItemListWindow = IItemListWindow(param1.content.findChildByName("item_list"));
            var _loc3_:IWindow = param1.content.findChildByName("scroller");
            var _loc4_:* = (_loc2_.scrollableRegion.height > _loc2_.height);
            if (_loc3_.visible)
            {
                if (_loc4_)
                {
                    return;
                };
                _loc3_.visible = false;
                _loc2_.width = (_loc2_.width + SCROLLBAR_WIDTH);
            }
            else
            {
                if (_loc4_)
                {
                    _loc3_.visible = true;
                    _loc2_.width = (_loc2_.width - SCROLLBAR_WIDTH);
                }
                else
                {
                    return;
                };
            };
        }

        public function stretchNewEntryIfNeeded(param1:IViewCtrl, param2:IWindowContainer):void
        {
            var _loc3_:IWindow = param1.content.findChildByName("scroller");
            if (_loc3_.visible)
            {
                return;
            };
            param2.width = (param2.width + SCROLLBAR_WIDTH);
        }

        private function refreshToHotelViewButton(param1:Boolean):void
        {
            this._navigator.refreshButton(this.var_3808, "icon_hotelview", (!(param1)), null, 0);
            this._navigator.refreshButton(this.var_3808, "icon_hotelview_reactive", param1, null, 0);
        }

        private function onHotelView(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                this.refreshToHotelViewButton(true);
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_626)
                {
                    this.refreshToHotelViewButton(false);
                }
                else
                {
                    if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                    {
                        this._navigator.send(new QuitMessageComposer());
                    };
                };
            };
        }

    }
}