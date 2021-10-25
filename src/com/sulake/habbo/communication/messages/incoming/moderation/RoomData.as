package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomData implements IDisposable
    {

        private var _exists: Boolean;
        private var _name: String;
        private var _desc: String;
        private var _tags: Array = [];
        private var _disposed: Boolean;

        public function RoomData(data: IMessageDataWrapper)
        {
            this._exists = data.readBoolean();

            if (!this.exists)
            {
                return;
            }


            this._name = data.readString();
            this._desc = data.readString();

            var tagCount: int = data.readInteger();
            var i: int;

            while (i < tagCount)
            {
                this._tags.push(data.readString());
                i++;
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }


            this._disposed = true;
            this._tags = null;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get desc(): String
        {
            return this._desc;
        }

        public function get tags(): Array
        {
            return this._tags;
        }

        public function get exists(): Boolean
        {
            return this._exists;
        }

    }
}
