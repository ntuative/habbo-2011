package com.sulake.habbo.friendbar.events
{

    import flash.events.Event;

    public class FindFriendsNotificationEvent extends Event
    {

        public static const TYPE: String = "FIND_FRIENDS_RESULT";

        private var _success: Boolean;

        public function FindFriendsNotificationEvent(success: Boolean)
        {
            this._success = success;
            
            super(TYPE);
        }

        public function get success(): Boolean
        {
            return this._success;
        }

    }
}
