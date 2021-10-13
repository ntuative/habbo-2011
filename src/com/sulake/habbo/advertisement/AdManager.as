package com.sulake.habbo.advertisement
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.habbo.advertisement.events.AdImageEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdMessageEvent;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.system.Security;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetInterstitialMessageComposer;
    import com.sulake.habbo.communication.messages.parser.advertisement.InterstitialMessageParser;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.loaders.IAssetLoader;
    import flash.display.Bitmap;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetRoomAdMessageComposer;
    import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdMessageParser;
    import flash.events.Event;
    import com.sulake.core.assets.IAsset;

    public class AdManager extends Component implements IAdManager 
    {

        private var var_2077:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _config:IHabboConfigurationManager;
        private var var_2359:Boolean;
        private var var_2360:String;
        private var var_2361:String;
        private var var_2362:int = 0;
        private var var_2363:int = 0;
        private var var_2364:int = 0;
        private var var_2365:int = 0;
        private var var_2366:int = 0;
        private var var_2367:Timer;
        private var var_2368:String;
        private var var_2369:String;
        private var var_2370:BitmapData = null;
        private var var_2371:BitmapData = null;
        private var var_2372:Map;

        public function AdManager(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_2372 = new Map();
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            events.addEventListener(AdImageEvent.ROOM_AD_LOAD_IMAGE, this.onLoadAdImage);
        }

        override public function dispose():void
        {
            super.dispose();
            this._connection = null;
            if (this.var_2372 != null)
            {
                this.var_2372.dispose();
                this.var_2372 = null;
            };
            if (this.var_2077 != null)
            {
                release(new IIDHabboCommunicationManager());
                this.var_2077 = null;
            };
            if (this._config != null)
            {
                release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this.var_2370)
            {
                this.var_2370.dispose();
                this.var_2370 = null;
            };
            if (this.var_2371)
            {
                this.var_2371.dispose();
                this.var_2371 = null;
            };
        }

        private function onCommunicationManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_2077 = (param2 as IHabboCommunicationManager);
            if (this.var_2077 == null)
            {
                return;
            };
            this._connection = this.var_2077.getHabboMainConnection(this.onConnectionReady);
            if (this._connection != null)
            {
                this.onConnectionReady(this._connection);
            };
        }

        private function onConnectionReady(param1:IConnection):void
        {
            if (((disposed) || (param1 == null)))
            {
                return;
            };
            this._connection = param1;
            this._connection.addMessageEvent(new InterstitialMessageEvent(this.onInterstitial));
            this._connection.addMessageEvent(new RoomAdMessageEvent(this.onRoomAd));
        }

        private function onConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            var _loc7_:URLRequest;
            var _loc8_:AssetLoaderStruct;
            this._config = (param2 as IHabboConfigurationManager);
            if (this._config == null)
            {
                return;
            };
            this.var_2359 = (this._config.getKey("interstitial.enabled", "false") == "true");
            this.var_2362 = int(this._config.getKey("interstitial.interval", "30000"));
            this.var_2364 = int(this._config.getKey("interstitial.show.time", "5000"));
            this.var_2365 = int(this._config.getKey("interstitial.max.displays.flash", "-1"));
            var _loc3_:String = this._config.getKey("ads.domain");
            if (_loc3_ != "")
            {
                Security.loadPolicyFile((("http://" + _loc3_) + "/crossdomain.xml"));
            };
            var _loc4_:String = this._config.getKey("billboard.adwarning.left.url");
            var _loc5_:String = this._config.getKey("billboard.adwarning.right.url");
            var _loc6_:String = this._config.getKey("image.library.url");
            if (((!(_loc4_ == "")) && (!(_loc5_ == ""))))
            {
                _loc4_ = (_loc6_ + _loc4_);
                _loc5_ = (_loc6_ + _loc5_);
                _loc7_ = new URLRequest(_loc4_);
                _loc8_ = assets.loadAssetFromFile("adWarningL", _loc7_, "image/png");
                _loc8_.addEventListener(AssetLoaderEvent.var_35, this.adWarningLeftReady);
                _loc7_ = new URLRequest(_loc5_);
                _loc8_ = assets.loadAssetFromFile("adWarningRight", _loc7_, "image/png");
                _loc8_.addEventListener(AssetLoaderEvent.var_35, this.adWarningRightReady);
            };
        }

        public function showInterstitial():Boolean
        {
            if (!this.var_2359)
            {
                return (false);
            };
            if (((!(this.var_2367 == null)) && (this.var_2367.running)))
            {
                this.var_2367.reset();
                return (false);
            };
            if (this.var_2363 == 0)
            {
                this.var_2363 = getTimer();
                return (false);
            };
            if (((this.var_2365 > 0) && (this.var_2366 >= this.var_2365)))
            {
                return (false);
            };
            var _loc1_:int = (getTimer() - this.var_2363);
            if (_loc1_ > this.var_2362)
            {
                this.var_2366++;
                this._connection.send(new GetInterstitialMessageComposer());
                return (true);
            };
            return (false);
        }

        private function onInterstitial(param1:InterstitialMessageEvent):void
        {
            var _loc3_:String;
            var _loc4_:URLRequest;
            var _loc5_:AssetLoaderStruct;
            var _loc2_:InterstitialMessageParser = param1.getParser();
            this.var_2360 = _loc2_.imageUrl;
            this.var_2361 = _loc2_.clickUrl;
            this.var_2363 = getTimer();
            if (this.var_2360 != "")
            {
                _loc3_ = this.var_2360;
                if (assets.hasAsset(_loc3_))
                {
                    assets.removeAsset(assets.getAssetByName(_loc3_));
                };
                if (this.var_2367 == null)
                {
                    this.var_2367 = new Timer(this.var_2364, 1);
                    this.var_2367.addEventListener(TimerEvent.TIMER_COMPLETE, this.interstitialTimerComplete);
                };
                if (this.var_2367.running)
                {
                    this.var_2367.reset();
                };
                this.var_2367.start();
                _loc4_ = new URLRequest(this.var_2360);
                _loc5_ = assets.loadAssetFromFile(_loc3_, _loc4_, "image/jpeg");
                _loc5_.addEventListener(AssetLoaderEvent.var_35, this.interstitialLoaderEventHandler);
                _loc5_.addEventListener(AssetLoaderEvent.var_36, this.interstitialLoaderEventHandler);
            }
            else
            {
                this.stopInterstitial();
            };
        }

        private function interstitialLoaderEventHandler(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct;
            var _loc3_:IAssetLoader;
            var _loc4_:Bitmap;
            if (param1 == null)
            {
                return;
            };
            switch (param1.type)
            {
                case AssetLoaderEvent.var_35:
                    _loc2_ = (param1.target as AssetLoaderStruct);
                    if (_loc2_ != null)
                    {
                        _loc3_ = _loc2_.assetLoader;
                        if (_loc3_ != null)
                        {
                            _loc4_ = (_loc3_.content as Bitmap);
                            this.startInterstitial(_loc4_);
                            return;
                        };
                    };
                    this.stopInterstitial();
                    return;
                case AssetLoaderEvent.var_36:
                    this.stopInterstitial();
                    return;
            };
        }

        private function startInterstitial(param1:Bitmap):void
        {
            if (((!(this.var_2367 == null)) && (!(this.var_2367.running))))
            {
                return;
            };
            if (this.isValidAdImage(param1))
            {
                events.dispatchEvent(new AdEvent(AdEvent.var_349, 0, 0, param1.bitmapData, this.var_2361));
                this.var_2363 = getTimer();
            }
            else
            {
                this.stopInterstitial();
            };
        }

        private function interstitialTimerComplete(param1:TimerEvent):void
        {
            this.stopInterstitial();
        }

        private function stopInterstitial():void
        {
            if (((!(this.var_2367 == null)) && (this.var_2367.running)))
            {
                this.var_2367.reset();
            };
            if (events != null)
            {
                events.dispatchEvent(new AdEvent(AdEvent.var_350));
            };
        }

        public function showRoomAd():void
        {
            this._connection.send(new GetRoomAdMessageComposer());
        }

        private function onRoomAd(param1:RoomAdMessageEvent):void
        {
            var _loc3_:String;
            var _loc4_:URLRequest;
            var _loc5_:AssetLoaderStruct;
            var _loc2_:RoomAdMessageParser = param1.getParser();
            this.var_2368 = _loc2_.imageUrl;
            this.var_2369 = _loc2_.clickUrl;
            if (((!(this.var_2368 == "")) && (!(this.var_2369 == ""))))
            {
                _loc3_ = this.var_2368;
                if (assets.hasAsset(_loc3_))
                {
                    assets.removeAsset(assets.getAssetByName(_loc3_));
                };
                _loc4_ = new URLRequest(this.var_2368);
                _loc5_ = assets.loadAssetFromFile(_loc3_, _loc4_, "image/jpeg");
                _loc5_.addEventListener(AssetLoaderEvent.var_35, this.roomAdImageReady);
            };
        }

        private function roomAdImageReady(param1:AssetLoaderEvent):void
        {
            var _loc4_:BitmapData;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            if (this.isValidAdImage(_loc3_))
            {
                _loc4_ = this.emulateBackgroundTransparency(_loc3_.bitmapData);
                events.dispatchEvent(new AdEvent(AdEvent.var_70, 0, 0, _loc4_, _loc2_.assetName, this.var_2369, this.var_2370, this.var_2371));
            };
        }

        private function adWarningLeftReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            if (_loc3_ != null)
            {
                this.var_2370 = this.emulateBackgroundTransparency(_loc3_.bitmapData);
            };
        }

        private function adWarningRightReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            if (_loc3_ != null)
            {
                this.var_2371 = this.emulateBackgroundTransparency(_loc3_.bitmapData);
            };
        }

        private function emulateBackgroundTransparency(param1:BitmapData):BitmapData
        {
            var _loc4_:int;
            var _loc5_:uint;
            if (param1 == null)
            {
                return (null);
            };
            var _loc2_:BitmapData = new BitmapData(param1.width, param1.height, true, 0);
            var _loc3_:int;
            while (_loc3_ < _loc2_.height)
            {
                _loc4_ = 0;
                while (_loc4_ < _loc2_.width)
                {
                    _loc5_ = param1.getPixel32(_loc4_, _loc3_);
                    if (_loc5_ != 0xFFFFFFFF)
                    {
                        _loc2_.setPixel32(_loc4_, _loc3_, _loc5_);
                    };
                    _loc4_++;
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        private function isValidAdImage(param1:Bitmap):Boolean
        {
            if (((!(param1 == null)) && ((param1.width > 1) || (param1.height > 1))))
            {
                return (true);
            };
            return (false);
        }

        public function loadRoomAdImage(param1:int, param2:int, param3:String, param4:String):void
        {
            if (events != null)
            {
                events.dispatchEvent(new AdImageEvent(AdImageEvent.ROOM_AD_LOAD_IMAGE, param3, param4, param1, param2));
            };
        }

        private function onLoadAdImage(param1:Event):void
        {
            if ((param1 is AdImageEvent))
            {
                this.loadImageAsset((param1 as AdImageEvent));
            };
        }

        private function loadImageAsset(param1:AdImageEvent):void
        {
            var _loc6_:IAsset;
            var _loc7_:Object;
            var _loc8_:AdImageEvent;
            if (param1 == null)
            {
                return;
            };
            if (((param1.imageUrl == null) || (param1.imageUrl == "")))
            {
                return;
            };
            var _loc2_:String = param1.imageUrl;
            if (assets.hasAsset(_loc2_))
            {
                _loc6_ = assets.getAssetByName(_loc2_);
                if (_loc6_ != null)
                {
                    _loc7_ = _loc6_.content;
                    if ((_loc7_ is BitmapData))
                    {
                        this.dispatchImageAsset((_loc6_.content as BitmapData), param1);
                        return;
                    };
                };
            };
            var _loc3_:Array = this.var_2372.getValue(_loc2_);
            if (_loc3_ == null)
            {
                _loc3_ = new Array();
                this.var_2372.add(_loc2_, _loc3_);
            };
            if (_loc3_.length > 0)
            {
                for each (_loc8_ in _loc3_)
                {
                    if (_loc8_.objectId == param1.objectId)
                    {
                        return;
                    };
                };
            };
            _loc3_.push(param1);
            Logger.log(("trying to load billboard from url " + _loc2_));
            var _loc4_:URLRequest = new URLRequest(_loc2_);
            var _loc5_:AssetLoaderStruct = assets.loadAssetFromFile(_loc2_, _loc4_, "image/png");
            _loc5_.addEventListener(AssetLoaderEvent.var_35, this.onBillboardImageReady);
            _loc5_.addEventListener(AssetLoaderEvent.var_36, this.onBillboardImageLoadError);
        }

        private function onBillboardImageReady(param1:AssetLoaderEvent):void
        {
            var _loc5_:BitmapData;
            var _loc6_:AdImageEvent;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            var _loc4_:Array = this.var_2372.remove(_loc2_.assetName);
            if (((_loc4_ == null) || (_loc4_.length == 0)))
            {
                return;
            };
            Logger.log(("billboard image loaded from url " + _loc2_.assetName));
            if (this.isValidAdImage(_loc3_))
            {
                _loc5_ = _loc3_.bitmapData;
                for each (_loc6_ in _loc4_)
                {
                    this.dispatchImageAsset(_loc5_, _loc6_);
                };
            };
        }

        private function dispatchImageAsset(param1:BitmapData, param2:AdImageEvent):void
        {
            if (events != null)
            {
                events.dispatchEvent(new AdEvent(AdEvent.var_347, param2.roomId, 0, param1.clone(), param2.imageUrl, param2.clickUrl, null, null, param2.objectId));
            };
        }

        private function onBillboardImageLoadError(param1:AssetLoaderEvent):void
        {
            var _loc5_:AdImageEvent;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            var _loc3_:Bitmap = (_loc2_.assetLoader.content as Bitmap);
            var _loc4_:Array = this.var_2372.remove(_loc2_.assetName);
            if (((_loc4_ == null) || (_loc4_.length == 0)))
            {
                return;
            };
            for each (_loc5_ in _loc4_)
            {
                Logger.log((("failed to load billboard image from url '" + _loc2_.assetName) + "'"));
                events.dispatchEvent(new AdEvent(AdEvent.var_348, _loc5_.roomId, 0, null, _loc5_.imageUrl, _loc5_.clickUrl, null, null, _loc5_.objectId));
            };
        }

    }
}