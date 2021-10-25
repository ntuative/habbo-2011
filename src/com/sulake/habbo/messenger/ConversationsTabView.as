package com.sulake.habbo.messenger
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.habbo.messenger.domain.*;
    import com.sulake.habbo.window.enum.*;

    public class ConversationsTabView
    {

        private var _messenger: HabboMessenger;
        private var _content: IWindowContainer;
        private var _conversations: IWindowContainer;
        private var _tabWidth: int = 30;

        public function ConversationsTabView(messenger: HabboMessenger, parent: IFrameWindow)
        {
            this._messenger = messenger;
            this._content = IWindowContainer(parent.findChildByName("content"));
            this._conversations = IWindowContainer(parent.findChildByName("conversationstab"));
            
            var conversationBackground: IBitmapWrapperWindow = IBitmapWrapperWindow(this._content.findChildByName("convo_bg"));
            conversationBackground.bitmap = this._messenger.getButtonImage("convo_bg");
        }

        public function getTabCount(): int
        {
            return Math.floor(this._conversations.width / this._tabWidth);
        }

        public function get content(): IWindowContainer
        {
            return this._content;
        }

        public function refresh(): void
        {
            var success: Boolean;
            var openConversations: Array = this._messenger.conversations.openConversations;
            var i: int;

            while (i < this.getTabCount())
            {
                this.refreshTabContent(i, openConversations[(this._messenger.conversations.startIndex + i)]);
                i++;
            }

            while (true)
            {
                success = this.refreshTabContent(i, null);

                if (success)
                {
                    break;
                }

                i++;
            }

            if (this.hasPrevButton())
            {
                this.refreshAsArrow(0, false);
            }

            if (this.hasNextButton())
            {
                this.refreshAsArrow(this.getTabCount() - 1, true);
            }

        }

        private function refreshTabContent(index: int, conversation: Conversation): Boolean
        {
            var container: IWindowContainer = this._conversations.getChildAt(index) as IWindowContainer;
            
            if (container == null)
            {
                if (conversation == null)
                {
                    return true;
                }

                container = IWindowContainer(this._messenger.getXmlWindow("tab_entry"));
                
                container.y = 1;
                
                this._conversations.addChild(container);
            }

            this.hideChildren(container);
            
            if (conversation == null)
            {
                return false;
            }

            var conversationBgId: String = conversation.selected ? "tab_bg_sel" : (conversation.newMessageArrived
                    ? "tab_bg_hilite"
                    : "tab_bg_unsel");

            this.refreshTabBg(container, index, conversationBgId);
            this.refreshFigure(container, conversation.figure);

            container.x = index * this._tabWidth;
            container.width = this._tabWidth;
            
            return false;
        }

        private function hideChildren(container: IWindowContainer): void
        {
            var i: int;

            while (i < container.numChildren)
            {
                container.getChildAt(i).visible = false;
                i++;
            }

        }

        private function refreshAsArrow(index: int, param2: Boolean): void
        {
            var _loc3_: IWindowContainer = this._conversations.getChildAt(index) as IWindowContainer;
            this.hideChildren(_loc3_);
            this.refreshArrow(_loc3_, index, param2);
            this.refreshTabBg(_loc3_, index, param2 ? "tab_bg_next" : "tab_bg_unsel");
            var _loc4_: int = this._conversations.width % this._tabWidth;
            _loc3_.width = this._tabWidth + (param2 ? _loc4_ : 0);
        }

        private function refreshTabBg(param1: IWindowContainer, param2: int, param3: String): void
        {
            this._messenger.refreshButton(param1, param3, true, this.onTabClick, param2);
        }

        private function refreshFigure(param1: IWindowContainer, param2: String): void
        {
            var _loc3_: IBitmapWrapperWindow = param1.getChildByName(HabboMessenger.var_304) as IBitmapWrapperWindow;
            if (param2 == null || param2 == "")
            {
                _loc3_.visible = false;
            }
            else
            {
                _loc3_.bitmap = this._messenger.getAvatarFaceBitmap(param2);
                _loc3_.visible = true;
            }

        }

        private function refreshArrow(param1: IWindowContainer, param2: int, param3: Boolean): void
        {
            this._messenger.refreshButton(param1, param3 ? "next" : "prev", true, null, 0);
        }

        private function hasPrevButton(): Boolean
        {
            return this._messenger.conversations.startIndex > 0;
        }

        private function hasNextButton(): Boolean
        {
            return this._messenger.conversations.openConversations.length - this._messenger.conversations.startIndex > this.getTabCount();
        }

        private function onTabClick(param1: WindowEvent, param2: IWindow): void
        {
            var _loc4_: Conversation;
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            var _loc3_: int = param2.id;
            if (_loc3_ == 0 && this.hasPrevButton())
            {
                this._messenger.conversations.changeStartIndex(-1);
            }
            else
            {
                if (_loc3_ == this.getTabCount() - 1 && this.hasNextButton())
                {
                    this._messenger.conversations.changeStartIndex(1);
                }
                else
                {
                    _loc4_ = param2.name == HabboMessenger.var_304
                            ? this._messenger.conversations.findConversation(param2.id)
                            : this._messenger.conversations.openConversations[(_loc3_ + this._messenger.conversations.startIndex)];
                    if (_loc4_ == null)
                    {
                        return;
                    }

                    this._messenger.conversations.setSelected(_loc4_);
                }

            }

            this._messenger.messengerView.refresh();
        }

    }
}
