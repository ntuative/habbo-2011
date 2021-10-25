package com.sulake.habbo.communication.messages.parser.room.chat
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChatMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _userId: int = 0;
        private var _text: String = "";
        private var _links: Array;
        private var _gesture: int = 0;
        private var _trackingId: int = -1;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get text(): String
        {
            return this._text;
        }

        public function get links(): Array
        {
            return this._links;
        }

        public function get gesture(): int
        {
            return this._gesture;
        }

        public function get trackingId(): int
        {
            return this._trackingId;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;
            this._text = "";
            this._gesture = 0;
            this._links = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._userId = data.readInteger();
            this._text = data.readString();
            this._gesture = data.readInteger();
            
            var linkCount: int = data.readInteger();

            if (linkCount > 0)
            {
                this._links = [];
                var i: int = 0;
                
                while (i < linkCount)
                {
                    this._links.push([data.readString(), data.readString(), data.readInteger()]);
                    i++;
                }
            }

            this._trackingId = data.readInteger();
            
            return true;
        }

    }
}
