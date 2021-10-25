package com.sulake.habbo.communication.messages.parser.users
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ApproveNameMessageParser implements IMessageParser
    {

        private var _result: int;
        private var _nameValidationInfo: String;

        public function get result(): int
        {
            return this._result;
        }

        public function get nameValidationInfo(): String
        {
            return this._nameValidationInfo;
        }

        public function flush(): Boolean
        {
            this._result = -1;
            this._nameValidationInfo = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._result = data.readInteger();
            this._nameValidationInfo = data.readString();
            
            return true;
        }

    }
}
