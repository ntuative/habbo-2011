package com.sulake.core.assets
{

    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.loaders.IAssetLoader;

    public class AssetLoaderStruct extends EventDispatcher implements IDisposable
    {

        private var _assetLoader: IAssetLoader;
        private var _assetName: String;

        public function AssetLoaderStruct(name: String, loader: IAssetLoader)
        {
            this._assetName = name;
            this._assetLoader = loader;
        }

        public function get assetName(): String
        {
            return this._assetName;
        }

        public function get assetLoader(): IAssetLoader
        {
            return this._assetLoader;
        }

        override public function dispose(): void
        {
            if (!disposed)
            {
                if (this._assetLoader != null)
                {
                    if (!this._assetLoader.disposed)
                    {
                        this._assetLoader.dispose();
                        this._assetLoader = null;
                    }

                }


                super.dispose();
            }

        }

    }
}
