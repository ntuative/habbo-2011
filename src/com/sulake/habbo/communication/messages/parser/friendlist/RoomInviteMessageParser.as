package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomInviteMessageParser implements IMessageParser
    {

        private var _senderId: int;
        private var _messageText: String;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._senderId = data.readInteger();
            this._messageText = data.readString();
            
            return true;
        }

        public function get senderId(): int
        {
            return this._senderId;
        }

        public function get messageText(): String
        {
            return this._messageText;
        }

    }
}
