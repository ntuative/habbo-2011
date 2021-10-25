package com.sulake.habbo.communication.messages.parser.availability
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityTimeMessageParser implements IMessageParser
    {

        private var _isOpen: Boolean;
        private var _minutesUntilChange: int;

        public function get isOpen(): Boolean
        {
            return this._isOpen;
        }

        public function get minutesUntilChange(): int
        {
            return this._minutesUntilChange;
        }

        public function flush(): Boolean
        {
            this._isOpen = false;
            this._minutesUntilChange = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._isOpen = data.readInteger() > 0;
            this._minutesUntilChange = data.readInteger();
            
            return true;
        }

    }
}
