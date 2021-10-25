package com.sulake.habbo.catalog.purchase
{

    import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;

    public class GiftWrappingConfiguration
    {

        private var _isEnabled: Boolean = false;
        private var _price: int;
        private var _stuffTypes: Array;
        private var _boxTypes: Array;
        private var _ribbonTypes: Array;

        public function GiftWrappingConfiguration(event: GiftWrappingConfigurationEvent)
        {
            if (event == null)
            {
                return;
            }


            var parser: GiftWrappingConfigurationParser = event.getParser();

            if (parser == null)
            {
                return;
            }


            this._isEnabled = parser.isWrappingEnabled;
            this._price = parser.wrappingPrice;
            this._stuffTypes = parser.stuffTypes;
            this._boxTypes = parser.boxTypes;
            this._ribbonTypes = parser.ribbonTypes;
        }

        public function get isEnabled(): Boolean
        {
            return this._isEnabled;
        }

        public function get price(): int
        {
            return this._price;
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

    }
}
