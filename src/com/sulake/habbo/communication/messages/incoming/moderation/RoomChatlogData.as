package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomChatlogData
    {

        private var _isPublic: Boolean;
        private var _roomId: int;
        private var _roomName: String;
        private var _chatlog: Array = [];

        public function RoomChatlogData(data: IMessageDataWrapper)
        {
            this._isPublic = data.readBoolean();
            this._roomId = data.readInteger();
            this._roomName = data.readString();

            var chatlogCount: int = data.readInteger();
            var i: int;

            while (i < chatlogCount)
            {
                this._chatlog.push(new ChatlineData(data));
                i++;
            }


            Logger.log("READ ROOMCHATLOGDATA: " + this._isPublic + ", " + this._roomId + ", " + this._roomName + ", " + this.chatlog.length);
        }

        public function get isPublic(): Boolean
        {
            return this._isPublic;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomName(): String
        {
            return this._roomName;
        }

        public function get chatlog(): Array
        {
            return this._chatlog;
        }

    }
}
