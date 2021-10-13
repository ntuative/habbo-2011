package com.sulake.habbo.moderation
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;

    public class IssueBundle 
    {

        private var _id:int;
        private var _issues:Map;
        private var _state:int;
        private var var_3230:int = 0;
        private var var_3658:String = "";
        private var var_2953:int;
        private var var_3659:int = 0;
        private var var_3660:int = 0;
        private var var_3661:IssueMessageData = null;
        private var var_3662:IssueMessageData = null;

        public function IssueBundle(param1:int, param2:IssueMessageData)
        {
            this._id = param1;
            this._issues = new Map();
            this._state = param2.state;
            this.var_3230 = param2.pickerUserId;
            this.var_3658 = param2.pickerUserName;
            this.var_2953 = param2.reportedUserId;
            this.addIssue(param2);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get issues():Array
        {
            return (this._issues.getValues());
        }

        public function get state():int
        {
            return (this._state);
        }

        public function get pickerUserId():int
        {
            return (this.var_3230);
        }

        public function get pickerName():String
        {
            return (this.var_3658);
        }

        public function updateIssue(param1:IssueMessageData):void
        {
            this.removeIssue(param1.issueId);
            this.addIssue(param1);
        }

        private function addIssue(param1:IssueMessageData):void
        {
            this._issues.add(param1.issueId, param1);
            this.var_3659 = (this.var_3659 + param1.priority);
            if (((!(param1.message == null)) && (!(param1.message == ""))))
            {
                this.var_3660++;
            };
            if (((this.var_3661 == null) || (param1.timeStamp < this.var_3661.timeStamp)))
            {
                this.var_3661 = param1;
            };
            if (((this.var_3662 == null) || (param1.priority > this.var_3662.timeStamp)))
            {
                this.var_3662 = param1;
            };
        }

        public function removeIssue(param1:int):IssueMessageData
        {
            var _loc2_:IssueMessageData = (this._issues.remove(param1) as IssueMessageData);
            if (_loc2_ != null)
            {
                this.var_3659 = (this.var_3659 - _loc2_.priority);
                if (((!(_loc2_.message == null)) && (!(_loc2_.message == ""))))
                {
                    this.var_3660--;
                };
                if (this.var_3661 == _loc2_)
                {
                    this.var_3661 = null;
                };
                if (this.var_3662 == _loc2_)
                {
                    this.var_3662 = null;
                };
            };
            return (_loc2_);
        }

        public function get prioritySum():int
        {
            return (this.var_3659);
        }

        public function getHighestPriorityIssue():IssueMessageData
        {
            var _loc2_:IssueMessageData;
            var _loc3_:int;
            var _loc1_:IssueMessageData = this.var_3662;
            if (_loc1_ == null)
            {
                if (((this._issues == null) || (this._issues.length < 1)))
                {
                    return (null);
                };
                _loc1_ = this._issues.getWithIndex(0);
                _loc3_ = 1;
                while (_loc3_ < this._issues.length)
                {
                    _loc2_ = this._issues.getWithIndex(_loc3_);
                    if (((!(_loc2_ == null)) && (_loc2_.priority > _loc1_.priority)))
                    {
                        _loc1_ = _loc2_;
                    };
                    _loc3_++;
                };
                this.var_3662 = _loc1_;
            };
            return (_loc1_);
        }

        public function getIssueCount():int
        {
            if (this._issues == null)
            {
                return (0);
            };
            return (this._issues.length);
        }

        public function getIssueIds():Array
        {
            if (this._issues == null)
            {
                return ([]);
            };
            return (this._issues.getKeys());
        }

        public function get reportedUserId():int
        {
            return (this.var_2953);
        }

        public function getMessageCount():int
        {
            return (this.var_3660);
        }

        public function getOpenTime(param1:int):String
        {
            var _loc3_:IssueMessageData;
            var _loc2_:IssueMessageData = this.var_3661;
            if (_loc2_ == null)
            {
                for each (_loc3_ in this._issues)
                {
                    if (((_loc2_ == null) || (_loc3_.timeStamp < _loc2_.timeStamp)))
                    {
                        _loc2_ = _loc3_;
                    };
                };
                this.var_3661 = _loc2_;
            };
            if (_loc2_ != null)
            {
                return (_loc2_.getOpenTime(param1));
            };
            return ("");
        }

    }
}