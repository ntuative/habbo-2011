package com.sulake.habbo.friendlist
{

    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.core.window.IWindow;

    import flash.utils.Dictionary;

    public class FriendListView
    {

        private static const NO_CONVERSATION_INFO: String = "noconvinfo";
        private static const MESSAGE_INPUT: String = "messageinput";

        private var _friendList: HabboFriendList;
        private var _tabsView: FriendListTabsView;
        private var _mainWindow: IFrameWindow;
        private var var_3432: IWindowContainer;
        private var var_3433: IWindowContainer;
        private var var_3434: ITextWindow;
        private var var_3435: int = -1;
        private var var_3436: int = -1;
        private var var_3437: Boolean;

        public function FriendListView(friendList: HabboFriendList)
        {
            this._friendList = friendList;
            this._tabsView = new FriendListTabsView(this._friendList);
        }

        public function isFriendListOpen(): Boolean
        {
            return this._mainWindow != null && this._mainWindow.visible;
        }

        public function openFriendList(): void
        {
            if (this._mainWindow == null)
            {
                this.prepare();
                this._friendList.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN, HabboToolbarIconEnum.FRIENDLIST, this._mainWindow));
            }
            else
            {
                this._mainWindow.visible = true;
                this._mainWindow.activate();
            }

        }

        public function showInfo(param1: WindowEvent, param2: String): void
        {
            var _loc3_: WindowMouseEvent = param1 as WindowMouseEvent;
            if (_loc3_ == null)
            {
                return;
            }

            if (_loc3_.type == WindowMouseEvent.var_626)
            {
                this.var_3434.text = "";
            }
            else
            {
                if (_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    this.var_3434.text = param2;
                }

            }

        }

        public function refresh(param1: String): void
        {
            if (this._mainWindow == null)
            {
                return;
            }

            this._tabsView.refresh(param1);
            this.refreshWindowSize();
        }

        public function close(): void
        {
            if (this._mainWindow != null)
            {
                this._mainWindow.visible = false;
            }

        }

        private function prepare(): void
        {
            this._mainWindow = IFrameWindow(this._friendList.getXmlWindow("main_window"));
            this._mainWindow.findChildByTag("close").procedure = this.onWindowClose;
            this.var_3432 = IWindowContainer(this._mainWindow.content.findChildByName("main_content"));
            this.var_3433 = IWindowContainer(this._mainWindow.content.findChildByName("footer"));
            this._tabsView.prepare(this.var_3432);
            this._mainWindow.procedure = this.onWindow;
            this._mainWindow.content.setParamFlag(HabboWindowParam.var_802, false);
            this._mainWindow.content.setParamFlag(HabboWindowParam.var_798, true);
            this._mainWindow.header.setParamFlag(HabboWindowParam.var_797, false);
            this._mainWindow.header.setParamFlag(HabboWindowParam.var_793, true);
            this._mainWindow.content.setParamFlag(HabboWindowParam.var_797, false);
            this._mainWindow.content.setParamFlag(HabboWindowParam.var_793, true);
            this._mainWindow.findChildByName("open_edit_ctgs_but").procedure = this.onEditCategoriesButtonClick;
            this.var_3434 = ITextWindow(this._mainWindow.findChildByName("info_text"));
            this.var_3434.text = "";
            this._friendList.refreshButton(this._mainWindow, "open_edit_ctgs", true, null, 0);
            this._mainWindow.title.color = 0xFFFAC200;
            this._mainWindow.title.textColor = 4287851525;
            this.refresh("prepare");
            this._mainWindow.height = 350;
            this._mainWindow.width = 230;
        }

        private function getTitleBar(): IWindowContainer
        {
            return this._mainWindow.findChildByName("titlebar") as IWindowContainer;
        }

        private function onWindowClose(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            Logger.log("Close window");
            this._mainWindow.visible = false;
            this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
        }

        private function onWindow(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowEvent.var_573 || param2 != this._mainWindow)
            {
                return;
            }

            if (this.var_3437)
            {
                return;
            }

            var _loc3_: int = this.var_3435 == -1 ? 0 : this._mainWindow.height - this.var_3435;
            var _loc4_: int = this.var_3436 == -1 ? 0 : this._mainWindow.width - this.var_3436;
            this._friendList.tabs.tabContentHeight = Math.max(100, this._friendList.tabs.tabContentHeight + _loc3_);
            this._friendList.tabs.windowWidth = Math.max(147, this._friendList.tabs.windowWidth + _loc4_);
            this.refresh("resize: " + _loc3_);
        }

        private function refreshWindowSize(): void
        {
            this.var_3437 = true;
            this.var_3433.visible = false;
            this.var_3433.y = Util.getLowestPoint(this._mainWindow.content);
            this.var_3433.width = this._friendList.tabs.windowWidth;
            this.var_3433.visible = true;
            this._mainWindow.content.height = Util.getLowestPoint(this._mainWindow.content);
            this._mainWindow.content.width = this._friendList.tabs.windowWidth - 10;
            this._mainWindow.header.width = this._friendList.tabs.windowWidth - 10;
            this._mainWindow.height = this._mainWindow.content.height + 30;
            this._mainWindow.width = this._friendList.tabs.windowWidth;
            this.var_3437 = false;
            this._mainWindow.scaler.setParamFlag(HabboWindowParam.var_821, false);
            this._mainWindow.scaler.setParamFlag(HabboWindowParam.var_818, this._friendList.tabs.findSelectedTab() != null);
            this._mainWindow.scaler.setParamFlag(HabboWindowParam.var_797, false);
            this._mainWindow.scaler.setParamFlag(HabboWindowParam.var_802, false);
            this._mainWindow.scaler.x = this._mainWindow.width - this._mainWindow.scaler.width;
            this._mainWindow.scaler.y = this._mainWindow.height - this._mainWindow.scaler.height;
            this.var_3435 = this._mainWindow.height;
            this.var_3436 = this._mainWindow.width;
            Logger.log("RESIZED: " + this._friendList.tabs.windowWidth);
        }

        private function onEditCategoriesButtonClick(param1: WindowEvent, param2: IWindow): void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.preferences}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            Logger.log("Edit categories clicked");
            var _loc3_: WindowMouseEvent = param1 as WindowMouseEvent;
            this._friendList.openHabboWebPage("link.format.friendlist.pref", new Dictionary(), _loc3_.stageX, _loc3_.stageY);
        }

        public function get mainWindow(): IWindowContainer
        {
            return this._mainWindow;
        }

        public function get tabsView(): FriendListTabsView
        {
            return this._tabsView;
        }

    }
}
