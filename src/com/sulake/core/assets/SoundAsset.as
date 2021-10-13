package com.sulake.core.assets
{
    import flash.media.Sound;
    import flash.utils.ByteArray;

    public class SoundAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var var_1997:Sound = null;
        private var var_2128:AssetTypeDeclaration;
        private var var_2104:String;

        public function SoundAsset(param1:AssetTypeDeclaration, param2:String=null)
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
            if ((param1 is Sound))
            {
                if (this.var_1997)
                {
                    this.var_1997.close();
                };
                this.var_1997 = (param1 as Sound);
                return;
            };
            if ((param1 is ByteArray))
            {
            };
            if ((param1 is Class))
            {
                if (this.var_1997)
                {
                    this.var_1997.close();
                };
                this.var_1997 = (new (param1)() as Sound);
                return;
            };
            if ((param1 is SoundAsset))
            {
                if (this.var_1997)
                {
                    this.var_1997.close();
                };
                this.var_1997 = SoundAsset(param1).var_1997;
                return;
            };
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            if ((param1 is SoundAsset))
            {
                this.var_1997 = SoundAsset(param1).var_1997;
            };
        }

        public function setParamsDesc(param1:XMLList):void
        {
        }

    }
}