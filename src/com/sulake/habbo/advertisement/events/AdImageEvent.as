package com.sulake.habbo.advertisement.events
{

    import flash.events.Event;

    public class AdImageEvent extends Event
    {

        public static const ROOM_AD_LOAD_IMAGE: String = "AE_ROOM_AD_LOAD_IMAGE";

        private var _imageUrl: String;
        private var dynamic: String;
        private var _roomId: int;
        private var _objectId: int;

        public function AdImageEvent(param1: String, param2: String, param3: String, param4: int, param5: int, param6: Boolean = false, param7: Boolean = false)
        {
            super(param1, param6, param7);
            this._imageUrl = param2;
            this.dynamic = param3;
            this._roomId = param4;
            this._objectId = param5;
        }

        public function get imageUrl(): String
        {
            return this._imageUrl;
        }

        public function get clickUrl(): String
        {
            return this.dynamic;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

    }
}
