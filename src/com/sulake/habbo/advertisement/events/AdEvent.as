package com.sulake.habbo.advertisement.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class AdEvent extends Event 
    {

        public static const var_347:String = "AE_ROOM_AD_IMAGE_LOADED";
        public static const var_348:String = "AE_ROOM_AD_IMAGE_LOADING_FAILED";
        public static const var_70:String = "AE_ROOM_AD_SHOW";
        public static const var_349:String = "AE_INTERSTITIAL_SHOW";
        public static const var_350:String = "AE_INTERSTITIAL_COMPLETE";

        private var var_988:BitmapData;
        private var _roomId:int;
        private var _roomCategory:int;
        private var _imageUrl:String;
        private var dynamic:String;
        private var var_2356:BitmapData;
        private var var_2357:BitmapData;
        private var var_2358:int;

        public function AdEvent(param1:String, param2:int=0, param3:int=0, param4:BitmapData=null, param5:String="", param6:String="", param7:BitmapData=null, param8:BitmapData=null, param9:int=-1, param10:Boolean=false, param11:Boolean=false)
        {
            super(param1, param10, param11);
            this.var_988 = param4;
            this._roomId = param2;
            this._roomCategory = param3;
            this._imageUrl = param5;
            this.dynamic = param6;
            this.var_2356 = param7;
            this.var_2357 = param8;
            this.var_2358 = param9;
        }

        public function get image():BitmapData
        {
            return (this.var_988);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get imageUrl():String
        {
            return (this._imageUrl);
        }

        public function get clickUrl():String
        {
            return (this.dynamic);
        }

        public function get adWarningL():BitmapData
        {
            return (this.var_2356);
        }

        public function get adWarningR():BitmapData
        {
            return (this.var_2357);
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

    }
}