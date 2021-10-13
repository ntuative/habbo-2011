package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftSelectedParser implements IMessageParser 
    {

        private var var_2611:String;
        private var var_2839:Array;

        public function flush():Boolean
        {
            this.var_2839 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2839 = new Array();
            this.var_2611 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_2839.push(new CatalogPageMessageProductData(param1));
                _loc3_++;
            };
            return (true);
        }

        public function get productCode():String
        {
            return (this.var_2611);
        }

        public function get products():Array
        {
            return (this.var_2839);
        }

    }
}