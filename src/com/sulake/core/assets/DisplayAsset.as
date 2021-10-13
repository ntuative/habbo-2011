package com.sulake.core.assets
{
    import flash.display.DisplayObject;

    public class DisplayAsset implements IAsset 
    {

        protected var var_2104:String;
        protected var var_1997:DisplayObject;
        protected var _disposed:Boolean = false;
        protected var var_2130:AssetTypeDeclaration;

        public function DisplayAsset(param1:AssetTypeDeclaration, param2:String=null)
        {
            this.var_2130 = param1;
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
            return (this.var_2130);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (this.var_1997.loaderInfo != null)
                {
                    if (this.var_1997.loaderInfo.loader != null)
                    {
                        this.var_1997.loaderInfo.loader.unload();
                    };
                };
                this.var_1997 = null;
                this.var_2130 = null;
                this._disposed = true;
                this.var_2104 = null;
            };
        }

        public function setUnknownContent(param1:Object):void
        {
            if ((param1 is DisplayObject))
            {
                this.var_1997 = (param1 as DisplayObject);
                if (this.var_1997 != null)
                {
                    return;
                };
                throw (new Error("Failed to convert DisplayObject to DisplayAsset!"));
            };
            if ((param1 is DisplayAsset))
            {
                this.var_1997 = DisplayAsset(param1).var_1997;
                this.var_2130 = DisplayAsset(param1).var_2130;
                if (this.var_1997 == null)
                {
                    throw (new Error("Failed to read content from DisplayAsset!"));
                };
            };
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            if ((param1 is DisplayAsset))
            {
                this.var_1997 = DisplayAsset(param1).var_1997;
                this.var_2130 = DisplayAsset(param1).var_2130;
            }
            else
            {
                throw (new Error("Provided asset should be of type DisplayAsset!"));
            };
        }

        public function setParamsDesc(param1:XMLList):void
        {
        }

    }
}