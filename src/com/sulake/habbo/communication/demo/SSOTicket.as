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

        public static const SUCCESS: String = "success";
        public static const FAILURE: String = "failure";

        private var _unknown1: URLLoader;
        private var _clientUrl: String;
        private var _habboWeb: IHabboWebLogin;
        private var _unknown2: String;
        private var _ticket: String;
        private var _flashClientUrl: String;
        private var _assets: IAssetLibrary;
        private var _isFacebookUser: Boolean;

        public function SSOTicket(assets: IAssetLibrary, habboWeb: IHabboWebLogin, origin: String, initialized: Boolean = true)
        {
            this._assets = assets;
            this._habboWeb = habboWeb;
            this._clientUrl = "http://" + origin + "/client";

            if (!initialized)
            {
                this._habboWeb.init();
                this._habboWeb.addEventListener(HabboWeb.var_1440, this.requestClientURL);
            }
            else
            {
                this.requestClientURL();
            }

        }

        public function get ticket(): String
        {
            return this._ticket;
        }

        public function get isFacebookUser(): Boolean
        {
            return this._isFacebookUser;
        }

        public function get flashClientUrl(): String
        {
            return this._flashClientUrl;
        }

        private function requestClientURL(param1: Event = null): void
        {
            var url: String = this._clientUrl;

            if (this._assets.hasAsset(url))
            {
                Logger.log("[CoreLocalizationManager] reload localization for url: " + this._clientUrl);
            }


            var request: URLRequest = new URLRequest(this._clientUrl);

            if (this._assets.hasAsset(url))
            {
                this._assets.removeAsset(this._assets.getAssetByName(url));
            }


            var loaderStruct: AssetLoaderStruct = this._assets.loadAssetFromFile(url, request, "text/plain");
            loaderStruct.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.clientURLComplete);
        }

        private function clientURLComplete(event: Event = null): void
        {
            var facebookData: Object;
            var loaderStruct: AssetLoaderStruct = event.target as AssetLoaderStruct;

            if (loaderStruct == null)
            {
                return;
            }


            var data: String = loaderStruct.assetLoader.content as String;

            if (data.indexOf("account/reauthenticate\"") > -1)
            {
                this._habboWeb.requestReAuthenticate();
            }
            else
            {
                try
                {
                    this._ticket = /\"sso.ticket\" : \"(.*?)\"/.exec(data)[1];
                    this._flashClientUrl = /\"flash.client.url\" : \"(.*?)\"/.exec(data)[1];
                    facebookData = /\"facebook.user\" : \"(.*?)\"/.exec(data);

                    if (facebookData)
                    {
                        this._isFacebookUser = Boolean(facebookData[1]);
                    }


                    if (this._ticket.length > 0)
                    {
                        dispatchEvent(new Event(SUCCESS));
                    }
                    else
                    {
                        dispatchEvent(new Event(FAILURE));
                    }

                }
                catch (e: Error)
                {
                    dispatchEvent(new Event(FAILURE));
                }

            }

        }

    }
}
