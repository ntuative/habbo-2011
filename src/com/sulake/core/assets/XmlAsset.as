package com.sulake.core.assets
{
    import flash.utils.ByteArray;

    public class XmlAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var var_1997:XML;
        private var var_2128:AssetTypeDeclaration;
        private var var_2104:String;

        public function XmlAsset(param1:AssetTypeDeclaration, param2:String=null)
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
            return (this.var_1997 as Object);
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
            var _loc2_:ByteArray;
            if ((param1 is Class))
            {
                _loc2_ = (new (param1)() as ByteArray);
                this.var_1997 = new XML(_loc2_.readUTFBytes(_loc2_.length));
                return;
            };
            if ((param1 is ByteArray))
            {
                _loc2_ = (param1 as ByteArray);
                this.var_1997 = new XML(_loc2_.readUTFBytes(_loc2_.length));
                return;
            };
            if ((param1 is String))
            {
                this.var_1997 = new XML((param1 as String));
                return;
            };
            if ((param1 is XML))
            {
                this.var_1997 = (param1 as XML);
                return;
            };
            if ((param1 is XmlAsset))
            {
                this.var_1997 = XmlAsset(param1).var_1997;
                return;
            };
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            if ((param1 is XmlAsset))
            {
                this.var_1997 = XmlAsset(param1).var_1997;
            }
            else
            {
                throw (Error("Provided asset is not of type XmlAsset!"));
            };
        }

        public function setParamsDesc(param1:XMLList):void
        {
        }

    }
}