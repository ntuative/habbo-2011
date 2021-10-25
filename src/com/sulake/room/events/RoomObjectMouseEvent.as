package com.sulake.room.events
{

    public class RoomObjectMouseEvent extends RoomObjectEvent
    {

        public static const ROOM_OBJECT_MOUSE_CLICK: String = "ROE_MOUSE_CLICK";
        public static const ROOM_OBJECT_MOUSE_ENTER: String = "ROE_MOUSE_ENTER";
        public static const ROOM_OBJECT_MOUSE_MOVE: String = "ROE_MOUSE_MOVE";
        public static const ROOM_OBJECT_MOUSE_LEAVE: String = "ROE_MOUSE_LEAVE";
        public static const ROOM_OBJECT_MOUSE_DOUBLE_CLICK: String = "ROE_MOUSE_DOUBLE_CLICK";
        public static const ROOM_OBJECT_MOUSE_DOWN: String = "ROE_MOUSE_DOWN";

        private var _eventId: String = "";
        private var _altKey: Boolean;
        private var _ctrlKey: Boolean;
        private var _shiftKey: Boolean;
        private var _buttonDown: Boolean;

        public function RoomObjectMouseEvent(type: String, eventId: String, objectId: int, objectType: String, altKey: Boolean = false, ctrlKey: Boolean = false, shiftKey: Boolean = false, buttonDown: Boolean = false, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, objectId, objectType, bubbles, cancelable);
            
            this._eventId = eventId;
            this._altKey = altKey;
            this._ctrlKey = ctrlKey;
            this._shiftKey = shiftKey;
            this._buttonDown = buttonDown;
        }

        public function get eventId(): String
        {
            return this._eventId;
        }

        public function get altKey(): Boolean
        {
            return this._altKey;
        }

        public function get ctrlKey(): Boolean
        {
            return this._ctrlKey;
        }

        public function get shiftKey(): Boolean
        {
            return this._shiftKey;
        }

        public function get buttonDown(): Boolean
        {
            return this._buttonDown;
        }

    }
}
