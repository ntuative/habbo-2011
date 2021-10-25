package com.sulake.habbo.session.events
{

    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserFigureUpdateEvent extends RoomSessionEvent
    {

        public static const var_1342: String = "RSUBE_FIGURE";

        private var _userId: int = 0;
        private var var_2534: String = "";
        private var var_2071: String = "";
        private var var_3310: String = "";
        private var var_3046: int;

        public function RoomSessionUserFigureUpdateEvent(param1: IRoomSession, param2: int, param3: String, param4: String, param5: String, param6: int, param7: Boolean = false, param8: Boolean = false)
        {
            super(var_1342, param1, param7, param8);
            this._userId = param2;
            this.var_2534 = param3;
            this.var_2071 = param4;
            this.var_3310 = param5;
            this.var_3046 = param6;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get figure(): String
        {
            return this.var_2534;
        }

        public function get gender(): String
        {
            return this.var_2071;
        }

        public function get customInfo(): String
        {
            return this.var_3310;
        }

        public function get achievementScore(): int
        {
            return this.var_3046;
        }

    }
}
