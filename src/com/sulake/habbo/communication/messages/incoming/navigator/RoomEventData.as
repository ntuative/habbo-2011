package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEventData implements IDisposable
    {

        private var _exists: Boolean;
        private var _ownerAvatarId: int;
        private var _ownerAvatarName: String;
        private var _flatId: int;
        private var _eventType: int;
        private var _eventName: String;
        private var _eventDescription: String;
        private var _creationTime: String;
        private var _tags: Array = [];
        private var _disposed: Boolean;

        public function RoomEventData(data: IMessageDataWrapper)
        {
            super();
            
            var ownerId: String = data.readString();
            
            if (ownerId == "-1")
            {
                Logger.log("Got null room event");
                this._exists = false;
                return;
            }

            this._exists = true;
            this._ownerAvatarId = int(ownerId);
            this._ownerAvatarName = data.readString();
            this._flatId = int(data.readString());
            this._eventType = data.readInteger();
            this._eventName = data.readString();
            this._eventDescription = data.readString();
            this._creationTime = data.readString();
            
            var tagCount: int = data.readInteger();
            var i: int;

            while (i < tagCount)
            {
                this._tags.push(data.readString());
                i++;
            }

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

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get ownerAvatarId(): int
        {
            return this._ownerAvatarId;
        }

        public function get ownerAvatarName(): String
        {
            return this._ownerAvatarName;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get eventType(): int
        {
            return this._eventType;
        }

        public function get eventName(): String
        {
            return this._eventName;
        }

        public function get eventDescription(): String
        {
            return this._eventDescription;
        }

        public function get creationTime(): String
        {
            return this._creationTime;
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
