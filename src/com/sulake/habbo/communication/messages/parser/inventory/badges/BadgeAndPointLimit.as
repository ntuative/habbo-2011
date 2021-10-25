package com.sulake.habbo.communication.messages.parser.inventory.badges
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgeAndPointLimit
    {

        private var _badgeId: String;
        private var _limit: int;

        public function BadgeAndPointLimit(id: String, data: IMessageDataWrapper)
        {
            this._badgeId = "ACH_" + id + data.readInteger();
            this._limit = data.readInteger();
        }

        public function get badgeId(): String
        {
            return this._badgeId;
        }

        public function get limit(): int
        {
            return this._limit;
        }

    }
}
