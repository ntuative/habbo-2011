﻿package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.friendlist.domain.FriendListTabs;
    import com.sulake.habbo.friendlist.domain.FriendCategories;
    import com.sulake.habbo.friendlist.domain.FriendRequests;
    import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import flash.utils.Timer;
    import com.sulake.habbo.friendlist.domain.FriendCategoriesDeps;
    import com.sulake.habbo.friendlist.domain.AvatarSearchDeps;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.TimerEvent;
    import iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RequestBuddyMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageComposer;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.MessengerInitMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.friendlist.domain.FriendCategory;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitMessageParser;
    import com.sulake.habbo.friendlist.domain.FriendRequestsDeps;
    import com.sulake.habbo.friendlist.domain.Friend;
    import com.sulake.habbo.friendlist.domain.FriendListTabsDeps;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import flash.events.Event;
    import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FollowFriendFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.BuddyRequestsEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewBuddyRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetBuddyRequestsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FriendListUpdateMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.communication.messages.parser.friendlist.BuddyRequestsMessageParser;
    import com.sulake.habbo.friendlist.domain.FriendRequest;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewBuddyRequestMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyFailureData;
    import com.sulake.habbo.communication.messages.parser.friendlist.AcceptBuddyResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.HabboSearchResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.FollowFriendFailedMessageParser;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.incoming.friendlist.*;
    import com.sulake.habbo.friendlist.domain.*;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.*;
    import com.sulake.habbo.communication.messages.parser.friendlist.*;
    import iid.*;

    public class HabboFriendList extends Component implements IHabboFriendList, IAvatarImageListener 
    {

        public static const var_304:String = "face";

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var var_3447:IHabboMessenger;
        private var var_2063:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var var_3403:IAvatarRenderManager;
        private var var_2065:ISessionDataManager;
        private var var_3448:FriendListLookAndFeel = new FriendListLookAndFeel();
        private var var_2809:FriendListTabs;
        private var _view:FriendListView;
        private var var_3449:OpenedToWebPopup;
        private var var_2916:int;
        internal var var_511:FriendCategories;
        private var var_3450:FriendRequests;
        private var var_3451:AvatarSearchResults;
        private var var_2844:IHabboToolbar;
        private var _notifications:IHabboNotifications;
        private var var_3452:Timer;

        public function HabboFriendList(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_511 = new FriendCategories(new FriendCategoriesDeps(this));
            this.var_3451 = new AvatarSearchResults(new AvatarSearchDeps(this));
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationComponentInit);
        }

        override public function dispose():void
        {
            if (this.var_3452)
            {
                this.var_3452.stop();
                this.var_3452.removeEventListener(TimerEvent.TIMER, this.sendFriendListUpdate);
                this.var_3452 = null;
            };
            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._communication)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this.var_3447)
            {
                this.var_3447.release(new IIDHabboMessenger());
                this.var_3447 = null;
            };
            if (this.var_2063)
            {
                this.var_2063.release(new IIDHabboConfigurationManager());
                this.var_2063 = null;
            };
            if (this._localization)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this.var_3403)
            {
                this.var_3403.release(new IIDAvatarRenderManager());
                this.var_3403 = null;
            };
            if (this._notifications)
            {
                this._notifications.release(new IIDHabboNotifications());
                this._notifications = null;
            };
            if (this.var_2844)
            {
                this.var_2844.release(new IIDHabboToolbar());
                this.var_2844 = null;
            };
            if (this.var_2065)
            {
                this.var_2065.release(new IIDSessionDataManager());
                this.var_2065 = null;
            };
            super.dispose();
        }

        public function send(param1:IMessageComposer):void
        {
            this._communication.getHabboMainConnection(null).send(param1);
        }

        public function openHabboWebPage(linkAlias:String, params:Dictionary, x:int, y:int):void
        {
            var url:String = this.getVariable(linkAlias, params);
            var webWindowName:String = "habboMain";
            try
            {
                HabboWebTools.navigateToURL(url, webWindowName);
            }
            catch(e:Error)
            {
                Logger.log(("GOT ERROR: " + e));
            };
            if (this.var_3449 == null)
            {
                this.var_3449 = new OpenedToWebPopup(this);
            };
            this.var_3449.show(x, y);
        }

        public function getText(param1:String):String
        {
            return (this._localization.getKey(param1));
        }

        public function registerParameter(param1:String, param2:String, param3:String):void
        {
            this._localization.registerParameter(param1, param2, param3);
        }

        public function showLimitReachedAlert():void
        {
            this.registerParameter("friendlist.listfull.text", "mylimit", ("" + this.friendRequests.limit));
            this.registerParameter("friendlist.listfull.text", "clublimit", ("" + this.friendRequests.clubLimit));
            this.registerParameter("friendlist.listfull.text", "viplimit", ("" + this.friendRequests.vipLimit));
            new SimpleAlertView(this, "${friendlist.listfull.title}", "${friendlist.listfull.text}").show();
        }

        public function getFriend(param1:int):IFriend
        {
            if (this._view == null)
            {
                Logger.log("Cannot process getFriend. Friendlist not initialized.");
                return (null);
            };
            return (this.var_511.findFriend(param1));
        }

        public function canBeAskedForAFriend(param1:int):Boolean
        {
            if (this._view == null)
            {
                Logger.log("Cannot process canBeAskedForAFriend. Friendlist not initialized.");
                return (false);
            };
            return (((this.getFriend(param1) == null) && (!(this.searchResults.isFriendRequestSent(param1)))) && (this.categories.getFriendCount(false) < this.friendRequests.limit));
        }

        public function askForAFriend(param1:int, param2:String):Boolean
        {
            if (this._view == null)
            {
                Logger.log("Cannot ask for friend. Friendlist not initialized.");
                return (false);
            };
            if (!this.canBeAskedForAFriend(param1))
            {
                return (false);
            };
            this.send(new RequestBuddyMessageComposer(param2));
            this.searchResults.setFriendRequestSent(param1);
            this.send(new FriendRequestQuestCompleteMessageComposer());
            return (true);
        }

        public function openFriendList():void
        {
            if (this._view == null)
            {
                Logger.log("Cannot open friendlist. Friendlist not initialized.");
                return;
            };
            this._view.openFriendList();
            var _loc1_:FriendListTab = this.tabs.findTab(FriendListTab.var_512);
            if (_loc1_ != this.tabs.findSelectedTab())
            {
                this.tabs.toggleSelected(_loc1_);
                this.view.refresh("openFriendList");
            };
            this._view.mainWindow.activate();
        }

        public function getFriendCount(param1:Boolean, param2:Boolean):int
        {
            if (this._view == null)
            {
                Logger.log("Cannot get friend count. Friendlist not initialized.");
                return (0);
            };
            return (this.var_511.getFriendCount(param1, param2));
        }

        public function refreshToolBarIcon():void
        {
            var _loc1_:HabboToolbarSetIconEvent = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_176, HabboToolbarIconEnum.FRIENDLIST);
            _loc1_.iconState = String(((this.var_3450.getCountOfOpenRequests() > 0) ? "2" : "0"));
            this.var_2844.events.dispatchEvent(_loc1_);
        }

        public function getButton(param1:String, param2:String, param3:Function, param4:int=0, param5:int=0, param6:int=0):IBitmapWrapperWindow
        {
            var _loc7_:BitmapData = this.getButtonImage(param2);
            var _loc8_:IBitmapWrapperWindow = (this._windowManager.createWindow(param1, "", HabboWindowType.var_155, HabboWindowStyle.var_156, (HabboWindowParam.var_157 | HabboWindowParam.var_158), new Rectangle(param4, param5, _loc7_.width, _loc7_.height), param3, param6) as IBitmapWrapperWindow);
            _loc8_.bitmap = _loc7_;
            return (_loc8_);
        }

        public function getXmlWindow(param1:String):IWindow
        {
            var _loc2_:IAsset = assets.getAssetByName((param1 + "_xml"));
            var _loc3_:XmlAsset = XmlAsset(_loc2_);
            return (this._windowManager.buildFromXML(XML(_loc3_.content)));
        }

        public function getAvatarFaceBitmap(param1:String):BitmapData
        {
            var _loc2_:IAvatarImage = this.var_3403.createAvatarImage(param1, AvatarScaleType.var_305, null, this);
            if (!_loc2_)
            {
                return (null);
            };
            var _loc3_:BitmapData = _loc2_.getCroppedImage(AvatarSetType.var_107);
            _loc2_.dispose();
            return (_loc3_);
        }

        public function isEmbeddedMinimailEnabled():Boolean
        {
            var _loc1_:String = this.var_2063.getKey("client.minimail.embed.enabled");
            return (_loc1_ == "true");
        }

        private function getVariable(param1:String, param2:Dictionary):String
        {
            return (this.var_2063.getKey(param1, param1, param2));
        }

        private function onCommunicationComponentInit(param1:IID=null, param2:IUnknown=null):void
        {
            Logger.log(("Friend list: communication available " + [param1, param2]));
            this._communication = (param2 as IHabboCommunicationManager);
            queueInterface(new IIDHabboMessenger(), this.onMessengerComponentInit);
        }

        private function onMessengerComponentInit(param1:IID=null, param2:IUnknown=null):void
        {
            Logger.log(("Friend list: messenger available " + [param1, param2]));
            this.var_3447 = (param2 as IHabboMessenger);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderedReady);
        }

        private function onAvatarRenderedReady(param1:IID=null, param2:IUnknown=null):void
        {
            Logger.log(("Messenger: avatar renderer " + [param1, param2]));
            this.var_3403 = (param2 as IAvatarRenderManager);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
        }

        private function onConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            Logger.log(("Friend list: configuration " + [param1, param2]));
            this.var_2063 = (param2 as IHabboConfigurationManager);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
        }

        private function onLocalizationReady(param1:IID=null, param2:IUnknown=null):void
        {
            Logger.log(("Friend list: localization " + [param1, param2]));
            this._localization = (param2 as IHabboLocalizationManager);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
        }

        private function onToolbarReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_2844 = (IHabboToolbar(param2) as IHabboToolbar);
            queueInterface(new IIDHabboNotifications(), this.onNotificationsReady);
        }

        private function onNotificationsReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._notifications = (param2 as IHabboNotifications);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            Logger.log(("Friend list: window manager " + [param1, param2]));
            this._windowManager = (param2 as IHabboWindowManager);
            this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthOK));
            this._communication.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            queueInterface(new IIDSessionDataManager(), this.onSessionDataReady);
        }

        private function onSessionDataReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_2065 = (param2 as ISessionDataManager);
        }

        private function onAuthOK(param1:IMessageEvent):void
        {
            this._communication.addHabboConnectionMessageEvent(new MessengerInitEvent(this.onMessengerInit));
            this.send(new MessengerInitMessageComposer());
        }

        private function onUserObject(param1:IMessageEvent):void
        {
            var _loc2_:UserObjectMessageParser = (param1 as UserObjectEvent).getParser();
            this.var_2916 = int(_loc2_.id);
        }

        private function onMessengerInit(param1:IMessageEvent):void
        {
            var _loc3_:FriendCategoryData;
            var _loc4_:FriendData;
            var _loc5_:FriendCategory;
            this._view = new FriendListView(this);
            var _loc2_:MessengerInitMessageParser = (param1 as MessengerInitEvent).getParser();
            this.var_3450 = new FriendRequests(new FriendRequestsDeps(this), _loc2_.userFriendLimit, _loc2_.extendedFriendLimit, _loc2_.evenMoreExtendedFriendLimit);
            for each (_loc3_ in _loc2_.categories)
            {
                this.var_511.addCategory(new FriendCategory(_loc3_.id, _loc3_.name));
            };
            this.var_511.addCategory(new FriendCategory(FriendCategory.var_513, this.getText("friendlist.friends")));
            this.var_511.addCategory(new FriendCategory(FriendCategory.var_514, this.getText("friendlist.friends.offlinecaption")));
            for each (_loc4_ in this.getSortedFriends(_loc2_.friends))
            {
                this.var_511.addFriend(new Friend(_loc4_));
            };
            this.var_2809 = new FriendListTabs(new FriendListTabsDeps(this));
            if (!this.var_3452)
            {
                this.var_3452 = new Timer(120000);
                this.var_3452.addEventListener(TimerEvent.TIMER, this.sendFriendListUpdate);
                this.var_3452.start();
            };
            this.getBuddyRequests();
            this.registerListeners();
            this.var_2844.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_145, HabboToolbarIconEnum.FRIENDLIST));
            this.var_2844.events.addEventListener(HabboToolbarEvent.var_49, this.onHabboToolbarEvent);
            if (this.var_511.getFriendCount(true, false) == 0)
            {
                _loc5_ = this.var_511.findCategory(FriendCategory.var_514);
                if (_loc5_)
                {
                    _loc5_.setOpen(true);
                };
            };
            Logger.log("FRIENDLIST INITIALIZED SUCCESSFULLY");
        }

        private function onHabboToolbarEvent(param1:HabboToolbarEvent):void
        {
            if (param1.iconId != HabboToolbarIconEnum.FRIENDLIST)
            {
                return;
            };
            if (param1.type == HabboToolbarEvent.var_49)
            {
                this.toggleWindow();
            };
        }

        public function trackFriendListEvent(param1:String):void
        {
            events.dispatchEvent(new Event(param1));
        }

        private function toggleWindow():void
        {
            var _loc1_:FriendListTab;
            if (this._view.isFriendListOpen())
            {
                this._view.close();
                this.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
            }
            else
            {
                this._view.openFriendList();
                _loc1_ = this.var_2809.findSelectedTab();
                if (_loc1_ == null)
                {
                    events.dispatchEvent(new Event(HabboFriendListTrackingEvent.var_48));
                }
                else
                {
                    switch (_loc1_.id)
                    {
                        case FriendListTab.var_512:
                            this.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS);
                            return;
                        case FriendListTab.var_515:
                            this.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH);
                            return;
                        case FriendListTab.var_516:
                            this.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST);
                            return;
                    };
                };
            };
        }

        private function getSortedFriends(param1:Array):Array
        {
            var _loc4_:FriendData;
            var _loc5_:Array;
            var _loc6_:String;
            var _loc2_:Array = new Array();
            var _loc3_:Dictionary = new Dictionary();
            for each (_loc4_ in param1)
            {
                _loc2_.push(_loc4_.name.toLowerCase());
                _loc3_[_loc4_.name.toLowerCase()] = _loc4_;
            };
            _loc2_.sort();
            _loc5_ = new Array();
            for each (_loc6_ in _loc2_)
            {
                _loc5_.push(_loc3_[_loc6_]);
            };
            return (_loc5_);
        }

        private function registerListeners():void
        {
            this._communication.addHabboConnectionMessageEvent(new FollowFriendFailedEvent(this.onFollowFriendFailed));
            this._communication.addHabboConnectionMessageEvent(new FriendListUpdateEvent(this.onFriendListUpdate));
            this._communication.addHabboConnectionMessageEvent(new BuddyRequestsEvent(this.onBuddyRequests));
            this._communication.addHabboConnectionMessageEvent(new NewBuddyRequestEvent(this.onNewBuddyRequest));
            this._communication.addHabboConnectionMessageEvent(new AcceptBuddyResultEvent(this.onAcceptBuddyResult));
            this._communication.addHabboConnectionMessageEvent(new MessengerErrorEvent(this.onMessengerError));
            this._communication.addHabboConnectionMessageEvent(new HabboSearchResultEvent(this.onHabboSearchResult));
            this._communication.addHabboConnectionMessageEvent(new RoomInviteErrorEvent(this.onRoomInviteError));
            this._communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
        }

        private function getBuddyRequests():void
        {
            Logger.log("Sending buddy requests request");
            this.send(new GetBuddyRequestsMessageComposer());
        }

        protected function sendFriendListUpdate(param1:Event):void
        {
            Logger.log("Sending update request");
            this.send(new FriendListUpdateMessageComposer());
        }

        private function onBuddyRequests(param1:IMessageEvent):void
        {
            var _loc3_:FriendRequestData;
            var _loc2_:BuddyRequestsMessageParser = (param1 as BuddyRequestsEvent).getParser();
            this.var_3450.clearAndUpdateView(false);
            for each (_loc3_ in _loc2_.reqs)
            {
                this.var_3450.addRequest(new FriendRequest(_loc3_));
            };
            if (_loc2_.reqs.length > 0)
            {
                this.var_2809.findTab(FriendListTab.var_516).setNewMessageArrived(true);
                this.refreshToolBarIcon();
            };
            this._view.refresh("buddyRequests");
        }

        private function onNewBuddyRequest(param1:IMessageEvent):void
        {
            Logger.log("Received new buddy request");
            var _loc2_:NewBuddyRequestMessageParser = (param1 as NewBuddyRequestEvent).getParser();
            var _loc3_:FriendRequest = new FriendRequest(_loc2_.req);
            this.var_3450.addRequestAndUpdateView(_loc3_);
            var _loc4_:FriendListTab = this.var_2809.findTab(FriendListTab.var_516);
            _loc4_.setNewMessageArrived(true);
            this.refreshToolBarIcon();
            this._view.refresh("newBuddyRequest");
        }

        private function onAcceptBuddyResult(param1:IMessageEvent):void
        {
            var _loc3_:AcceptBuddyFailureData;
            var _loc2_:AcceptBuddyResultMessageParser = (param1 as AcceptBuddyResultEvent).getParser();
            for each (_loc3_ in _loc2_.failures)
            {
                this.friendRequests.acceptFailed(_loc3_.senderName);
            };
        }

        private function onHabboSearchResult(param1:IMessageEvent):void
        {
            var _loc2_:HabboSearchResultMessageParser = (param1 as HabboSearchResultEvent).getParser();
            this.var_3451.searchReceived(_loc2_.friends, _loc2_.others);
            this._view.refresh("search");
        }

        private function onMessengerError(param1:IMessageEvent):void
        {
            var _loc2_:MessengerErrorMessageParser = (param1 as MessengerErrorEvent).getParser();
            var _loc3_:String = "";
            switch (_loc2_.errorCode)
            {
                case 1:
                    _loc3_ = "${friendlist.error.friendlistownlimit}";
                    break;
                case 2:
                    _loc3_ = "${friendlist.error.friendlistlimitofrequester}";
                    break;
                case 3:
                    _loc3_ = "${friendlist.error.friend_requests_disabled}";
                    break;
                case 4:
                    _loc3_ = "${friendlist.error.requestnotfound}";
                    break;
                default:
                    _loc3_ = ((("Received messenger error: msg: " + _loc2_.clientMessageId) + ", errorCode: ") + _loc2_.errorCode);
            };
            new SimpleAlertView(this, "${friendlist.alert.title}", _loc3_).show();
        }

        private function onRoomInviteError(param1:IMessageEvent):void
        {
            var _loc2_:RoomInviteErrorMessageParser = (param1 as RoomInviteErrorEvent).getParser();
            var _loc3_:String = ((("Received room invite error: errorCode: " + _loc2_.errorCode) + ", recipients: ") + Util.arrayToString(_loc2_.failedRecipients));
            new SimpleAlertView(this, "${friendlist.alert.title}", _loc3_).show();
        }

        private function onFriendListUpdate(param1:IMessageEvent):void
        {
            this.var_511.onFriendListUpdate(param1);
            this._view.refresh("friendListUpdate");
        }

        private function onFollowFriendFailed(param1:IMessageEvent):void
        {
            var _loc2_:FollowFriendFailedMessageParser = (param1 as FollowFriendFailedEvent).getParser();
            var _loc3_:String = this.getFollowFriendErrorText(_loc2_.errorCode);
            Logger.log(((("Received follow friend failed: " + _loc2_.errorCode) + ", ") + _loc3_));
            new SimpleAlertView(this, "${friendlist.alert.title}", _loc3_).show();
        }

        private function getFollowFriendErrorText(param1:int):String
        {
            if (param1 == 0)
            {
                return ("${friendlist.followerror.notfriend}");
            };
            if (param1 == 1)
            {
                return ("${friendlist.followerror.offline}");
            };
            if (param1 == 2)
            {
                return ("${friendlist.followerror.hotelview}");
            };
            if (param1 == 3)
            {
                return ("${friendlist.followerror.prevented}");
            };
            return ("Unknown follow friend error " + param1);
        }

        public function refreshText(param1:IWindowContainer, param2:String, param3:Boolean, param4:String):void
        {
            var _loc5_:IWindow = param1.getChildByName(param2);
            if (!param3)
            {
                _loc5_.visible = false;
            }
            else
            {
                _loc5_.visible = true;
                _loc5_.caption = param4;
            };
        }

        public function refreshButton(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function, param5:int):void
        {
            var _loc6_:IWindow = (param1.findChildByName(param2) as IWindow);
            if (!param3)
            {
                _loc6_.visible = false;
            }
            else
            {
                this.prepareButton(_loc6_, param2, param4, param5);
                _loc6_.visible = true;
            };
        }

        public function refreshIcon(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function, param5:int):void
        {
            var _loc6_:IWindow = param1.findChildByName(param2);
            if (!param3)
            {
                _loc6_.visible = false;
            }
            else
            {
                _loc6_.id = param5;
                _loc6_.procedure = param4;
                _loc6_.visible = true;
            };
        }

        private function prepareButton(param1:IWindow, param2:String, param3:Function, param4:int):void
        {
            var _loc5_:IBitmapWrapperWindow;
            param1.id = param4;
            if ((param1 is IBitmapWrapperWindow))
            {
                _loc5_ = (param1 as IBitmapWrapperWindow);
            }
            else
            {
                _loc5_ = (IWindowContainer(param1).findChildByTag("bitmap") as IBitmapWrapperWindow);
            };
            if (_loc5_.bitmap != null)
            {
                return;
            };
            _loc5_.bitmap = this.getButtonImage(param2);
            _loc5_.width = _loc5_.bitmap.width;
            _loc5_.height = _loc5_.bitmap.height;
            param1.procedure = param3;
        }

        public function getButtonImage(param1:String):BitmapData
        {
            var _loc5_:BitmapData;
            var _loc2_:IAsset = assets.getAssetByName((param1 + "_png"));
            var _loc3_:BitmapDataAsset = (_loc2_ as BitmapDataAsset);
            Logger.log(("GETTING ASSET: " + param1));
            var _loc4_:BitmapData = (_loc3_.content as BitmapData);
            Logger.log(((("GOT ASSET: " + _loc2_) + ", ") + _loc4_));
            _loc5_ = new BitmapData(_loc4_.width, _loc4_.height, true, 0);
            _loc5_.draw(_loc4_);
            return (_loc5_);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get categories():FriendCategories
        {
            return (this.var_511);
        }

        public function get friendRequests():FriendRequests
        {
            return (this.var_3450);
        }

        public function get searchResults():AvatarSearchResults
        {
            return (this.var_3451);
        }

        public function get view():FriendListView
        {
            return (this._view);
        }

        public function get tabs():FriendListTabs
        {
            return (this.var_2809);
        }

        public function get laf():FriendListLookAndFeel
        {
            return (this.var_3448);
        }

        public function get messenger():IHabboMessenger
        {
            return (this.var_3447);
        }

        public function get avatarId():int
        {
            return (this.var_2916);
        }

        public function get toolbar():IHabboToolbar
        {
            return (this.var_2844);
        }

        public function get notifications():IHabboNotifications
        {
            return (this._notifications);
        }

        public function getFriendNames():Array
        {
            if (this.var_511 == null)
            {
                return ([]);
            };
            return (this.var_511.getFriendNames());
        }

        public function acceptFriendRequest(param1:int):void
        {
            var _loc2_:FriendListTab = this.var_2809.findTab(FriendListTab.var_516);
            if (!_loc2_)
            {
                return;
            };
            var _loc3_:IFriendRequestsView = (_loc2_.tabView as IFriendRequestsView);
            if (!_loc3_)
            {
                return;
            };
            _loc3_.acceptRequest(param1);
        }

        public function declineFriendRequest(param1:int):void
        {
            var _loc2_:FriendListTab = this.var_2809.findTab(FriendListTab.var_516);
            if (!_loc2_)
            {
                return;
            };
            var _loc3_:IFriendRequestsView = (_loc2_.tabView as IFriendRequestsView);
            if (!_loc3_)
            {
                return;
            };
            _loc3_.declineRequest(param1);
        }

        private function onUserRights(param1:IMessageEvent):void
        {
            if (((!(this.var_2065)) || (!(this.var_3450))))
            {
                return;
            };
            var _loc2_:int;
            if (this.var_2065.hasUserRight("fuse_super_extended_buddylist", HabboClubLevelEnum.var_122))
            {
                _loc2_ = this.var_3450.vipLimit;
            }
            else
            {
                if (this.var_2065.hasUserRight("fuse_extended_buddylist", HabboClubLevelEnum.var_256))
                {
                    _loc2_ = this.var_3450.clubLimit;
                };
            };
            if (_loc2_ > this.var_3450.limit)
            {
                this.var_3450.limit = _loc2_;
            };
        }

        public function avatarImageReady(param1:String):void
        {
            var _loc3_:Friend;
            var _loc4_:IBitmapWrapperWindow;
            var _loc5_:BitmapData;
            if (((disposed) || (this.var_511 == null)))
            {
                return;
            };
            var _loc2_:Dictionary = this.var_511.getAllFriends();
            if (_loc2_ == null)
            {
                return;
            };
            for each (_loc3_ in _loc2_)
            {
                if ((((!(_loc3_ == null)) && (!(_loc3_.disposed))) && (_loc3_.figure == param1)))
                {
                    _loc3_.face = this.getAvatarFaceBitmap(_loc3_.figure);
                    if (_loc3_.face != null)
                    {
                        _loc4_ = (_loc3_.view.getChildByName(var_304) as IBitmapWrapperWindow);
                        if (((!(_loc4_ == null)) && (!(_loc4_.disposed))))
                        {
                            _loc5_ = _loc4_.bitmap;
                            if (_loc5_ != null)
                            {
                                _loc5_.fillRect(_loc5_.rect, 0);
                                _loc5_.copyPixels(_loc3_.face, _loc3_.face.rect, new Point(0, 0), null, null, true);
                            };
                            _loc4_.invalidate();
                        };
                    };
                };
            };
        }

    }
}