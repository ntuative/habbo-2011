package com.sulake.habbo.navigator.domain
{

    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;

    public class Tabs
    {

        public static const TAB_EVENTS_PAGE: int = 1;
        public static const TAB_ROOMS_PAGE: int = 2;
        public static const TAB_MY_ROOMS_PAGE: int = 3;
        public static const TAB_OFFICIALS_PAGE: int = 4;
        public static const TAB_SEARCH_PAGE: int = 5;
        
        public static const SEARCH_TYPE_POPULAR_ROOMS: int = 1;
        public static const SEARCH_TYPE_ROOMS_WITH_HIGHEST_SCORE: int = 2;
        public static const SEARCH_TYPE_MY_FRIENDS_ROOMS: int = 3;
        public static const SEARCH_TYPE_ROOMS_WHERE_MY_FRIENDS_ARE: int = 4;
        public static const SEARCH_TYPE_MY_ROOMS: int = 5;
        public static const SEARCH_TYPE_MY_FAVOURITES: int = 6;
        public static const SEARCH_TYPE_MY_HISTORY: int = 7;
        public static const SEARCH_TYPE_TEXT_SEARCH: int = 8;
        public static const SEARCH_TYPE_TAG_SEARCH: int = 9;
        public static const SEARCH_TYPE_UNKNOWN_1: int = 10;
        public static const SEARCH_TYPE_OFFICIAL_ROOMS: int = 11;
        public static const SEARCH_TYPE_LATEST_EVENTS: int = 12;

        private var _tabs: Array;
        private var _navigator: HabboNavigator;

        public function Tabs(param1: HabboNavigator)
        {
            this._navigator = param1;
            this._tabs = [];
            this._tabs.push(new Tab(this._navigator, TAB_EVENTS_PAGE, SEARCH_TYPE_LATEST_EVENTS, new EventsTabPageDecorator(this._navigator), MainViewCtrl.var_828));
            this._tabs.push(new Tab(this._navigator, TAB_ROOMS_PAGE, SEARCH_TYPE_POPULAR_ROOMS, new RoomsTabPageDecorator(this._navigator), MainViewCtrl.var_828));
            this._tabs.push(new Tab(this._navigator, TAB_OFFICIALS_PAGE, SEARCH_TYPE_OFFICIAL_ROOMS, new OfficialTabPageDecorator(this._navigator), MainViewCtrl.var_831));
            this._tabs.push(new Tab(this._navigator, TAB_MY_ROOMS_PAGE, SEARCH_TYPE_MY_ROOMS, new MyRoomsTabPageDecorator(this._navigator), MainViewCtrl.var_828));
            this._tabs.push(new Tab(this._navigator, TAB_SEARCH_PAGE, SEARCH_TYPE_TEXT_SEARCH, new SearchTabPageDecorator(this._navigator), MainViewCtrl.var_829));
            this.setSelectedTab(TAB_EVENTS_PAGE);
        }

        public function onFrontPage(): Boolean
        {
            return this.getSelected().id == TAB_OFFICIALS_PAGE;
        }

        public function get tabs(): Array
        {
            return this._tabs;
        }

        public function setSelectedTab(id: int): void
        {
            this.clearSelected();

            this.getTab(id).selected = true;
        }

        public function getSelected(): Tab
        {
            var tab: Tab;

            for each (tab in this._tabs)
            {
                if (tab.selected)
                {
                    return tab;
                }

            }

            return null;
        }

        private function clearSelected(): void
        {
            var _loc1_: Tab;
            for each (_loc1_ in this._tabs)
            {
                _loc1_.selected = false;
            }

        }

        public function getTab(param1: int): Tab
        {
            var _loc2_: Tab;
            for each (_loc2_ in this._tabs)
            {
                if (_loc2_.id == param1)
                {
                    return _loc2_;
                }

            }

            return null;
        }

    }
}
