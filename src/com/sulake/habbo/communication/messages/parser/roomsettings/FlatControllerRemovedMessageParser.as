package com.sulake.habbo.communication.messages.parser.roomsettings
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerRemovedMessageParser implements IMessageParser
    {

        private var _flatId: int;
        private var _userId: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._flatId = data.readInteger();
            this._userId = data.readInteger();
            
            return true;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get userId(): int
        {
            return this._userId;
        }

    }
}
