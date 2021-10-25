package com.sulake.habbo.moderation
{

    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;

    public class IssueBundle
    {

        private var _id: int;
        private var _issues: Map;
        private var _state: int;
        private var _pickerUserId: int = 0;
        private var _pickerName: String = "";
        private var _reportedUserId: int;
        private var _prioritySum: int = 0;
        private var _messageCount: int = 0;
        private var _active: IssueMessageData = null;
        private var _highestPriority: IssueMessageData = null;

        public function IssueBundle(id: int, issue: IssueMessageData)
        {
            this._id = id;
            this._issues = new Map();
            this._state = issue.state;
            this._pickerUserId = issue.pickerUserId;
            this._pickerName = issue.pickerUserName;
            this._reportedUserId = issue.reportedUserId;

            this.addIssue(issue);
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get issues(): Array
        {
            return this._issues.getValues();
        }

        public function get state(): int
        {
            return this._state;
        }

        public function get pickerUserId(): int
        {
            return this._pickerUserId;
        }

        public function get pickerName(): String
        {
            return this._pickerName;
        }

        public function updateIssue(issue: IssueMessageData): void
        {
            this.removeIssue(issue.issueId);
            this.addIssue(issue);
        }

        private function addIssue(issue: IssueMessageData): void
        {
            this._issues.add(issue.issueId, issue);
            this._prioritySum = this._prioritySum + issue.priority;

            if (issue.message != null && issue.message != "")
            {
                this._messageCount++;
            }

            if (this._active == null || issue.timeStamp < this._active.timeStamp)
            {
                this._active = issue;
            }

            if (this._highestPriority == null || issue.priority > this._highestPriority.timeStamp)
            {
                this._highestPriority = issue;
            }

        }

        public function removeIssue(id: int): IssueMessageData
        {
            var issue: IssueMessageData = this._issues.remove(id) as IssueMessageData;
            
            if (issue != null)
            {
                this._prioritySum = this._prioritySum - issue.priority;
                
                if (issue.message != null && issue.message != "")
                {
                    this._messageCount--;
                }

                if (this._active == issue)
                {
                    this._active = null;
                }

                if (this._highestPriority == issue)
                {
                    this._highestPriority = null;
                }

            }

            return issue;
        }

        public function get prioritySum(): int
        {
            return this._prioritySum;
        }

        public function getHighestPriorityIssue(): IssueMessageData
        {
            var issue: IssueMessageData;
            var i: int;
            var highestPriority: IssueMessageData = this._highestPriority;

            if (highestPriority == null)
            {
                if (this._issues == null || this._issues.length < 1)
                {
                    return null;
                }

                highestPriority = this._issues.getWithIndex(0);
                i = 1;

                while (i < this._issues.length)
                {
                    issue = this._issues.getWithIndex(i);

                    if (issue != null && issue.priority > highestPriority.priority)
                    {
                        highestPriority = issue;
                    }

                    i++;
                }

                this._highestPriority = highestPriority;
            }

            return highestPriority;
        }

        public function getIssueCount(): int
        {
            if (this._issues == null)
            {
                return 0;
            }

            return this._issues.length;
        }

        public function getIssueIds(): Array
        {
            if (this._issues == null)
            {
                return [];
            }

            return this._issues.getKeys();
        }

        public function get reportedUserId(): int
        {
            return this._reportedUserId;
        }

        public function getMessageCount(): int
        {
            return this._messageCount;
        }

        public function getOpenTime(id: int): String
        {
            var issue: IssueMessageData;
            var active: IssueMessageData = this._active;

            if (active == null)
            {
                for each (issue in this._issues)
                {
                    if (active == null || issue.timeStamp < active.timeStamp)
                    {
                        active = issue;
                    }

                }

                this._active = active;
            }

            if (active != null)
            {
                return active.getOpenTime(id);
            }

            return "";
        }

    }
}
