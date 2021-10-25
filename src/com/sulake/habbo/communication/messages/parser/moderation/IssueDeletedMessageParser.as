package com.sulake.habbo.communication.messages.parser.moderation
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueDeletedMessageParser implements IMessageParser
    {

        private var _issueId: int;

        public function get issueId(): int
        {
            return this._issueId;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._issueId = parseInt(data.readString());
            
            return true;
        }

    }
}
