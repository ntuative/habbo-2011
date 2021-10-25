package com.sulake.habbo.communication.messages.parser.inventory.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetAddedToInventoryParser implements IMessageParser
    {

        private var _pet: PetData;
        private var _purchased: Boolean;

        public function flush(): Boolean
        {
            this._pet = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._pet = new PetData(data);
            this._purchased = data.readBoolean();

            return true;
        }

        public function get pet(): PetData
        {
            return this._pet;
        }

        public function get purchased(): Boolean
        {
            return this._purchased;
        }

    }
}
