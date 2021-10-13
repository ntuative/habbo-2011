package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.loaders.IAssetLoader;

    public class AssetLoaderStruct extends EventDispatcher implements IDisposable 
    {

        private var var_2121:IAssetLoader;
        private var var_2120:String;

        public function AssetLoaderStruct(param1:String, param2:IAssetLoader)
        {
            this.var_2120 = param1;
            this.var_2121 = param2;
        }

        public function get assetName():String
        {
            return (this.var_2120);
        }

        public function get assetLoader():IAssetLoader
        {
            return (this.var_2121);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (this.var_2121 != null)
                {
                    if (!this.var_2121.disposed)
                    {
                        this.var_2121.dispose();
                        this.var_2121 = null;
                    };
                };
                super.dispose();
            };
        }

    }
}