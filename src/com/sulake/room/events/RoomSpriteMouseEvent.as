package com.sulake.room.events
{

    public class RoomSpriteMouseEvent
    {

        private var _type: String = "";
        private var _eventId: String = "";
        private var _canvasId: String = "";
        private var _spriteTag: String = "";
        private var _screenX: Number = 0;
        private var _screenY: Number = 0;
        private var _localX: Number = 0;
        private var _localY: Number = 0;
        private var _ctrlKey: Boolean = false;
        private var _altKey: Boolean = false;
        private var _shiftKey: Boolean = false;
        private var _buttonDown: Boolean = false;

        public function RoomSpriteMouseEvent(type: String, eventId: String, canvasId: String, spriteTag: String, screenX: Number, screenY: Number, localX: Number = 0, localY: Number = 0, ctrlKey: Boolean = false, altKey: Boolean = false, shiftKey: Boolean = false, buttonDown: Boolean = false)
        {
            this._type = type;
            this._eventId = eventId;
            this._canvasId = canvasId;
            this._spriteTag = spriteTag;
            this._screenX = screenX;
            this._screenY = screenY;
            this._localX = localX;
            this._localY = localY;
            this._ctrlKey = ctrlKey;
            this._altKey = altKey;
            this._shiftKey = shiftKey;
            this._buttonDown = buttonDown;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get eventId(): String
        {
            return this._eventId;
        }

        public function get canvasId(): String
        {
            return this._canvasId;
        }

        public function get spriteTag(): String
        {
            return this._spriteTag;
        }

        public function get screenX(): Number
        {
            return this._screenX;
        }

        public function get screenY(): Number
        {
            return this._screenY;
        }

        public function get localX(): Number
        {
            return this._localX;
        }

        public function get localY(): Number
        {
            return this._localY;
        }

        public function get ctrlKey(): Boolean
        {
            return this._ctrlKey;
        }

        public function get altKey(): Boolean
        {
            return this._altKey;
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
