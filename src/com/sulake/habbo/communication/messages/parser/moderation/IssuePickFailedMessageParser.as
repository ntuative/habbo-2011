package com.sulake.habbo.communication.messages.parser.moderation
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssuePickFailedMessageParser implements IMessageParser
    {

        private var _issues: Array;
        private var _retryEnabled: Boolean;
        private var _retryCount: int;

        public function get issues(): Array
        {
            return this._issues;
        }

        public function get retryEnabled(): Boolean
        {
            return this._retryEnabled;
        }

        public function get retryCount(): int
        {
            return this._retryCount;
        }

        public function flush(): Boolean
        {
            this._issues = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var issueId: int;
            var pickerUserId: int;
            var pickerUserName: String;
            var issue: IssueMessageData;
            this._issues = [];
            
            var issueCount: int = data.readInteger();
            var i: int;
            
            while (i < issueCount)
            {
                issueId = data.readInteger();
                pickerUserId = data.readInteger();
                pickerUserName = data.readString();
                
                issue = new IssueMessageData(issueId, 0, 0, 0, 0, 0, 0, null, 0, null, pickerUserId, pickerUserName, null, 0, null, 0, null, 0, null, null, 0, 0);
                
                this._issues.push(issue);
                i++;
            }

            this._retryEnabled = data.readBoolean();
            this._retryCount = data.readInteger();
            
            return true;
        }

    }
}
