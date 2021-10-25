package com.sulake.habbo.friendlist.domain
{

    import com.sulake.habbo.friendlist.FriendsView;
    import com.sulake.habbo.friendlist.FriendRequestsView;
    import com.sulake.habbo.friendlist.SearchView;
    import com.sulake.habbo.friendlist.*;

    public class FriendListTabs
    {

        private var _deps: IFriendListTabsDeps;
        private var _tabs: Array = [];
        private var _tab: FriendListTab;
        private var _tabContentHeight: int = 200;
        private var _tabContentCollapsedHeight: int = 200;
        private var _windowWidth: int = 200;

        public function FriendListTabs(deps: IFriendListTabsDeps)
        {
            this._deps = deps;

            this._tabs.push(new FriendListTab(this._deps.getFriendList(), FriendListTab.FRIEND_LIST_FRIENDS, new FriendsView(), "${friendlist.friends}", "friends_footer", "hdr_friends"));
            this._tabs.push(new FriendListTab(this._deps.getFriendList(), FriendListTab.FRIEND_LIST_REQUESTS, new FriendRequestsView(), "${friendlist.tab.friendrequests}", "friend_requests_footer", "hdr_friend_requests"));
            this._tabs.push(new FriendListTab(this._deps.getFriendList(), FriendListTab.FRIEND_LIST_SEARCH, new SearchView(), "${generic.search}", "search_footer", "hdr_search"));
            
            this.toggleSelected(null);
        }

        public function getTabs(): Array
        {
            return this._tabs;
        }

        public function findTab(id: int): FriendListTab
        {
            var tab: FriendListTab;

            for each (tab in this._tabs)
            {
                if (tab.id == id)
                {
                    return tab;
                }

            }

            return null;
        }

        public function clearSelections(): void
        {
            var tab: FriendListTab;

            for each (tab in this._tabs)
            {
                tab.setSelected(false);
            }

        }

        public function findSelectedTab(): FriendListTab
        {
            var tab: FriendListTab;

            for each (tab in this._tabs)
            {
                if (tab.selected)
                {
                    return tab;
                }

            }

            return null;
        }

        public function toggleSelected(tab: FriendListTab): void
        {
            var t: FriendListTab = this.findSelectedTab();

            if (t == null)
            {
                this._tabContentHeight = this._tabContentCollapsedHeight;
                this.setSelected(this.determineDisplayedTab(tab), true);
            }
            else
            {
                if (t == tab || tab == null)
                {
                    this._tabContentCollapsedHeight = this._tabContentHeight;
                    this._tabContentHeight = 0;
                    
                    this.clearSelections();
                }
                else
                {
                    this.setSelected(this.determineDisplayedTab(tab), true);
                }

            }

        }

        private function setSelected(tab: FriendListTab, selected: Boolean): void
        {
            var t: FriendListTab = this.findSelectedTab();
            this.clearSelections();
            
            tab.setSelected(selected);
            
            if (selected)
            {
                this._tab = tab;
            }

        }

        private function determineDisplayedTab(tab: FriendListTab): FriendListTab
        {
            if (tab != null)
            {
                return tab;
            }

            if (this._tab != null)
            {
                return this._tab;
            }

            return this._tabs[0];
        }

        public function get tabContentHeight(): int
        {
            return this._tabContentHeight;
        }

        public function get windowWidth(): int
        {
            return this._windowWidth;
        }

        public function get tabContentWidth(): int
        {
            return this._windowWidth - 2;
        }

        public function set tabContentHeight(value: int): void
        {
            this._tabContentHeight = value;
        }

        public function set windowWidth(value: int): void
        {
            this._windowWidth = value;
        }

    }
}
