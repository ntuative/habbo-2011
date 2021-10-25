package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    public class CatalogWidgetUpdateRoomPreviewEvent extends Event
    {

        private var _wallType: String = "default";
        private var _floorType: String = "default";
        private var _landscapeType: String = "1.1";
        private var _tileSize: int = 64;

        public function CatalogWidgetUpdateRoomPreviewEvent(floorType: String, wallType: String, landscapeType: String, tileSize: int, param5: Boolean = false, param6: Boolean = false)
        {
            super(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, param5, param6);

            this._floorType = floorType;
            this._wallType = wallType;
            this._landscapeType = landscapeType;
            this._tileSize = tileSize;
        }

        public function get wallType(): String
        {
            return this._wallType;
        }

        public function get floorType(): String
        {
            return this._floorType;
        }

        public function get landscapeType(): String
        {
            return this._landscapeType;
        }

        public function get tileSize(): int
        {
            return this._tileSize;
        }

    }
}
