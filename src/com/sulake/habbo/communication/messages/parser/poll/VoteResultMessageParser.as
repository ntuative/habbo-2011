package com.sulake.habbo.communication.messages.parser.poll
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoteResultMessageParser implements IMessageParser
    {

        private var _question: String;
        private var _choices: Array;
        private var _votes: Array;
        private var _totalVotes: int;

        public function get question(): String
        {
            return this._question;
        }

        public function get choices(): Array
        {
            return this._choices.slice();
        }

        public function get votes(): Array
        {
            return this._votes.slice();
        }

        public function get totalVotes(): int
        {
            return this._totalVotes;
        }

        public function flush(): Boolean
        {
            this._question = "";
            this._choices = [];
            this._votes = [];
            this._totalVotes = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._question = data.readString();
            
            this._choices = [];
            this._votes = [];
            
            var entryCount: int = data.readInteger();
            var i: int;
            
            while (i < entryCount)
            {
                var unknown1: int = data.readInteger();
                
                this._choices.push(data.readString());
                this._votes.push(data.readInteger());
                i++;
            }

            this._totalVotes = data.readInteger();
            
            return true;
        }

    }
}
