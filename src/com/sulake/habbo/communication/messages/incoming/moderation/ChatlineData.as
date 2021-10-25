package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChatlineData
    {

        private var _hour: int;
        private var _minute: int;
        private var _chatterId: int;
        private var _chatterName: String;
        private var _msg: String;

        public function ChatlineData(data: IMessageDataWrapper)
        {
            this._hour = data.readInteger();
            this._minute = data.readInteger();
            this._chatterId = data.readInteger();
            this._chatterName = data.readString();
            this._msg = data.readString();
        }

        public function get hour(): int
        {
            return this._hour;
        }

        public function get minute(): int
        {
            return this._minute;
        }

        public function get chatterId(): int
        {
            return this._chatterId;
        }

        public function get chatterName(): String
        {
            return this._chatterName;
        }

        public function get msg(): String
        {
            return this._msg;
        }

    }
}
