package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetLevelNotificationParser implements IMessageParser
    {

        private var _petId: int;
        private var _petName: String;
        private var _level: int;
        private var _petType: int;
        private var _breed: int;
        private var _color: String;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._petId = data.readInteger();
            this._petName = data.readString();
            this._level = data.readInteger();
            this._petType = data.readInteger();
            this._breed = data.readInteger();
            this._color = data.readString();

            return true;
        }

        public function get petId(): int
        {
            return this._petId;
        }

        public function get petName(): String
        {
            return this._petName;
        }

        public function get level(): int
        {
            return this._level;
        }

        public function get petType(): int
        {
            return this._petType;
        }

        public function get breed(): int
        {
            return this._breed;
        }

        public function get color(): String
        {
            return this._color;
        }

    }
}
