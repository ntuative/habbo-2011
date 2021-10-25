package com.sulake.habbo.widget.events
{

    public class RoomWidgetPlayListEditorEvent extends RoomWidgetUpdateEvent
    {

        public static const var_1241: String = "RWPLEE_SHOW_PLAYLIST_EDITOR";
        public static const var_1242: String = "RWPLEE_HIDE_PLAYLIST_EDITOR";
        public static const var_1243: String = "RWPLEE_INVENTORY_UPDATED";

        private var _furniId: int;

        public function RoomWidgetPlayListEditorEvent(param1: String, param2: int = -1, param3: Boolean = false, param4: Boolean = false)
        {
            super(param1, param3, param4);
            this._furniId = param2;
        }

        public function get furniId(): int
        {
            return this._furniId;
        }

    }
}
