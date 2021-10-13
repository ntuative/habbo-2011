package com.sulake.habbo.avatar.structure
{
    import flash.events.EventDispatcher;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;

    public class AvatarStructureDownload extends EventDispatcher 
    {

        public static const STRUCTURE_DONE:String = "AVATAR_STRUCTURE_DONE";

        private var var_2530:IStructureData;
        private var var_2531:XML;
        private var _assets:IAssetLibrary;

        public function AvatarStructureDownload(param1:IAssetLibrary, param2:String, param3:IStructureData)
        {
            this._assets = param1;
            this.var_2530 = param3;
            var _loc4_:String = param2;
            if (this._assets.hasAsset(_loc4_))
            {
                Logger.log(("[AvatarStructureDownload] reload data for url: " + param2));
            };
            var _loc5_:URLRequest = new URLRequest(param2);
            var _loc6_:AssetLoaderStruct = this._assets.loadAssetFromFile(_loc4_, _loc5_, "text/plain");
            _loc6_.addEventListener(AssetLoaderEvent.var_35, this.onDataComplete);
        }

        private function onDataComplete(event:Event):void
        {
            var loaderStruct:AssetLoaderStruct = (event.target as AssetLoaderStruct);
            if (loaderStruct == null)
            {
                return;
            };
            try
            {
                this.var_2531 = new XML((loaderStruct.assetLoader.content as String));
            }
            catch(e:Error)
            {
                Logger.log(("[AvatarStructureDownload] Error: " + e.message));
                return;
            };
            if (this.var_2531 == null)
            {
                Logger.log((("[AvatarStructureDownload] XML error: " + loaderStruct) + " not valid XML"));
                return;
            };
            this.var_2530.appendXML(this.var_2531);
            dispatchEvent(new Event(AvatarStructureDownload.STRUCTURE_DONE));
        }

    }
}