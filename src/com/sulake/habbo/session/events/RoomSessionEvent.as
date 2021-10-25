package com.sulake.habbo.session.events
{

    import flash.events.Event;

    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionEvent extends Event
    {

        public static const RSE_CREATED: String = "RSE_CREATED";
        public static const RSE_STARTED: String = "RSE_STARTED";
        public static const RSE_ENDED: String = "RSE_ENDED";

        private var _session: IRoomSession;

        public function RoomSessionEvent(type: String, session: IRoomSession, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, bubbles, cancelable);

            this._session = session;
        }

        public function get session(): IRoomSession
        {
            return this._session;
        }

    }
}
