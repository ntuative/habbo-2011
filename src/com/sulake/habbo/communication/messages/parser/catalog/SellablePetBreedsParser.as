package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SellablePetBreedsParser implements IMessageParser
    {

        private var _productCode: String = "";
        private var _sellableBreeds: Array = [];

        public function get productCode(): String
        {
            return this._productCode;
        }

        public function get sellableBreeds(): Array
        {
            return this._sellableBreeds.slice();
        }

        public function flush(): Boolean
        {
            this._productCode = "";
            this._sellableBreeds = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._productCode = data.readString();
            
            var sellableBreedCount: int = data.readInteger();
            var i: int;
            
            while (i < sellableBreedCount)
            {
                this._sellableBreeds.push(new SellablePetBreedData(data));
                i++;
            }

            return true;
        }

    }
}
