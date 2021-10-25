package com.sulake.habbo.communication.messages.parser.room.session
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CantConnectMessageParser implements IMessageParser
    {

        public static const CANT_CONNECT_ROOM_FULL: int = 1;
        public static const CANT_CONNECT_UNKNOWN_1: int = 2;
        public static const CANT_CONNECT_ROOM_QUEUE: int = 3;
        public static const CANT_CONNECT_ROOM_BANNED: int = 4;

        private var _reason: int = 0;
        private var _parameter: String = "";

        public function flush(): Boolean
        {
            this._reason = 0;
            this._parameter = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._reason = data.readInteger();

            if (this._reason == 3)
            {
                this._parameter = data.readString();
            }
            else
            {
                this._parameter = "";
            }

            return true;
        }

        public function get reason(): int
        {
            return this._reason;
        }

        public function get parameter(): String
        {
            return this._parameter;
        }

    }
}
