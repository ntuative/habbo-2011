package com.sulake.habbo.communication.messages.parser.availability
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoHotelClosingMessageParser implements IMessageParser
    {

        private var _minutesUntilClosing: int;

        public function get minutesUntilClosing(): int
        {
            return this._minutesUntilClosing;
        }

        public function flush(): Boolean
        {
            this._minutesUntilClosing = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._minutesUntilClosing = data.readInteger();
            
            return true;
        }

    }
}
