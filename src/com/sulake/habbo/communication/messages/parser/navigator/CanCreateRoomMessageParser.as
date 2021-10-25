package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CanCreateRoomMessageParser implements IMessageParser
    {

        public static const UNKNOWN_1: int = 0;
        public static const UNKNOWN_2: int = 1;

        private var _resultCode: int;
        private var _roomLimit: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._resultCode = data.readInteger();
            this._roomLimit = data.readInteger();

            return true;
        }

        public function get resultCode(): int
        {
            return this._resultCode;
        }

        public function get roomLimit(): int
        {
            return this._roomLimit;
        }

    }
}
