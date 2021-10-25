package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WelcomeGiftStatusParser implements IMessageParser
    {

        private var _email: String;
        private var _isVerified: Boolean;
        private var _allowChange: Boolean;
        private var _furniId: int;
        private var _requestedByUser: Boolean;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._email = data.readString();
            this._isVerified = data.readBoolean();
            this._allowChange = data.readBoolean();
            this._furniId = data.readInteger();
            this._requestedByUser = data.readBoolean();

            return true;
        }

        public function get requestedByUser(): Boolean
        {
            return this._requestedByUser;
        }

        public function get email(): String
        {
            return this._email;
        }

        public function get isVerified(): Boolean
        {
            return this._isVerified;
        }

        public function get allowChange(): Boolean
        {
            return this._allowChange;
        }

        public function get furniId(): int
        {
            return this._furniId;
        }

    }
}
