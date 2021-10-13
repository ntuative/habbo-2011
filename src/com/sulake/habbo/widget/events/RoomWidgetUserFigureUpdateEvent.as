package com.sulake.habbo.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetUserFigureUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1342:String = "RWUTUE_USER_FIGURE";

        private var _userId:int;
        private var var_988:BitmapData;
        private var var_4721:Boolean;
        private var var_3310:String = "";
        private var var_3046:int;

        public function RoomWidgetUserFigureUpdateEvent(param1:int, param2:BitmapData, param3:Boolean, param4:String, param5:int, param6:Boolean=false, param7:Boolean=false)
        {
            super(var_1342, param6, param7);
            this._userId = param1;
            this.var_988 = param2;
            this.var_4721 = param3;
            this.var_3310 = param4;
            this.var_3046 = param5;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get image():BitmapData
        {
            return (this.var_988);
        }

        public function get isOwnUser():Boolean
        {
            return (this.var_4721);
        }

        public function get customInfo():String
        {
            return (this.var_3310);
        }

        public function get achievementScore():int
        {
            return (this.var_3046);
        }

    }
}