package com.sulake.habbo.communication.messages.incoming.friendlist
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AcceptBuddyFailureData
    {

        private var _senderName: String;
        private var _errorCode: int;

        public function AcceptBuddyFailureData(data: IMessageDataWrapper)
        {
            this._senderName = data.readString();
            this._errorCode = data.readInteger();
        }

        public function get senderName(): String
        {
            return this._senderName;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

    }
}
