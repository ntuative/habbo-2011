package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogPageMessageProductData 
    {

        public static const var_113:String = "i";
        public static const var_112:String = "s";
        public static const var_118:String = "e";

        private var var_2835:String;
        private var var_2899:int;
        private var var_2836:String;
        private var var_2837:int;
        private var var_2838:int;

        public function CatalogPageMessageProductData(param1:IMessageDataWrapper)
        {
            this.var_2835 = param1.readString();
            this.var_2899 = param1.readInteger();
            this.var_2836 = param1.readString();
            this.var_2837 = param1.readInteger();
            this.var_2838 = param1.readInteger();
        }

        public function get productType():String
        {
            return (this.var_2835);
        }

        public function get furniClassId():int
        {
            return (this.var_2899);
        }

        public function get extraParam():String
        {
            return (this.var_2836);
        }

        public function get productCount():int
        {
            return (this.var_2837);
        }

        public function get expiration():int
        {
            return (this.var_2838);
        }

    }
}