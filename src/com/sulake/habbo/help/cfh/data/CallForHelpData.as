package com.sulake.habbo.help.cfh.data
{

    public class CallForHelpData
    {

        private var _topicIndex: int;
        private var _reportedUserId: int;
        private var _reportedUserName: String = "";

        public function get topicIndex(): int
        {
            return this._topicIndex;
        }

        public function get reportedUserId(): int
        {
            return this._reportedUserId;
        }

        public function get reportedUserName(): String
        {
            return this._reportedUserName;
        }

        public function set topicIndex(value: int): void
        {
            this._topicIndex = value;
        }

        public function set reportedUserId(value: int): void
        {
            this._reportedUserId = value;
        }

        public function set reportedUserName(value: String): void
        {
            this._reportedUserName = value;
        }

        public function get userSelected(): Boolean
        {
            return this._reportedUserId > 0;
        }

        public function getTopicKey(id: int): String
        {
            return (this.userSelected ? "help.cfh.topicwithharasser." : "help.cfh.topic.") + id;
        }

        public function flush(): void
        {
            this._reportedUserId = 0;
            this._reportedUserName = "";
        }

    }
}
