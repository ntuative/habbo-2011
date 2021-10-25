package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserFlatCatsMessageParser implements IMessageParser
    {

        private var _nodes: Array;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._nodes = [];
            
            var categoryCount: int = data.readInteger();
            var i: int;
            
            while (i < categoryCount)
            {
                this._nodes.push(new FlatCategory(data));
                i++;
            }

            return true;
        }

        public function flush(): Boolean
        {
            this._nodes = null;

            return true;
        }

        public function get nodes(): Array
        {
            return this._nodes;
        }

    }
}
