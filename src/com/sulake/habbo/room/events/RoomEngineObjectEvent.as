package com.sulake.habbo.room.events
{

    public class RoomEngineObjectEvent extends RoomEngineEvent
    {

        public static const REOE_OBJECT_SELECTED: String = "REOE_OBJECT_SELECTED";
        public static const REOE_OBJECT_DESELECTED: String = "REOE_OBJECT_DESELECTED";
        public static const REOB_OBJECT_ADDED: String = "REOB_OBJECT_ADDED";
        public static const REOE_OBJECT_REMOVED: String = "REOE_OBJECT_REMOVED";
        public static const REOB_OBJECT_PLACED: String = "REOB_OBJECT_PLACED";
        public static const REOB_OBJECT_REQUEST_MOVE: String = "REOB_OBJECT_REQUEST_MOVE";
        public static const REOE_WIDGET_REQUEST_PLACEHOLDER: String = "REOE_WIDGET_REQUEST_PLACEHOLDER";
        public static const ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI: String = "REOE_WIDGET_REQUEST_CREDITFURNI";
        public static const REOE_WIDGET_REQUEST_STICKIE: String = "REOE_WIDGET_REQUEST_STICKIE";
        public static const REOE_WIDGET_REQUEST_PRESENT: String = "REOE_WIDGET_REQUEST_PRESENT";
        public static const ROOM_OBJECT_WIDGET_REQUEST_TROPHY: String = "REOE_WIDGET_REQUEST_TROPHY";
        public static const REOE_WIDGET_REQUEST_TEASER: String = "REOE_WIDGET_REQUEST_TEASER";
        public static const REOE_WIDGET_REQUEST_ECOTRONBOX: String = "REOE_WIDGET_REQUEST_ECOTRONBOX";
        public static const REOE_WIDGET_REQUEST_DIMMER: String = "REOE_WIDGET_REQUEST_DIMMER";
        public static const REOR_REMOVE_DIMMER: String = "REOR_REMOVE_DIMMER";
        public static const REOR_REQUEST_CLOTHING_CHANGE: String = "REOR_REQUEST_CLOTHING_CHANGE";
        public static const REOR_WIDGET_REQUEST_PLAYLIST_EDITOR: String = "REOR_WIDGET_REQUEST_PLAYLIST_EDITOR";
        public static const REOE_ROOM_AD_FURNI_CLICK: String = "REOE_ROOM_AD_FURNI_CLICK";
        public static const REOE_ROOM_AD_FURNI_DOUBLE_CLICK: String = "REOE_ROOM_AD_FURNI_DOUBLE_CLICK";
        public static const REOE_ROOM_AD_TOOLTIP_SHOW: String = "REOE_ROOM_AD_TOOLTIP_SHOW";
        public static const REOE_ROOM_AD_TOOLTIP_HIDE: String = "REOE_ROOM_AD_TOOLTIP_HIDE";

        private var _objectId: int;
        private var _category: int;
        private var _roomId: int;
        private var _roomCategory: int;

        public function RoomEngineObjectEvent(type: String, roomId: int, roomCategory: int, objectId: int, category: int, bubbles: Boolean = false, cancelable: Boolean = false)
        {
            super(type, roomId, roomCategory, bubbles, cancelable);
            this._objectId = objectId;
            this._category = category;
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function get category(): int
        {
            return this._category;
        }

    }
}
