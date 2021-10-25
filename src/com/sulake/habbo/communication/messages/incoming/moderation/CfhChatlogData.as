package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CfhChatlogData
    {

        private var _callId: int;
        private var _callerUserId: int;
        private var _reportedUserId: int;
        private var _chatRecordId: int;
        private var _room: RoomChatlogData;

        public function CfhChatlogData(data: IMessageDataWrapper)
        {
            this._callId = data.readInteger();
            this._callerUserId = data.readInteger();
            this._reportedUserId = data.readInteger();
            this._chatRecordId = data.readInteger();
            this._room = new RoomChatlogData(data);

            Logger.log("READ CFHCHATLOGDATA: callId: " + this._callId);
        }

        public function get callId(): int
        {
            return this._callId;
        }

        public function get callerUserId(): int
        {
            return this._callerUserId;
        }

        public function get reportedUserId(): int
        {
            return this._reportedUserId;
        }

        public function get chatRecordId(): int
        {
            return this._chatRecordId;
        }

        public function get room(): RoomChatlogData
        {
            return this._room;
        }

    }
}
