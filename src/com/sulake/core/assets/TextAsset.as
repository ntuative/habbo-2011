package com.sulake.core.assets
{

    import flash.utils.ByteArray;

    public class TextAsset implements IAsset
    {

        private var _disposed: Boolean = false;
        private var _content: String = "";
        private var _declaration: AssetTypeDeclaration;
        private var _url: String;

        public function TextAsset(param1: AssetTypeDeclaration, param2: String = null)
        {
            this._declaration = param1;
            this._url = param2;
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
                this._disposed = true;
                this._content = null;
                this._declaration = null;
                this._url = null;
            }

        }

        public function setUnknownContent(content: Object): void
        {
            var byteArray: ByteArray;

            if (content is String)
            {
                this._content = content as String;

                return;
            }


            if (content is Class)
            {
                byteArray = new content() as ByteArray;
                this._content = byteArray.readUTFBytes(byteArray.length);

                return;
            }


            if (content is ByteArray)
            {
                byteArray = content as ByteArray;
                this._content = byteArray.readUTFBytes(byteArray.length);

                return;
            }


            if (content is TextAsset)
            {
                this._content = TextAsset(content)._content;

                return;
            }


            this._content = content.toString();
        }

        public function setFromOtherAsset(asset: IAsset): void
        {
            if (asset is TextAsset)
            {
                this._content = TextAsset(asset)._content;
            }
            else
            {
                throw new Error("Provided asset is not of type TextAsset!");
            }

        }

        public function setParamsDesc(_: XMLList): void
        {
        }

    }
}
