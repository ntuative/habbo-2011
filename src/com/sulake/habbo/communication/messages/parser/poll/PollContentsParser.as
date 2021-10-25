package com.sulake.habbo.communication.messages.parser.poll
{

    import com.sulake.core.communication.messages.IMessageParser;

    import flash.utils.Dictionary;

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PollContentsParser implements IMessageParser
    {

        private var _id: int = -1;
        private var _startMessage: String = "";
        private var _endMessage: String = "";
        private var _numQuestions: int = 0;
        private var _questionArray: Array = null;

        public function get id(): int
        {
            return this._id;
        }

        public function get startMessage(): String
        {
            return this._startMessage;
        }

        public function get endMessage(): String
        {
            return this._endMessage;
        }

        public function get numQuestions(): int
        {
            return this._numQuestions;
        }

        public function get questionArray(): Array
        {
            return this._questionArray;
        }

        public function flush(): Boolean
        {
            this._id = -1;
            this._startMessage = "";
            this._endMessage = "";
            this._numQuestions = 0;
            this._questionArray = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var question: Dictionary;
            var selectionCount: int;
            var selections: Array;
            var j: int;

            this._id = data.readInteger();
            this._startMessage = data.readString();
            this._endMessage = data.readString();
            this._numQuestions = data.readInteger();
            this._questionArray = [];

            var i: int;

            while (i < this._numQuestions)
            {
                question = new Dictionary();
                
                question["id"] = data.readInteger();
                question["number"] = data.readInteger();
                question["type"] = data.readInteger();
                question["content"] = data.readString();

                if (question["type"] == 1 || question["type"] == 2)
                {
                    selectionCount = data.readInteger();
                    selections = [];

                    question["selections"] = selections;
                    question["selection_count"] = selectionCount;
                    question["selection_min"] = data.readInteger();
                    question["selection_max"] = data.readInteger();
                    
                    j = 0;
                    
                    while (j < selectionCount)
                    {
                        selections.push(data.readString());
                        j++;
                    }

                }

                this._questionArray.push(question);

                i++;
            }

            return true;
        }

    }
}
