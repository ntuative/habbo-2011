package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouriteChangedMessageParser implements IMessageParser
    {

        private var _flatId: int;
        private var _added: Boolean;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._flatId = data.readInteger();
            this._added = data.readBoolean();
            
            return true;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get added(): Boolean
        {
            return this._added;
        }

    }
}
