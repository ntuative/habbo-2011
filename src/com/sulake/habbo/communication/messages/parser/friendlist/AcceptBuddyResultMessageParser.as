package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyFailureData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AcceptBuddyResultMessageParser implements IMessageParser
    {

        private var _failures: Array;

        public function flush(): Boolean
        {
            this._failures = [];
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var failureCount: int = data.readInteger();
            var i: int;
            
            while (i < failureCount)
            {
                this._failures.push(new AcceptBuddyFailureData(data));
                i++;
            }

            return true;
        }

        public function get failures(): Array
        {
            return this._failures;
        }

    }
}
