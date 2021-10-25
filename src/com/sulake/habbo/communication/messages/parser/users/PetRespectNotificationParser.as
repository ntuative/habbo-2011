package com.sulake.habbo.communication.messages.parser.users
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetRespectNotificationParser implements IMessageParser
    {

        private var _respect: int;
        private var _petOwnerId: int;
        private var _petData: PetData;

        public function flush(): Boolean
        {
            this._petData = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._respect = data.readInteger();
            this._petOwnerId = data.readInteger();
            this._petData = new PetData(data);

            return true;
        }

        public function get petOwnerId(): int
        {
            return this._petOwnerId;
        }

        public function get respect(): int
        {
            return this._respect;
        }

        public function get petData(): PetData
        {
            return this._petData;
        }

    }
}
