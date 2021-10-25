package com.sulake.habbo.widget.events
{

    public class RoomWidgetPollUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_397: String = "RWPUW_OFFER";
        public static const var_61: String = "RWPUW_ERROR";
        public static const var_396: String = "RWPUW_CONTENT";

        private var _id: int = -1;
        private var var_3274: String;
        private var var_3272: int = 0;
        private var var_3270: String = "";
        private var var_3271: String = "";
        private var var_3273: Array = null;

        public function RoomWidgetPollUpdateEvent(param1: int, param2: String, param3: Boolean = false, param4: Boolean = false)
        {
            this._id = param1;
            super(param2, param3, param4);
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get summary(): String
        {
            return this.var_3274;
        }

        public function set summary(param1: String): void
        {
            this.var_3274 = param1;
        }

        public function get numQuestions(): int
        {
            return this.var_3272;
        }

        public function set numQuestions(param1: int): void
        {
            this.var_3272 = param1;
        }

        public function get startMessage(): String
        {
            return this.var_3270;
        }

        public function set startMessage(param1: String): void
        {
            this.var_3270 = param1;
        }

        public function get endMessage(): String
        {
            return this.var_3271;
        }

        public function set endMessage(param1: String): void
        {
            this.var_3271 = param1;
        }

        public function get questionArray(): Array
        {
            return this.var_3273;
        }

        public function set questionArray(param1: Array): void
        {
            this.var_3273 = param1;
        }

    }
}
