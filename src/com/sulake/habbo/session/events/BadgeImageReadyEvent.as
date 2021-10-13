package com.sulake.habbo.session.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class BadgeImageReadyEvent extends Event 
    {

        public static const var_101:String = "BIRE_BADGE_IMAGE_READY";

        private var var_2925:String;
        private var var_988:BitmapData;

        public function BadgeImageReadyEvent(param1:String, param2:BitmapData, param3:Boolean=false, param4:Boolean=false)
        {
            super(var_101, param3, param4);
            this.var_2925 = param1;
            this.var_988 = param2;
        }

        public function get badgeId():String
        {
            return (this.var_2925);
        }

        public function get badgeImage():BitmapData
        {
            return (this.var_988);
        }

    }
}