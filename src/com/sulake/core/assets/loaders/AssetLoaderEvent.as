package com.sulake.core.assets.loaders
{

    import flash.events.Event;

    public class AssetLoaderEvent extends Event
    {

        public static const ASSET_LOADER_EVENT_COMPLETE: String = "AssetLoaderEventComplete";
        public static const ASSET_LOADER_EVENT_PROGRESS: String = "AssetLoaderEventProgress";
        public static const ASSET_LOADER_EVENT_UNLOAD: String = "AssetLoaderEventUnload";
        public static const ASSET_LOADER_EVENT_STATUS: String = "AssetLoaderEventStatus";
        public static const ASSET_LOADER_EVENT_ERROR: String = "AssetLoaderEventError";
        public static const ASSET_LOADER_EVENT_OPEN: String = "AssetLoaderEventOpen";

        private var _status: int;

        public function AssetLoaderEvent(type: String, status: int)
        {
            this._status = status;

            super(type, false, false);
        }

        public function get status(): int
        {
            return this._status;
        }

        override public function clone(): Event
        {
            return new AssetLoaderEvent(type, this._status);
        }

        override public function toString(): String
        {
            return formatToString("AssetLoaderEvent", "type", "status");
        }

    }
}
