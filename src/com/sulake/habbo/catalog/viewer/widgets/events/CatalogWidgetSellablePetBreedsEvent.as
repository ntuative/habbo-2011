package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    public class CatalogWidgetSellablePetBreedsEvent extends Event
    {

        private var _productCode: String;
        private var _sellableBreeds: Array;

        public function CatalogWidgetSellablePetBreedsEvent(productCode: String, sellableBreeds: Array, param3: Boolean = false, param4: Boolean = false)
        {
            super(WidgetEvent.CWE_SELLABLE_PET_BREEDS, param3, param4);

            this._productCode = productCode;
            this._sellableBreeds = sellableBreeds;
        }

        public function get productCode(): String
        {
            return this._productCode;
        }

        public function get sellableBreeds(): Array
        {
            if (this._sellableBreeds != null)
            {
                return this._sellableBreeds.slice();
            }


            return [];
        }

    }
}
