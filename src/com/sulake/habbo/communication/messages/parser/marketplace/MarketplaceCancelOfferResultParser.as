﻿package com.sulake.habbo.communication.messages.parser.marketplace
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MarketplaceCancelOfferResultParser implements IMessageParser
    {

        private var _result: int;
        private var _offerId: int;

        public function get result(): int
        {
            return this._result;
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._offerId = param1.readInteger();
            this._result = param1.readInteger();
            return true;
        }

    }
}
