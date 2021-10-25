package com.sulake.habbo.communication.messages.parser.room.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInfoMessageParser implements IMessageParser
    {

        private var _petId: int;
        private var _name: String;
        private var _level: int;
        private var _maxLevel: int;
        private var _experience: int;
        private var _energy: int;
        private var _nutrition: int;
        private var _figure: String;
        private var _experienceRequiredToLevel: int;
        private var _maxEnergy: int;
        private var _maxNutrition: int;
        private var _respect: int;
        private var _ownerId: int;
        private var _ownerName: String;
        private var _age: int;

        public function get petId(): int
        {
            return this._petId;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get level(): int
        {
            return this._level;
        }

        public function get maxLevel(): int
        {
            return this._maxLevel;
        }

        public function get experience(): int
        {
            return this._experience;
        }

        public function get energy(): int
        {
            return this._energy;
        }

        public function get nutrition(): int
        {
            return this._nutrition;
        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get experienceRequiredToLevel(): int
        {
            return this._experienceRequiredToLevel;
        }

        public function get maxEnergy(): int
        {
            return this._maxEnergy;
        }

        public function get maxNutrition(): int
        {
            return this._maxNutrition;
        }

        public function get respect(): int
        {
            return this._respect;
        }

        public function get ownerId(): int
        {
            return this._ownerId;
        }

        public function get ownerName(): String
        {
            return this._ownerName;
        }

        public function get age(): int
        {
            return this._age;
        }

        public function flush(): Boolean
        {
            this._petId = -1;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._petId = data.readInteger();
            this._name = data.readString();
            this._level = data.readInteger();
            this._maxLevel = data.readInteger();
            this._experience = data.readInteger();
            this._experienceRequiredToLevel = data.readInteger();
            this._energy = data.readInteger();
            this._maxEnergy = data.readInteger();
            this._nutrition = data.readInteger();
            this._maxNutrition = data.readInteger();
            this._figure = data.readString();
            this._respect = data.readInteger();
            this._ownerId = data.readInteger();
            this._age = data.readInteger();
            this._ownerName = data.readString();
            
            return true;
        }

    }
}
