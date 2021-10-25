package com.sulake.core.assets
{

    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.Core;

    public class LazyAssetProcessor implements IUpdateReceiver
    {

        private var _assets: Array = [];
        private var _processed: Boolean = false;
        private var _disposed: Boolean = false;

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                Core.instance.removeUpdateReceiver(this);

                this._assets = null;
                this._processed = false;
                this._disposed = true;
            }

        }

        public function push(asset: ILazyAsset): void
        {
            if (asset)
            {
                this._assets.push(asset);

                if (!this._processed)
                {
                    Core.instance.registerUpdateReceiver(this, 2);
                    this._processed = true;
                }

            }

        }

        public function flush(): void
        {
            var asset: ILazyAsset;

            for each (asset in this._assets)
            {
                if (!asset.disposed)
                {
                    asset.prepareLazyContent();
                }

            }


            this._assets = [];

            if (this._processed)
            {
                Core.instance.removeUpdateReceiver(this);
                this._processed = false;
            }

        }

        public function update(_: uint): void
        {
            var asset: ILazyAsset = this._assets.shift();

            if (asset == null)
            {
                if (this._processed)
                {
                    Core.instance.removeUpdateReceiver(this);
                    this._processed = false;
                }

            }
            else
            {
                if (!asset.disposed)
                {
                    asset.prepareLazyContent();
                }

            }

        }

    }
}
