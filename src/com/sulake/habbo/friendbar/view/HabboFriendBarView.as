package com.sulake.habbo.friendbar.view
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.view.tabs.ITab;
    import com.sulake.habbo.friendbar.view.utils.TextCropper;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.iid.IIDAvatarRenderManager;
    import iid.IIDHabboWindowManager;
    import com.sulake.habbo.friendbar.iid.IIDHabboFriendBarData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.view.tabs.FriendEntityTab;
    import com.sulake.habbo.friendbar.view.tabs.Tab;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.friendbar.view.tabs.AddFriendsEntityTab;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.enum.WindowParam;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.Event;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.enum.HabboAlertDialogFlag;
    import com.sulake.core.window.events.WindowMouseEvent;
    import __AS3__.vec.*;

    public class HabboFriendBarView extends Component implements IHabboFriendBarView, IAvatarImageListener 
    {

        private static const var_1405:int = 127;
        private static const var_3401:int = 40;
        private static const var_3402:int = -1;
        private static const var_1384:int = 1;
        private static const var_1388:int = -4;
        private static const var_1404:int = 80;
        private static const var_1389:Boolean = false;
        private static const var_1387:String = "bar_xml";
        private static const var_1390:String = "toggle_xml";
        private static const var_1386:String = "list";
        private static const var_186:String = "header";
        private static const var_1396:String = "canvas";
        private static const var_1397:String = "button_left";
        private static const var_1400:String = "button_right";
        private static const var_1398:String = "button_left_page";
        private static const var_1401:String = "button_right_page";
        private static const var_1399:String = "button_left_end";
        private static const var_1402:String = "button_right_end";
        private static const var_1052:String = "button_close";
        private static const var_1403:String = "button_open";

        private var _windowManager:IHabboWindowManager;
        private var var_3403:IAvatarRenderManager;
        private var var_3404:IHabboFriendBarData;
        private var var_3405:IWindowContainer;
        private var var_3406:IWindowContainer;
        private var var_3407:Vector.<ITab>;
        private var var_3408:ITab;
        private var var_3409:int = -1;
        private var _startIndex:int = 0;
        private var var_3410:TextCropper;
        private var var_3411:Boolean = false;

        public function HabboFriendBarView(param1:HabboFriendBar, param2:uint, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
            this.var_3410 = new TextCropper();
            this.var_3407 = new Vector.<ITab>();
            if ((param1 is HabboFriendBar))
            {
                this.var_3411 = HabboFriendBar(param1).findFriendsEnabled;
            };
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRendererAvailable);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerAvailable);
            queueInterface(new IIDHabboFriendBarData(), this.onFriendBarDataAvailable);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                this._windowManager.getWindowContext(var_1384).getDesktopWindow().removeEventListener(WindowEvent.var_573, this.onDesktopResized);
                if (this.var_3406)
                {
                    this.var_3406.dispose();
                    this.var_3406 = null;
                };
                if (this.var_3405)
                {
                    this.var_3405.dispose();
                    this.var_3405 = null;
                };
                while (this.var_3407.length > 0)
                {
                    ITab(this.var_3407.pop()).dispose();
                };
                if (this.var_3404)
                {
                    this.var_3404.events.removeEventListener(FriendBarUpdateEvent.var_1385, this.onRefreshView);
                    this.var_3404 = null;
                    release(new IIDHabboFriendBarData());
                };
                if (this._windowManager)
                {
                    this._windowManager = null;
                    release(new IIDHabboWindowManager());
                };
                if (this.var_3403)
                {
                    this.var_3403 = null;
                    release(new IIDAvatarRenderManager());
                };
                this.var_3410.dispose();
                this.var_3410 = null;
                super.dispose();
            };
        }

        public function set visible(param1:Boolean):void
        {
            if (this.var_3405)
            {
                this.var_3405.visible = param1;
                this.var_3405.activate();
            };
            if (this.var_3406)
            {
                this.var_3406.visible = (!(param1));
                if (this.var_3405)
                {
                    this.var_3406.x = this.var_3405.x;
                    this.var_3406.y = this.var_3405.y;
                    this.var_3406.activate();
                };
            };
        }

        public function get visible():Boolean
        {
            return ((this.var_3405) && (this.var_3405.visible));
        }

        public function populate():void
        {
            var _loc4_:int;
            var _loc7_:IFriendEntity;
            var _loc8_:FriendEntityTab;
            var _loc9_:Tab;
            var _loc1_:int = this.var_3409;
            this.deSelect();
            var _loc2_:IItemListWindow = (this.var_3405.findChildByName(var_1386) as IItemListWindow);
            _loc2_.autoArrangeItems = false;
            var _loc3_:int = _loc2_.numListItems;
            _loc4_ = _loc3_;
            while (_loc4_ > 0)
            {
                _loc2_.removeListItemAt((_loc4_ - 1));
                _loc4_--;
            };
            while (this.var_3407.length > 0)
            {
                this.var_3407.pop().recycle();
            };
            var _loc5_:int = (this.var_3404.numFriends + ((this.var_3411) ? 1 : 0));
            var _loc6_:int = Math.min(this.maxNumOfTabsVisible, _loc5_);
            if ((this._startIndex + _loc6_) > _loc5_)
            {
                this._startIndex = Math.max(0, (this._startIndex - ((this._startIndex + _loc6_) - _loc5_)));
            };
            _loc3_ = Math.min(this.var_3404.numFriends, (this._startIndex + _loc6_));
            _loc4_ = this._startIndex;
            while (_loc4_ < _loc3_)
            {
                _loc7_ = this.var_3404.getFriendAt(_loc4_);
                _loc8_ = FriendEntityTab.allocate(_loc7_);
                this.var_3407.push(_loc8_);
                _loc2_.addListItem(_loc8_.window);
                _loc4_++;
            };
            if (this.var_3411)
            {
                if (this.var_3407.length < this.maxNumOfTabsVisible)
                {
                    _loc9_ = new AddFriendsEntityTab();
                    _loc2_.addListItem(_loc9_.window);
                    this.var_3407.push(_loc9_);
                };
            };
            _loc2_.autoArrangeItems = true;
            if (_loc1_ > -1)
            {
                this.selectFriendEntity(_loc1_);
            };
            this.visible = (this.var_3407.length > 0);
            this.toggleArrowButtons((this.var_3407.length < _loc5_));
        }

        private function getFriendEntityTabByID(param1:int):FriendEntityTab
        {
            var _loc2_:FriendEntityTab;
            var _loc3_:int = this.var_3407.length;
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                _loc2_ = (this.var_3407[_loc4_] as FriendEntityTab);
                if (_loc2_)
                {
                    if (_loc2_.friend.id == param1)
                    {
                        return (_loc2_);
                    };
                };
                _loc4_++;
            };
            return (null);
        }

        private function getEntityTabByWindow(param1:IWindow):ITab
        {
            var _loc2_:ITab;
            var _loc3_:int = this.var_3407.length;
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                _loc2_ = this.var_3407[_loc4_];
                if (_loc2_.window == param1)
                {
                    return (_loc2_);
                };
                _loc4_++;
            };
            return (null);
        }

        private function onFriendBarDataAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3404 = (param2 as IHabboFriendBarData);
            this.var_3404.events.addEventListener(FriendBarUpdateEvent.var_1385, this.onRefreshView);
            this.var_3404.events.addEventListener(FindFriendsNotificationEvent.TYPE, this.onFindFriendsNotification);
        }

        private function onWindowManagerAvailable(param1:IID, param2:IUnknown):void
        {
            this._windowManager = (param2 as IHabboWindowManager);
        }

        private function isUserInterfaceReady():Boolean
        {
            return ((this.var_3405) && (!(this.var_3405.disposed)));
        }

        private function buildUserInterface():void
        {
            Tab.var_1391 = this.var_3404;
            Tab.var_1392 = this;
            Tab.var_1393 = assets;
            Tab.var_1394 = this._windowManager;
            Tab.var_1395 = this.var_3410;
            var _loc1_:IAsset = assets.getAssetByName(var_1387);
            this.var_3405 = (this._windowManager.buildFromXML((_loc1_.content as XML), var_1384) as IWindowContainer);
            this.var_3405.x = ((this.var_3405.parent.width / 2) - (this.var_3405.width / 2));
            this.var_3405.y = (this.var_3405.parent.height - (this.var_3405.height + var_1388));
            this.var_3405.setParamFlag(WindowParam.var_668, true);
            this.var_3405.procedure = this.barWindowEventProc;
            if (var_1389)
            {
                _loc1_ = assets.getAssetByName(var_1390);
                this.var_3406 = (this._windowManager.buildFromXML((_loc1_.content as XML), var_1384) as IWindowContainer);
                this.var_3406.x = this.var_3405.x;
                this.var_3406.y = this.var_3405.y;
                this.var_3406.setParamFlag(WindowParam.var_668, true);
                this.var_3406.visible = false;
                this.var_3406.procedure = this.toggleWindowEventProc;
            };
            this.visible = true;
            this._windowManager.getWindowContext(var_1384).getDesktopWindow().addEventListener(WindowEvent.var_573, this.onDesktopResized);
        }

        private function onAvatarRendererAvailable(param1:IID, param2:IUnknown):void
        {
            this.var_3403 = (param2 as IAvatarRenderManager);
        }

        public function getAvatarFaceBitmap(param1:String):BitmapData
        {
            var _loc2_:BitmapData;
            var _loc3_:IAvatarImage;
            if (!_loc2_)
            {
                if (this.var_3403)
                {
                    _loc3_ = this.var_3403.createAvatarImage(param1, AvatarScaleType.var_106, null, this);
                    if (_loc3_)
                    {
                        _loc2_ = _loc3_.getCroppedImage(AvatarSetType.var_107);
                        _loc3_.dispose();
                    };
                };
            };
            return (_loc2_);
        }

        public function avatarImageReady(param1:String):void
        {
            var _loc2_:IFriendEntity;
            var _loc6_:BitmapData;
            var _loc7_:IWindowContainer;
            var _loc8_:IItemListWindow;
            var _loc9_:IWindowContainer;
            var _loc10_:IBitmapWrapperWindow;
            var _loc3_:IItemListWindow = (this.var_3405.findChildByName(var_1386) as IItemListWindow);
            var _loc4_:int = this.var_3404.numFriends;
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                _loc2_ = this.var_3404.getFriendAt(_loc5_);
                if (_loc2_.figure == param1)
                {
                    _loc6_ = this.getAvatarFaceBitmap(_loc2_.figure);
                    if (_loc6_)
                    {
                        _loc7_ = (_loc3_.getListItemByID(_loc2_.id) as IWindowContainer);
                        if (_loc7_)
                        {
                            _loc8_ = (_loc7_.getChildByName(var_1386) as IItemListWindow);
                            if (_loc8_)
                            {
                                _loc9_ = IWindowContainer(_loc8_.getListItemByName(var_186));
                                if (_loc9_)
                                {
                                    _loc10_ = (_loc9_.findChildByName(var_1396) as IBitmapWrapperWindow);
                                    _loc10_.bitmap = _loc6_;
                                    _loc10_.width = _loc6_.width;
                                    _loc10_.height = _loc6_.height;
                                };
                            };
                        };
                    };
                };
                _loc5_++;
            };
        }

        public function faceBookImageReady(param1:BitmapData):void
        {
        }

        private function isFriendSelected(param1:IFriendEntity):Boolean
        {
            return (this.var_3409 == param1.id);
        }

        public function selectTab(param1:ITab):void
        {
            if (!param1.selected)
            {
                if (this.var_3408)
                {
                    this.deSelect();
                };
                param1.select();
                this.var_3408 = param1;
            };
        }

        public function selectFriendEntity(param1:int):void
        {
            if (this.var_3409 == param1)
            {
                return;
            };
            var _loc2_:FriendEntityTab = this.getFriendEntityTabByID(param1);
            if (_loc2_)
            {
                this.selectTab(_loc2_);
                this.var_3409 = param1;
            };
        }

        public function deSelect():void
        {
            if (this.var_3408)
            {
                this.var_3408.deselect();
                this.var_3409 = -1;
            };
        }

        private function onRefreshView(param1:Event):void
        {
            if (!this.isUserInterfaceReady())
            {
                this.buildUserInterface();
            };
            this.resizeAndPopulate(true);
        }

        private function onFindFriendsNotification(event:FindFriendsNotificationEvent):void
        {
            var title:String = ((event.success) ? "${friendbar.find.success.title}" : "${friendbar.find.error.title}");
            var text:String = ((event.success) ? "${friendbar.find.success.text}" : "${friendbar.find.error.text}");
            this._windowManager.notify(title, text, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            }, HabboAlertDialogFlag.var_1047);
        }

        private function barWindowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:int;
            if (param1.type == WindowMouseEvent.var_628)
            {
                _loc3_ = this._startIndex;
                switch (param2.name)
                {
                    case var_1397:
                        _loc3_ = Math.max(0, (this._startIndex - 1));
                        break;
                    case var_1398:
                        _loc3_ = Math.max(0, (this._startIndex - this.numTabsVisibleAtCurrentSize));
                        break;
                    case var_1399:
                        _loc3_ = 0;
                        break;
                    case var_1400:
                        _loc3_ = Math.max(0, Math.min((this.var_3404.numFriends - this.numTabsVisibleAtCurrentSize), (this._startIndex + 1)));
                        break;
                    case var_1401:
                        _loc3_ = Math.max(0, Math.min((this.var_3404.numFriends - this.numTabsVisibleAtCurrentSize), (this._startIndex + this.numTabsVisibleAtCurrentSize)));
                        break;
                    case var_1402:
                        _loc3_ = Math.max(0, (this.var_3404.numFriends - this.numTabsVisibleAtCurrentSize));
                        break;
                    case var_1052:
                        this.visible = false;
                        break;
                };
                if (_loc3_ != this._startIndex)
                {
                    this.deSelect();
                    this._startIndex = _loc3_;
                    this.resizeAndPopulate(true);
                };
            };
            if (param1.type == WindowEvent.var_558)
            {
                this.deSelect();
            };
        }

        private function toggleWindowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (this.var_3406.visible)
            {
                if (param1.type == WindowMouseEvent.var_628)
                {
                    switch (param2.name)
                    {
                        case var_1403:
                            this.visible = true;
                            return;
                    };
                };
            };
        }

        private function toggleArrowButtons(param1:Boolean):void
        {
            this.var_3405.findChildByName(var_1400).visible = param1;
            this.var_3405.findChildByName(var_1397).visible = param1;
        }

        private function resizeAndPopulate(param1:Boolean=false):void
        {
            var _loc2_:int;
            if (!disposed)
            {
                if (this.var_3405)
                {
                    _loc2_ = Math.min(this.maxNumOfTabsVisible, (this.var_3404.numFriends + ((this.var_3411) ? 1 : 0)));
                    if (((!(this.var_3407.length == _loc2_)) || (param1)))
                    {
                        this.populate();
                    };
                    this.var_3405.x = Math.max(((this.var_3405.parent.width / 2) - (this.var_3405.width / 2)), var_1404);
                };
            };
        }

        private function get numTabsVisibleAtCurrentSize():int
        {
            var _loc1_:IItemListWindow = (this.var_3405.findChildByName(var_1386) as IItemListWindow);
            return (_loc1_.width / (var_1405 + _loc1_.spacing));
        }

        private function get maxNumOfTabsVisible():int
        {
            var _loc1_:IItemListWindow = (this.var_3405.findChildByName(var_1386) as IItemListWindow);
            var _loc2_:int = (this._windowManager.getWindowContext(var_1384).getDesktopWindow().width - var_1404);
            var _loc3_:int = (this.var_3405.width - _loc1_.width);
            return ((_loc2_ - _loc3_) / (var_1405 + _loc1_.spacing));
        }

        private function onDesktopResized(param1:WindowEvent):void
        {
            this.resizeAndPopulate(false);
        }

    }
}