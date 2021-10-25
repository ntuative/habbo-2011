package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NewBuddyRequestMessageParser implements IMessageParser
    {

        private var _req: FriendRequestData;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._req = new FriendRequestData(data);
            
            return true;
        }

        public function get req(): FriendRequestData
        {
            return this._req;
        }

    }
}
