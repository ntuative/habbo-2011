package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomData implements IDisposable
    {

        private var _unitPropertySet: String;
        private var _unitPort: int;
        private var _worldId: int;
        private var _castLibs: String;
        private var _maxUsers: int;
        private var _nodeId: int;
        private var _disposed: Boolean;

        public function PublicRoomData(data: IMessageDataWrapper)
        {
            this._unitPropertySet = data.readString();
            this._unitPort = data.readInteger();
            this._worldId = data.readInteger();
            this._castLibs = data.readString();
            this._maxUsers = data.readInteger();
            this._nodeId = data.readInteger();
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get unitPropertySet(): String
        {
            return this._unitPropertySet;
        }

        public function get unitPort(): int
        {
            return this._unitPort;
        }

        public function get worldId(): int
        {
            return this._worldId;
        }

        public function get castLibs(): String
        {
            return this._castLibs;
        }

        public function get maxUsers(): int
        {
            return this._maxUsers;
        }

        public function get nodeId(): int
        {
            return this._nodeId;
        }

    }
}
