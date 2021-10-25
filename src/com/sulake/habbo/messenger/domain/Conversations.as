package com.sulake.habbo.messenger.domain
{

    import com.sulake.habbo.messenger.Util;
    import com.sulake.habbo.messenger.*;

    public class Conversations
    {

        private static var INSTANCE_ID: int = 1;

        private var _deps: IConversationsDeps;
        private var _openConversations: Array = [];
        private var _closedConversations: Array = [];
        private var _startIndex: int;

        public function Conversations(deps: IConversationsDeps)
        {
            this._deps = deps;
        }

        public function changeStartIndex(offset: int): void
        {
            this._startIndex = this._startIndex + offset;
        }

        public function setSelected(conversation: Conversation): void
        {
            this.clearSelections();
            conversation.setSelected(true);

            var index: int = this._openConversations.indexOf(conversation);
            
            while (this._startIndex + this._deps.getTabCount() <= index)
            {
                this._startIndex++;
            }

        }

        public function closeConversation(): void
        {
            var index: int;
            var conversation: Conversation = this.findSelectedConversation();

            if (conversation != null)
            {
                index = this._openConversations.indexOf(conversation);
                Util.remove(this._openConversations, conversation);
                this._closedConversations.push(conversation);
                conversation.setSelected(false);

                while (index >= 0)
                {
                    if (this._openConversations[index] != null)
                    {
                        this._openConversations[index].setSelected(true);
                        break;
                    }

                    index--;
                }

            }

            this.fixStartIndex();
        }

        public function addTestUser(): void
        {
            this.addConversation(INSTANCE_ID++);
        }

        public function addConversation(id: int): Conversation
        {
            var unknown1: Boolean = this._closedConversations.length == 0 && this._openConversations.length == 0;
            
            var conversation: Conversation = this.addConversationInt(id);
            
            if (conversation == null)
            {
                return null;
            }

            if (this._openConversations.length == 1)
            {
                this._openConversations[0].setSelected(true);
            }

            if (unknown1)
            {
                conversation.addMessage(new Message(Message.MESSAGE_MODERATION, 0, this._deps.getText("messenger.moderationinfo"), ""));
            }

            return conversation;
        }

        public function findConversation(id: int): Conversation
        {
            var conversation: Conversation;

            for each (conversation in this._openConversations)
            {
                if (conversation.id == id)
                {
                    return conversation;
                }

            }

            return null;
        }

        public function addMessageAndUpdateView(message: Message): void
        {
            var conversationsLength: int = this._openConversations.length;
            var conversation: Conversation = this.addConversation(message.senderId);
            
            if (conversation == null)
            {
                Logger.log("Received message from non friend " + message.senderId + ". Ignoring");
                
                return;
            }

            var isNew: Boolean = conversation.newMessageArrived;

            conversation.setNewMessageArrived(true);
            conversation.addMessage(message);
            this._deps.addMsgToView(conversation, message);
            
            if (conversationsLength != this._openConversations.length || isNew != conversation.newMessageArrived)
            {
                this._deps.refresh(false);
            }

        }

        public function setOnlineStatusAndUpdateView(id: int, online: Boolean): void
        {
            var conversation: Conversation = this.findConversation(id);
            
            if (conversation == null)
            {
                conversation = this.findClosedConversation(id);
            }

            if (conversation == null)
            {
                return;
            }

            var message: Message = this.getOnlineInfoMsg(online);
            
            conversation.addMessage(message);
            this._deps.addMsgToView(conversation, message);
        }

        public function setFollowingAllowedAndUpdateView(id: int, followingAllowed: Boolean): void
        {
            var conversation: Conversation = this.findConversation(id);

            if (conversation == null)
            {
                conversation = this.findClosedConversation(id);
            }

            if (conversation == null)
            {
                return;
            }

            conversation.followingAllowed = followingAllowed;

            if (conversation.selected)
            {
                this._deps.refresh(false);
            }

        }

        public function findSelectedConversation(): Conversation
        {
            var converstaion: Conversation;

            for each (converstaion in this._openConversations)
            {
                if (converstaion.selected)
                {
                    return converstaion;
                }

            }

            return null;
        }

        public function get openConversations(): Array
        {
            return this._openConversations;
        }

        public function get startIndex(): int
        {
            return this._startIndex;
        }

        private function clearSelections(): void
        {
            var conversation: Conversation;

            for each (conversation in this._openConversations)
            {
                conversation.setSelected(false);
            }

        }

        private function findClosedConversation(id: int): Conversation
        {
            var conversation: Conversation;

            for each (conversation in this._closedConversations)
            {
                if (conversation.id == id)
                {
                    return conversation;
                }

            }

            return null;
        }

        private function addConversationInt(id: int): Conversation
        {
            var conversation: Conversation = this.findConversation(id);
            
            if (conversation != null)
            {
                return conversation;
            }

            conversation = this.findClosedConversation(id);
            
            if (conversation != null)
            {
                Util.remove(this._closedConversations, conversation);
                this._openConversations.push(conversation);

                return conversation;
            }

            conversation = this._deps.createConversation(id);

            if (conversation == null)
            {
                return null;
            }

            this._openConversations.push(conversation);

            return conversation;
        }

        private function fixStartIndex(): void
        {
            this._startIndex = Math.min(this._startIndex, this._openConversations.length - this._deps.getTabCount());
            this._startIndex = Math.max(0, this._startIndex);
        }

        private function getOnlineInfoMsg(online: Boolean): Message
        {
            return new Message(Message.MESSAGE_ONLINE, 0, this.getOnlineText(online), Util.getFormattedNow());
        }

        private function getOnlineText(online: Boolean): String
        {
            return this._deps.getText(online ? "messenger.notification.online" : "messenger.notification.offline");
        }

    }
}
