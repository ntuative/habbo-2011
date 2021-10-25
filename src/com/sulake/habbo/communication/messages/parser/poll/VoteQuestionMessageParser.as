package com.sulake.habbo.communication.messages.parser.poll
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoteQuestionMessageParser implements IMessageParser
    {

        private var _question: String;
        private var _choices: Array;

        public function get question(): String
        {
            return this._question;
        }

        public function get choices(): Array
        {
            return this._choices.slice();
        }

        public function flush(): Boolean
        {
            this._question = "";
            this._choices = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._question = data.readString();
            this._choices = [];
            
            var choiceCount: int = data.readInteger();
            var i: int;
            
            while (i < choiceCount)
            {
                data.readInteger();
                this._choices.push(data.readString());
                i++;
            }

            return true;
        }

    }
}
