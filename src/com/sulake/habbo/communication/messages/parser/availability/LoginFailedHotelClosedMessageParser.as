package com.sulake.habbo.communication.messages.parser.availability
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class LoginFailedHotelClosedMessageParser implements IMessageParser
    {

        private var _openHour: int;
        private var _openMinute: int;

        public function get openHour(): int
        {
            return this._openHour;
        }

        public function get openMinute(): int
        {
            return this._openMinute;
        }

        public function flush(): Boolean
        {
            this._openHour = 0;
            this._openMinute = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._openHour = data.readInteger();
            this._openMinute = data.readInteger();
            
            return true;
        }

    }
}
