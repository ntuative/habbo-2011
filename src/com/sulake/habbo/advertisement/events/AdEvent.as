package com.sulake.habbo.advertisement.events
{

    import flash.events.Event;
    import flash.display.BitmapData;

    public class AdEvent extends Event
    {

        public static const ROOM_AD_IMAGE_LOADED: String = "AE_ROOM_AD_IMAGE_LOADED";
        public static const ROOM_AD_IMAGE_LOADING_FAILED: String = "AE_ROOM_AD_IMAGE_LOADING_FAILED";
        public static const ROOM_AD_SHOW: String = "AE_ROOM_AD_SHOW";
        public static const INTERSTITIAL_SHOW: String = "AE_INTERSTITIAL_SHOW";
        public static const INTERSTITIAL_COMPLETE: String = "AE_INTERSTITIAL_COMPLETE";

        private var _image: BitmapData;
        private var _roomId: int;
        private var _roomCategory: int;
        private var _imageUrl: String;
        private var dynamic: String;
        private var _adWarningL: BitmapData;
        private var _adWarningR: BitmapData;
        private var _objectId: int;

        public function AdEvent(param1: String, param2: int = 0, param3: int = 0, param4: BitmapData = null, param5: String = "", param6: String = "", param7: BitmapData = null, param8: BitmapData = null, param9: int = -1, param10: Boolean = false, param11: Boolean = false)
        {
            super(param1, param10, param11);
            this._image = param4;
            this._roomId = param2;
            this._roomCategory = param3;
            this._imageUrl = param5;
            this.dynamic = param6;
            this._adWarningL = param7;
            this._adWarningR = param8;
            this._objectId = param9;
        }

        public function get image(): BitmapData
        {
            return this._image;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get imageUrl(): String
        {
            return this._imageUrl;
        }

        public function get clickUrl(): String
        {
            return this.dynamic;
        }

        public function get adWarningL(): BitmapData
        {
            return this._adWarningL;
        }

        public function get adWarningR(): BitmapData
        {
            return this._adWarningR;
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

    }
}
