package com.sulake.habbo.communication.messages.incoming.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubGiftData
    {

        private var _offerId: int;
        private var _isVip: Boolean;
        private var _isSelectable: Boolean;
        private var _daysRequired: int;

        public function ClubGiftData(data: IMessageDataWrapper)
        {
            this._offerId = data.readInteger();
            this._isVip = data.readBoolean();
            this._daysRequired = data.readInteger();
            this._isSelectable = data.readBoolean();
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function get isVip(): Boolean
        {
            return this._isVip;
        }

        public function get isSelectable(): Boolean
        {
            return this._isSelectable;
        }

        public function get daysRequired(): int
        {
            return this._daysRequired;
        }

    }
}
