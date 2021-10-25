package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IsOfferGiftableMessageParser implements IMessageParser
    {

        private var _offerId: int;
        private var _isGiftable: Boolean;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._offerId = data.readInteger();
            this._isGiftable = data.readBoolean();
            
            return true;
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function get isGiftable(): Boolean
        {
            return this._isGiftable;
        }

    }
}
