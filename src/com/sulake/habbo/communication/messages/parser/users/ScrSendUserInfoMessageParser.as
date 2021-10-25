package com.sulake.habbo.communication.messages.parser.users
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ScrSendUserInfoMessageParser implements IMessageParser
    {

        public static const HABBO_SUBSCRIPTION_UNKNOWN: int = 1;
        public static const HABBO_SUBSCRIPTION_UPDATE: int = 2;

        private var _productName: String;
        private var _daysToPeriodEnd: int;
        private var _memberPeriods: int;
        private var _periodsSubscribedAhead: int;
        private var _responseType: int;
        private var _hasEverBeenMember: Boolean;
        private var _isVip: Boolean;
        private var _pastClubDays: int;
        private var _pastVipDays: int;
        private var _isShowBasicPromo: Boolean;
        private var _basicNormalPrice: int;
        private var _basicPromoPrice: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._productName = data.readString();
            this._daysToPeriodEnd = data.readInteger();
            this._memberPeriods = data.readInteger();
            this._periodsSubscribedAhead = data.readInteger();
            this._responseType = data.readInteger();
            this._hasEverBeenMember = data.readBoolean();
            this._isVip = data.readBoolean();
            this._pastClubDays = data.readInteger();
            this._pastVipDays = data.readInteger();
            this._isShowBasicPromo = data.readBoolean();
            this._basicNormalPrice = data.readInteger();
            this._basicPromoPrice = data.readInteger();

            return true;
        }

        public function get productName(): String
        {
            return this._productName;
        }

        public function get daysToPeriodEnd(): int
        {
            return this._daysToPeriodEnd;
        }

        public function get memberPeriods(): int
        {
            return this._memberPeriods;
        }

        public function get periodsSubscribedAhead(): int
        {
            return this._periodsSubscribedAhead;
        }

        public function get responseType(): int
        {
            return this._responseType;
        }

        public function get hasEverBeenMember(): Boolean
        {
            return this._hasEverBeenMember;
        }

        public function get isVIP(): Boolean
        {
            return this._isVip;
        }

        public function get pastClubDays(): int
        {
            return this._pastClubDays;
        }

        public function get pastVipDays(): int
        {
            return this._pastVipDays;
        }

        public function get isShowBasicPromo(): Boolean
        {
            return this._isShowBasicPromo;
        }

        public function get basicNormalPrice(): int
        {
            return this._basicNormalPrice;
        }

        public function get basicPromoPrice(): int
        {
            return this._basicPromoPrice;
        }

    }
}
