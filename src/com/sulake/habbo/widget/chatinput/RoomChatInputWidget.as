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

        private static const MIN_LAST_PASTE_TIME: int = 5000;

        private var _visualization: RoomChatInputView;
        private var _selectedUserName: String = "";
        private var _floodBlockRemainingSeconds: int = 0;
        private var _floodBlocked: Boolean = false;
        private var _timer: Timer = null;
        private var _lastPasteTime: int;
        private var _crash: Boolean = false;
        private var _component: Component = null;
        private var _config: IHabboConfigurationManager;

        public function RoomChatInputWidget(windowManager: IHabboWindowManager, assetLibrary: IAssetLibrary, localizationManager: IHabboLocalizationManager, configurationManager: IHabboConfigurationManager, component: Component)
        {
            super(windowManager, assetLibrary, localizationManager);

            this._component = component;
            this._config = configurationManager;
            this._visualization = new RoomChatInputView(this);
        }

        public function get floodBlocked(): Boolean
        {
            return this._floodBlocked;
        }

        public function get config(): IHabboConfigurationManager
        {
            return this._config;
        }

        override public function dispose(): void
        {
            if (this._visualization != null)
            {
                this._visualization.dispose();
                this._visualization = null;
            }

            if (this._timer != null)
            {
                this._timer.stop();
                this._timer = null;
            }

            this._component = null;
            this._config = null;

            super.dispose();
        }

        public function get allowPaste(): Boolean
        {
            return getTimer() - this._lastPasteTime > MIN_LAST_PASTE_TIME;
        }

        public function setLastPasteTime(): void
        {
            this._lastPasteTime = getTimer();
        }

        public function sendChat(text: String, chatType: int, recipientName: String = ""): void
        {
            if (this._floodBlocked)
            {
                return;
            }

            var widget: RoomWidgetChatMessage = new RoomWidgetChatMessage(RoomWidgetChatMessage.RWCM_MESSAGE_CHAT, text, chatType, recipientName);
            
            if (messageListener != null)
            {
                messageListener.processWidgetMessage(widget);
            }

        }

        override public function registerUpdateEvents(dispatcher: IEventDispatcher): void
        {
            if (dispatcher == null)
            {
                return;
            }

            dispatcher.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.onRoomObjectSelected);
            dispatcher.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onRoomObjectDeselected);
            dispatcher.addEventListener(RoomWidgetChatInputContentUpdateEvent.RWWCIDE_CHAT_INPUT_CONTENT, this.onChatInputUpdate);
            dispatcher.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            dispatcher.addEventListener(RoomWidgetFloodControlEvent.RWFCE_FLOOD_CONTROL, this.onFloodControl);
            
            super.registerUpdateEvents(dispatcher);
        }

        override public function unregisterUpdateEvents(dispatcher: IEventDispatcher): void
        {
            if (dispatcher == null)
            {
                return;
            }

            dispatcher.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.onRoomObjectSelected);
            dispatcher.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onRoomObjectDeselected);
            dispatcher.removeEventListener(RoomWidgetChatInputContentUpdateEvent.RWWCIDE_CHAT_INPUT_CONTENT, this.onChatInputUpdate);
            dispatcher.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            dispatcher.removeEventListener(RoomWidgetFloodControlEvent.RWFCE_FLOOD_CONTROL, this.onFloodControl);
        }

        private function onRoomObjectSelected(event: RoomWidgetRoomObjectUpdateEvent): void
        {
            var widget: RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO, event.id, event.category);
        }

        private function onRoomObjectDeselected(event: RoomWidgetRoomObjectUpdateEvent): void
        {
            this._selectedUserName = "";
        }

        private function onUserInfo(event: RoomWidgetUserInfoUpdateEvent): void
        {
            this._selectedUserName = event.name;
        }

        private function onChatInputUpdate(event: RoomWidgetChatInputContentUpdateEvent): void
        {
            var chatMode: String = "";

            switch (event.messageType)
            {
                case RoomWidgetChatInputContentUpdateEvent.WHISPER:
                    chatMode = localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
                    this._visualization.displaySpecialChatMessage(chatMode, event.userName);
                    
                    return;
                
                case RoomWidgetChatInputContentUpdateEvent.SHOUT:
                    return;
            }

        }

        private function onReleaseTimerComplete(event: TimerEvent): void
        {
            Logger.log("Releasing flood blocking");

            this._floodBlocked = false;
            
            if (this._visualization != null)
            {
                this._visualization.hideFloodBlocking();
            }

            this._timer = null;
        }

        private function onReleaseTimerTick(param1: TimerEvent): void
        {
            if (this._visualization != null)
            {
                this._floodBlockRemainingSeconds = this._floodBlockRemainingSeconds - 1;

                this._visualization.updateBlockText(this._floodBlockRemainingSeconds);
            }

        }

        public function get selectedUserName(): String
        {
            return this._selectedUserName;
        }

        public function triggerManualCrash(): void
        {
            this._crash = true;
            throw new CrashMeError();
        }

        public function onFloodControl(param1: RoomWidgetFloodControlEvent): void
        {
            this._floodBlocked = true;
            this._floodBlockRemainingSeconds = param1.seconds;

            Logger.log("Enabling flood blocking for " + this._floodBlockRemainingSeconds + " seconds");
            
            if (this._timer)
            {
                this._timer.reset();
            }
            else
            {
                this._timer = new Timer(1000, this._floodBlockRemainingSeconds);
                this._timer.addEventListener(TimerEvent.TIMER, this.onReleaseTimerTick);
                this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onReleaseTimerComplete);
            }

            this._timer.start();

            if (this._visualization != null)
            {
                this._visualization.updateBlockText(this._floodBlockRemainingSeconds);
                this._visualization.showFloodBlocking();
            }

        }

        override public function get mainWindow(): IWindow
        {
            return this._visualization.window;
        }

    }
}
