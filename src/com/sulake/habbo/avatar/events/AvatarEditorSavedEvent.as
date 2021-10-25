package com.sulake.habbo.avatar.events
{

    import flash.events.Event;

    public class AvatarEditorSavedEvent extends Event
    {

        public static const AVATAREDITOR_SAVED: String = "AVATAREDITOR_SAVED";

        private var _figureString: String;

        public function AvatarEditorSavedEvent(figureString: String, param2: Boolean = false, param3: Boolean = false)
        {
            super(AVATAREDITOR_SAVED, param2, param3);
            this._figureString = figureString;
        }

        public function get figureString(): String
        {
            return this._figureString;
        }

    }
}
