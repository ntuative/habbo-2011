package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PlaceObjectErrorMessageParser implements IMessageParser
    {

        private var _errorCode: int;

        public function get errorCode(): int
        {
            return this._errorCode;
        }

        public function flush(): Boolean
        {
            this._errorCode = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._errorCode = data.readInteger();
            
            return true;
        }

    }
}
