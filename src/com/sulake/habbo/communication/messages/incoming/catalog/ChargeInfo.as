package com.sulake.habbo.communication.messages.incoming.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChargeInfo
    {

        private var _stuffId: int;
        private var _charges: int;
        private var _priceInCredits: int;
        private var _priceInActivityPoints: int;
        private var _activityPointType: int;
        private var _chargePatchSize: int;

        public function ChargeInfo(data: IMessageDataWrapper)
        {
            this._stuffId = data.readInteger();
            this._charges = data.readInteger();
            this._priceInCredits = data.readInteger();
            this._priceInActivityPoints = data.readInteger();
            this._activityPointType = data.readInteger();
            this._chargePatchSize = data.readInteger();
        }

        public function get stuffId(): int
        {
            return this._stuffId;
        }

        public function get charges(): int
        {
            return this._charges;
        }

        public function get priceInCredits(): int
        {
            return this._priceInCredits;
        }

        public function get priceInActivityPoints(): int
        {
            return this._priceInActivityPoints;
        }

        public function get chargePatchSize(): int
        {
            return this._chargePatchSize;
        }

        public function get activityPointType(): int
        {
            return this._activityPointType;
        }

    }
}
