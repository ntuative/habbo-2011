package com.sulake.habbo.communication.messages.parser.inventory.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInventoryMessageParser implements IMessageParser
    {

        private var _pets: Array;

        public function flush(): Boolean
        {
            this._pets = [];
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._pets = [];
            
            var petData: PetData;
            var petCount: int = data.readInteger();
            var i: int;
            
            while (i < petCount)
            {
                petData = new PetData(data);
                this._pets.push(petData);
                i++;
            }

            return true;
        }

        public function get pets(): Array
        {
            return this._pets;
        }

    }
}
