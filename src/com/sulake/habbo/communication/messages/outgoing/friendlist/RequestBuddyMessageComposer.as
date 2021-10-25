package com.sulake.habbo.communication.messages.outgoing.friendlist
{

    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class RequestBuddyMessageComposer implements IMessageComposer, IDisposable
    {

        private var _messages: Array = [];

        public function RequestBuddyMessageComposer(message: String)
        {
            this._messages.push(message);
        }

        public function getMessageArray(): Array
        {
            return this._messages;
        }

        public function dispose(): void
        {
            this._messages = null;
        }

        public function get disposed(): Boolean
        {
            return false;
        }

    }
}
