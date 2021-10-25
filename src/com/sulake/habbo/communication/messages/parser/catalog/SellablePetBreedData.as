package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SellablePetBreedData
    {

        private var _type: int;
        private var _breed: int;
        private var _sellable: Boolean;
        private var _rare: Boolean;

        public function SellablePetBreedData(data: IMessageDataWrapper)
        {
            this._type = data.readInteger();
            this._breed = data.readInteger();
            this._sellable = data.readBoolean();
            this._rare = data.readBoolean();
        }

        public function get type(): int
        {
            return this._type;
        }

        public function get breed(): int
        {
            return this._breed;
        }

        public function get sellable(): Boolean
        {
            return this._sellable;
        }

        public function get rare(): Boolean
        {
            return this._rare;
        }

    }
}
