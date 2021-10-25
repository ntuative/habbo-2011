package com.sulake.habbo.navigator.domain
{

    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;

    public class Tab
    {

        private var _navigator: HabboNavigator;
        private var _id: int;
        private var _defaultSearchType: int;
        private var _button: ITabButtonWindow;
        private var _tabPageDecorator: ITabPageDecorator;
        private var _selected: Boolean;
        private var _searchMsg: int;

        public function Tab(navigator: HabboNavigator, id: int, defaultSearchType: int, tapPageDecorator: ITabPageDecorator, searchMsg: int = 1)
        {
            this._navigator = navigator;
            this._id = id;
            this._defaultSearchType = defaultSearchType;
            this._tabPageDecorator = tapPageDecorator;
            this._searchMsg = searchMsg;
        }

        public function sendSearchRequest(): void
        {
            this._navigator.mainViewCtrl.startSearch(this._id, this._defaultSearchType, "-1", this._searchMsg);
        }

        public function set selected(value: Boolean): void
        {
            this._selected = value;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get defaultSearchType(): int
        {
            return this._defaultSearchType;
        }

        public function get selected(): Boolean
        {
            return this._selected;
        }

        public function get tabPageDecorator(): ITabPageDecorator
        {
            return this._tabPageDecorator;
        }

        public function get searchMsg(): int
        {
            return this._searchMsg;
        }

        public function get button(): ITabButtonWindow
        {
            return this._button;
        }

        public function set button(value: ITabButtonWindow): void
        {
            this._button = value;
        }

    }
}
