package com.sulake.core.assets
{

    import flash.display.DisplayObject;

    public class DisplayAsset implements IAsset
    {

        protected var _url: String;
        protected var _content: DisplayObject;
        protected var _disposed: Boolean = false;
        protected var _declaration: AssetTypeDeclaration;

        public function DisplayAsset(declaration: AssetTypeDeclaration, url: String = null)
        {
            this._declaration = declaration;
            this._url = url;
        }

        public function get url(): String
        {
            return this._url;
        }

        public function get content(): Object
        {
            return this._content;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get declaration(): AssetTypeDeclaration
        {
            return this._declaration;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this._content.loaderInfo != null)
                {
                    if (this._content.loaderInfo.loader != null)
                    {
                        this._content.loaderInfo.loader.unload();
                    }

                }


                this._content = null;
                this._declaration = null;
                this._disposed = true;
                this._url = null;
            }

        }

        public function setUnknownContent(content: Object): void
        {
            if (content is DisplayObject)
            {
                this._content = content as DisplayObject;

                if (this._content != null)
                {
                    return;
                }


                throw new Error("Failed to convert DisplayObject to DisplayAsset!");
            }


            if (content is DisplayAsset)
            {
                this._content = DisplayAsset(content)._content;
                this._declaration = DisplayAsset(content)._declaration;
                if (this._content == null)
                {
                    throw new Error("Failed to read content from DisplayAsset!");
                }

            }

        }

        public function setFromOtherAsset(asset: IAsset): void
        {
            if (asset is DisplayAsset)
            {
                this._content = DisplayAsset(asset)._content;
                this._declaration = DisplayAsset(asset)._declaration;
            }
            else
            {
                throw new Error("Provided asset should be of type DisplayAsset!");
            }

        }

        public function setParamsDesc(param1: XMLList): void
        {
            // no-op
        }

    }
}
