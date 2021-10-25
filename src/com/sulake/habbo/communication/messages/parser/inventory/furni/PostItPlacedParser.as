package com.sulake.habbo.communication.messages.parser.inventory.furni
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PostItPlacedParser implements IMessageParser
    {

        private var _id: int;
        private var _itemsLeft: int;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._id = data.readInteger();
            this._itemsLeft = data.readInteger();

            return true;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get itemsLeft(): int
        {
            return this._itemsLeft;
        }

    }
}
