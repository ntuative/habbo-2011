package com.sulake.habbo.avatar.events
{
    import flash.events.Event;

    public class AvatarEditorClosedEvent extends Event 
    {

        public static const AVATAREDITOR_CLOSED:String = "AVATAREDITOR_CLOSED";

        public function AvatarEditorClosedEvent(param1:Boolean=false, param2:Boolean=false)
        {
            super(AVATAREDITOR_CLOSED, param1, param2);
        }

    }
}