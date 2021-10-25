package com.sulake.habbo.communication.messages.parser.room.chat
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FloodControlMessageParser implements IMessageParser
    {

        private var _seconds: int = 0;

        public function get seconds(): int
        {
            return this._seconds;
        }

        public function flush(): Boolean
        {
            this._seconds = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._seconds = data.readInteger();
            
            return true;
        }

    }
}
