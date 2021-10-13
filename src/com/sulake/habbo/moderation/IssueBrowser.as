package com.sulake.habbo.moderation
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.assets.XmlAsset;

    public class IssueBrowser 
    {

        private const var_3649:String = "my_issues";
        private const var_3650:String = "open_issues";
        private const var_3651:String = "picked_issues";
        private const var_3652:String = "closed_issues";

        private var _issueManager:IssueManager;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _window:IFrameWindow;
        private var var_3653:ITabContextWindow;
        private var var_3654:IIssueBrowserView;
        private var var_3655:IIssueBrowserView;
        private var var_3656:IIssueBrowserView;
        private var var_3657:PickedIssuesView;

        public function IssueBrowser(param1:IssueManager, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            this._issueManager = param1;
            this._windowManager = param2;
            this._assets = param3;
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get assets():IAssetLibrary
        {
            return (this._assets);
        }

        public function get issueManager():IssueManager
        {
            return (this._issueManager);
        }

        public function show():void
        {
            if (this._window == null)
            {
                this.createMainFrame();
            };
            this._window.visible = true;
            this._window.activate();
            this.update();
        }

        public function isOpen():Boolean
        {
            return ((!(this._window == null)) && (this._window.visible));
        }

        private function createMainFrame():void
        {
            var _loc2_:IWindow;
            var _loc3_:IWindow;
            var _loc4_:IWindow;
            var _loc5_:ITabButtonWindow;
            var _loc6_:int;
            if (this._window == null)
            {
                this._window = (this.createWindow("issue_browser_xml") as IFrameWindow);
                if (this._window == null)
                {
                    return;
                };
                _loc2_ = this._window.desktop;
                this._window.x = ((_loc2_.width / 2) - (this._window.width / 2));
                this._window.y = ((_loc2_.height / 2) - (this._window.height / 2));
                _loc3_ = this._window.findChildByTag("close");
                if (_loc3_ != null)
                {
                    _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
                };
                _loc4_ = this._window.findChildByName("auto_pick");
                if (_loc4_ != null)
                {
                    _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onAutoPick);
                };
                this.var_3653 = (this._window.findChildByName("tab_context") as ITabContextWindow);
                _loc6_ = 0;
                while (_loc6_ < this.var_3653.numTabItems)
                {
                    _loc5_ = this.var_3653.getTabItemAt(_loc6_);
                    _loc5_.addEventListener(WindowEvent.var_560, this.onTabSelected);
                    _loc6_++;
                };
            };
            this.var_3653 = (this._window.findChildByName("tab_context") as ITabContextWindow);
            if (((this.var_3653 == null) || (this.var_3653.container == null)))
            {
                return;
            };
            var _loc1_:ISelectableWindow = this.var_3653.selector.getSelectableByName("open_issues");
            this.var_3653.selector.setSelected(_loc1_);
        }

        private function selectView(param1:String):void
        {
            var _loc2_:IIssueBrowserView = this.getView(param1);
            if (this.var_3654 == _loc2_)
            {
                return;
            };
            if (this.var_3654 != null)
            {
                this.var_3654.visible = false;
            };
            this.var_3654 = _loc2_;
            if (this.var_3654 == null)
            {
                return;
            };
            this.var_3654.view.width = this.var_3653.container.width;
            this.var_3654.view.height = this.var_3653.container.height;
            this.var_3654.visible = true;
            this.var_3654.update();
        }

        private function getView(param1:String):IIssueBrowserView
        {
            switch (param1)
            {
                case this.var_3649:
                    if (this.var_3655 == null)
                    {
                        this.var_3655 = new MyIssuesView(this.issueManager, this, this.var_3653.container);
                    };
                    return (this.var_3655);
                case this.var_3650:
                    if (this.var_3656 == null)
                    {
                        this.var_3656 = new OpenIssuesView(this.issueManager, this, this.var_3653.container);
                    };
                    return (this.var_3656);
                case this.var_3651:
                    if (this.var_3657 == null)
                    {
                        this.var_3657 = new PickedIssuesView(this.issueManager, this, this.var_3653.container);
                    };
                    return (this.var_3657);
                default:
                    return (null);
            };
        }

        private function onTabSelected(param1:WindowEvent):void
        {
            if (((param1 == null) || (param1.window == null)))
            {
                return;
            };
            this.selectView(param1.window.name);
        }

        public function update():void
        {
            if (((this._window == null) || (!(this._window.visible))))
            {
                return;
            };
            if (this.var_3654 == null)
            {
                return;
            };
            this.var_3654.update();
        }

        public function createWindow(param1:String):IWindow
        {
            if (((this._windowManager == null) || (this._assets == null)))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (this._assets.getAssetByName(param1) as XmlAsset);
            if (((_loc2_ == null) || (_loc2_.content == null)))
            {
                return (null);
            };
            return (this._windowManager.buildFromXML((_loc2_.content as XML)));
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            this._window.visible = false;
        }

        private function onAutoPick(param1:WindowMouseEvent):void
        {
            if (this._issueManager != null)
            {
                this._issueManager.autoPick();
            };
        }

    }
}