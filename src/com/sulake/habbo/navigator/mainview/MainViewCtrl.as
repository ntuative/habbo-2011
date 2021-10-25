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

        public static const var_828: int = 1;
        public static const var_829: int = 2;
        public static const var_830: int = 3;
        public static const var_831: int = 4;
        private static const var_833: int = 1;
        private static const var_832: int = 2;
        private static const var_843: int = 3;
        private static const var_844: int = 4;
        private static const SCROLLBAR_WIDTH: int = 22;

        private var _navigator: HabboNavigator;
        private var _mainWindow: IFrameWindow;
        private var _tabContent: IWindowContainer;
        private var _customContent: IWindowContainer;
        private var _customFooter: IWindowContainer;
        private var _listContent: IWindowContainer;
        private var _popularTagsListCtrl: PopularTagsListCtrl;
        private var _guestRoomListCtrl: GuestRoomListCtrl;
        private var _officialRoomsListCtrl: OfficialRoomListCtrl;
        private var _tabContext: ITabContextWindow;
        private var var_3803: Boolean;
        private var _blend: int;
        private var _focused: Boolean = true;
        private var _alpha: int = 0;
        private var _loadingText: IWindow;
        private var _toHotelView: IRegionWindow;
        private var _offsetHeight: int = 0;
        private var _timer: Timer;
        private var _disposed: Boolean = false;

        public function MainViewCtrl(param1: HabboNavigator): void
        {
            this._navigator = param1;
            this._popularTagsListCtrl = new PopularTagsListCtrl(this._navigator);
            this._guestRoomListCtrl = new GuestRoomListCtrl(this._navigator);
            this._officialRoomsListCtrl = new OfficialRoomListCtrl(this._navigator);
            this._timer = new Timer(300, 1);
            this._timer.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function onNavigatorToolBarIconClick(): Boolean
        {
            if (this.isOpen())
            {
                this.close();
                return false;
            }

            var _loc1_: Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.navigatorOpenedWhileInTab();
            return true;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this._navigator = null;
                if (this._mainWindow)
                {
                    this._mainWindow.dispose();
                    this._mainWindow = null;
                }

                if (this._tabContent)
                {
                    this._tabContent.dispose();
                    this._tabContent = null;
                }

                if (this._timer)
                {
                    this._timer.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                    this._timer.reset();
                    this._timer = null;
                }

                if (this._popularTagsListCtrl)
                {
                    this._popularTagsListCtrl.dispose();
                    this._popularTagsListCtrl = null;
                }

                if (this._guestRoomListCtrl)
                {
                    this._guestRoomListCtrl.dispose();
                    this._guestRoomListCtrl = null;
                }

                if (this._officialRoomsListCtrl)
                {
                    this._officialRoomsListCtrl.dispose();
                    this._officialRoomsListCtrl = null;
                }

            }

        }

        public function open(): void
        {
            var _loc1_: Boolean;
            if (this._mainWindow == null)
            {
                this.prepare();
                _loc1_ = true;
            }

            this.refresh();
            this._mainWindow.visible = true;
            this._mainWindow.activate();
            if (_loc1_)
            {
                this._navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN, HabboToolbarIconEnum.NAVIGATOR, this._mainWindow));
            }

        }

        public function isOpen(): Boolean
        {
            return this._mainWindow != null && this._mainWindow.visible;
        }

        public function close(): void
        {
            if (this._mainWindow != null)
            {
                this._mainWindow.visible = false;
            }

        }

        public function get mainWindow(): IFrameWindow
        {
            return this._mainWindow;
        }

        private function prepare(): void
        {
            var tab: Tab;
            var tabButton: ITabButtonWindow;

            if (!this._navigator)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _navigator is null!");
            }

            this._mainWindow = IFrameWindow(this._navigator.getXmlWindow("grs_main_window"));
            if (!this._mainWindow)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _mainWindow is null!");
            }

            this._tabContext = ITabContextWindow(this._mainWindow.findChildByName("tab_context"));
            if (!this._tabContext)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _tabContext is null!");
            }

            this._tabContent = IWindowContainer(this._mainWindow.findChildByName("tab_content"));
            this._customContent = IWindowContainer(this._mainWindow.findChildByName("custom_content"));
            this._listContent = IWindowContainer(this._mainWindow.findChildByName("list_content"));
            this._customFooter = IWindowContainer(this._mainWindow.findChildByName("custom_footer"));
            this._loadingText = this._mainWindow.findChildByName("loading_text");
            var _loc1_: IWindow = this._mainWindow.findChildByTag("close");
            _loc1_.procedure = this.onWindowClose;
            this._toHotelView = IRegionWindow(this._mainWindow.findChildByName("to_hotel_view"));
            if (!this._toHotelView)
            {
                ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: _toHotelView is null!");
            }

            this._toHotelView.procedure = this.onHotelView;
            this.refreshToHotelViewButton(false);
            this._mainWindow.procedure = this.onWindow;
            for each (tab in this._navigator.tabs.tabs)
            {
                tabButton = this._tabContext.getTabItemByID(tab.id);
                if (!tabButton)
                {
                    ErrorReportStorage.addDebugData("MainViewCtrl", "prepare: but is null!");
                }

                tabButton.setParamFlag(HabboWindowParam.var_157, true);
                tabButton.procedure = this.onTabClick;
                tab.button = tabButton;
            }

            this._mainWindow.scaler.setParamFlag(HabboWindowParam.var_821, false);
            this._mainWindow.scaler.setParamFlag(HabboWindowParam.var_820, true);
        }

        public function refresh(): void
        {
            if (this._mainWindow == null)
            {
                return;
            }

            this.refreshTab();
            this.refreshCustomContent();
            this.refreshListContent(true);
            this.refreshFooter();
            this._customContent.height = Util.getLowestPoint(this._customContent);
            this._customFooter.height = Util.getLowestPoint(this._customFooter);
            var _loc1_: int = this._listContent.y;
            Util.moveChildrenToColumn(this._tabContent, ["custom_content", "list_content"], this._customContent.y, 8);
            this._listContent.height = ((this._listContent.height + _loc1_) - this._listContent.y - this._customFooter.height) + this._offsetHeight;
            Util.moveChildrenToColumn(this._tabContent, ["list_content", "custom_footer"], this._listContent.y, 0);
            this._offsetHeight = this._customFooter.height;
            this.onResizeTimer(null);
        }

        private function refreshTab(): void
        {
            var _loc1_: Tab = this._navigator.tabs.getSelected();
            var _loc2_: ISelectableWindow = this._tabContext.selector.getSelected();
            if (_loc1_.button != _loc2_)
            {
                this.var_3803 = true;
                this._tabContext.selector.setSelected(_loc1_.button);
            }

        }

        private function refreshCustomContent(): void
        {
            Util.hideChildren(this._customContent);
            var _loc1_: Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.refreshCustomContent(this._customContent);
            if (Util.hasVisibleChildren(this._customContent))
            {
                this._customContent.visible = true;
            }
            else
            {
                this._customContent.visible = false;
                this._customContent.blend = 1;
            }

        }

        private function refreshFooter(): void
        {
            Util.hideChildren(this._customFooter);
            var _loc1_: Tab = this._navigator.tabs.getSelected();
            _loc1_.tabPageDecorator.refreshFooter(this._customFooter);
            this._customFooter.visible = Util.hasVisibleChildren(this._customFooter);

        }

        private function refreshListContent(param1: Boolean): void
        {
            Util.hideChildren(this._listContent);
            this.refreshGuestRooms(param1, this._navigator.data.guestRoomSearchArrived);
            this.refreshPopularTags(param1, this._navigator.data.popularTagsArrived);
            this.refreshOfficialRooms(param1, this._navigator.data.officialRoomsArrived);
        }

        private function refreshGuestRooms(param1: Boolean, param2: Boolean): void
        {
            this.refreshList(param1, param2, this._guestRoomListCtrl, "guest_rooms");
        }

        private function refreshPopularTags(param1: Boolean, param2: Boolean): void
        {
            this.refreshList(param1, param2, this._popularTagsListCtrl, "popular_tags");
        }

        private function refreshOfficialRooms(param1: Boolean, param2: Boolean): void
        {
            this.refreshList(param1, param2, this._officialRoomsListCtrl, "official_rooms");
        }

        private function refreshList(param1: Boolean, param2: Boolean, param3: IViewCtrl, param4: String): void
        {
            var _loc5_: IWindow;
            if (!param2)
            {
                return;
            }

            if (param3.content == null)
            {
                _loc5_ = this._listContent.getChildByName(param4);
                param3.content = IWindowContainer(_loc5_);
            }

            if (param1)
            {
                param3.refresh();
            }

            param3.content.visible = true;
        }

        private function onWindowClose(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            Logger.log("Close window");
            this.close();
        }

        private function onTabClick(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowEvent.var_560)
            {
                return;
            }

            var _loc3_: int = param2.id;
            if (this.var_3803)
            {
                this.var_3803 = false;
                return;
            }

            var _loc4_: Tab = this._navigator.tabs.getTab(_loc3_);
            _loc4_.sendSearchRequest();
            switch (_loc4_.id)
            {
                case Tabs.TAB_EVENTS_PAGE:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS));
                    return;
                case Tabs.TAB_MY_ROOMS_PAGE:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME));
                    return;
                case Tabs.TAB_OFFICIALS_PAGE:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL));
                    return;
                case Tabs.TAB_ROOMS_PAGE:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS));
                    return;
                case Tabs.TAB_SEARCH_PAGE:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH));
                    return;
            }

        }

        public function reloadRoomList(param1: int): Boolean
        {
            ErrorReportStorage.addDebugData("MainViewCtrl", "Reloading RoomList");
            if (this.isOpen() && this._navigator.data.guestRoomSearchResults != null && this._navigator.data.guestRoomSearchResults.searchType == param1)
            {
                this.startSearch(this._navigator.tabs.getSelected().id, param1, "");
                return true;
            }

            return false;
        }

        public function startSearch(param1: int, param2: int, param3: String = "-1", param4: int = 1): void
        {
            var _loc5_: Tab = this._navigator.tabs.getSelected();
            this._navigator.tabs.setSelectedTab(param1);
            var _loc6_: Tab = this._navigator.tabs.getSelected();
            ErrorReportStorage.addDebugData("StartSearch", "Start search " + _loc5_.id + " => " + _loc6_.id);
            this._focused = _loc5_ != _loc6_;
            if (_loc5_ != _loc6_)
            {
                _loc6_.tabPageDecorator.tabSelected();
            }

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
                }

            }

            if (!this.isOpen())
            {
                this.open();
                this._blend = var_832;
                this._listContent.blend = 0;
                if (this._customContent.visible)
                {
                    this._customContent.blend = 0;
                    this._customFooter.blend = 0;
                }

            }
            else
            {
                this._blend = var_833;
            }

            this._alpha = 0;
            this._navigator.registerUpdateReceiver(this, 2);
            this.sendTrackingEvent(param2);
        }

        private function sendTrackingEvent(param1: int): void
        {
            switch (param1)
            {
                case Tabs.SEARCH_TYPE_LATEST_EVENTS:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS));
                    return;
                case Tabs.SEARCH_TYPE_MY_FAVOURITES:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES));
                    return;
                case Tabs.SEARCH_TYPE_MY_FRIENDS_ROOMS:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS));
                    return;
                case Tabs.SEARCH_TYPE_MY_HISTORY:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY));
                    return;
                case Tabs.SEARCH_TYPE_MY_ROOMS:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS));
                    return;
                case Tabs.SEARCH_TYPE_OFFICIAL_ROOMS:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS));
                    return;
                case Tabs.SEARCH_TYPE_POPULAR_ROOMS:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS));
                    return;
                case Tabs.SEARCH_TYPE_ROOMS_WHERE_MY_FRIENDS_ARE:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE));
                    return;
                case Tabs.SEARCH_TYPE_ROOMS_WITH_HIGHEST_SCORE:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE));
                    return;
                case Tabs.SEARCH_TYPE_TAG_SEARCH:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH));
                    return;
                case Tabs.SEARCH_TYPE_TEXT_SEARCH:
                    this._navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH));
                    return;
            }

        }

        private function getSearchMsg(param1: int, param2: String): IMessageComposer
        {
            if (param1 == Tabs.SEARCH_TYPE_MY_FAVOURITES)
            {
                return new MyFavouriteRoomsSearchMessageComposer();
            }

            if (param1 == Tabs.SEARCH_TYPE_MY_FRIENDS_ROOMS)
            {
                return new MyFriendsRoomsSearchMessageComposer();
            }

            if (param1 == Tabs.SEARCH_TYPE_MY_HISTORY)
            {
                return new MyRoomHistorySearchMessageComposer();
            }

            if (param1 == Tabs.SEARCH_TYPE_MY_ROOMS)
            {
                return new MyRoomsSearchMessageComposer();
            }

            if (param1 == Tabs.SEARCH_TYPE_POPULAR_ROOMS)
            {
                return new PopularRoomsSearchMessageComposer(param2, this._navigator.data.adIndex);
            }

            if (param1 == Tabs.SEARCH_TYPE_ROOMS_WHERE_MY_FRIENDS_ARE)
            {
                return new RoomsWhereMyFriendsAreSearchMessageComposer();
            }

            if (param1 == Tabs.SEARCH_TYPE_ROOMS_WITH_HIGHEST_SCORE)
            {
                return new RoomsWithHighestScoreSearchMessageComposer(this._navigator.data.adIndex);
            }

            if (param1 == Tabs.SEARCH_TYPE_TAG_SEARCH)
            {
                return new RoomTagSearchMessageComposer(param2);
            }

            if (param1 == Tabs.SEARCH_TYPE_TEXT_SEARCH)
            {
                return new RoomTextSearchMessageComposer(param2);
            }

            if (param1 == Tabs.SEARCH_TYPE_LATEST_EVENTS)
            {
                return new LatestEventsSearchMessageComposer(param2, this._navigator.data.adIndex);
            }

            Logger.log("No message for searchType: " + param1);
            return null;
        }

        public function update(param1: uint): void
        {
            var _loc3_: Number;
            if (this._listContent == null)
            {
                return;
            }

            var _loc2_: Number = param1 / 150;
            if (this._blend == var_833)
            {
                _loc3_ = Math.min(1, Math.max(0, this._listContent.blend - _loc2_));
                this._listContent.blend = _loc3_;
                this._customContent.blend = this._focused ? _loc3_ : 1;
                this._customFooter.blend = this._focused ? _loc3_ : 1;
                if (_loc3_ == 0)
                {
                    this._blend = var_832;
                }

            }
            else
            {
                if (this._blend == var_832)
                {
                    if (this._alpha % 10 == 1)
                    {
                        this._loadingText.visible = !this._loadingText.visible;
                    }

                    this._alpha++;
                    if (!this._navigator.data.isLoading())
                    {
                        this._blend = var_843;
                    }

                }
                else
                {
                    if (this._blend == var_843)
                    {
                        this.refresh();
                        this._blend = var_844;
                    }
                    else
                    {
                        this._loadingText.visible = false;
                        _loc3_ = Math.min(1, Math.max(0, this._listContent.blend + _loc2_));
                        this._listContent.blend = _loc3_;
                        this._customContent.blend = this._focused ? _loc3_ : 1;
                        this._customFooter.blend = this._focused ? _loc3_ : 1;
                        if (this._listContent.blend >= 1)
                        {
                            this._navigator.removeUpdateReceiver(this);
                        }

                    }

                }

            }

        }

        private function onWindow(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowEvent.var_573 || param2 != this._mainWindow)
            {
                return;
            }

            if (!this._timer.running)
            {
                this._timer.reset();
                this._timer.start();
            }

        }

        private function onResizeTimer(param1: TimerEvent): void
        {
            this.refreshScrollbar(this._popularTagsListCtrl);
            this.refreshScrollbar(this._guestRoomListCtrl);
        }

        private function refreshScrollbar(param1: IViewCtrl): void
        {
            if (param1.content == null || !param1.content.visible)
            {
                return;
            }

            var _loc2_: IItemListWindow = IItemListWindow(param1.content.findChildByName("item_list"));
            var _loc3_: IWindow = param1.content.findChildByName("scroller");
            var _loc4_: * = _loc2_.scrollableRegion.height > _loc2_.height;
            if (_loc3_.visible)
            {
                if (_loc4_)
                {
                    return;
                }

                _loc3_.visible = false;
                _loc2_.width = _loc2_.width + SCROLLBAR_WIDTH;
            }
            else
            {
                if (_loc4_)
                {
                    _loc3_.visible = true;
                    _loc2_.width = _loc2_.width - SCROLLBAR_WIDTH;
                }
                else
                {

                }

            }

        }

        public function stretchNewEntryIfNeeded(param1: IViewCtrl, param2: IWindowContainer): void
        {
            var _loc3_: IWindow = param1.content.findChildByName("scroller");
            if (_loc3_.visible)
            {
                return;
            }

            param2.width = param2.width + SCROLLBAR_WIDTH;
        }

        private function refreshToHotelViewButton(param1: Boolean): void
        {
            this._navigator.refreshButton(this._toHotelView, "icon_hotelview", !param1, null, 0);
            this._navigator.refreshButton(this._toHotelView, "icon_hotelview_reactive", param1, null, 0);
        }

        private function onHotelView(param1: WindowEvent, param2: IWindow): void
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
                    }

                }

            }

        }

    }
}
