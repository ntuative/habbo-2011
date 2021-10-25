package com.sulake.core.assets.loaders
{

    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;

    import flash.events.HTTPStatusEvent;

    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;

    internal class AssetLoaderEventBroker extends EventDispatcher implements IDisposable
    {

        public static const NONE: uint = 0;
        public static const IO_ERROR: uint = 1;
        public static const SECURITY_ERROR: uint = 2;

        protected var _status: int = 0;
        protected var _retryCount: int = 0;
        protected var _maxRetryCount: int = 2;
        protected var _errorCode: uint = 0;

        public function get errorCode(): uint
        {
            return this._errorCode;
        }

        protected function loadEventHandler(event: Event): void
        {
            switch (event.type)
            {
                case HTTPStatusEvent.HTTP_STATUS:
                    this._status = HTTPStatusEvent(event).status;
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_STATUS, this._status));
                    return;
                case Event.COMPLETE:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this._status));
                    return;
                case Event.UNLOAD:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_UNLOAD, this._status));
                    return;
                case Event.OPEN:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_OPEN, this._status));
                    return;
                case ProgressEvent.PROGRESS:
                    dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_PROGRESS, this._status));
                    return;
                case IOErrorEvent.IO_ERROR:
                    this._errorCode = IO_ERROR;
                    if (!this.retry())
                    {
                        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this._status));
                    }

                    return;
                case SecurityErrorEvent.SECURITY_ERROR:
                    this._errorCode = SECURITY_ERROR;
                    if (!this.retry())
                    {
                        dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this._status));
                    }

                    return;
                default:
                    Logger.log("Unknown asset loader event! AssetLoaderEventBroker::loadEventHandler(" + event + ")");
            }

        }

        protected function retry(): Boolean
        {
            return false;
        }

    }
}
