package com.sulake.habbo.messenger
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IFrameWindow;

    import flash.utils.Timer;
    import flash.events.TimerEvent;

    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;

    import flash.ui.Keyboard;

    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendMsgMessageComposer;

    public class MessengerView implements IDisposable
    {

        private var var_3447: HabboMessenger;
        private var var_3636: ConversationsTabView;
        private var var_3457: ITextFieldWindow;
        private var var_3431: IFrameWindow;
        private var var_3637: ConversationView;
        private var var_3635: Timer;
        private var _disposed: Boolean = false;

        public function MessengerView(param1: HabboMessenger)
        {
            this.var_3447 = param1;
            this.var_3635 = new Timer(300, 1);
            this.var_3635.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this.var_3635)
                {
                    this.var_3635.stop();
                    this.var_3635.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                    this.var_3635 = null;
                }

                this.var_3447 = null;
                this._disposed = true;
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function isMessengerOpen(): Boolean
        {
            return this.var_3431 != null && this.var_3431.visible;
        }

        public function close(): void
        {
            if (this.var_3431 != null)
            {
                this.var_3431.visible = false;
            }

        }

        public function openMessenger(): void
        {
            if (this.var_3447.conversations.openConversations.length < 1)
            {
                return;
            }

            if (this.var_3431 == null)
            {
                this.prepareContent();
                this.refresh();
                this.var_3447.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.HTSME_ANIMATE_MENU_IN, HabboToolbarIconEnum.MESSENGER, this.var_3431));
            }
            else
            {
                this.refresh();
                this.var_3431.visible = true;
                this.var_3431.activate();
            }

        }

        public function refresh(): void
        {
            if (this.var_3431 == null)
            {
                return;
            }

            var _loc1_: Conversation = this.var_3447.conversations.findSelectedConversation();
            this.var_3431.caption = _loc1_ == null ? "" : _loc1_.name;
            this.var_3636.refresh();
            this.var_3637.refresh();
            if (this.var_3447.conversations.openConversations.length < 1)
            {
                this.var_3431.visible = false;
                this.var_3447.setHabboToolbarIcon(false, false);
            }

        }

        public function addMsgToView(param1: Conversation, param2: Message): void
        {
            if (this.var_3431 == null)
            {
                return;
            }

            if (!param1.selected)
            {
                return;
            }

            this.var_3637.addMessage(param2);
        }

        private function prepareContent(): void
        {
            this.var_3431 = IFrameWindow(this.var_3447.getXmlWindow("main_window"));
            var _loc1_: IWindow = this.var_3431.findChildByTag("close");
            _loc1_.procedure = this.onWindowClose;
            this.var_3431.procedure = this.onWindow;
            this.var_3431.title.color = 0xFFFAC200;
            this.var_3431.title.textColor = 4287851525;
            this.var_3636 = new ConversationsTabView(this.var_3447, this.var_3431);
            this.var_3636.refresh();
            this.var_3457 = ITextFieldWindow(this.var_3431.findChildByName("message_input"));
            this.var_3457.addEventListener(WindowKeyboardEvent.var_1156, this.onMessageInput);
            this.var_3637 = new ConversationView(this.var_3447, this.var_3431);
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_821, false);
            this.var_3431.scaler.setParamFlag(HabboWindowParam.var_818, true);
        }

        private function onMessageInput(param1: WindowKeyboardEvent): void
        {
            var _loc3_: int;
            var _loc4_: String;
            var _loc2_: IWindow = IWindow(param1.target);
            if (param1.charCode == Keyboard.ENTER)
            {
                this.sendMsg();
            }
            else
            {
                _loc3_ = 120;
                _loc4_ = this.var_3457.text;
                if (_loc4_.length > _loc3_)
                {
                    this.var_3457.text = _loc4_.substring(0, _loc3_);
                }

            }

        }

        private function onWindow(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowEvent.var_573 || param2 != this.var_3431)
            {
                return;
            }

            if (!this.var_3635.running)
            {
                this.var_3635.reset();
                this.var_3635.start();
            }

        }

        private function onResizeTimer(param1: TimerEvent): void
        {
            Logger.log("XXX RESIZE XXX");
            this.var_3637.afterResize();
            this.var_3636.refresh();
        }

        private function onWindowClose(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            Logger.log("Close window");
            this.var_3431.visible = false;
        }

        private function sendMsg(): void
        {
            var _loc1_: String = this.var_3457.text;
            Logger.log("Send msg: " + _loc1_);
            if (_loc1_ == "")
            {
                Logger.log("No text...");
                return;
            }

            var _loc2_: Conversation = this.var_3447.conversations.findSelectedConversation();
            if (_loc2_ == null)
            {
                Logger.log("No conversation...");
                return;
            }

            this.var_3447.send(new SendMsgMessageComposer(_loc2_.id, _loc1_));
            if (_loc2_.messages.length == 1)
            {
                this.var_3447.playSendSound();
            }

            this.var_3457.text = "";
            this.var_3447.conversations.addMessageAndUpdateView(new Message(Message.MESSAGE_PREVIOUS, _loc2_.id, _loc1_, Util.getFormattedNow()));
        }

        public function getTabCount(): int
        {
            return this.var_3636 == null ? 7 : this.var_3636.getTabCount();
        }

    }
}
