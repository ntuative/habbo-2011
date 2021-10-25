package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CanCreateRoomEventMessageParser implements IMessageParser
    {

        private var _canCreateEvent: Boolean;
        private var _errorCode: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._canCreateEvent = data.readBoolean();
            this._errorCode = data.readInteger();
            
            return true;
        }

        public function get canCreateEvent(): Boolean
        {
            return this._canCreateEvent;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

    }
}
