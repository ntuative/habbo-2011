package com.sulake.habbo.widget.events
{

    public class RoomWidgetWelcomeGiftUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_1239: String = "rwwgue_welcome_gift_widget_status";

        private var var_3316: String;
        private var var_3317: Boolean;
        private var var_4734: Boolean;
        private var _furniId: int;
        private var var_3319: Boolean;

        public function RoomWidgetWelcomeGiftUpdateEvent(param1: Boolean = false, param2: Boolean = false)
        {
            super(var_1239, param1, param2);
        }

        public function get email(): String
        {
            return this.var_3316;
        }

        public function get isVerified(): Boolean
        {
            return this.var_3317;
        }

        public function get allowEmailChange(): Boolean
        {
            return this.var_4734;
        }

        public function get furniId(): int
        {
            return this._furniId;
        }

        public function get requestedByUser(): Boolean
        {
            return this.var_3319;
        }

        public function set email(param1: String): void
        {
            this.var_3316 = param1;
        }

        public function set isVerified(param1: Boolean): void
        {
            this.var_3317 = param1;
        }

        public function set allowEmailChange(param1: Boolean): void
        {
            this.var_4734 = param1;
        }

        public function set furniId(param1: int): void
        {
            this._furniId = param1;
        }

        public function set requestedByUser(param1: Boolean): void
        {
            this.var_3319 = param1;
        }

    }
}
