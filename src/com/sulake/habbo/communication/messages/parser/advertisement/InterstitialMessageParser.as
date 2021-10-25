package com.sulake.habbo.communication.messages.parser.advertisement
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InterstitialMessageParser implements IMessageParser
    {

        private var _imageUrl: String;
        private var dynamic: String;

        public function get imageUrl(): String
        {
            return this._imageUrl;
        }

        public function get clickUrl(): String
        {
            return this.dynamic;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._imageUrl = param1.readString();
            this.dynamic = param1.readString();
            return true;
        }

    }
}
