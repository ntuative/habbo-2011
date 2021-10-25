package com.sulake.habbo.navigator.mainview.tabpagedecorators
{

    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;

    public class OfficialTabPageDecorator implements ITabPageDecorator
    {

        private var _navigator: HabboNavigator;

        public function OfficialTabPageDecorator(param1: HabboNavigator)
        {
            this._navigator = param1;
        }

        public function refreshCustomContent(param1: IWindowContainer): void
        {
        }

        public function tabSelected(): void
        {
        }

        public function refreshFooter(param1: IWindowContainer): void
        {
        }

        public function navigatorOpenedWhileInTab(): void
        {
            this._navigator.mainViewCtrl.startSearch(Tabs.TAB_OFFICIALS_PAGE, Tabs.SEARCH_TYPE_OFFICIAL_ROOMS, "-1", MainViewCtrl.var_831);
        }

    }
}
