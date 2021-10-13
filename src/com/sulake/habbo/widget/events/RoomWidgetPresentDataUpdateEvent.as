package com.sulake.habbo.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPresentDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1274:String = "RWPDUE_PACKAGEINFO";
        public static const var_1275:String = "RWPDUE_CONTENTS";
        public static const var_1276:String = "RWPDUE_CONTENTS_CLUB";
        public static const var_1277:String = "RWPDUE_CONTENTS_FLOOR";
        public static const var_1278:String = "RWPDUE_CONTENTS_LANDSCAPE";
        public static const var_1279:String = "RWPDUE_CONTENTS_WALLPAPER";

        private var var_2358:int = -1;
        private var _text:String;
        private var _controller:Boolean;
        private var var_4703:BitmapData;

        public function RoomWidgetPresentDataUpdateEvent(param1:String, param2:int, param3:String, param4:Boolean=false, param5:BitmapData=null, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_2358 = param2;
            this._text = param3;
            this._controller = param4;
            this.var_4703 = param5;
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

        public function get text():String
        {
            return (this._text);
        }

        public function get controller():Boolean
        {
            return (this._controller);
        }

        public function get iconBitmapData():BitmapData
        {
            return (this.var_4703);
        }

    }
}