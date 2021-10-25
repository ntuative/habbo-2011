package com.sulake.room.events
{

    import flash.events.Event;

    public class RoomContentLoadedEvent extends Event
    {

        public static const ROOM_CONTENT_SUCCESS: String = "RCLE_SUCCESS";
        public static const ROOM_CONTENT_FAILURE: String = "RCLE_FAILURE";
        public static const ROOM_CONTENT_CANCEL: String = "RCLE_CANCEL";

        private var _contentType: String;

        public function RoomContentLoadedEvent(type: String, contentType: String, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, bubbles, cancelable);
            
            this._contentType = contentType;
        }

        public function get contentType(): String
        {
            return this._contentType;
        }

    }
}
