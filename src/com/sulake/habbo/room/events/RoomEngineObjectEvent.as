package com.sulake.habbo.room.events
{
    public class RoomEngineObjectEvent extends RoomEngineEvent 
    {

        public static const var_402:String = "REOE_OBJECT_SELECTED";
        public static const var_403:String = "REOE_OBJECT_DESELECTED";
        public static const var_404:String = "REOB_OBJECT_ADDED";
        public static const var_405:String = "REOE_OBJECT_REMOVED";
        public static const var_141:String = "REOB_OBJECT_PLACED";
        public static const var_406:String = "REOB_OBJECT_REQUEST_MOVE";
        public static const var_411:String = "REOE_WIDGET_REQUEST_PLACEHOLDER";
        public static const ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:String = "REOE_WIDGET_REQUEST_CREDITFURNI";
        public static const var_407:String = "REOE_WIDGET_REQUEST_STICKIE";
        public static const var_408:String = "REOE_WIDGET_REQUEST_PRESENT";
        public static const ROOM_OBJECT_WIDGET_REQUEST_TROPHY:String = "REOE_WIDGET_REQUEST_TROPHY";
        public static const var_409:String = "REOE_WIDGET_REQUEST_TEASER";
        public static const var_410:String = "REOE_WIDGET_REQUEST_ECOTRONBOX";
        public static const var_412:String = "REOE_WIDGET_REQUEST_DIMMER";
        public static const var_417:String = "REOR_REMOVE_DIMMER";
        public static const var_418:String = "REOR_REQUEST_CLOTHING_CHANGE";
        public static const var_419:String = "REOR_WIDGET_REQUEST_PLAYLIST_EDITOR";
        public static const var_413:String = "REOE_ROOM_AD_FURNI_CLICK";
        public static const var_414:String = "REOE_ROOM_AD_FURNI_DOUBLE_CLICK";
        public static const var_415:String = "REOE_ROOM_AD_TOOLTIP_SHOW";
        public static const var_416:String = "REOE_ROOM_AD_TOOLTIP_HIDE";

        private var var_2358:int;
        private var _category:int;
        private var _roomId:int;
        private var _roomCategory:int;

        public function RoomEngineObjectEvent(param1:String, param2:int, param3:int, param4:int, param5:int, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param2, param3, param6, param7);
            this.var_2358 = param4;
            this._category = param5;
        }

        public function get objectId():int
        {
            return (this.var_2358);
        }

        public function get category():int
        {
            return (this._category);
        }

    }
}