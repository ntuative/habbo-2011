package com.sulake.core.assets
{
    public class AssetTypeDeclaration 
    {

        private var var_2122:String;
        private var var_2123:Class;
        private var var_2124:Class;
        private var var_2125:Array;

        public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class, ... _args)
        {
            this.var_2122 = param1;
            this.var_2123 = param2;
            this.var_2124 = param3;
            if (_args == null)
            {
                this.var_2125 = new Array();
            }
            else
            {
                this.var_2125 = _args;
            };
        }

        public function get mimeType():String
        {
            return (this.var_2122);
        }

        public function get assetClass():Class
        {
            return (this.var_2123);
        }

        public function get loaderClass():Class
        {
            return (this.var_2124);
        }

        public function get fileTypes():Array
        {
            return (this.var_2125);
        }

    }
}