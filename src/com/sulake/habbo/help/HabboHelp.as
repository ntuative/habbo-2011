package com.sulake.habbo.help
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.help.tutorial.TutorialUI;
    import com.sulake.habbo.help.hotelmerge.HotelMergeUI;
    import com.sulake.habbo.help.cfh.data.CallForHelpData;
    import com.sulake.habbo.help.cfh.data.UserRegistry;
    import iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;

    public class HabboHelp extends Component implements IHabboHelp 
    {

        private var var_2844:IHabboToolbar;
        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var var_2077:IHabboCommunicationManager;
        private var var_3506:IHabboLocalizationManager;
        private var var_3507:IHabboConfigurationManager;
        private var var_2847:ISessionDataManager;
        private var var_3508:FaqIndex;
        private var var_3509:IncomingMessages;
        private var var_3510:HelpUI;
        private var var_3511:TutorialUI;
        private var var_3512:HotelMergeUI;
        private var var_3513:CallForHelpData = new CallForHelpData();
        private var var_3514:UserRegistry = new UserRegistry();
        private var var_3515:String = "";
        private var var_3516:WelcomeScreenController;

        public function HabboHelp(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this._assetLibrary = param3;
            this.var_3508 = new FaqIndex();
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
        }

        public function set ownUserName(param1:String):void
        {
            this.var_3515 = param1;
        }

        public function get ownUserName():String
        {
            return (this.var_3515);
        }

        public function get callForHelpData():CallForHelpData
        {
            return (this.var_3513);
        }

        public function get userRegistry():UserRegistry
        {
            return (this.var_3514);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this.var_3506);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get toolbar():IHabboToolbar
        {
            return (this.var_2844);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (this.var_2847);
        }

        public function get tutorialUI():TutorialUI
        {
            return (this.var_3511);
        }

        public function get hotelMergeUI():HotelMergeUI
        {
            return (this.var_3512);
        }

        public function hasChangedName():Boolean
        {
            if (this.var_3511)
            {
                return (this.var_3511.hasChangedName);
            };
            return (true);
        }

        override public function dispose():void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.dispose();
                this.var_3510 = null;
            };
            if (this.var_3511 != null)
            {
                this.var_3511.dispose();
                this.var_3511 = null;
            };
            if (this.var_3512)
            {
                this.var_3512.dispose();
                this.var_3512 = null;
            };
            if (this.var_3508 != null)
            {
                this.var_3508.dispose();
                this.var_3508 = null;
            };
            this.var_3509 = null;
            if (this.var_2844)
            {
                this.var_2844.release(new IIDHabboToolbar());
                this.var_2844 = null;
            };
            if (this.var_3506)
            {
                this.var_3506.release(new IIDHabboLocalizationManager());
                this.var_3506 = null;
            };
            if (this.var_2077)
            {
                this.var_2077.release(new IIDHabboCommunicationManager());
                this.var_2077 = null;
            };
            if (this.var_3507)
            {
                this.var_3507.release(new IIDHabboConfigurationManager());
                this.var_3507 = null;
            };
            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this.var_2847 != null)
            {
                this.var_2847.release(new IIDSessionDataManager());
                this.var_2847 = null;
            };
            if (this.var_3516 != null)
            {
                this.var_3516.dispose();
                this.var_3516 = null;
            };
            super.dispose();
        }

        public function showUI(param1:String=null):void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.showUI(param1);
            };
        }

        public function hideUI():void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.hideUI();
            };
        }

        public function tellUI(param1:String, param2:*=null):void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.tellUI(param1, param2);
            };
        }

        public function enableCallForGuideBotUI():void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.updateCallForGuideBotUI(true);
            };
        }

        public function disableCallForGuideBotUI():void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.updateCallForGuideBotUI(false);
            };
        }

        public function getFaq():FaqIndex
        {
            return (this.var_3508);
        }

        public function sendMessage(param1:IMessageComposer):void
        {
            if (((!(this.var_2077 == null)) && (!(param1 == null))))
            {
                this.var_2077.getHabboMainConnection(null).send(param1);
            };
        }

        public function getConfigurationKey(param1:String, param2:String=null, param3:Dictionary=null):String
        {
            if (this.var_3507 == null)
            {
                return (param1);
            };
            return (this.var_3507.getKey(param1, param2, param3));
        }

        public function showCallForHelpReply(param1:String):void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.showCallForHelpReply(param1);
            };
        }

        public function showCallForHelpResult(param1:String):void
        {
            if (this.var_3510 != null)
            {
                this.var_3510.showCallForHelpResult(param1);
            };
        }

        public function reportUser(param1:int, param2:String):void
        {
            this.var_3513.reportedUserId = param1;
            this.var_3513.reportedUserName = param2;
            this.var_3510.showUI(HabboHelpViewEnum.var_302);
        }

        private function toggleHelpUI():void
        {
            if (this.var_3510 == null)
            {
                if (!this.createHelpUI())
                {
                    return;
                };
            };
            this.var_3510.toggleUI();
        }

        private function createHelpUI():Boolean
        {
            if ((((this.var_3510 == null) && (!(this._assetLibrary == null))) && (!(this._windowManager == null))))
            {
                this.var_3510 = new HelpUI(this, this._assetLibrary, this._windowManager, this.var_3506, this.var_2844);
            };
            return (!(this.var_3510 == null));
        }

        private function createTutorialUI():Boolean
        {
            var _loc1_:Boolean;
            if ((((this.var_3511 == null) && (!(this._assetLibrary == null))) && (!(this._windowManager == null))))
            {
                _loc1_ = (this.getConfigurationKey("avatar.widget.enabled", "0") == "0");
                this.var_3511 = new TutorialUI(this, _loc1_);
            };
            return (!(this.var_3511 == null));
        }

        public function removeTutorialUI():void
        {
            if (this.var_3511 != null)
            {
                this.var_3511.dispose();
                this.var_3511 = null;
            };
        }

        public function initHotelMergeUI():void
        {
            if (!this.var_3512)
            {
                this.var_3512 = new HotelMergeUI(this);
            };
            this.var_3512.startNameChange();
        }

        public function updateTutorial(param1:Boolean, param2:Boolean, param3:Boolean):void
        {
            if ((((param1) && (param2)) && (param3)))
            {
                this.removeTutorialUI();
                return;
            };
            if (this.var_3511 == null)
            {
                if (!this.createTutorialUI())
                {
                    return;
                };
            };
            this.var_3511.update(param1, param2, param3);
        }

        public function startNameChange():void
        {
            if (this.var_3511)
            {
                this.var_3511.showView(TutorialUI.var_303);
            };
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(param2);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
        }

        private function onCommunicationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_2077 = IHabboCommunicationManager(param2);
            this.var_3509 = new IncomingMessages(this, this.var_2077);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
        }

        private function onToolbarReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_2844 = IHabboToolbar(param2);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
        }

        private function onLocalizationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_3506 = IHabboLocalizationManager(param2);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
        }

        private function onConfigurationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_3507 = IHabboConfigurationManager(param2);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
        }

        private function onRoomSessionManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc3_:IRoomSessionManager = IRoomSessionManager(param2);
            _loc3_.events.addEventListener(RoomSessionEvent.var_94, this.onRoomSessionEvent);
            _loc3_.events.addEventListener(RoomSessionEvent.var_98, this.onRoomSessionEvent);
            this.var_2844.events.addEventListener(HabboToolbarEvent.var_100, this.onHabboToolbarEvent);
            this.var_2844.events.addEventListener(HabboToolbarEvent.var_49, this.onHabboToolbarEvent);
            this.createHelpUI();
            this.setHabboToolbarIcon();
        }

        private function onSessionDataManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this.var_2847 = (param2 as ISessionDataManager);
        }

        private function onRoomSessionEvent(param1:RoomSessionEvent):void
        {
            switch (param1.type)
            {
                case RoomSessionEvent.var_94:
                    if (this.var_3510 != null)
                    {
                        this.var_3510.setRoomSessionStatus(true);
                    };
                    if (this.var_3511 != null)
                    {
                        this.var_3511.setRoomSessionStatus(true);
                    };
                    this.showWelcomeScreen(true);
                    return;
                case RoomSessionEvent.var_98:
                    if (this.var_3510 != null)
                    {
                        this.var_3510.setRoomSessionStatus(false);
                    };
                    if (this.var_3511 != null)
                    {
                        this.var_3511.setRoomSessionStatus(false);
                    };
                    this.userRegistry.unregisterRoom();
                    this.showWelcomeScreen(false);
                    return;
            };
        }

        private function showWelcomeScreen(param1:Boolean):void
        {
            if (!this.var_3516)
            {
                this.var_3516 = new WelcomeScreenController(this, this._windowManager, this.var_3507);
            };
            this.var_3516.showWelcomeScreen(param1);
        }

        private function setHabboToolbarIcon():void
        {
            if (this.var_2844 != null)
            {
                this.var_2844.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_145, HabboToolbarIconEnum.HELP));
            };
        }

        private function onHabboToolbarEvent(param1:HabboToolbarEvent):void
        {
            if (param1.type == HabboToolbarEvent.var_100)
            {
                this.setHabboToolbarIcon();
                return;
            };
            if (param1.type == HabboToolbarEvent.var_49)
            {
                if (param1.iconId == HabboToolbarIconEnum.HELP)
                {
                    this.toggleHelpUI();
                    return;
                };
            };
        }

        public function setWelcomeNotifications(param1:Array):void
        {
            if (!this.var_3516)
            {
                this.showWelcomeScreen(true);
            };
            this.var_3516.notifications = param1;
        }

    }
}