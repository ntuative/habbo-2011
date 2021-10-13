package com.sulake.habbo.widget.events
{
    public class RoomWidgetTeaserDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1377:String = "RWTDUE_TEASER_DATA";
        public static const var_1378:String = "RWTDUE_GIFT_DATA";
        public static const var_1379:String = "RWTDUE_GIFT_RECEIVED";

        private var var_2358:int;
        private var _data:String;
        private var var_2101:int;
        private var var_3314:String;
        private var var_3312:String;
        private var var_3313:Boolean;
        private var var_3315:int = 0;
        private var var_4719:String;

        public function RoomWidgetTeaserDataUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

        public function get data():String
        {
            return (this._data);
        }

        public function get status():int
        {
            return (this.var_2101);
        }

        public function get firstClickUserName():String
        {
            return (this.var_3312);
        }

        public function get giftWasReceived():Boolean
        {
            return (this.var_3313);
        }

        public function get ownRealName():String
        {
            return (this.var_4719);
        }

        public function get itemCategory():int
        {
            return (this.var_3315);
        }

        public function set status(param1:int):void
        {
            this.var_2101 = param1;
        }

        public function set data(param1:String):void
        {
            this._data = param1;
        }

        public function set firstClickUserName(param1:String):void
        {
            this.var_3312 = param1;
        }

        public function set giftWasReceived(param1:Boolean):void
        {
            this.var_3313 = param1;
        }

        public function set ownRealName(param1:String):void
        {
            this.var_4719 = param1;
        }

        public function set objectId(param1:int):void
        {
            this.var_2358 = param1;
        }

        public function get campaignID():String
        {
            return (this.var_3314);
        }

        public function set campaignID(param1:String):void
        {
            this.var_3314 = param1;
        }

        public function set itemCategory(param1:int):void
        {
            this.var_3315 = param1;
        }

    }
}