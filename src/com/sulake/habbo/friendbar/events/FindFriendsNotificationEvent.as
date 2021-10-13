package com.sulake.habbo.friendbar.events
{
    import flash.events.Event;

    public class FindFriendsNotificationEvent extends Event 
    {

        public static const TYPE:String = "FIND_FRIENDS_RESULT";

        private var var_3147:Boolean;

        public function FindFriendsNotificationEvent(param1:Boolean)
        {
            this.var_3147 = param1;
            super(TYPE);
        }

        public function get success():Boolean
        {
            return (this.var_3147);
        }

    }
}