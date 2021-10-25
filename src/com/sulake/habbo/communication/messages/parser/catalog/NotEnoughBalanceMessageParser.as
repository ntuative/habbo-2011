package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NotEnoughBalanceMessageParser implements IMessageParser
    {

        private var _notEnoughCredits: int = 0;
        private var _notEnoughActivityPoints: int = 0;
        private var _activityPointType: int = 0;

        public function get notEnoughCredits(): int
        {
            return this._notEnoughCredits;
        }

        public function get notEnoughActivityPoints(): int
        {
            return this._notEnoughActivityPoints;
        }

        public function get activityPointType(): int
        {
            return this._activityPointType;
        }

        public function flush(): Boolean
        {
            this._notEnoughCredits = 0;
            this._notEnoughActivityPoints = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._notEnoughCredits = data.readInteger();
            this._notEnoughActivityPoints = data.readInteger();
            this._activityPointType = data.readInteger();
            
            return true;
        }

    }
}
