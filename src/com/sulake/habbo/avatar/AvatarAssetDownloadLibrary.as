package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import flash.events.Event;

    public class AvatarAssetDownloadLibrary extends EventDispatcher 
    {

        private static var var_2541:int = 0;
        private static var var_2544:int = 1;
        private static var var_1237:int = 2;

        private var _state:int;
        private var var_2542:String;
        private var _revision:String;
        private var var_2543:String;
        private var _assets:IAssetLibrary;

        public function AvatarAssetDownloadLibrary(param1:String, param2:String, param3:String, param4:IAssetLibrary)
        {
            this._state = var_2541;
            this._assets = param4;
            this.var_2542 = String(param1);
            this._revision = String(param2);
            this.var_2543 = ((param3 + this.var_2542) + ".swf");
            this.var_2543 = this.var_2543.replace("%revision%", this._revision);
            var _loc5_:AssetLibraryCollection = (this._assets as AssetLibraryCollection);
            var _loc6_:IAssetLibrary = _loc5_.getAssetLibraryByUrl((this.var_2542 + ".swf"));
            if (_loc6_ != null)
            {
                Logger.log(("[AvatarAssetDownloadLibrary] Already Downloaded by Core: " + this.var_2542));
                this._state = var_1237;
            };
        }

        override public function dispose():void
        {
            super.dispose();
        }

        public function startDownloading():void
        {
            this._state = var_2544;
            var _loc1_:URLRequest = new URLRequest(this.var_2543);
            var _loc2_:LibraryLoader = new LibraryLoader();
            this._assets.loadFromFile(_loc2_, true);
            _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _loc2_.load(_loc1_);
        }

        private function onLoaderComplete(param1:Event):void
        {
            var _loc2_:LibraryLoader = (param1.target as LibraryLoader);
            _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            this._state = var_1237;
            dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get libraryName():String
        {
            return (this.var_2542);
        }

        public function get isReady():Boolean
        {
            return (this._state == var_1237);
        }

        public function toString():String
        {
            var _loc1_:String = this.var_2542;
            return (_loc1_ + ((this.isReady) ? "[x]" : "[ ]"));
        }

    }
}