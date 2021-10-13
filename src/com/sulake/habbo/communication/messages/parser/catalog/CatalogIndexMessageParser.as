package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogIndexMessageParser implements IMessageParser 
    {

        private var var_2274:NodeData;

        public function get root():NodeData
        {
            return (this.var_2274);
        }

        public function flush():Boolean
        {
            this.var_2274 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2274 = new NodeData(param1);
            return (true);
        }

    }
}