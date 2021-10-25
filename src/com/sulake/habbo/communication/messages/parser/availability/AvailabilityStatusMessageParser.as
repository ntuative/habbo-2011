package com.sulake.habbo.communication.messages.parser.availability
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvailabilityStatusMessageParser implements IMessageParser
    {

        private var _isOpen: Boolean;
        private var _onShutDown: Boolean;

        public function get isOpen(): Boolean
        {
            return this._isOpen;
        }

        public function get onShutDown(): Boolean
        {
            return this._onShutDown;
        }

        public function flush(): Boolean
        {
            this._isOpen = false;
            this._onShutDown = false;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._isOpen = data.readInteger() > 0;
            this._onShutDown = data.readInteger() > 0;

            return true;
        }

    }
}
