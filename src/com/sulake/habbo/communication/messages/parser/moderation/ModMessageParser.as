package com.sulake.habbo.communication.messages.parser.moderation
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModMessageParser implements IMessageParser
    {

        private var _message: String;
        private var _url: String;

        public function get message(): String
        {
            return this._message;
        }

        public function get url(): String
        {
            return this._url;
        }

        public function flush(): Boolean
        {
            this._message = "";
            this._url = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._message = data.readString();
            this._url = data.readString();
            
            return true;
        }

    }
}
