package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GiftWrappingConfigurationParser implements IMessageParser
    {

        private var _isWrappingEnabled: Boolean;
        private var _wrappingPrice: int;
        private var _stuffTypes: Array;
        private var _boxTypes: Array;
        private var _ribbonTypes: Array;

        public function get isWrappingEnabled(): Boolean
        {
            return this._isWrappingEnabled;
        }

        public function get wrappingPrice(): int
        {
            return this._wrappingPrice;
        }

        public function get stuffTypes(): Array
        {
            return this._stuffTypes;
        }

        public function get boxTypes(): Array
        {
            return this._boxTypes;
        }

        public function get ribbonTypes(): Array
        {
            return this._ribbonTypes;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var i: int;
            this._stuffTypes = [];
            this._boxTypes = [];
            this._ribbonTypes = [];
            this._isWrappingEnabled = data.readBoolean();
            this._wrappingPrice = data.readInteger();

            var itemCount: int = data.readInteger();
            i = 0;

            while (i < itemCount)
            {
                this._stuffTypes.push(data.readInteger());
                i++;
            }

            itemCount = data.readInteger();
            i = 0;
            
            while (i < itemCount)
            {
                this._boxTypes.push(data.readInteger());
                i++;
            }

            itemCount = data.readInteger();
            i = 0;
            
            while (i < itemCount)
            {
                this._ribbonTypes.push(data.readInteger());
                i++;
            }

            return true;
        }

    }
}
