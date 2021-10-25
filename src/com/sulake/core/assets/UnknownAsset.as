﻿package com.sulake.core.assets
{

    import flash.utils.getQualifiedClassName;

    public class UnknownAsset implements IAsset
    {

        private var _disposed: Boolean = false;
        private var _content: Object = null;
        private var _declaration: AssetTypeDeclaration;
        private var _url: String;

        public function UnknownAsset(declaration: AssetTypeDeclaration, url: String = null)
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
                this._disposed = true;
                this._content = null;
                this._declaration = null;
                this._url = null;
            }

        }

        public function setUnknownContent(content: Object): void
        {
            this._content = content;
        }

        public function setFromOtherAsset(asset: IAsset): void
        {
            this._content = asset.content as Object;
        }

        public function setParamsDesc(_: XMLList): void
        {
        }

        public function toString(): String
        {
            return getQualifiedClassName(this) + ": " + this._content;
        }

    }
}
