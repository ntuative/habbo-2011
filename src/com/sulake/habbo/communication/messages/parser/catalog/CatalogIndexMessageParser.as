package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogIndexMessageParser implements IMessageParser
    {

        private var _root: NodeData;

        public function get root(): NodeData
        {
            return this._root;
        }

        public function flush(): Boolean
        {
            this._root = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._root = new NodeData(param1);
            
            return true;
        }

    }
}
