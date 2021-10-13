package com.sulake.habbo.widget.chatinput
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import flash.utils.Timer;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.utils.getTimer;
    import com.sulake.habbo.widget.messages.RoomWidgetChatMessage;
    import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetFloodControlEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
    import flash.events.TimerEvent;
    import com.sulake.core.runtime.exceptions.CrashMeError;
    import com.sulake.core.window.IWindow;

    public class RoomChatInputWidget extends RoomWidgetBase 
    {

        private static const var_1351:int = 5000;

        private var _visualization:RoomChatInputView;
        private var var_4682:String = "";
        private var var_4683:int = 0;
        private var var_4684:Boolean = false;
        private var var_4685:Timer = null;
        private var var_4686:int;
        private var var_4687:Boolean = false;
        private var var_3479:Component = null;
        private var var_2063:IHabboConfigurationManager;

        public function RoomChatInputWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager, param5:Component)
        {
            super(param1, param2, param3);
            this.var_3479 = param5;
            this.var_2063 = param4;
            this._visualization = new RoomChatInputView(this);
        }

        public function get floodBlocked():Boolean
        {
            return (this.var_4684);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this.var_2063);
        }

        override public function dispose():void
        {
            if (this._visualization != null)
            {
                this._visualization.dispose();
                this._visualization = null;
            };
            if (this.var_4685 != null)
            {
                this.var_4685.stop();
                this.var_4685 = null;
            };
            this.var_3479 = null;
            this.var_2063 = null;
            super.dispose();
        }

        public function get allowPaste():Boolean
        {
            return ((getTimer() - this.var_4686) > var_1351);
        }

        public function setLastPasteTime():void
        {
            this.var_4686 = getTimer();
        }

        public function sendChat(param1:String, param2:int, param3:String=""):void
        {
            if (this.var_4684)
            {
                return;
            };
            var _loc4_:RoomWidgetChatMessage = new RoomWidgetChatMessage(RoomWidgetChatMessage.var_1352, param1, param2, param3);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc4_);
            };
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1340, this.onRoomObjectSelected);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.onRoomObjectDeselected);
            param1.addEventListener(RoomWidgetChatInputContentUpdateEvent.var_1353, this.onChatInputUpdate);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.var_1256, this.onUserInfo);
            param1.addEventListener(RoomWidgetFloodControlEvent.var_1354, this.onFloodControl);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1340, this.onRoomObjectSelected);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1257, this.onRoomObjectDeselected);
            param1.removeEventListener(RoomWidgetChatInputContentUpdateEvent.var_1353, this.onChatInputUpdate);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.var_1256, this.onUserInfo);
            param1.removeEventListener(RoomWidgetFloodControlEvent.var_1354, this.onFloodControl);
        }

        private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1336, param1.id, param1.category);
        }

        private function onRoomObjectDeselected(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            this.var_4682 = "";
        }

        private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.var_4682 = param1.name;
        }

        private function onChatInputUpdate(param1:RoomWidgetChatInputContentUpdateEvent):void
        {
            var _loc2_:String = "";
            switch (param1.messageType)
            {
                case RoomWidgetChatInputContentUpdateEvent.var_1355:
                    _loc2_ = localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
                    this._visualization.displaySpecialChatMessage(_loc2_, param1.userName);
                    return;
                case RoomWidgetChatInputContentUpdateEvent.var_1356:
                    return;
            };
        }

        private function onReleaseTimerComplete(param1:TimerEvent):void
        {
            Logger.log("Releasing flood blocking");
            this.var_4684 = false;
            if (this._visualization != null)
            {
                this._visualization.hideFloodBlocking();
            };
            this.var_4685 = null;
        }

        private function onReleaseTimerTick(param1:TimerEvent):void
        {
            if (this._visualization != null)
            {
                this.var_4683 = (this.var_4683 - 1);
                this._visualization.updateBlockText(this.var_4683);
            };
        }

        public function get selectedUserName():String
        {
            return (this.var_4682);
        }

        public function triggerManualCrash():void
        {
            this.var_4687 = true;
            throw (new CrashMeError());
        }

        public function onFloodControl(param1:RoomWidgetFloodControlEvent):void
        {
            this.var_4684 = true;
            this.var_4683 = param1.seconds;
            Logger.log((("Enabling flood blocking for " + this.var_4683) + " seconds"));
            if (this.var_4685)
            {
                this.var_4685.reset();
            }
            else
            {
                this.var_4685 = new Timer(1000, this.var_4683);
                this.var_4685.addEventListener(TimerEvent.TIMER, this.onReleaseTimerTick);
                this.var_4685.addEventListener(TimerEvent.TIMER_COMPLETE, this.onReleaseTimerComplete);
            };
            this.var_4685.start();
            if (this._visualization != null)
            {
                this._visualization.updateBlockText(this.var_4683);
                this._visualization.showFloodBlocking();
            };
        }

        override public function get mainWindow():IWindow
        {
            return (this._visualization.window);
        }

    }
}