package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NavigatorSettingsMessageParser implements IMessageParser
    {

        private var _homeRoomId: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._homeRoomId = data.readInteger();
            
            return true;
        }

        public function get homeRoomId(): int
        {
            return this._homeRoomId;
        }

    }
}
