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

        private static const var_3428:String = "noconvinfo";
        private static const var_3429:String = "messageinput";

        private var _friendList:HabboFriendList;
        private var var_3430:FriendListTabsView;
        private var var_3431:IFrameWindow;
        private var var_3432:IWindowContainer;
        private var var_3433:IWindowContainer;
        private var var_3434:ITextWindow;
        private var var_3435:int = -1;
        private var var_3436:int = -1;
        private var var_3437:Boolean;

        public function FriendListView(param1:HabboFriendList)
        {
            this._friendList = param1;
            this.var_3430 = new FriendListTabsView(this._friendList);
        }

        public function isFriendListOpen():Boolean
        {
            return ((!(this.var_3431 == null)) && (this.var_3431.visible));
        }

        public function openFriendList():void
        {
            if (this.var_3431 == null)
            {
                this.prepare();
                this._friendList.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_146, HabboToolbarIconEnum.FRIENDLIST, this.var_3431));
            }
            else
            {
                this.var_3431.visible = true;
                this.var_3431.activate();
            };
        }

        public function showInfo(param1:WindowEvent, param2:String):void
        {
            var _loc3_:WindowMouseEvent = (param1 as WindowMouseEvent);
            if (_loc3_ == null)
            {
                return;
            };
            if (_loc3_.type == WindowMouseEvent.var_626)
            {
                this.var_3434.text = "";
            }
            else
            {
                if (_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    this.var_3434.text = param2;
                };
            };
        }

        public function refresh(param1:String):void
        {
            if (this.var_3431 == null)
            {
                return;
            };
            this.var_3430.refresh(param1);
            this.refreshWindowSize();
        }

        public function close():void
        {
            if (this.var_3431 != null)
            {
                this.var_3431.visible = false;
            };
        }

        private function prepare():void
        {
            this.var_3431 = IFrameWindow(this._friendList.getXmlWindow("main_window"));
            this.var_3431.findChildByTag("close").procedure = this.onWindowClose;
            this.var_3432 = IWindowContainer(this.var_3431.content.findChildByName("main_content"));
            this.var_3433 = IWindowContainer(this.var_3431.content.findChildByName("footer"));
            this.var_3430.prepare(this.var_3432);
            this.var_3431.procedure = this.onWindow;
            this.var_3431.content.setParamFlag(HabboWindowParam.var_802, false);
            this.var_3431.content.setParamFlag(HabboWindowParam.var_798, true);
            this.var_3431.header.setParamFlag(HabboWindowParam.var_797, false);
            this.var_3431.header.setParamFlag(HabboWindowParam.var_793, true);
            this.var_3431.content.setParamFlag(HabboWindowParam.var_797, false);
            this.var_3431.content.setParamFlag(HabboWindowParam.var_793, true);
            this.var_3431.findChildByName("open_edit_ctgs_but").procedure = this.var_3438;
            this.var_3434 = ITextWindow(this.var_3431.findChildByName("info_text"));
            this.var_3434.text = "";
            this._friendList.refreshButton(this.var_3431, "open_edit_ctgs", true, null, 0);
            this.var_3431.title.color = 0xFFFAC200;
            this.var_3431.title.textColor = 4287851525;
            this.refresh("prepare");
            this.var_3431.height = 350;
            this.var_3431.width = 230;
        }

        private function getTitleBar():IWindowContainer
        {
            return (this.var_3431.findChildByName("titlebar") as IWindowContainer);
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Close window");
            this.var_3431.visible = false;
            this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
        }

        private function onWindow(param1:WindowEvent, param2:IWindow):void
        {
            if (((!(param1.type == WindowEvent.var_573)) || (!(param2 == this.var_3431))))
            {
                return;
            };
            if (this.var_3437)
            {
                return;
            };
            var _loc3_:int = ((this.var_3435 == -1) ? 0 : (this.var_3431.height - this.var_3435));
            var _loc4_:int = ((this.var_3436 == -1) ? 0 : (this.var_3431.width - this.var_3436));
            this._friendList.tabs.tabContentHeight = Math.max(100, (this._friendList.tabs.tabContentHeight + _loc3_));
            this._friendList.tabs.windowWidth = Math.max(147, (this._friendList.tabs.windowWidth + _loc4_));
            this.refresh(("resize: " + _loc3_));
        }

        private function refreshWindowSize():void
        {
            this.var_3437 = true;
            this.var_3433.visible = false;
            this.var_3433.y = Util.getLowestPoint(this.var_3431.content);
            this.var_3433.width = this._friendList.tabs.windowWidth;
            this.var_3433.visible = true;
            this.var_3431.content.height = Util.getLowestPoint(this.var_3431.content);
            this.var_3431.content.width = (this._friendList.tabs.windowWidth - 10);
            this.var_3431.header.width = (this._friendList.tabs.windowWidth - 10);
            this.var_3431.height = (this.var_3431.content.height + 30);
            this.var_3431.width = this._friendList.tabs.windowWidth;
            this.var_3437 = false;
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_821, false);
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_818, (!(this._friendList.tabs.findSelectedTab() == null)));
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_797, false);
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_802, false);
            this.var_3431.scaler.x = (this.var_3431.width - this.var_3431.scaler.width);
            this.var_3431.scaler.y = (this.var_3431.height - this.var_3431.scaler.height);
            this.var_3435 = this.var_3431.height;
            this.var_3436 = this.var_3431.width;
            Logger.log(("RESIZED: " + this._friendList.tabs.windowWidth));
        }

        private function var_3438(param1:WindowEvent, param2:IWindow):void
        {
            this._friendList.view.showInfo(param1, "${friendlist.tip.preferences}");
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Edit categories clicked");
            var _loc3_:WindowMouseEvent = (param1 as WindowMouseEvent);
            this._friendList.openHabboWebPage("link.format.friendlist.pref", new Dictionary(), _loc3_.stageX, _loc3_.stageY);
        }

        public function get mainWindow():IWindowContainer
        {
            return (this.var_3431);
        }

        public function get tabsView():FriendListTabsView
        {
            return (this.var_3430);
        }

    }
}