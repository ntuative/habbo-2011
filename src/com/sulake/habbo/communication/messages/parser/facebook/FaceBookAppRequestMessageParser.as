package com.sulake.habbo.communication.messages.parser.facebook
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaceBookAppRequestMessageParser implements IMessageParser
    {

        private var _authToken: String;
        private var _data: String;
        private var _userFilter: String;
        private var _senderReference: int;

        public function get authToken(): String
        {
            return this._authToken;
        }

        public function get data(): String
        {
            return this._data;
        }

        public function get userFilter(): String
        {
            return this._userFilter;
        }

        public function get senderReference(): int
        {
            return this._senderReference;
        }

        public function flush(): Boolean
        {
            this._authToken = null;
            this._data = null;
            this._userFilter = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._authToken = data.readString();
            this._data = data.readString();
            this._userFilter = data.readString();
            this._senderReference = data.readInteger();
            
            return true;
        }

    }
}
