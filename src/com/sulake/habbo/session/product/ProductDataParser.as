package com.sulake.habbo.session.product
{

    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;

    import com.sulake.core.assets.AssetLibrary;

    import flash.net.URLRequest;

    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    import flash.events.Event;

    public class ProductDataParser extends EventDispatcher
    {

        public static const var_437: String = "ready";

        private var var_2839: Dictionary;
        private var var_2883: AssetLibrary;

        public function ProductDataParser(param1: String, param2: Dictionary)
        {
            this.var_2839 = param2;
            this.var_2883 = new AssetLibrary("ProductDataParserAssetLib");
            var _loc3_: AssetLoaderStruct = this.var_2883.loadAssetFromFile(param1, new URLRequest(param1), "text/plain");
            _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.parseProductsData);
        }

        public function dispose(): void
        {
            if (this.var_2883)
            {
                this.var_2883.dispose();
                this.var_2883 = null;
            }

            this.var_2839 = null;
        }

        private function parseProductsData(param1: Event): void
        {
            var _loc10_: String;
            var _loc11_: Array;
            var _loc12_: String;
            var _loc13_: Array;
            var _loc14_: String;
            var _loc15_: String;
            var _loc16_: String;
            var _loc17_: ProductData;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            if (_loc2_ == null)
            {
                return;
            }

            if (_loc2_.assetLoader == null || _loc2_.assetLoader.content == null)
            {
                return;
            }

            var _loc3_: String = _loc2_.assetLoader.content as String;
            var _loc4_: Array = [];
            var _loc5_: RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
            var _loc6_: RegExp = /^\s+|\s+$/g;
            var _loc7_: RegExp = /\[+?((.)*?)\]/g;
            _loc3_ = _loc3_.replace(/"{1,}/mg, "");
            var _loc8_: Array = _loc3_.split(_loc5_);
            var _loc9_: int;
            for each (_loc10_ in _loc8_)
            {
                _loc11_ = _loc10_.match(_loc7_);
                for each (_loc12_ in _loc11_)
                {
                    _loc12_ = _loc12_.replace(/\[{1,}/mg, "");
                    _loc12_ = _loc12_.replace(/\]{1,}/mg, "");
                    _loc13_ = _loc12_.split(",");
                    _loc14_ = _loc13_.shift();
                    _loc15_ = _loc13_.shift();
                    _loc16_ = _loc13_.join(",");
                    _loc17_ = new ProductData(_loc14_, _loc15_, _loc16_);
                    this.var_2839[_loc14_] = _loc17_;
                }

                _loc9_++;
            }

            dispatchEvent(new Event(var_437));
        }

    }
}
