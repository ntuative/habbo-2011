package com.sulake.habbo.communication.messages.parser.users
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserNameChangedMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _webId: int;
        private var _id: int;
        private var _newName: String;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get webId(): int
        {
            return this._webId;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get newName(): String
        {
            return this._newName;
        }

        public function flush(): Boolean
        {
            this._webId = -1;
            this._id = -1;
            this._newName = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._webId = data.readInteger();
            this._id = data.readInteger();
            this._newName = data.readString();
            
            return true;
        }

    }
}
