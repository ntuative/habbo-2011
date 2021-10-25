package com.sulake.habbo.friendlist.domain
{

    import com.sulake.habbo.friendlist.ITabView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendlist.HabboFriendList;

    public class FriendListTab
    {

        public static const FRIEND_LIST_FRIENDS: int = 1;
        public static const FRIEND_LIST_REQUESTS: int = 2;
        public static const FRIEND_LIST_SEARCH: int = 3;

        private var _id: int;
        private var _name: String;
        private var _footerName: String;
        private var _headerPicName: String;
        private var _tabView: ITabView;
        private var _newMessageArrived: Boolean;
        private var _selected: Boolean;
        private var _view: IWindowContainer;

        public function FriendListTab(friendList: HabboFriendList, id: int, tabView: ITabView, name: String, footerName: String, headerPicName: String)
        {
            this._id = id;
            this._name = name;
            this._tabView = tabView;
            this._footerName = footerName;
            this._headerPicName = headerPicName;
            
            this._tabView.init(friendList);
        }

        public function setSelected(value: Boolean): void
        {
            if (value)
            {
                this._newMessageArrived = false;
            }

            this._selected = value;
        }

        public function setNewMessageArrived(value: Boolean): void
        {
            if (this.selected)
            {
                this._newMessageArrived = false;
            }
            else
            {
                this._newMessageArrived = value;
            }

        }

        public function get newMessageArrived(): Boolean
        {
            return this._newMessageArrived;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get footerName(): String
        {
            return this._footerName;
        }

        public function get headerPicName(): String
        {
            return this._headerPicName;
        }

        public function get selected(): Boolean
        {
            return this._selected;
        }

        public function get tabView(): ITabView
        {
            return this._tabView;
        }

        public function get view(): IWindowContainer
        {
            return this._view;
        }

        public function set view(param1: IWindowContainer): void
        {
            this._view = param1;
        }

    }
}
