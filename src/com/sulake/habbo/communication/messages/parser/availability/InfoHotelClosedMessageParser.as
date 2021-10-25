package com.sulake.habbo.communication.messages.parser.availability
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoHotelClosedMessageParser implements IMessageParser
    {

        private var _openHour: int;
        private var _openMinute: int;
        private var _userThrowOutAtClose: Boolean;

        public function get openHour(): int
        {
            return this._openHour;
        }

        public function get openMinute(): int
        {
            return this._openMinute;
        }

        public function get userThrownOutAtClose(): Boolean
        {
            return this._userThrowOutAtClose;
        }

        public function flush(): Boolean
        {
            this._openHour = 0;
            this._openMinute = 0;
            this._userThrowOutAtClose = false;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._openHour = data.readInteger();
            this._openMinute = data.readInteger();
            this._userThrowOutAtClose = data.readInteger() > 0;

            return true;
        }

    }
}
