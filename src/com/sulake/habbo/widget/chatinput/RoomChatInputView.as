package com.sulake.habbo.widget.chatinput
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;

    import flash.utils.Timer;
    import flash.events.TimerEvent;

    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;

    import flash.events.KeyboardEvent;

    import com.sulake.habbo.widget.messages.RoomWidgetChatMessage;

    import flash.ui.Keyboard;

    import com.sulake.habbo.widget.messages.RoomWidgetChatTypingMessage;

    import flash.display.Stage;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObject;
    import flash.text.TextField;

    public class RoomChatInputView
    {

        private var _widget: RoomChatInputWidget;
        private var _window: IWindowContainer;
        private var _chatbar: ITextFieldWindow;
        private var _button: IWindow;
        private var _floodBlockedText: IWindow;
        private var var_4672: int = 0;
        private var _chatModeIdShout: String;
        private var _chatModeIdWhisper: String;
        private var _chatModeIdSpeak: String;
        private var var_4675: Boolean = false;
        private var var_3296: Boolean = false;
        private var var_4676: Boolean = false;
        private var _typingTimer: Timer;
        private var _idleTimer: Timer;
        private var _message: String = "";

        public function RoomChatInputView(widget: RoomChatInputWidget)
        {
            this._widget = widget;

            this._chatModeIdWhisper = widget.localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
            this._chatModeIdShout = widget.localizations.getKey("widgets.chatinput.mode.shout", ":shout");
            this._chatModeIdSpeak = widget.localizations.getKey("widgets.chatinput.mode.speak", ":speak");

            this._typingTimer = new Timer(1000, 1);
            this._typingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTypingTimerComplete);

            this._idleTimer = new Timer(10000, 1);
            this._idleTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onIdleTimerComplete);

            this.createWindow();
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        public function dispose(): void
        {
            this._widget = null;
            this._chatbar = null;
            this._button = null;

            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            }

            if (this._typingTimer != null)
            {
                this._typingTimer.reset();
                this._typingTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTypingTimerComplete);
                this._typingTimer = null;
            }

            if (this._idleTimer != null)
            {
                this._idleTimer.reset();
                this._idleTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onIdleTimerComplete);
                this._idleTimer = null;
            }

        }

        private function createWindow(): void
        {
            if (this._window != null)
            {
                return;
            }

            var windowLayout: XmlAsset = this._widget.assets.getAssetByName("chatinput_window") as XmlAsset;
            if (windowLayout == null || windowLayout.content == null)
            {
                return;
            }

            this._window = (this._widget.windowManager.buildFromXML(windowLayout.content as XML, 0) as IWindowContainer);

            var friendbarOffset: int = this._widget.config.getKey("friendbar.enabled") == "true" ? 55 : 5;

            this._window.x = (this._window.desktop.width - this._window.width) / 2;
            this._window.y = this._window.desktop.height - this._window.height - friendbarOffset;
            this._window.tags.push("room_widget_chatinput");
            this._chatbar = (this._window.findChildByName("chat_input") as ITextFieldWindow);
            this._button = this._window.findChildByName("send_button");
            this._floodBlockedText = this._window.findChildByName("block_text");

            var buttonText: IWindow = this._window.findChildByName("send_button_text");
            buttonText.caption = "$" + "{" + buttonText.caption + "}";

            this.addEventListenerToChild(this._chatbar);

            this._chatbar.addEventListener(WindowKeyboardEvent.var_1156, this.windowKeyEventProcessor);
            this._chatbar.addEventListener(WindowEvent.var_590, this.onInputChanged);

            this._window.findChildByName("send_button")
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSend);

            this.var_4675 = true;
            this._message = "";
        }

        private function onSend(param1: WindowMouseEvent): void
        {
            if (!this.var_4675)
            {
                this.sendChatFromInputField(this.var_4672);
            }

        }

        public function hideFloodBlocking(): void
        {
            this._chatbar.visible = true;
            this._floodBlockedText.visible = false;

            if (this._button != null)
            {
                this._button.enable();
            }

        }

        public function showFloodBlocking(): void
        {
            this._chatbar.visible = false;
            this._floodBlockedText.visible = true;

            if (this._button != null)
            {
                this._button.disable();
            }

        }

        public function updateBlockText(remaining: int): void
        {
            this._widget.localizations.registerParameter("chat.input.alert.flood", "time", remaining.toString());
        }

        public function displaySpecialChatMessage(param1: String, param2: String = ""): void
        {
            if (this._window == null || this._chatbar == null)
            {
                return;
            }

            this._chatbar.enable();
            this._chatbar.selectable = true;
            this._chatbar.text = "";

            this.setInputFieldFocus();

            this._chatbar.text = this._chatbar.text + (param1 + " ");

            if (param2.length > 0)
            {
                this._chatbar.text = this._chatbar.text + (param2 + " ");
            }

            this._chatbar.setSelection(this._chatbar.text.length, this._chatbar.text.length);

            this._message = this._chatbar.text;
        }

        private function addEventListenerToChild(window: IWindow): void
        {
            if (window != null)
            {
                window.setParamFlag(HabboWindowParam.var_157, true);
                window.addEventListener(WindowMouseEvent.var_628, this.windowMouseEventProcessor);
            }

        }

        private function windowMouseEventProcessor(param1: WindowEvent = null, param2: IWindow = null): void
        {
            this.setInputFieldFocus();
        }

        private function windowKeyEventProcessor(param1: WindowEvent = null, param2: IWindow = null): void
        {
            var charCode: uint;
            var isShiftPressed: Boolean;
            var windowKeyboardEvent: WindowKeyboardEvent;
            var keyboardEvent: KeyboardEvent;
            var text: String;
            var chunks: Array;

            if (this._window == null || this._widget == null || this._widget.floodBlocked)
            {
                return;
            }

            if (this.anotherFieldHasFocus())
            {
                return;
            }

            var chatType: int = this.var_4672;

            this.setInputFieldFocus();

            if (param1 is WindowKeyboardEvent)
            {
                windowKeyboardEvent = (param1 as WindowKeyboardEvent);
                charCode = windowKeyboardEvent.charCode;
                isShiftPressed = windowKeyboardEvent.shiftKey;
            }

            if (param1 is KeyboardEvent)
            {
                keyboardEvent = (param1 as KeyboardEvent);
                charCode = keyboardEvent.charCode;
                isShiftPressed = keyboardEvent.shiftKey;
            }

            if (keyboardEvent == null && windowKeyboardEvent == null)
            {
                return;
            }

            if (isShiftPressed)
            {
                chatType = RoomWidgetChatMessage.CHAT_TYPE_SHOUT;
            }

            if (charCode == Keyboard.SPACE)
            {
                this.checkSpecialKeywordForInput();
            }

            if (charCode == Keyboard.ENTER)
            {
                this.sendChatFromInputField(chatType);
            }

            if (charCode == Keyboard.BACKSPACE)
            {
                if (this._chatbar != null)
                {
                    text = this._chatbar.text;
                    chunks = text.split(" ");
                    if (chunks[0] == this._chatModeIdWhisper && chunks.length == 3 && chunks[2] == "")
                    {
                        this._chatbar.text = "";
                        this._message = "";
                    }

                }

            }

        }

        private function onWindowMoved(event: WindowEvent): void
        {
            if (this._window == null)
            {

            }

        }

        private function onInputChanged(event: WindowEvent): void
        {
            var textField: ITextFieldWindow = event.window as ITextFieldWindow;

            if (textField == null)
            {
                return;
            }

            this._idleTimer.reset();

            var textLength: Boolean = textField.text.length == 0;

            if (textLength)
            {
                this.var_3296 = false;
                this._typingTimer.start();
            }
            else
            {
                if (textField.text.length > this._message.length + 1)
                {
                    if (this._widget.allowPaste)
                    {
                        this._widget.setLastPasteTime();
                    }
                    else
                    {
                        textField.text = "";
                    }

                }

                this._message = textField.text;

                if (!this.var_3296)
                {
                    this.var_3296 = true;
                    this._typingTimer.reset();
                    this._typingTimer.start();
                }

                this._idleTimer.start();
            }

        }

        private function checkSpecialKeywordForInput(): void
        {
            if (this._chatbar == null || this._chatbar.text == "")
            {
                return;
            }

            var text: String = this._chatbar.text;
            var selectedUserName: String = this._widget.selectedUserName;

            if (text == this._chatModeIdWhisper)
            {
                if (selectedUserName.length > 0)
                {
                    this._chatbar.text = this._chatbar.text + (" " + this._widget.selectedUserName);
                    this._chatbar.setSelection(this._chatbar.text.length, this._chatbar.text.length);
                    this._message = this._chatbar.text;
                }

            }

        }

        private function onIdleTimerComplete(param1: TimerEvent): void
        {
            if (this.var_3296)
            {
                this.var_4676 = false;
            }

            this.var_3296 = false;
            this.sendTypingMessage();
        }

        private function onTypingTimerComplete(param1: TimerEvent): void
        {
            if (this.var_3296)
            {
                this.var_4676 = true;
            }

            this.sendTypingMessage();
        }

        private function sendTypingMessage(): void
        {
            if (this._widget == null)
            {
                return;
            }

            if (this._widget.floodBlocked)
            {
                return;
            }

            var message: RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(this.var_3296);

            this._widget.messageListener.processWidgetMessage(message);
        }

        private function setInputFieldFocus(): void
        {
            if (this._chatbar == null)
            {
                return;
            }

            if (this.var_4675)
            {
                this._chatbar.text = "";
                this._chatbar.textColor = 0;
                this._chatbar.italic = false;
                this.var_4675 = false;
                this._message = "";
            }

            this._chatbar.focus();
        }

        private function setInputFieldUnFocus(): void
        {
            if (this._chatbar == null)
            {
                return;
            }

            this._chatbar.unfocus();
        }

        private function sendChatFromInputField(chatType: int): void
        {
            if (this._chatbar == null || this._chatbar.text == "")
            {
                return;
            }

            var rawText: String = this._chatbar.text;
            var chunks: Array = rawText.split(" ");
            var userName: String = "";
            var text: String = "";

            switch (chunks[0])
            {
                case this._chatModeIdWhisper:
                    chatType = RoomWidgetChatMessage.CHAT_TYPE_WHISPER;
                    userName = chunks[1];
                    text = this._chatModeIdWhisper + " " + userName + " ";
                    chunks.shift();
                    chunks.shift();

                    break;
                case this._chatModeIdShout:
                    chatType = RoomWidgetChatMessage.CHAT_TYPE_SHOUT;
                    chunks.shift();

                    break;
                case this._chatModeIdSpeak:
                    chatType = RoomWidgetChatMessage.CHAT_TYPE_NORMAL;
                    chunks.shift();

                    break;
            }

            rawText = chunks.join(" ");

            if (this._widget != null)
            {
                if (this._typingTimer.running)
                {
                    this._typingTimer.reset();
                }

                if (this._idleTimer.running)
                {
                    this._idleTimer.reset();
                }

                this._widget.sendChat(rawText, chatType, userName);

                this.var_3296 = false;

                if (this.var_4676)
                {
                    this.sendTypingMessage();
                }

                this.var_4676 = false;
            }

            this._chatbar.text = text;
            this._message = text;
        }

        private function anotherFieldHasFocus(): Boolean
        {
            var stage: Stage;
            var interactiveObject: InteractiveObject;

            if (this._chatbar != null)
            {
                if (this._chatbar.focused)
                {
                    return false;
                }

            }

            var displayObject: DisplayObject = this._window.context.getDesktopWindow().getDisplayObject();

            if (displayObject != null)
            {
                stage = displayObject.stage;

                if (stage != null)
                {
                    interactiveObject = stage.focus;

                    if (interactiveObject == null)
                    {
                        return false;
                    }

                    if (interactiveObject is TextField)
                    {
                        return true;
                    }

                }

            }

            return false;
        }

    }
}
