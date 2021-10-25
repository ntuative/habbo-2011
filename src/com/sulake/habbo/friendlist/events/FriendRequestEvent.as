package com.sulake.habbo.friendlist.events
{

    import flash.events.Event;

    public class FriendRequestEvent extends Event
    {

        public static const FRIEND_REQUEST_ACCEPTED: String = "FRE_ACCEPTED";
        public static const FRIEND_REQUEST_DECLINED: String = "FRE_DECLINED";

        private var _requestId: int;

        public function FriendRequestEvent(type: String, requestId: int, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, bubbles, cancelable);
            
            this._requestId = requestId;
        }

        public function get requestId(): int
        {
            return this._requestId;
        }

    }
}
