package com.sulake.habbo.communication.demo
{
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import com.sulake.habbo.communication.IHabboWebLogin;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.enum.HabboWeb;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;

    public class SSOTicket extends EventDispatcher 
    {

        public static const var_1572:String = "success";
        public static const var_1573:String = "failure";

        private var var_2103:URLLoader;
        private var var_2888:String;
        private var var_2887:IHabboWebLogin;
        private var var_2889:String;
        private var var_2890:String;
        private var var_2873:String;
        private var _assets:IAssetLibrary;
        private var var_2891:Boolean;

        public function SSOTicket(param1:IAssetLibrary, param2:IHabboWebLogin, param3:String, param4:Boolean=true)
        {
            this._assets = param1;
            this.var_2887 = param2;
            this.var_2888 = (("http://" + param3) + "/client");
            if (!param4)
            {
                this.var_2887.init();
                this.var_2887.addEventListener(HabboWeb.var_1440, this.requestClientURL);
            }
            else
            {
                this.requestClientURL();
            };
        }

        public function get ticket():String
        {
            return (this.var_2890);
        }

        public function get isFacebookUser():Boolean
        {
            return (this.var_2891);
        }

        public function get flashClientUrl():String
        {
            return (this.var_2873);
        }

        private function requestClientURL(param1:Event=null):void
        {
            var _loc2_:String = this.var_2888;
            if (this._assets.hasAsset(_loc2_))
            {
                Logger.log(("[CoreLocalizationManager] reload localization for url: " + this.var_2888));
            };
            var _loc3_:URLRequest = new URLRequest(this.var_2888);
            if (this._assets.hasAsset(_loc2_))
            {
                this._assets.removeAsset(this._assets.getAssetByName(_loc2_));
            };
            var _loc4_:AssetLoaderStruct = this._assets.loadAssetFromFile(_loc2_, _loc3_, "text/plain");
            _loc4_.addEventListener(AssetLoaderEvent.var_35, this.clientURLComplete);
        }

        private function clientURLComplete(event:Event=null):void
        {
            var facebookData:Object;
            var loaderStruct:AssetLoaderStruct = (event.target as AssetLoaderStruct);
            if (loaderStruct == null)
            {
                return;
            };
            var data:String = (loaderStruct.assetLoader.content as String);
            if (data.indexOf('account/reauthenticate"') > -1)
            {
                this.var_2887.requestReAuthenticate();
            }
            else
            {
                try
                {
                    this.var_2890 = /\"sso.ticket\" : \"(.*?)\"/.exec(data)[1];
                    this.var_2873 = /\"flash.client.url\" : \"(.*?)\"/.exec(data)[1];
                    facebookData = /\"facebook.user\" : \"(.*?)\"/.exec(data);
                    if (facebookData)
                    {
                        this.var_2891 = Boolean(facebookData[1]);
                    };
                    if (this.var_2890.length > 0)
                    {
                        dispatchEvent(new Event(var_1572));
                    }
                    else
                    {
                        dispatchEvent(new Event(var_1573));
                    };
                }
                catch(e:Error)
                {
                    dispatchEvent(new Event(var_1573));
                };
            };
        }

    }
}