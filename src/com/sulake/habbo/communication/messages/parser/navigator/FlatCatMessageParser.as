package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCatMessageParser implements IMessageParser
    {

        private var _flatId: int;
        private var _nodeId: int;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._flatId = data.readInteger();
            this._nodeId = data.readInteger();
            
            return true;
        }

        public function flush(): Boolean
        {
            this._flatId = 0;
            this._nodeId = 0;

            return true;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get nodeId(): int
        {
            return this._nodeId;
        }

    }
}
