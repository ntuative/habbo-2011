package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserObjectMessageParser implements IMessageParser
    {

        private var _id: int;
        private var _name: String;
        private var _figure: String;
        private var _sex: String;
        private var _customData: String;
        private var _realName: String;
        private var _tickets: int;
        private var _poolFigure: String;
        private var _photoFilm: int;
        private var _directMail: int;
        private var _respectTotal: int;
        private var _respectLeft: int;
        private var _petRespectLeft: int;
        private var _identityId: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._id = int(data.readString());
            this._name = data.readString();
            this._figure = data.readString();
            this._sex = data.readString();
            this._customData = data.readString();
            this._realName = data.readString();
            this._tickets = data.readInteger();
            this._poolFigure = data.readString();
            this._photoFilm = data.readInteger();
            this._directMail = data.readInteger();
            this._respectTotal = data.readInteger();
            this._respectLeft = data.readInteger();
            this._petRespectLeft = data.readInteger();
            this._identityId = data.readInteger();

            return true;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get sex(): String
        {
            return this._sex;
        }

        public function get customData(): String
        {
            return this._customData;
        }

        public function get realName(): String
        {
            return this._realName;
        }

        public function get tickets(): int
        {
            return this._tickets;
        }

        public function get poolFigure(): String
        {
            return this._poolFigure;
        }

        public function get photoFilm(): int
        {
            return this._photoFilm;
        }

        public function get directMail(): int
        {
            return this._directMail;
        }

        public function get respectTotal(): int
        {
            return this._respectTotal;
        }

        public function get respectLeft(): int
        {
            return this._respectLeft;
        }

        public function get petRespectLeft(): int
        {
            return this._petRespectLeft;
        }

        public function get identityId(): int
        {
            return this._identityId;
        }

    }
}
