package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BuddyRequestsMessageParser implements IMessageParser
    {

        private var _totalReqCount: int;
        private var _reqs: Array;

        public function flush(): Boolean
        {
            this._reqs = [];
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._totalReqCount = data.readInteger();
            
            var requestCount: int = data.readInteger();
            var i: int;
            
            Logger.log("Received buddy requests: " + this._totalReqCount + ", " + requestCount);
            
            while (i < requestCount)
            {
                this._reqs.push(new FriendRequestData(data));
                i++;
            }

            return true;
        }

        public function get totalReqCount(): int
        {
            return this._totalReqCount;
        }

        public function get reqs(): Array
        {
            return this._reqs;
        }

    }
}
