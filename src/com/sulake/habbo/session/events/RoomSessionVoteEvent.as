package com.sulake.habbo.session.events
{

    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionVoteEvent extends RoomSessionEvent
    {

        public static const var_394: String = "RSPE_VOTE_QUESTION";
        public static const var_395: String = "RSPE_VOTE_RESULT";

        private var var_3275: String = "";
        private var var_3276: Array = [];
        private var var_3277: Array = [];
        private var var_3278: int = 0;

        public function RoomSessionVoteEvent(param1: String, param2: IRoomSession, param3: String, param4: Array, param5: Array = null, param6: int = 0, param7: Boolean = false, param8: Boolean = false)
        {
            super(param1, param2, param7, param8);
            this.var_3275 = param3;
            this.var_3276 = param4;
            this.var_3277 = param5;
            if (this.var_3277 == null)
            {
                this.var_3277 = [];
            }

            this.var_3278 = param6;
        }

        public function get question(): String
        {
            return this.var_3275;
        }

        public function get choices(): Array
        {
            return this.var_3276.slice();
        }

        public function get votes(): Array
        {
            return this.var_3277.slice();
        }

        public function get totalVotes(): int
        {
            return this.var_3278;
        }

    }
}
