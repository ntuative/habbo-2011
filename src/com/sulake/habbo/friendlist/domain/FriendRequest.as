package com.sulake.habbo.friendlist.domain
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;

    public class FriendRequest implements IDisposable
    {

        public static const FRIEND_STATE_PENDING: int = 1;
        public static const FRIEND_STATE_ACCEPTED: int = 2;
        public static const FRIEND_STATE_REJECTED: int = 3;
        public static const FRIEND_STATE_FAILED: int = 4;

        private var _requestId: int;
        private var _requesterName: String;
        private var _requesterUserId: int;
        private var _state: int = 1;
        private var _disposed: Boolean;
        private var _view: IWindowContainer;

        public function FriendRequest(data: FriendRequestData)
        {
            this._requestId = data.requestId;
            this._requesterName = data.requesterName;
            this._requesterUserId = data.requesterUserId;
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;

            if (this.view != null)
            {
                this.view.destroy();
                this.view = null;
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get requestId(): int
        {
            return this._requestId;
        }

        public function get requesterName(): String
        {
            return this._requesterName;
        }

        public function get requesterUserId(): int
        {
            return this._requesterUserId;
        }

        public function get view(): IWindowContainer
        {
            return this._view;
        }

        public function get state(): int
        {
            return this._state;
        }

        public function set view(value: IWindowContainer): void
        {
            this._view = value;
        }

        public function set state(value: int): void
        {
            this._state = value;
        }

    }
}
