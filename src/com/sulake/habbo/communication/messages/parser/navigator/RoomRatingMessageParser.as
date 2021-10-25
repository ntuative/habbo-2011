package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomRatingMessageParser implements IMessageParser
    {

        private var _rating: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._rating = data.readInteger();
            
            return true;
        }

        public function get rating(): int
        {
            return this._rating;
        }

    }
}
