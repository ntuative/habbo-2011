package com.sulake.habbo.communication.messages.parser.inventory.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetReceivedMessageParser implements IMessageParser
    {

        private var _boughtAsGift: Boolean;
        private var _pet: PetData;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._boughtAsGift = data.readBoolean();
            this._pet = new PetData(data);

            Logger.log("Got PetReceived: " + this._boughtAsGift + ", " + this._pet.id + ", " + this._pet.name + ", " + this._pet.type + ", " + this._pet.breed + ", " + this.pet.color);

            return true;
        }

        public function get boughtAsGift(): Boolean
        {
            return this._boughtAsGift;
        }

        public function get pet(): PetData
        {
            return this._pet;
        }

    }
}
