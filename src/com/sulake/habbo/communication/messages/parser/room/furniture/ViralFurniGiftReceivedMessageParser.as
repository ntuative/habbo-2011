package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniGiftReceivedMessageParser implements IMessageParser
    {

        private var _firstClickUserName: String;
        private var _giftWasReceived: Boolean;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._firstClickUserName = param1.readString();
            this._giftWasReceived = param1.readBoolean();
            return true;
        }

        public function get firstClickUserName(): String
        {
            return this._firstClickUserName;
        }

        public function get giftWasReceived(): Boolean
        {
            return this._giftWasReceived;
        }

    }
}
