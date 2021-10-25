package com.sulake.habbo.communication.messages.parser.users
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserNotificationParser implements IMessageParser
    {

        private var _title: String = "";
        private var _message: String = "";
        private var _parameters: Array;

        public function get title(): String
        {
            return this._title;
        }

        public function get message(): String
        {
            return this._message;
        }

        public function get parameters(): Array
        {
            return this._parameters;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._title = param1.readString();
            this._message = param1.readString();
            this._parameters = [];

            var parameterCount: int = param1.readInteger();
            var i: int;
            
            while (i < parameterCount)
            {
                this._parameters.push(param1.readString());
                this._parameters.push(param1.readString());
                i++;
            }

            return true;
        }

    }
}
