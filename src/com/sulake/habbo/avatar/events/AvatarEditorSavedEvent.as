package com.sulake.habbo.avatar.events
{
    import flash.events.Event;

    public class AvatarEditorSavedEvent extends Event 
    {

        public static const AVATAREDITOR_SAVED:String = "AVATAREDITOR_SAVED";

        private var var_2474:String;

        public function AvatarEditorSavedEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(AVATAREDITOR_SAVED, param2, param3);
            this.var_2474 = param1;
        }

        public function get figureString():String
        {
            return (this.var_2474);
        }

    }
}