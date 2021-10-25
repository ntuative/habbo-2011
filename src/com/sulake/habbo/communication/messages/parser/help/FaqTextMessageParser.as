package com.sulake.habbo.communication.messages.parser.help
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqTextMessageParser implements IMessageParser
    {

        private var _questionId: int;
        private var _answerText: String;

        public function get questionId(): int
        {
            return this._questionId;
        }

        public function get answerText(): String
        {
            return this._answerText;
        }

        public function flush(): Boolean
        {
            this._questionId = -1;
            this._answerText = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._questionId = data.readInteger();
            this._answerText = data.readString();
            
            return true;
        }

    }
}
