package com.sulake.core.assets
{

    import flash.text.Font;

    import com.sulake.core.utils.FontEnum;

    public class FontAsset implements IAsset
    {

        protected var _declaration: AssetTypeDeclaration;
        protected var _content: Font;
        protected var _disposed: Boolean = false;

        public function FontAsset(param1: AssetTypeDeclaration, param2: String = null)
        {
            this._declaration = param1;
        }

        public function get url(): String
        {
            return null;
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
                this._declaration = null;
                this._content = null;
                this._disposed = true;
            }

        }

        public function setUnknownContent(content: Object): void
        {
            try
            {
                if (content is Class)
                {
                    this._content = Font(FontEnum.registerFont(content as Class));
                }

            }
            catch (e: Error)
            {
                throw new Error("Failed to register font from resource: " + content.toString());
            }

        }

        public function setFromOtherAsset(asset: IAsset): void
        {
            if (asset is FontAsset)
            {
                this._content = FontAsset(asset)._content;
            }
            else
            {
                throw new Error("Provided asset should be of type FontAsset!");
            }

        }

        public function setParamsDesc(param1: XMLList): void
        {
            // no-op

            // var key:String;
            // var value:String;

            // for (var i: int = 0; i < param1.length(); i++)
            // {
            //     key = param1[i].attribute("key");
            //     value = param1[i].attribute("value");
            // };
        }

    }
}
