﻿package com.sulake.habbo.communication.messages.parser.inventory.trading
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingAcceptParser implements IMessageParser
    {

        private var _userID: int;
        private var _userAccepts: Boolean;

        public function get userID(): int
        {
            return this._userID;
        }

        public function get userAccepts(): Boolean
        {
            return this._userAccepts;
        }

        public function flush(): Boolean
        {
            this._userID = -1;
            this._userAccepts = false;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._userID = data.readInteger();
            this._userAccepts = data.readInteger() > 0;

            return true;
        }

    }
}
