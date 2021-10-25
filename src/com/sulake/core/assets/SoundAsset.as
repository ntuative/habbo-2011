package com.sulake.core.assets
{

    import flash.media.Sound;
    import flash.utils.ByteArray;

    public class SoundAsset implements IAsset
    {

        private var _disposed: Boolean = false;
        private var _content: Sound = null;
        private var _declaration: AssetTypeDeclaration;
        private var _url: String;

        public function SoundAsset(declaration: AssetTypeDeclaration, url: String = null)
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
            return this._content as Object;
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
                this._disposed = true;
                this._content = null;
                this._declaration = null;
                this._url = null;
            }

        }

        public function setUnknownContent(content: Object): void
        {
            if (content is Sound)
            {
                if (this._content != null)
                {
                    this._content.close();
                }


                this._content = (content as Sound);

                return;
            }


            if (content is ByteArray)
            {
                // no-op
            }


            if (content is Class)
            {
                if (this._content != null)
                {
                    this._content.close();
                }


                this._content = new content() as Sound;

                return;
            }


            if (content is SoundAsset)
            {
                if (this._content != null)
                {
                    this._content.close();
                }


                this._content = SoundAsset(content)._content;


            }

        }

        public function setFromOtherAsset(asset: IAsset): void
        {
            if (asset is SoundAsset)
            {
                this._content = SoundAsset(asset)._content;
            }

        }

        public function setParamsDesc(params: XMLList): void
        {
            // no-op
        }

    }
}
