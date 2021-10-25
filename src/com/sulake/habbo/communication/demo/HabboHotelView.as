package com.sulake.habbo.communication.demo
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.assets.IAssetLibrary;

    import flash.events.IEventDispatcher;

    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.IHabboWindowManager;

    import flash.net.URLRequest;

    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    import flash.display.BitmapData;

    import com.sulake.core.assets.BitmapDataAsset;

    import flash.display.Bitmap;
    import flash.events.Event;

    import com.sulake.habbo.communication.enum.HabboHotelViewEvent;

    public class HabboHotelView implements IDisposable
    {

        private var _window: IDisplayObjectWrapper;
        private var var_2880: IDesktopWindow;
        private var _disposed: Boolean = false;
        private var var_2881: Function;
        private var var_2882: Function;
        private var var_2883: IAssetLibrary;
        private var var_2884: uint = 0;
        private var _events: IEventDispatcher;

        public function HabboHotelView(param1: IHabboWindowManager, param2: IAssetLibrary, param3: IEventDispatcher)
        {
            var _loc4_: IAsset;
            var _loc5_: XML;
            super();
            this.var_2883 = param2;
            this._events = param3;
            this.var_2880 = param1.getDesktop(0);
            var _loc6_: Array = [];
            _loc4_ = param2.getAssetByName("hotel_view_window");
            if (_loc4_ == null)
            {
                throw new Error("Missing asset; hotel view window layout!");
            }

            _loc5_ = (XmlAsset(_loc4_).content as XML);
            if (_loc5_)
            {
                this._window = (param1.buildFromXML(_loc5_, 0) as IDisplayObjectWrapper);
                this._window.rectangle = this._window.desktop.rectangle;
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this._window)
                {
                    this._window.dispose();
                    this._window = null;
                }

                this._disposed = true;
                this.var_2881 = null;
                this.var_2882 = null;
                this.var_2880 = null;
                this._events = null;
            }

        }

        public function loadHotelViewImage(param1: String, param2: Function = null): void
        {
            var _loc3_: AssetLoaderStruct = this.var_2883.loadAssetFromFile("hotelview_png", new URLRequest(param1), "image/png");
            if (param2 == null)
            {
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.hotelViewLoadedHandler);
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.hotelViewLoadedHandler);
            }
            else
            {
                this.var_2882 = param2;
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.hotelViewLoadedCallbackHandler);
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.hotelViewLoadedCallbackHandler);
            }

            this.var_2884++;
        }

        private function hotelViewLoadedHandler(param1: AssetLoaderEvent): void
        {
            var _loc4_: BitmapData;
            var _loc5_: IDisplayObjectWrapper;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            var _loc3_: IAsset = this.var_2883.getAssetByName(_loc2_.assetName);
            if (param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
            {
                _loc4_ = (BitmapDataAsset(_loc3_).content as BitmapData);
                if (this._window && !this._window.disposed)
                {
                    _loc5_ = (this._window as IDisplayObjectWrapper);
                    if (_loc5_ != null)
                    {
                        _loc5_.width = _loc4_.width;
                        _loc5_.height = _loc4_.height;
                        _loc5_.setDisplayObject(new Bitmap(_loc4_));
                    }

                }

            }

            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.hotelViewLoadedHandler);
            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.hotelViewLoadedHandler);
        }

        private function hotelViewLoadedCallbackHandler(param1: AssetLoaderEvent): void
        {
            var _loc4_: BitmapData;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            var _loc3_: IAsset = this.var_2883.getAssetByName(_loc2_.assetName);
            if (param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR)
            {
                if (this._events != null)
                {
                    this._events.dispatchEvent(new Event(HabboHotelViewEvent.var_61));
                }

            }
            else
            {
                if (param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
                {
                    if (this._events != null)
                    {
                        this._events.dispatchEvent(new Event(HabboHotelViewEvent.var_62));
                    }

                    _loc4_ = (BitmapDataAsset(_loc3_).content as BitmapData);
                    if (this.var_2882 != null)
                    {
                        this.var_2882(_loc4_);
                        this.var_2882 = null;
                    }

                }

            }

            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.hotelViewLoadedCallbackHandler);
            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.hotelViewLoadedCallbackHandler);
        }

        public function loadBannerImage(param1: String, param2: Function): void
        {
            var _loc3_: AssetLoaderStruct = this.var_2883.loadAssetFromFile("hotel_view_banner_" + this.var_2884, new URLRequest(param1), "image/png");
            if (param2 == null)
            {
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.bannerLoadedHandler);
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.bannerLoadedHandler);
            }
            else
            {
                if (this._events != null)
                {
                    this._events.dispatchEvent(new Event(HabboHotelViewEvent.var_60));
                }

                this.var_2881 = param2;
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.bannerLoadedCallbackHandler);
                _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.bannerLoadedCallbackHandler);
            }

            this.var_2884++;
        }

        private function bannerLoadedHandler(param1: AssetLoaderEvent): void
        {
            var _loc4_: BitmapData;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            var _loc3_: IAsset = this.var_2883.getAssetByName(_loc2_.assetName);
            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.bannerLoadedHandler);
            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.bannerLoadedHandler);
        }

        private function bannerLoadedCallbackHandler(param1: AssetLoaderEvent): void
        {
            var _loc4_: BitmapData;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            var _loc3_: IAsset = this.var_2883.getAssetByName(_loc2_.assetName);
            if (param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR)
            {
                if (this._events != null)
                {
                    this._events.dispatchEvent(new Event(HabboHotelViewEvent.var_61));
                }

            }
            else
            {
                if (param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
                {
                    if (this._events != null)
                    {
                        this._events.dispatchEvent(new Event(HabboHotelViewEvent.var_62));
                    }

                    _loc4_ = (BitmapDataAsset(_loc3_).content as BitmapData);
                    if (this.var_2881 != null)
                    {
                        this.var_2881(_loc4_);
                        this.var_2881 = null;
                    }

                }

            }

            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.bannerLoadedCallbackHandler);
            _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_ERROR, this.bannerLoadedCallbackHandler);
        }

        public function show(): void
        {
            if (this._window && !this._window.disposed)
            {
                this.var_2880.addChildAt(this._window, 0);
            }

        }

        public function hide(): void
        {
            if (this._window && !this._window.disposed)
            {
                this.var_2880.removeChild(this._window);
            }

        }

    }
}
