package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomShortData implements IDisposable
    {

        private var _unitPropertySet: String;
        private var _worldId: int;
        private var _disposed: Boolean;

        public function PublicRoomShortData(param1: IMessageDataWrapper)
        {
            this._unitPropertySet = param1.readString();
            this._worldId = param1.readInteger();
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

        public function get worldId(): int
        {
            return this._worldId;
        }

    }
}
