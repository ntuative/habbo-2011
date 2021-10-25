package com.sulake.habbo.communication.messages.incoming.friendlist
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendRequestData
    {

        private var _requestId: int;
        private var _requesterName: String;
        private var _requesterUserId: int;

        public function FriendRequestData(param1: IMessageDataWrapper)
        {
            this._requestId = param1.readInteger();
            this._requesterName = param1.readString();
            this._requesterUserId = int(param1.readString());
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

    }
}
