package com.sulake.core.assets
{

    import flash.utils.ByteArray;

    public class XmlAsset implements IAsset
    {

        private var _disposed: Boolean = false;
        private var _content: XML;
        private var _declaration: AssetTypeDeclaration;
        private var _url: String;

        public function XmlAsset(param1: AssetTypeDeclaration, param2: String = null)
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
            var byteArray: ByteArray;

            if (content is Class)
            {
                byteArray = new content() as ByteArray;
                this._content = new XML(byteArray.readUTFBytes(byteArray.length));

                return;
            }


            if (content is ByteArray)
            {
                byteArray = content as ByteArray;
                this._content = new XML(byteArray.readUTFBytes(byteArray.length));

                return;
            }


            if (content is String)
            {
                this._content = new XML(content as String);

                return;
            }


            if (content is XML)
            {
                this._content = content as XML;

                return;
            }


            if (content is XmlAsset)
            {
                this._content = XmlAsset(content)._content;


            }

        }

        public function setFromOtherAsset(asset: IAsset): void
        {
            if (asset is XmlAsset)
            {
                this._content = XmlAsset(asset)._content;
            }
            else
            {
                throw new Error("Provided asset is not of type XmlAsset!");
            }

        }

        public function setParamsDesc(param1: XMLList): void
        {
        }

    }
}
