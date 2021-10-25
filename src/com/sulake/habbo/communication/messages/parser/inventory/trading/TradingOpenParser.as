package com.sulake.habbo.communication.messages.parser.inventory.trading
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingOpenParser implements IMessageParser
    {

        private var _userID: int;
        private var _userCanTrade: Boolean;
        private var _otherUserId: int;
        private var _otherUserCanTrade: Boolean;

        public function get userID(): int
        {
            return this._userID;
        }

        public function get userCanTrade(): Boolean
        {
            return this._userCanTrade;
        }

        public function get otherUserID(): int
        {
            return this._otherUserId;
        }

        public function get otherUserCanTrade(): Boolean
        {
            return this._otherUserCanTrade;
        }

        public function flush(): Boolean
        {
            this._userID = -1;
            this._userCanTrade = false;
            this._otherUserId = -1;
            this._otherUserCanTrade = false;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._userID = data.readInteger();
            this._userCanTrade = data.readInteger() == 1;
            this._otherUserId = data.readInteger();
            this._otherUserCanTrade = data.readInteger() == 1;
            
            return true;
        }

    }
}
