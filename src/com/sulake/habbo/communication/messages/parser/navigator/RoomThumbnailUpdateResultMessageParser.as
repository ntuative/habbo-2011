package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomThumbnailUpdateResultMessageParser implements IMessageParser
    {

        private var _flatId: int;
        private var _resultCode: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._flatId = data.readInteger();
            this._resultCode = data.readInteger();
            
            return true;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get resultCode(): int
        {
            return this._resultCode;
        }

    }
}
