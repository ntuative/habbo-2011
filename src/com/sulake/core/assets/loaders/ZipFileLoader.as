package com.sulake.core.assets.loaders
{

    import flash.net.URLStream;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class ZipFileLoader extends AssetLoaderEventBroker implements IAssetLoader
    {

        protected var _url: String;
        protected var _type: String;
        protected var _content: URLStream;

        public function ZipFileLoader(param1: String, param2: URLRequest = null)
        {
            this._url = param2 == null ? "" : param2.url;
            this._type = param1;
            this._content = new URLStream();
            this._content.addEventListener(Event.COMPLETE, loadEventHandler);
            this._content.addEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
            this._content.addEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
            this._content.addEventListener(Event.OPEN, loadEventHandler);
            this._content.addEventListener(ProgressEvent.PROGRESS, loadEventHandler);
            this._content.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
            if (param2 != null)
            {
                this.load(param2);
            }

        }

        public function get url(): String
        {
            return this._url;
        }

        public function get ready(): Boolean
        {
            return this.bytesTotal > 0 ? this.bytesTotal == this.bytesLoaded : false;
        }

        public function get content(): Object
        {
            return this._content;
        }

        public function get mimeType(): String
        {
            return this._type;
        }

        public function get bytesLoaded(): uint
        {
            return this._content.bytesAvailable;
        }

        public function get bytesTotal(): uint
        {
            return this._content.bytesAvailable;
        }

        public function load(param1: URLRequest): void
        {
            this._url = param1.url;
            this._content.load(param1);
        }

        override public function dispose(): void
        {
            if (!_disposed)
            {
                super.dispose();
                this._content.removeEventListener(Event.COMPLETE, loadEventHandler);
                this._content.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loadEventHandler);
                this._content.removeEventListener(IOErrorEvent.IO_ERROR, loadEventHandler);
                this._content.removeEventListener(Event.OPEN, loadEventHandler);
                this._content.removeEventListener(ProgressEvent.PROGRESS, loadEventHandler);
                this._content.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadEventHandler);
                this._content.close();
                this._content = null;
                this._type = null;
                this._url = null;
            }

        }

    }
}
