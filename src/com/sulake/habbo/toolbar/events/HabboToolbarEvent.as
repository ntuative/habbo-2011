package com.sulake.habbo.toolbar.events
{

    import flash.events.Event;

    public class HabboToolbarEvent extends Event
    {

        public static const var_100: String = "HTE_INITIALIZED";
        public static const HTE_TOOLBAR_CLICK: String = "HTE_TOOLBAR_CLICK";
        public static const var_102: String = "HTE_TOOLBAR_ORIENTATION";
        public static const var_364: String = "HTE_TOOLBAR_RESIZED";

        private var var_2661: String;
        private var var_2085: String;
        private var var_4520: String;

        public function HabboToolbarEvent(param1: String, param2: Boolean = false, param3: Boolean = false)
        {
            super(param1, param2, param3);
        }

        public function set iconId(param1: String): void
        {
            this.var_2661 = param1;
        }

        public function get iconId(): String
        {
            return this.var_2661;
        }

        public function set orientation(param1: String): void
        {
            this.var_2085 = param1;
        }

        public function get orientation(): String
        {
            return this.var_2085;
        }

        public function set iconName(param1: String): void
        {
            this.var_4520 = param1;
        }

        public function get iconName(): String
        {
            return this.var_4520;
        }

    }
}
