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
    import com.sulake.habbo.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetFloodControlEvent;

    import flash.events.IEventDispatcher;

    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetChatInputWidgetMessage;

    import flash.events.TimerEvent;

    import com.sulake.core.runtime.exceptions.CrashMeError;

    public class RoomChatInputWidgetOld extends RoomWidgetBase
    {

        private static const var_1351: int = 5000;

        private var _visualization: RoomChatInputViewOld;
        private var var_4682: String = "";
        private var var_4683: int = 0;
        private var var_4684: Boolean = false;
        private var var_4685: Timer = null;
        private var var_4686: int;
        private var var_4687: Boolean = false;
        private var var_3479: Component = null;
        private var var_2063: IHabboConfigurationManager;

        public function RoomChatInputWidgetOld(param1: IHabboWindowManager, param2: IAssetLibrary, param3: IHabboLocalizationManager, param4: IHabboConfigurationManager, param5: Component)
        {
            super(param1, param2, param3);
            this.var_3479 = param5;
            this.var_2063 = param4;
            this._visualization = new RoomChatInputViewOld(this, param1, param2, localizations);
        }

        public function get floodBlocked(): Boolean
        {
            return this.var_4684;
        }

        override public function dispose(): void
        {
            if (this._visualization != null)
            {
                this._visualization.dispose();
                this._visualization = null;
            }

            if (this.var_4685 != null)
            {
                this.var_4685.stop();
                this.var_4685 = null;
            }

            this.var_3479 = null;
            this.var_2063 = null;
            super.dispose();
        }

        public function get allowPaste(): Boolean
        {
            return getTimer() - this.var_4686 > var_1351;
        }

        public function setLastPasteTime(): void
        {
            this.var_4686 = getTimer();
        }

        public function sendChat(param1: String, param2: int, param3: String = ""): void
        {
            if (this.var_4684)
            {
                return;
            }

            var _loc4_: RoomWidgetChatMessage = new RoomWidgetChatMessage(RoomWidgetChatMessage.RWCM_MESSAGE_CHAT, param1, param2, param3);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc4_);
            }

        }

        override public function registerUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.onRoomObjectSelected);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onRoomObjectDeselected);
            param1.addEventListener(RoomWidgetRoomViewUpdateEvent.var_1327, this.onRoomViewUpdate);
            param1.addEventListener(RoomWidgetChatInputContentUpdateEvent.RWWCIDE_CHAT_INPUT_CONTENT, this.onChatInputUpdate);
            param1.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            param1.addEventListener(RoomWidgetFloodControlEvent.RWFCE_FLOOD_CONTROL, this.onFloodControl);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.onRoomObjectSelected);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onRoomObjectDeselected);
            param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.var_1327, this.onRoomViewUpdate);
            param1.removeEventListener(RoomWidgetChatInputContentUpdateEvent.RWWCIDE_CHAT_INPUT_CONTENT, this.onChatInputUpdate);
            param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            param1.removeEventListener(RoomWidgetFloodControlEvent.RWFCE_FLOOD_CONTROL, this.onFloodControl);
        }

        private function onRoomViewUpdate(param1: RoomWidgetRoomViewUpdateEvent): void
        {
            this.refreshWindowPosition();
        }

        private function onRoomObjectSelected(param1: RoomWidgetRoomObjectUpdateEvent): void
        {
            var _loc2_: RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO, param1.id, param1.category);
        }

        private function onRoomObjectDeselected(param1: RoomWidgetRoomObjectUpdateEvent): void
        {
            this.var_4682 = "";
        }

        private function onUserInfo(param1: RoomWidgetUserInfoUpdateEvent): void
        {
            this.var_4682 = param1.name;
        }

        private function onChatInputUpdate(param1: RoomWidgetChatInputContentUpdateEvent): void
        {
            var _loc2_: String = "";
            switch (param1.messageType)
            {
                case RoomWidgetChatInputContentUpdateEvent.WHISPER:
                    _loc2_ = localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
                    this._visualization.displaySpecialChatMessage(_loc2_, param1.userName);
                    return;
                case RoomWidgetChatInputContentUpdateEvent.SHOUT:
                    return;
            }

        }

        private function refreshWindowPosition(): void
        {
            if (this._visualization == null)
            {
                return;
            }

            var _loc1_: RoomWidgetChatInputWidgetMessage = new RoomWidgetChatInputWidgetMessage(RoomWidgetChatInputWidgetMessage.RWCIW_MESSAGE_POSITION_WINDOW, this._visualization.window);
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(_loc1_);
            }

        }

        private function onReleaseTimerComplete(param1: TimerEvent): void
        {
            Logger.log("Releasing flood blocking");
            this.var_4684 = false;
            if (this._visualization != null)
            {
                this._visualization.hideFloodBlocking();
            }

            this.var_4685 = null;
        }

        private function onReleaseTimerTick(param1: TimerEvent): void
        {
            if (this._visualization != null)
            {
                this.var_4683 = this.var_4683 - 1;
                this._visualization.showFloodBlocking(this.var_4683);
            }

        }

        public function get selectedUserName(): String
        {
            return this.var_4682;
        }

        public function triggerManualCrash(): void
        {
            this.var_4687 = true;
            throw new CrashMeError();
        }

        public function onFloodControl(param1: RoomWidgetFloodControlEvent): void
        {
            this.var_4684 = true;
            this.var_4683 = param1.seconds;
            Logger.log("Enabling flood blocking for " + this.var_4683 + " seconds");
            if (this.var_4685)
            {
                this.var_4685.reset();
            }
            else
            {
                this.var_4685 = new Timer(1000, this.var_4683);
                this.var_4685.addEventListener(TimerEvent.TIMER, this.onReleaseTimerTick);
                this.var_4685.addEventListener(TimerEvent.TIMER_COMPLETE, this.onReleaseTimerComplete);
            }

            this.var_4685.start();
            if (this._visualization != null)
            {
                this._visualization.showFloodBlocking(this.var_4683);
            }

        }

    }
}
