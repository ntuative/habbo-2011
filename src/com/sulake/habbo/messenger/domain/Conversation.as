package com.sulake.habbo.messenger.domain
{

    import com.sulake.core.runtime.IDisposable;

    public class Conversation implements IDisposable
    {

        private var _id: int;
        private var _name: String;
        private var _followingAllowed: Boolean;
        private var _figure: String;
        private var _messages: Array = [];
        private var _newMessageArrived: Boolean;
        private var _selected: Boolean;
        private var _disposed: Boolean;

        public function Conversation(id: int, name: String, figure: String, followingAllowed: Boolean)
        {
            this._id = id;
            this._name = name;
            this._figure = figure;
            this._followingAllowed = followingAllowed;
        }

        public function addMessage(message: Message): void
        {
            this._messages.push(message);
        }

        public function setSelected(value: Boolean): void
        {
            if (value)
            {
                this._newMessageArrived = false;
            }

            this._selected = value;
        }

        public function setNewMessageArrived(value: Boolean): void
        {
            if (this._selected)
            {
                this._newMessageArrived = false;
            }
            else
            {
                this._newMessageArrived = value;
            }

        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
            this._messages = null;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get selected(): Boolean
        {
            return this._selected;
        }

        public function get messages(): Array
        {
            return this._messages;
        }

        public function get newMessageArrived(): Boolean
        {
            return this._newMessageArrived;
        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get followingAllowed(): Boolean
        {
            return this._followingAllowed;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function set followingAllowed(value: Boolean): void
        {
            this._followingAllowed = value;
        }

    }
}
