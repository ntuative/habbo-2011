package com.sulake.habbo.communication.messages.parser.room.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRespectFailedParser implements IMessageParser
    {

        private var _requiredDays: int;
        private var _avatarAgeInDays: int;

        public function get requiredDays(): int
        {
            return this._requiredDays;
        }

        public function get avatarAgeInDays(): int
        {
            return this._avatarAgeInDays;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._requiredDays = data.readInteger();
            this._avatarAgeInDays = data.readInteger();
            
            return true;
        }

    }
}
