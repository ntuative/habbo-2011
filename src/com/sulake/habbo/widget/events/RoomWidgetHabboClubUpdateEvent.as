package com.sulake.habbo.widget.events
{

    public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_123: String = "RWBIUE_HABBO_CLUB";

        private var var_4706: int = 0;
        private var var_4707: int = 0;
        private var var_4708: int = 0;
        private var var_4709: Boolean = false;
        private var var_2521: int;

        public function RoomWidgetHabboClubUpdateEvent(param1: int, param2: int, param3: int, param4: Boolean, param5: int, param6: Boolean = false, param7: Boolean = false)
        {
            super(var_123, param6, param7);
            this.var_4706 = param1;
            this.var_4707 = param2;
            this.var_4708 = param3;
            this.var_4709 = param4;
            this.var_2521 = param5;
        }

        public function get daysLeft(): int
        {
            return this.var_4706;
        }

        public function get periodsLeft(): int
        {
            return this.var_4707;
        }

        public function get pastPeriods(): int
        {
            return this.var_4708;
        }

        public function get allowClubDances(): Boolean
        {
            return this.var_4709;
        }

        public function get clubLevel(): int
        {
            return this.var_2521;
        }

    }
}
