package com.sulake.habbo.communication.messages.parser.inventory.furni
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FurniListRemoveParser implements IMessageParser
    {

        private var _stripId: int;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._stripId = data.readInteger();
            
            return true;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function get stripId(): int
        {
            return this._stripId;
        }

    }
}
