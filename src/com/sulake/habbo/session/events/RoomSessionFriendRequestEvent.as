package com.sulake.habbo.session.events
{

    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionFriendRequestEvent extends RoomSessionEvent
    {

        public static const var_277: String = "RSFRE_FRIEND_REQUEST";

        private var var_2913: int = 0;
        private var _userId: int = 0;
        private var _userName: String;

        public function RoomSessionFriendRequestEvent(param1: IRoomSession, param2: int, param3: int, param4: String, param5: Boolean = false, param6: Boolean = false)
        {
            super(var_277, param1, param5, param6);
            this.var_2913 = param2;
            this._userId = param3;
            this._userName = param4;
        }

        public function get requestId(): int
        {
            return this.var_2913;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get userName(): String
        {
            return this._userName;
        }

    }
}
