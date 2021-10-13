package com.sulake.core.assets
{
    import flash.utils.getQualifiedClassName;

    public class UnknownAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var var_1997:Object = null;
        private var var_2128:AssetTypeDeclaration;
        private var var_2104:String;

        public function UnknownAsset(param1:AssetTypeDeclaration, param2:String=null)
        {
            this.var_2128 = param1;
            this.var_2104 = param2;
        }

        public function get url():String
        {
            return (this.var_2104);
        }

        public function get content():Object
        {
            return (this.var_1997);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get declaration():AssetTypeDeclaration
        {
            return (this.var_2128);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_1997 = null;
                this.var_2128 = null;
                this.var_2104 = null;
            };
        }

        public function setUnknownContent(param1:Object):void
        {
            this.var_1997 = param1;
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            this.var_1997 = (param1.content as Object);
        }

        public function setParamsDesc(param1:XMLList):void
        {
        }

        public function toString():String
        {
            return ((getQualifiedClassName(this) + ": ") + this.var_1997);
        }

    }
}