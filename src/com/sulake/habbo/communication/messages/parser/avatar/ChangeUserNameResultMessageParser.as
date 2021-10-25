package com.sulake.habbo.communication.messages.parser.avatar
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChangeUserNameResultMessageParser implements IMessageParser
    {

        private var _resultCode: int = -1;
        private var _name: String;
        private var _nameSuggestions: Array;

        public function get resultCode(): int
        {
            return this._resultCode;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get nameSuggestions(): Array
        {
            return this._nameSuggestions;
        }

        public function flush(): Boolean
        {
            this._resultCode = -1;
            this._name = "";
            this._nameSuggestions = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._resultCode = data.readInteger();
            this._name = data.readString();
            this._nameSuggestions = [];
            
            var suggestionCount: int = data.readInteger();
            var i: int;
            
            while (i < suggestionCount)
            {
                this._nameSuggestions.push(data.readString());
                i++;
            }

            return true;
        }

    }
}
